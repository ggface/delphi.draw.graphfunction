unit graph;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TGraphForm = class(TForm)
    pbGraph: TPaintBox;
    procedure pbGraphPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FPoints: array [0..144] of TPoint;
    procedure CalculateGraph;
    function GetPoint(Index: Integer): TPoint;
  public
    property Points[Index: Integer]: TPoint read GetPoint;
  end;

var
  GraphForm: TGraphForm;

implementation

{$R *.dfm}

{ TGraphForm }

procedure TGraphForm.CalculateGraph;
var
  xRangePixels, yRangePixels: Integer;
  origin: TPoint;
  radian, interval: Double;
  i: Integer;
begin
  xRangePixels := (pbGraph.Width - 2) div 4;
  yRangePixels := (pbGraph.Height - 2) div 2;
  origin       := Point(pbGraph.Width div 2, pbGraph.Height div 2);
  radian       := -2.0 * Pi;
  interval     := 4.0 * Pi / 144.0;
  for i := 0 to High(FPoints) do 
  begin
    FPoints[i].X := origin.x + Round(radian * xRangePixels / Pi);
    FPoints[i].Y := origin.y - Round(sin(radian) * yRangePixels);
    radian       := radian + interval;
  end;
end;

procedure TGraphForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ModalResult := mrYes;
end;

procedure TGraphForm.FormResize(Sender: TObject);
begin
  CalculateGraph;
end;

procedure TGraphForm.FormShow(Sender: TObject);
begin
  CalculateGraph;
end;

function TGraphForm.GetPoint(Index: Integer): TPoint;
begin
   result := FPoints[Index];
end;

procedure TGraphForm.pbGraphPaint(Sender: TObject);
var
  origin: TPoint;
  xRangePixels, yRangePixels: Integer;
begin
  with pbGraph.Canvas do
  begin
    { Заполним фон белым цветом }
    Brush.Color := clBtnFace;
    Brush.Style := bsSolid;
    Fillrect(pbGraph.BoundsRect);

    { Ось координат }
    origin    := Point(pbGraph.Width div 2, pbGraph.Height div 2);
    Pen.Color := clBlack;
    Pen.Style := psSolid;
    Pen.Width := 1;
    MoveTo(1, origin.Y);
    LineTo(pbGraph.Width - 1, origin.y);
    MoveTo(origin.x, 1);
    LineTo(origin.x, pbGraph.Height - 1);

    { Нарисуем деления и подписи }
    Font.Name    := 'Symbol';
    Font.Size    := 8;
    Font.Color   := clBlack;
    xRangePixels := (pbGraph.Width - 2) div 4; { пихсели в Pi }
    yRangePixels := (pbGraph.Height - 2) div 2; { пихсели в 1 }

    { Ось Х }
    MoveTo(origin.x - 2 * xRangePixels, origin.y - 4);
    LineTo(origin.x - 2 * xRangePixels, origin.y + 4);
    TextOut(origin.x - 2 * xRangePixels + 2, origin.y + 2, '-2p');
    MoveTo(origin.x - xRangePixels, origin.y - 4);
    LineTo(origin.x - xRangePixels, origin.y + 4);
    TextOut(origin.x - xRangePixels + 2, origin.y + 2, '-p');
    MoveTo(origin.x + xRangePixels, origin.y - 4);
    LineTo(origin.x + xRangePixels, origin.y + 4);
    TextOut(origin.x + xRangePixels - 2 - TextWidth('p'), origin.y + 2, 'p');
    MoveTo(origin.x + 2 * xRangePixels, origin.y - 4);
    LineTo(origin.x + 2 * xRangePixels, origin.y + 4);
    TextOut(origin.x + 2 * xRangePixels - 2 - TextWidth('2p'), origin.y + 2, '2p');


    { Ось Y }
    MoveTo(origin.x - 4, origin.y - yRangePixels);
    LineTo(origin.x + 4, origin.y - yRangePixels);
    TextOut(origin.x + 4, origin.y - yRangePixels, '1.0');
    MoveTo(origin.x - 4, origin.y - yRangePixels div 2);
    LineTo(origin.x + 4, origin.y - yRangePixels div 2);
    TextOut(origin.x + 4, origin.y - (yRangePixels + TextHeight('1')) div 2, '0.5');
    MoveTo(origin.x - 2, origin.y + yRangePixels div 2);
    LineTo(origin.x + 2, origin.y + yRangePixels div 2);
    TextOut(origin.x + 3, origin.y + (yRangePixels - TextHeight('1')) div 2, '-0.5');
    MoveTo(origin.x - 2, origin.y + yRangePixels);
    LineTo(origin.x + 2, origin.y + yRangePixels);
    TextOut(origin.x + 3, origin.y + yRangePixels - TextHeight('1'), '-1.0');

    { Рисуем график }
    Pen.Color := clBlue;
    Polyline(FPoints);
  end;
end;

end.
