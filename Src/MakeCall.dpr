library MakeCall;

uses
  SysUtils,
  AnsiStrings,
  hbTAPI,
  dialogs;

{$R *.res}

function GetTapiDevicesA(buf: PAnsiChar): integer; stdcall;
var
  mTapiLine: ThbTapiLine;
  len: Integer;
  s: AnsiString;
begin
  mTapiLine := ThbTapiLine.Create(nil);
  try
    try
      mTapiLine.Active := false;
      s := AnsiString(mTapiLine.DeviceList.Text);
      len := (Length(s)+1{NUL}) * SizeOf(AnsiChar);
      if buf <> nil then
      begin
        FillChar(buf^, len, 0);
        AnsiStrings.StrPCopy(buf, s);
      end;
      result := len;
    except
      result := -1;
    end;
  finally
    FreeAndNil(mTapiLine);
  end;
end;

function GetTapiDevicesW(buf: PWideChar): integer; stdcall;
var
  mTapiLine: ThbTapiLine;
  len: Integer;
  s: WideString;
begin
  mTapiLine := ThbTapiLine.Create(nil);
  try
    try
      mTapiLine.Active := false;
      s := WideString(mTapiLine.DeviceList.Text);
      len := (Length(s)+1{NUL}) * SizeOf(WideChar);
      if buf <> nil then
      begin
        FillChar(buf^, len, 0);
        StrPCopy(buf, s);
      end;
      result := len;
    except
      result := -1;
    end;
  finally
    FreeAndNil(mTapiLine);
  end;
end;

function MakeCallA(phoneNumber: PAnsiChar; deviceId: integer): integer; stdcall;
var
  mTapiLine: ThbTapiLine;
  sPhoneNumber: AnsiString;
begin
  mTapiLine := ThbTapiLine.Create(nil);
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
      sPhoneNumber := phoneNumber;
      mTapiLine.MakeCall(String(sPhoneNumber));
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

{$IFDEF UNICODE}
function MakeCallW(phoneNumber: PWideChar; deviceId: integer): integer; stdcall;
var
  mTapiLine: ThbTapiLine;
  sPhoneNumber: WideString;
begin
  mTapiLine := ThbTapiLine.Create(nil);
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
      sPhoneNumber := phoneNumber;
      mTapiLine.MakeCall(String(sPhoneNumber));
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
{$ELSE}
function MakeCallW(phoneNumber: PWideChar; deviceId: integer): integer; stdcall;
var
  wst: WideString;
  ast: AnsiString;
begin
  wst := WideString(phoneNumber);
  ast := AnsiString(wst);
  result := MakeCallA(PAnsiChar(ast), deviceId);
end;
{$ENDIF}

exports
  MakeCallA,
  MakeCallW,
  GetTapiDevicesA,
  GetTapiDevicesW;

begin
end.
