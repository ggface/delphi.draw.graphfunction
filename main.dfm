object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = #1047#1072#1076#1072#1095#1072'. '#1056#1080'c'#1091#1077#1084' '#1075#1088#1072#1092#1080#1082' '#1087#1086' '#1076#1072#1085#1085#1099#1084' '#1080#1079' '#1092#1072#1081#1083#1072'.'
  ClientHeight = 442
  ClientWidth = 624
  Color = clBtnFace
  Constraints.MinHeight = 240
  Constraints.MinWidth = 360
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  DesignSize = (
    624
    442)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 573
    Height = 394
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = False
    Caption = #1053#1072#1078#1084#1080#1090#1077' '#1083#1102#1073#1091#1102' '#1082#1083#1072#1074#1080#1096#1091' '#1076#1083#1103' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1075#1088#1072#1092#1080#1082#1072' '#1092#1091#1085#1082#1094#1080#1080' y=2x'#178
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
    ExplicitWidth = 401
    ExplicitHeight = 273
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' (*.txt)|*.txt'
    Left = 16
    Top = 16
  end
end
