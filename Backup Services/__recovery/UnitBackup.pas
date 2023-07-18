unit UnitBackup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFormBackup = class(TForm)
    GroupBoxBackup: TGroupBox;
    GroupBoxConfiguracao: TGroupBox;
    GroupBoxDestino: TGroupBox;
    LabelLocalizar: TLabel;
    ButtonSelecionarArquivo: TButton;
    ListBoxBackup: TListBox;
    ButtonRemover: TButton;
    ButtonBackupManual: TButton;
    OpenDialogAdicionarArquivo: TOpenDialog;
    CheckBoxCompactacao: TCheckBox;
    RadioGroupTipoCompactacao: TRadioGroup;
    EditDestino: TEdit;
    ButtonSalvarConfiguracoes: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBackup: TFormBackup;

implementation

{$R *.dfm}

end.
