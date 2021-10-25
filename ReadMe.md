ViaThinkSoft CallLib (MakeCall.dll) API
=======================================

The CallLib API is a minimal API for making calls over the TAPI line.
It contains only two functions which are described below:

GetTapiDevices
==============

Delphi: `function GetTapiDevices(buf: PAnsiChar): integer; stdcall;`
C++:    `int __stdcall GetTapiDevices(AnsiChar* buf);`

GetTapiDevices lists all available TAPI devices.

If buf is NULL, the result of the function is the number of bytes required to fill the buffer.

If buf is not NULL, the names of the TAPI devices, separated by CR LF, with appended NUL
character is written into buf, and the number of bytes written is returned.

If the result is -1, an error occured.

MakeCall
========

Delphi: `function MakeCall(phoneNumber: PAnsiChar; deviceId: integer): integer; stdcall;`
C++:    `int __stdcall MakeCall(AnsiChar* phoneNumber, int deviceId);`

MakeCall requests the telephone to make a call.

phoneNumber is the number to be called. It should only contain numbers.

deviceId is the index of the TAPI device, as listed in GetTapiDevices.

If the result is 0, everything is OK. If the result is below 0, an error occured.
-1 usually means that the TAPI device cannot be found.
-2 usually means that the headset / telephone receiver is active and therefore the line is busy.
