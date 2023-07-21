program ProjectBackup;

uses
  Vcl.Forms,
  UnitBackup in 'UnitBackup.pas' {FormBackup},
  UnitControllerBackup in 'UnitControllerBackup.pas',
  UnitReadWriteFile in 'UnitReadWriteFile.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormBackup, FormBackup);
  Application.Run;
end.
