program graphfunction;

uses
  Forms,
  main in 'main.pas' {MainForm},
  graph in 'graph.pas' {GraphForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TGraphForm, GraphForm);
  Application.Run;
end.
