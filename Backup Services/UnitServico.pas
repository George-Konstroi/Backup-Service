unit UnitServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  Vcl.ExtCtrls;

type
  TmServico = class(TService)
    Timer: TTimer;
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
    procedure BackupWithWin(Compactar, Tipo, pathFilesOrigem, pathFileDestino: string);
    procedure BackupWithoutWin(Compactar, Tipo, pathFileOrigem, pathFileDestino: string);
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  mServico: TmServico;
implementation

{$R *.dfm}

uses
  IniFiles, ShellAPI;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  mServico.Controller(CtrlCode);
end;

procedure TmServico.BackupWithoutWin(Compactar, Tipo, pathFileOrigem,
  pathFileDestino: string);
begin
  pathFileDestino := pathFileDestino + '\' + ExtractFileName(pathFileOrigem);

  if not CopyFile(PChar(pathFileOrigem), PChar(pathFileDestino), true) then
    ShowMessage('Erro ao copiar ' + pathFileOrigem + ' para ' + pathFileDestino + ': ' + SysErrorMessage(GetLastError));
end;

procedure TmServico.BackupWithWin(Compactar, Tipo, pathFilesOrigem, pathFileDestino: string);
var
  nomeDoArquivo: string;
  linhadeComando: string;
  pathProgramaWin: string;
begin
  if Tipo = 'Z' then begin 
    nomeDoArquivo := ChangeFileExt(FormatDateTime('yyyy-mm-dd hh-nn-ss-zzz', Now), '.rar');
    pathFileDestino := pathFileDestino + '\' + nomeDoArquivo;
    linhadeComando := 'a "' + pathFileDestino + '" ' + pathFilesOrigem;
    pathProgramaWin := 'C:\SProgram Files\WinRAR\WinRAR.exe';
  end
  else begin
    nomeDoArquivo := ChangeFileExt(FormatDateTime('yyyy-mm-dd hh-nn-ss-zzz', Now), '.zip');
    pathFileDestino := pathFileDestino + '\' + ExtractFileName(nomeDoArquivo);
    linhadeComando := '-A "' + pathFileDestino + '" ' + pathFilesOrigem;
    pathProgramaWin := 'C:\Program Files (x86)\WinZip\WINZIP32.EXE';
  end;

  ShellExecute(0, 'open', PChar(pathProgramaWin), PChar(linhadeComando), nil, SW_SHOWNORMAL);
end;

function TmServico.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TmServico.TimerTimer(Sender: TObject);
var
  conf: TIniFile;
  pData: TDate;
  Compactar: string;
  TipoComp: string;
  Destino: string;
  Lista: TStringList;
  I: Integer;
  CaminhoArquivo: string;
begin
  conf := nil;
  Compactar := 'N';
  
  try
    try
      conf := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Backup.ini');
      pData := StrToDate(conf.ReadString('BACKUP','ULTIMO',''));

      if pData < Date then begin
        Compactar := Trim(conf.ReadString('BACKUP','COMPACTAR',''));

        if Compactar = 'S' then
          TipoComp := Trim(conf.ReadString('BACKUP','TIPO',''));

        Destino := conf.ReadString('BACKUP','DESTINO','');
        Lista := TStringList.Create;
        Lista.LoadFromFile(ExtractFilePath(ParamStr(0))+'Lista.ini');

        if Compactar = 'S' then begin
          for I := 0 to Lista.Count - 1 do
            CaminhoArquivo := '"' + Lista.Strings[I] + '" ' + CaminhoArquivo;

          BackupWithWin(Compactar,TipoComp,CaminhoArquivo,Destino);
        end
        else begin
          for I := 0 to Lista.Count - 1 do begin
            CaminhoArquivo := Lista.Strings[I];
            BackupWithoutWin(Compactar,TipoComp,CaminhoArquivo,Destino);
          end;
        end;

        conf.WriteString('BACKUP','ULTIMO',
        FormatDateTime('dd/MM/yyyy',Date));
      end;
    except end;
  finally
    conf.Free;
    Lista.Free;
  end;
end;

end.
