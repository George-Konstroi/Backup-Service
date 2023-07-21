unit UnitBackup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, IniFiles, ShellAPI, UnitControllerBackup, UnitReadWriteFile;

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

    procedure ButtonSelecionarArquivoClick(Sender: TObject);
    procedure ButtonRemoverClick(Sender: TObject);
    procedure CheckBoxCompactacaoClick(Sender: TObject);
    procedure ButtonSalvarConfiguracoesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonBackupManualClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    RWFile: TUnitReadWriteFile;
  public
    { Public declarations }
  end;

var
  FormBackup: TFormBackup;

implementation

{$R *.dfm}

procedure TFormBackup.ButtonBackupManualClick(Sender: TObject);
var
  arquivo: Integer;
  compactar: Boolean;
  tipoCompactacao: string;
  pathFilesOrigem, pathFileDestino: string;
begin
  pathFileDestino := EditDestino.Text;
  pathFilesOrigem := '';
  compactar := CheckBoxCompactacao.Checked;
  tipoCompactacao := '';

  if RadioGroupTipoCompactacao.ItemIndex = 0 then tipoCompactacao := '.rar'
  else if RadioGroupTipoCompactacao.ItemIndex = 1 then tipoCompactacao := '.rar';

  if not compactar then
    for arquivo := 0 to ListBoxBackup.Count - 1 do begin
      pathFilesOrigem := ListBoxBackup.Items.Strings[arquivo];
      UnitControllerBackup.Backup.BackupWithoutWin(pathFilesOrigem, pathFileDestino)
    end
  else begin
    for arquivo := 0 to ListBoxBackup.Count - 1 do
      pathFilesOrigem := pathFilesOrigem + ' "' + ListBoxBackup.Items.Strings[arquivo] + '"';

    UnitControllerBackup.Backup.BackupWithWin(tipoCompactacao, pathFilesOrigem, pathFileDestino);
    end;
end;

procedure TFormBackup.ButtonRemoverClick(Sender: TObject);
begin
  ListBoxBackup.Items.Delete(ListBoxBackup.ItemIndex);
end;

procedure TFormBackup.ButtonSalvarConfiguracoesClick(Sender: TObject);
begin
  try
    if not CheckBoxCompactacao.Checked then RWFile.setCompactar(False)
    else begin
      RWFile.setCompactar(True);

      if RadioGroupTipoCompactacao.ItemIndex = 0 then RWFile.setTipoCompactacao('.rar') //WinRar
      else RWFile.setTipoCompactacao('.zip'); //WinZip
    end;

    RWFile.setDestino(EditDestino.Text);
    RWFile.atualizarDataModificacao;
  finally
  end;

  ListBoxBackup.Items.SaveToFile(ExtractFilePath(Application.ExeName) + 'Lista.ini');
end;

procedure TFormBackup.ButtonSelecionarArquivoClick(Sender: TObject);
var
  arquivo: Integer;
begin
  if OpenDialogAdicionarArquivo.Execute then
    if OpenDialogAdicionarArquivo.FileName <> '' then
      for arquivo := 0 to OpenDialogAdicionarArquivo.Files.Count - 1 do
        ListBoxBackup.Items.Add(OpenDialogAdicionarArquivo.Files[arquivo]);
end;

procedure TFormBackup.CheckBoxCompactacaoClick(Sender: TObject);
begin
  //if CheckBoxCompactacao.Checked then RadioGroupTipoCompactacao.Visible := True
  //else RadioGroupTipoCompactacao.Visible := False;
end;

procedure TFormBackup.FormCreate(Sender: TObject);
begin
  RWFile.Create;

  try
    if RWFile.getCompactar then
    begin
      CheckBoxCompactacao.Checked := True;

      if RWFile.getTipoCompactacao = '.rar' then RadioGroupTipoCompactacao.ItemIndex := 0
      else RadioGroupTipoCompactacao.ItemIndex := 1;
    end;

    EditDestino.Text := RWFile.getDestino;
  finally
  end;

  ListBoxBackup.Items.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Lista.ini');
end;

procedure TFormBackup.FormDestroy(Sender: TObject);
begin
  RWFile.Free;
end;

end.
