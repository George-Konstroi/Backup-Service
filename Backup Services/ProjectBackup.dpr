program ProjectBackup;

uses
  Vcl.Forms,
  UnitBackup in 'UnitBackup.pas' {FormBackup},
  UnitIniciarArquivos in 'UnitIniciarArquivos.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormBackup, FormBackup);
  Application.Run;
end.
