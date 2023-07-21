unit UnitReadWriteFile;

interface

uses
   System.SysUtils, System.Variants, System.Classes, IniFiles, Winapi.Windows;

type
  TUnitReadWriteFile = class(TObject)
  private
    class var configuracoes: TIniFile;
  public
    constructor Create;
    function getCompactar(): Boolean;
    procedure setCompactar(compactar: Boolean);
    function getTipoCompactacao(): string;
    procedure setTipoCompactacao(tipo: string);
    function getDestino(): string;
    procedure setDestino(destino: string);
    function getLista(): string;
    procedure setLista();
    procedure atualizarDataModificacao();
  end;

var
  RWFile: TUnitReadWriteFile;

implementation

{ TUnitReadWriteFile }

constructor TUnitReadWriteFile.create;
begin
  configuracoes := nil;
  configuracoes := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Backup.ini');
end;

procedure TUnitReadWriteFile.atualizarDataModificacao;
begin
  configuracoes.WriteString('BACKUP','ULTIMO', FormatDateTime('dd/mm/yyyy', Date));
end;

function TUnitReadWriteFile.getCompactar: Boolean;
begin
  if configuracoes.ReadString('BACKUP','COMPACTAR','') = 'S' then Result := True
  else if configuracoes.ReadString('BACKUP','COMPACTAR','') = 'N' then Result := False;
end;

function TUnitReadWriteFile.getDestino: string;
begin
  Result := configuracoes.ReadString('BACKUP','DESTINO','');
end;

function TUnitReadWriteFile.getLista: string;
begin

end;

function TUnitReadWriteFile.getTipoCompactacao: string;
begin
  if configuracoes.ReadString('BACKUP','TIPO','') = 'R' then Result := '.rar'
  else if configuracoes.ReadString('BACKUP','TIPO','') = 'Z' then Result := '.zip';
end;

procedure TUnitReadWriteFile.setCompactar(compactar: Boolean);
begin
  configuracoes.WriteString('BACKUP','COMPACTAR','S');
end;

procedure TUnitReadWriteFile.setDestino(destino: string);
begin
  configuracoes.WriteString('BACKUP','DESTINO', destino);
end;

procedure TUnitReadWriteFile.setLista;
begin

end;

procedure TUnitReadWriteFile.setTipoCompactacao(tipo: string);
begin
  if tipo = '.rar' then configuracoes.WriteString('BACKUP','TIPO','R')
  else if tipo = '.zip' then configuracoes.WriteString('BACKUP','TIPO','Z');
end;

end.
