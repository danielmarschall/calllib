unit DemoMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    DeviceListBox: TListBox;
    Label1: TLabel;
    CallBtn: TButton;
    PhoneNumberEdit: TEdit;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure DeviceListBoxClick(Sender: TObject);
    procedure CallBtnClick(Sender: TObject);
    procedure PhoneNumberEditChange(Sender: TObject);
  private
    procedure ListDevices;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function GetTapiDevices(buf: PAnsiChar): integer; stdcall; external 'MakeCall.dll';
function MakeCall(phoneNumber: PAnsiChar; deviceId: integer): integer; stdcall; external 'MakeCall.dll';

type
  TAnsiCharArray = array of AnsiChar;

function ArrayToString(const a: TAnsiCharArray): string;
begin
  if Length(a)>0 then
    SetString(Result, PChar(@a[0]), Length(a))
  else
    Result := '';
end;

procedure TForm1.CallBtnClick(Sender: TObject);
var
  s: AnsiString;
begin
  s := PhoneNumberEdit.Text;
  MakeCall(PAnsiChar(s), DeviceListBox.ItemIndex);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ListDevices;
end;

procedure TForm1.DeviceListBoxClick(Sender: TObject);
begin
  CallBtn.Enabled := (DeviceListBox.ItemIndex <> -1) and (PhoneNumberEdit.Text <> '');
end;

procedure TForm1.PhoneNumberEditChange(Sender: TObject);
begin
  CallBtn.Enabled := (DeviceListBox.ItemIndex <> -1) and (PhoneNumberEdit.Text <> '');
end;

procedure TForm1.ListDevices;
var
  len: integer;
  buf: TAnsiCharArray;
begin
  len := GetTapiDevices(nil);
  SetLength(buf, len+1);
  GetTapiDevices(PAnsiChar(buf));
  DeviceListBox.Items.Text := ArrayToString(buf);
end;

end.
