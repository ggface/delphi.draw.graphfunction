unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TMainForm = class(TForm)
    Label1: TLabel;
    OpenDialog: TOpenDialog;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

uses graph;

{$R *.dfm}
{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  OpenDialog.InitialDir := Copy(paramstr(0), 1,
    LastDelimiter('\:', paramstr(0)));
end;

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
var
  i: Integer;
  list: TStringList;
begin
  if OpenDialog.Execute and FileExists(OpenDialog.FileName) then
  begin
    // Откроем файл с данными
    list := TStringList.Create;
    list.LoadFromFile(OpenDialog.FileName);
    // Заполняем массив
    GraphForm.Source.Clear;
    for i := 0 to list.Count - 1 do
    begin
      try
        GraphForm.Source.Add(pointer(StrToInt(list[i])));
      except
        ShowMessage('Ошибка чтения точки координат.');
        continue;
      end;
    end;
    FreeAndNil(list);
    // Открываем форму
    GraphForm.ShowModal;
  end;
end;

end.
