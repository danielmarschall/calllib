library MakeCall;

uses
  SysUtils,
  hbTAPI;

{$R *.res}

function GetTapiDevices(buf: PAnsiChar): integer; stdcall;
var
  mTapiLine: TTapiLine;
  len: Integer;
  s: string;
begin
  mTapiLine := TTapiLine.Create(nil);
  try
    try
      mTapiLine.Active := false;
      s := mTapiLine.DeviceList.Text;
      len := Length(s);
      if buf <> nil then
      begin
        FillChar(buf^, len+1{NUL}, 0);
        StrPCopy(buf, s);
        result := 0;
      end;
      result := len+1{NUL};
    except
      result := -1;
    end;
  finally
    FreeAndNil(mTapiLine);
  end;
end;

function Call(phoneNumber: PAnsiChar; deviceId: integer): integer; stdcall;
var
  mTapiLine: TTapiLine;
begin
  mTapiLine := TTapiLine.Create(nil);
  try
    mTapiLine.Active := false;
    mTapiLine.CallParams.Flags := 0;
    mTapiLine.DeviceID := deviceId;
    mTapiLine.Active := true;
    if not mTapiLine.Active then
    begin
      // Usually "TAPI device not available"
      result := -1;
      exit;
    end;
    try
      mTapiLine.MakeCall(AnsiString(phoneNumber));
    except
      // This can tappen when the headset is active, so the line is busy
      result := -2;
      exit;
    end;
    result := 0;
  finally
    FreeAndNil(mTapiLine);
  end;
end;

exports
  Call name 'MakeCall',
  GetTapiDevices;

begin
end.
