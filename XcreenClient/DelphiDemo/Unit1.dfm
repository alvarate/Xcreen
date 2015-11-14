object Form1: TForm1
  Left = 302
  Top = 130
  Width = 522
  Height = 601
  Caption = 'XcreenClient _20150416_2229'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 200
    Top = 8
    Width = 70
    Height = 13
    Caption = #26381#21153#22120'IP'#22320#22336
    Transparent = True
  end
  object TntGroupBox1: TTntGroupBox
    Left = 8
    Top = 40
    Width = 497
    Height = 129
    Caption = 'Point Text Capturing'
    TabOrder = 0
    Visible = False
    object LabelAllText: TTntLabel
      Left = 16
      Top = 76
      Width = 43
      Height = 13
      Caption = 'All Text: '
    end
    object LabelCursorText: TTntLabel
      Left = 16
      Top = 100
      Width = 61
      Height = 13
      Caption = 'Cursor Text:'
    end
    object LabelCursorPos: TTntLabel
      Left = 16
      Top = 122
      Width = 56
      Height = 13
      Caption = 'Cursor Pos:'
    end
    object CheckBoxCursor: TTntCheckBox
      Left = 16
      Top = 24
      Width = 441
      Height = 17
      Caption = 'Enable text-capturing with mouse cursor'
      TabOrder = 0
      OnClick = CheckBoxCursorClick
    end
    object CheckBoxHotkey: TTntCheckBox
      Left = 16
      Top = 48
      Width = 417
      Height = 17
      Caption = 'Enable text-capturing with hotkey (Ctrl+Alt+P)'
      TabOrder = 1
      OnClick = CheckBoxHotkeyClick
    end
    object EditAllText: TTntEdit
      Left = 96
      Top = 72
      Width = 393
      Height = 21
      TabOrder = 2
    end
    object EditCursorText: TTntEdit
      Left = 96
      Top = 96
      Width = 393
      Height = 21
      TabOrder = 3
    end
    object EditCursorPos: TTntEdit
      Left = 96
      Top = 120
      Width = 65
      Height = 21
      TabOrder = 4
    end
  end
  object TntGroupBox2: TTntGroupBox
    Left = 0
    Top = 72
    Width = 505
    Height = 217
    Caption = 'Rectangle Text Capturing'
    TabOrder = 1
    object TntLabel1: TTntLabel
      Left = 16
      Top = 26
      Width = 23
      Height = 13
      Caption = 'Left:'
    end
    object TntLabel2: TTntLabel
      Left = 104
      Top = 26
      Width = 22
      Height = 13
      Caption = 'Top:'
    end
    object TntLabel3: TTntLabel
      Left = 192
      Top = 26
      Width = 29
      Height = 13
      Caption = 'Right:'
    end
    object TntLabel4: TTntLabel
      Left = 296
      Top = 26
      Width = 38
      Height = 13
      Caption = 'Bottom:'
    end
    object EditLeft: TTntEdit
      Left = 48
      Top = 24
      Width = 50
      Height = 21
      ReadOnly = True
      TabOrder = 0
      Text = '0'
    end
    object EditTop: TTntEdit
      Left = 136
      Top = 24
      Width = 50
      Height = 21
      ReadOnly = True
      TabOrder = 1
      Text = '0'
    end
    object EditRight: TTntEdit
      Left = 232
      Top = 24
      Width = 50
      Height = 21
      ReadOnly = True
      TabOrder = 2
      Text = '900'
    end
    object EditBottom: TTntEdit
      Left = 344
      Top = 24
      Width = 50
      Height = 21
      ReadOnly = True
      TabOrder = 3
      Text = '700'
    end
    object Button1: TTntButton
      Left = 408
      Top = 16
      Width = 73
      Height = 33
      Caption = 'Capture'
      TabOrder = 4
      Visible = False
      OnClick = Button1Click
    end
    object Memo: TTntMemo
      Left = 16
      Top = 64
      Width = 473
      Height = 145
      Lines.Strings = (
        'Memo')
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 5
    end
  end
  object TntGroupBox3: TTntGroupBox
    Left = 0
    Top = 320
    Width = 505
    Height = 233
    Caption = #40736#26631#21010#35789#35299#26512
    TabOrder = 2
    object CheckBoxHighlight: TTntCheckBox
      Left = 16
      Top = 24
      Width = 425
      Height = 17
      Caption = #24320#21551#40736#26631#21010#35789#35299#26512#21151#33021
      TabOrder = 0
      Visible = False
      OnClick = CheckBoxHighlightClick
    end
    object Memo2: TTntMemo
      Left = 16
      Top = 56
      Width = 473
      Height = 121
      Lines.Strings = (
        'Memo2')
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
    end
  end
  object Edit1: TEdit
    Left = 304
    Top = 8
    Width = 89
    Height = 21
    TabOrder = 3
    Text = '127.0.0.1'
  end
  object Button2: TButton
    Left = 416
    Top = 8
    Width = 75
    Height = 25
    Caption = #27979#35797#36830#36890#24615
    TabOrder = 4
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer1Timer
    Left = 448
    Top = 40
  end
  object Client1: TIdTCPClient
    MaxLineAction = maException
    ReadTimeout = 0
    Port = 0
    Left = 368
    Top = 48
  end
end
