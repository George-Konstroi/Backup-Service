unit UnitControllerBackup;

interface
type
  TUnitControllerBackup = class(TObject)
  private

  public
    procedure BackupWithoutWin(pathFileOrigem, pathFileDestino: string);
    procedure BackupWithWin(tipoCompactacao, pathFilesOrigem, pathFileDestino: string);
  end;

var
  Backup: TUnitControllerBackup;

implementation

uses
  IniFiles, ShellAPI, System.SysUtils, Winapi.Windows;

{ TUnitControllerBackup }

procedure TUnitControllerBackup.BackupWithoutWin(pathFileOrigem, pathFileDestino: string);
var
  nomeDoArquivoDestino, linhadeComando: string;
begin
  nomeDoArquivoDestino := ExtractFileName(pathFileOrigem);
  pathFileDestino := pathFileDestino + '\' + nomeDoArquivoDestino;

  if not CopyFile(PChar(pathFileOrigem), PChar(pathFileDestino), true) then
    //Writeln(SysErrorMessage(GetLastError));
end;

procedure TUnitControllerBackup.BackupWithWin(tipoCompactacao, pathFilesOrigem, pathFileDestino: string);
var
  nomeDoArquivoDestino: string;
  linhadeComando: string;
  pathProgramaWin: string;
begin
  if tipoCompactacao = '.rar' then begin // WinRar
    nomeDoArquivoDestino := ChangeFileExt(FormatDateTime('yyyy-mm-dd hh-nn-ss-zzz', Now), '.rar');
    pathFileDestino := pathFileDestino + '\' + nomeDoArquivoDestino;
    linhadeComando := 'a "' + pathFileDestino + '" ' + pathFilesOrigem;
    pathProgramaWin := 'C:\Program Files\WinRAR\WinRAR.exe';
  end
  else if tipoCompactacao = '.zip' then begin // WinZip
    nomeDoArquivoDestino := ChangeFileExt(FormatDateTime('yyyy-mm-dd hh-nn-ss-zzz', Now), '.zip');
    pathFileDestino := pathFileDestino + '\' + nomeDoArquivoDestino;
    linhadeComando := '-A "' + pathFileDestino + '" ' + pathFilesOrigem;
    pathProgramaWin := 'C:\Program Files (x86)\WinZip\WINZIP32.EXE';
  end;

  ShellExecute(0, 'open', PChar(pathProgramaWin), PChar(linhadeComando), nil, 1);
end;

end.
