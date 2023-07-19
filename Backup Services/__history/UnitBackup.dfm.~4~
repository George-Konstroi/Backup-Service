object FormBackup: TFormBackup
  Left = 0
  Top = 0
  Caption = 'Configura'#231#227'o de Servi'#231'o de Backup'
  ClientHeight = 445
  ClientWidth = 432
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBoxBackup: TGroupBox
    AlignWithMargins = True
    Left = 1
    Top = 1
    Width = 430
    Height = 249
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alTop
    Caption = 'Backup'
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 0
    ExplicitLeft = -160
    ExplicitTop = 8
    ExplicitWidth = 669
    object ListBoxBackup: TListBox
      Left = 12
      Top = 65
      Width = 406
      Height = 143
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      ExplicitLeft = 11
      ExplicitTop = 59
    end
    object Panel1: TPanel
      Left = 12
      Top = 25
      Width = 406
      Height = 40
      Align = alTop
      TabOrder = 1
      object LabelLocalizar: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 15
        Width = 134
        Height = 19
        Caption = 'Localizar arquivo de origem:'
      end
      object ButtonSelecionarArquivo: TButton
        Left = 145
        Top = 9
        Width = 75
        Height = 25
        Caption = 'Selecionar'
        TabOrder = 0
        OnClick = ButtonSelecionarArquivoClick
      end
    end
    object Panel2: TPanel
      Left = 12
      Top = 208
      Width = 406
      Height = 29
      Align = alBottom
      TabOrder = 2
      ExplicitTop = 196
      object ButtonRemover: TButton
        Left = 205
        Top = 1
        Width = 200
        Height = 27
        Align = alRight
        Caption = 'Remover da Lista'
        TabOrder = 0
        OnClick = ButtonRemoverClick
        ExplicitLeft = 214
        ExplicitHeight = 39
      end
      object ButtonBackupManual: TButton
        Left = 1
        Top = 1
        Width = 200
        Height = 27
        Align = alLeft
        Caption = 'Backup Manual'
        TabOrder = 1
        ExplicitHeight = 39
      end
    end
  end
  object GroupBoxConfiguracao: TGroupBox
    AlignWithMargins = True
    Left = 1
    Top = 252
    Width = 430
    Height = 53
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alTop
    Caption = 'Configura'#231#245'es'
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 1
    ExplicitWidth = 448
    object CheckBoxCompactacao: TCheckBox
      Left = 12
      Top = 25
      Width = 406
      Height = 17
      Align = alTop
      Caption = 'Usar compacta'#231#227'o nods aruivos'
      TabOrder = 0
      OnClick = CheckBoxCompactacaoClick
      ExplicitLeft = 64
      ExplicitTop = 56
      ExplicitWidth = 187
    end
  end
  object GroupBoxDestino: TGroupBox
    AlignWithMargins = True
    Left = 1
    Top = 363
    Width = 430
    Height = 54
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alTop
    Caption = 'Destino do Backup'
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 2
    ExplicitWidth = 448
    ExplicitHeight = 158
    object EditDestino: TEdit
      Left = 12
      Top = 25
      Width = 406
      Height = 21
      Align = alTop
      TabOrder = 0
      Text = 'C:\Backup\'
      ExplicitLeft = 24
      ExplicitTop = 32
      ExplicitWidth = 353
    end
  end
  object RadioGroupTipoCompactacao: TRadioGroup
    AlignWithMargins = True
    Left = 1
    Top = 307
    Width = 430
    Height = 54
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alTop
    Caption = 'Tipo de compacta'#231#227'o'
    Columns = 4
    ItemIndex = 0
    Items.Strings = (
      'WinRar'
      'WinZip')
    TabOrder = 3
    ExplicitWidth = 448
  end
  object ButtonSalvarConfiguracoes: TButton
    AlignWithMargins = True
    Left = 1
    Top = 419
    Width = 430
    Height = 25
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alTop
    Caption = 'Salvar Configura'#231#245'es'
    TabOrder = 4
    OnClick = ButtonSalvarConfiguracoesClick
    ExplicitLeft = 288
    ExplicitTop = 280
    ExplicitWidth = 75
  end
  object OpenDialogAdicionarArquivo: TOpenDialog
    InitialDir = 'C:\Users'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 8
    Top = 64
  end
end
