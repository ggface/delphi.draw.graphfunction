unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TMainForm = class(TForm)
    Label1: TLabel;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  MainForm: TMainForm;

  implementation

uses graph;

{$R *.dfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  OpenDialog.InitialDir := Copy(paramstr(0), 1, LastDelimiter('\:', paramstr(0)));
end;

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
var
  i: Integer;
  point: TPoint;
  list: TStringList;
begin
  if OpenDialog.Execute and FileExists(OpenDialog.FileName) then
  begin
    // Откроем файл с данными
    list := TStringList.Create;
    list.LoadFromFile(OpenDialog.FileName);
    // Заполняем массив точками
    GraphForm.SetLength(list.Count);
    for i := 0 to list.Count - 1 do
    begin
      try
        point.X := StrToInt(Copy(list[i], 1, Pos(#9, list[i]) - 1));
        point.Y := StrToInt(Copy(list[i], Pos(#9, list[i]) + 1,
          Length(list[i])));
      except
        ShowMessage('Ошибка чтения точки координат.');
        continue;
      end;
      GraphForm.Points[i] := point;
    end;
    // Открываем форму
    GraphForm.ShowModal;
  end
  else
    ShowMessage('Ошибка открытия файла.');
end;

end.
