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

// Обработчик создания формы
procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Определим папку по умолчанию для диалога открытия файла
  OpenDialog.InitialDir := ExtractFilePath(Application.ExeName);
end;

// Обработчик нажатия клавиш
procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
var
  i: Integer;
  list: TStringList;
begin
  // Откроем диалог и проверим существует ли выбранный файл
  if OpenDialog.Execute and FileExists(OpenDialog.FileName) then
  begin
    // Создаем временный список точек X
    list := TStringList.Create;
    // Загрузим данные из файла
    list.LoadFromFile(OpenDialog.FileName);
    // Определим длину массива для хранения точек Х
    SetLength(GraphForm.DotsX, list.Count);
    // Запишем точки в массив
    for i := 0 to list.Count - 1 do
    begin
      try
        GraphForm.DotsX[i] := StrToInt(list[i]);
      except
        // Вывод ошибки
        ShowMessage('Ошибка чтения файла.');
        // Очистим масиив точек
        SetLength(GraphForm.DotsX, 0);
        // Очистим список с точками
        list.Clear;
        // Прерываем выполнение программы
        exit;
      end;
    end;
    // Проверим кол-во точек
    if Length(GraphForm.DotsX) < 2 then
    begin
      // Вывод ошибки
      ShowMessage('Ошибка. Количество точек меньше двух.');
      // Очистим масиив точек
      SetLength(GraphForm.DotsX, 0);
      // Очистим список с точками
      list.Clear;
      // Прерываем выполнение программы
      exit;
    end;
    // Очистим список с точками
    list.Clear;
    // Открываем форму для рисования графика
    GraphForm.ShowModal;
  end;
end;

end.
