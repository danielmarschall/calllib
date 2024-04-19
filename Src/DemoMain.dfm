object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Call Lib Demo'
  ClientHeight = 342
  ClientWidth = 266
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 112
    Height = 13
    Caption = 'Available TAPI devices:'
  end
  object Label2: TLabel
    Left = 8
    Top = 256
    Width = 73
    Height = 13
    Caption = 'Phone number:'
  end
  object DeviceListBox: TListBox
    Left = 8
    Top = 27
    Width = 250
    Height = 221
    ItemHeight = 13
    TabOrder = 0
    OnClick = DeviceListBoxClick
  end
  object CallBtn: TButton
    Left = 183
    Top = 302
    Width = 75
    Height = 25
    Caption = 'Make call'
    Default = True
    Enabled = False
    TabOrder = 2
    OnClick = CallBtnClick
  end
  object PhoneNumberEdit: TEdit
    Left = 8
    Top = 275
    Width = 250
    Height = 21
    TabOrder = 1
    OnChange = PhoneNumberEditChange
  end
end
