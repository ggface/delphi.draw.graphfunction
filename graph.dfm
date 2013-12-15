object GraphForm: TGraphForm
  Left = 0
  Top = 0
  Caption = #1043#1088#1072#1092#1080#1082' '#1092#1091#1085#1082#1094#1080#1080
  ClientHeight = 291
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pbGraph: TPaintBox
    Left = 0
    Top = 0
    Width = 482
    Height = 291
    Align = alClient
    OnPaint = pbGraphPaint
    ExplicitLeft = 232
    ExplicitTop = 136
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
end
