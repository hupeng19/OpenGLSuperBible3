program OpenglSuperBible3Sam;

uses
  Forms,
  uMainFrame in 'uMainFrame.pas' {Form5},
  uOGLBase in 'uOGLBase.pas',
  uSample2_1 in 'Part_1_\uSample2_1.pas',
  uSample2_2 in 'Part_1_\uSample2_2.pas',
  uJet in 'Chapter5\uJet.pas',
  uSomeSameCode in 'uSomeSameCode.pas',
  uGLrect in 'Chpter2\uGLrect.pas',
  uTriangles in 'Chapter5\uTriangles.pas',
  uSmoother in 'Chapter6\uSmoother.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
