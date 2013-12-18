unit graph;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TGraphForm = class(TForm)
    pbGraph: TPaintBox;
    procedure pbGraphPaint(Sender: TObject);
  public
    DotsX: array of integer;
  end;

var
  GraphForm: TGraphForm;

implementation

{$R *.dfm}
{ TGraphForm }

const
  xmin = -10;
  xmax = 10;
  ymin = -10;
  ymax = 10;

  // Функция, график которой надо построить
function f(x: real): real;
begin
  // Result := sin(x) * cos(x);
  Result := sin(x) * cos(x);
end;

// Событие при перерисовке пэинтбокса
procedure TGraphForm.pbGraphPaint(Sender: TObject);
var
  x, y, h: real;

  max, min: real;

  sx, sy: real;

  xmid, ymid: integer;

  a, b: real;
begin
  with pbGraph.Canvas do
  begin
    // Найдем центр холста
    xmid := pbGraph.Width div 2;
    ymid := pbGraph.Height div 2;

    // Заполним фон белым цветом
    Brush.Color := clBtnFace;
    Brush.Style := bsSolid;
    FillRect(pbGraph.BoundsRect);

    // Ось координат
    Pen.Color := clBlack;
    Pen.Style := psSolid;
    Pen.Width := 1;
    MoveTo(1, ymid);
    LineTo(pbGraph.Width - 1, ymid);
    MoveTo(xmid, 1);
    LineTo(xmid, pbGraph.Height - 1);

    // Рисуем график
    Pen.Color := clBlue;
    Pen.Width := 2;
    a := -1;
    b := 1;

    sx := (ClipRect.Right) / (b - a);
    h := 1 / sx;
    x := a;
    max := f(x);
    min := max;

    while x <= b do
    begin
      y := f(x);

      if y < min then
        min := y;

      if y > max then
        max := y;

      x := x + h;
    end;

    sy := ClipRect.Bottom / (max - min);
    x := a;
    y := f(x);
    MoveTo(xmid + round(sx * x), ymid - round(sy * y));

    while x <= b do
    begin
      y := f(x);
      LineTo(xmid + round(sx * x), ymid - round(sy * y));
      x := x + h;
    end;
  end;
end;

end.
