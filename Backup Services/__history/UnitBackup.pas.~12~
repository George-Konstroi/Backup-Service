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
    Label1: TLabel;
    procedure ButtonSelecionarArquivoClick(Sender: TObject);
    procedure ButtonRemoverClick(Sender: TObject);
    procedure CheckBoxCompactacaoClick(Sender: TObject);
    procedure ButtonSalvarConfiguracoesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonBackupManualClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    { Private declarations }
    procedure BackupWithWin(pathFilesOrigem: string);
    procedure BackupWithoutWin(pathFileOrigem: string);
  public
    { Public declarations }
  end;

var
  FormBackup: TFormBackup;

implementation

{$R *.dfm}

uses
  IniFiles, ShellAPI;

procedure TFormBackup.BackupWithoutWin(pathFileOrigem: string);
var
  pathFileDestino: string;
begin
  pathFileDestino := EditDestino.Text + '\' + ExtractFileName(pathFileOrigem);

  if not CopyFile(PChar(pathFileOrigem), PChar(pathFileDestino), true) then
    ShowMessage('Erro ao copiar ' + pathFileOrigem + ' para ' + pathFileDestino + ': ' + SysErrorMessage(GetLastError));
end;

procedure TFormBackup.BackupWithWin(pathFilesOrigem: string);
var
  nomeDoArquivo: string;
  linhadeComando: string;
  pathFileDestino: string;
  pathProgramaWin: string;
begin
  if RadioGroupTipoCompactacao.ItemIndex >= 0 then // WinRar
  begin
    nomeDoArquivo := ChangeFileExt(FormatDateTime('yyyy-mm-dd hh-nn-ss-zzz', Now), '.rar');
    pathFileDestino := EditDestino.Text + '\' + nomeDoArquivo;
    linhadeComando := 'a "' + pathFileDestino + '" ' + pathFilesOrigem;
    pathProgramaWin := 'C:\Program Files\WinRAR\WinRAR.exe';
  end
  // Por limitações da máquina, compactação WinZip não esta disponível
  else begin // WinZip
    nomeDoArquivo := ChangeFileExt(FormatDateTime('yyyy-mm-dd hh-nn-ss-zzz', Now), '.zip');
    pathFileDestino := EditDestino.Text + '\' + ExtractFileName(nomeDoArquivo);
    linhadeComando := '-A "' + pathFileDestino + '" ' + pathFilesOrigem;
    pathProgramaWin := 'C:\Program Files (x86)\WinZip\WINZIP32.EXE';
  end;

  ShellExecute(0, 'open', PChar(pathProgramaWin), PChar(linhadeComando), nil, SW_SHOWNORMAL);
end;

procedure TFormBackup.ButtonBackupManualClick(Sender: TObject);
var
  arquivo: Integer;
  pathFile: string;
begin
  pathFile := '';

  if CheckBoxCompactacao.Checked then begin
    // Compactar todos os arquivos selecionados em um único arquivo
    for arquivo := 0 to ListBoxBackup.Count - 1 do
      pathFile := pathFile + ' "' + ListBoxBackup.Items.Strings[arquivo] + '"';

    BackupWithWin(pathFile);
  end
  else begin
    for arquivo := 0 to ListBoxBackup.Count - 1 do begin
      pathFile := ListBoxBackup.Items.Strings[arquivo];
      BackupWithoutWin(pathFile);
    end;
  end;
end;

procedure TFormBackup.ButtonRemoverClick(Sender: TObject);
begin
  ListBoxBackup.Items.Delete(ListBoxBackup.ItemIndex);
end;

procedure TFormBackup.ButtonSalvarConfiguracoesClick(Sender: TObject);
var
  configuracao: TIniFile;
begin
  configuracao := nil;

  try
    configuracao := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Backup.ini');

    if not CheckBoxCompactacao.Checked then configuracao.WriteString('BACKUP','COMPACTAR','N')
    else begin
      configuracao.WriteString('BACKUP','COMPACTAR','S');

      if RadioGroupTipoCompactacao.ItemIndex = 0 then configuracao.WriteString('BACKUP','TIPO','R') //WinRar
      else configuracao.WriteString('BACKUP','TIPO','Z');                                            //WinZip
    end;

    configuracao.WriteString('BACKUP','DESTINO', EditDestino.Text);
    configuracao.WriteString('BACKUP','ULTIMO', FormatDateTime('dd/mm/yyyy', Date));
  finally
    configuracao.Free;
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
var
  configuracoes: TIniFile;
begin
  configuracoes := nil;

  try
    configuracoes := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Backup.ini');

    if configuracoes.ReadString('BACKUP','COMPACTAR','') = 'S' then
    begin
      CheckBoxCompactacao.Checked := True;

      if configuracoes.ReadString('BACKUP','TIPO','') = 'R' then RadioGroupTipoCompactacao.ItemIndex := 0
      else RadioGroupTipoCompactacao.ItemIndex := 1;
    end;

    EditDestino.Text := configuracoes.ReadString('BACKUP','DESTINO','');
  finally
    configuracoes.Free;
  end;

  ListBoxBackup.Items.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Lista.ini');
end;

procedure TFormBackup.Label1Click(Sender: TObject);
begin
  Label1.Caption := ExtractFilePath(ParamStr(0));
end;

end.
