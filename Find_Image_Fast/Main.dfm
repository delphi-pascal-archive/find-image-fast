object Form1: TForm1
  Left = 222
  Top = 131
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Find image fast'
  ClientHeight = 369
  ClientWidth = 569
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 16
  object ScrollBox1: TScrollBox
    Left = 8
    Top = 8
    Width = 273
    Height = 289
    HorzScrollBar.Tracking = True
    VertScrollBar.Tracking = True
    TabOrder = 0
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 137
      Height = 137
      AutoSize = True
    end
  end
  object ScrollBox2: TScrollBox
    Left = 288
    Top = 8
    Width = 273
    Height = 289
    HorzScrollBar.Increment = 16
    HorzScrollBar.Tracking = True
    VertScrollBar.Increment = 13
    VertScrollBar.Tracking = True
    TabOrder = 1
    object Image2: TImage
      Left = 0
      Top = 0
      Width = 137
      Height = 137
      AutoSize = True
    end
  end
  object Button1: TButton
    Left = 8
    Top = 304
    Width = 273
    Height = 25
    Caption = 'Load image 1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 288
    Top = 304
    Width = 273
    Height = 25
    Caption = 'Load image 2'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 336
    Width = 553
    Height = 25
    Caption = 'Compare'
    TabOrder = 4
    OnClick = Button3Click
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 344
    Top = 16
  end
end
