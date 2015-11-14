program Delphi7Demo;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  untICall in 'untICall.pas',
  untLicense in 'untLicense.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
