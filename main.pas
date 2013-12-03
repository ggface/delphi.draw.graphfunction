unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TMainForm = class(TForm)
    Label1: TLabel;
    SaveDialog: TSaveDialog;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  end;

var
  MainForm: TMainForm;

  implementation

uses graph;

{$R *.dfm}

{ TMainForm }

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
var
  i: Integer;
  list: TStringList;
begin
  if GraphForm.ShowModal = mrYes then
    if SaveDialog.Execute then
    begin
      list := TStringList.Create;
      for i := 0 to 144 - 1 do
        list.Add('X: ' + IntToStr(GraphForm.Points[i].X) + #9 + 'Y: ' +
          IntToStr(GraphForm.Points[i].Y));
      try
        list.SaveToFile(SaveDialog.FileName);
      except
        ShowMessage('Ошибка сохранения файла. Путь ' + SaveDialog.FileName);
      end;
      FreeAndNil(list);
    end;
end;

end.
