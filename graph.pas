unit graph;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TMyItem = class
    X: real;
    Y: real;
  public
    constructor Create(X, Y: real);
  end;

  TGraphForm = class(TForm)
    pbGraph: TPaintBox;
    procedure pbGraphPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    FDrawPoints: array of TPoint;
    FPoints, FSourceX: TList;
    function f(X: real): real;
    procedure CalculateGraph;
    procedure AddPoint(X, Y: real);
    procedure AddPoints(beginX, endX: integer; step: real);
  public
    property Source: TList read FSourceX write FSourceX;
  end;

var
  GraphForm: TGraphForm;

implementation

{$R *.dfm}
{ TGraphForm }

procedure TGraphForm.AddPoint(X, Y: real);
begin
  FPoints.Add(Pointer(TMyItem.Create(X, Y)));
end;

procedure TGraphForm.AddPoints(beginX, endX: integer; step: real);
var
  Center: TPoint;
  currentX, currentY: real;
begin
  Center.X := pbGraph.ClientWidth div 2;
  Center.Y := pbGraph.ClientHeight div 2;
  currentX := beginX;
  repeat
    currentY := f(currentX);
    AddPoint(currentX * 100 + Center.X, currentY * 100 - Center.Y);
    if endX < beginX then
      currentX := currentX - step
    else if endX > beginX then
      currentX := currentX + step;
  until (Trunc(currentX) = endX);
end;

procedure TGraphForm.CalculateGraph;
var
  i: integer;
begin
  FPoints.Clear;
  for i := 0 to Source.Count - 2 do
    AddPoints(integer(Source[i]), integer(Source[i + 1]), 0.1);

  SetLength(FDrawPoints, FPoints.Count);
  for i := 0 to FPoints.Count - 1 do
    FDrawPoints[i] := Point(Trunc(TMyItem(FPoints[i]).X),
      Trunc(TMyItem(FPoints[i]).Y));
end;

function TGraphForm.f(X: real): real;
begin
  Result := 2 * sqr(X);
end;

procedure TGraphForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FSourceX.Clear;
  FPoints.Clear;
end;

procedure TGraphForm.FormCreate(Sender: TObject);
begin
  FSourceX := TList.Create;
  FPoints := TList.Create;
end;

procedure TGraphForm.FormResize(Sender: TObject);
begin
  CalculateGraph;
end;

procedure TGraphForm.FormShow(Sender: TObject);
begin
  CalculateGraph;
end;

procedure TGraphForm.pbGraphPaint(Sender: TObject);
var
  origin: TPoint;
begin
  with pbGraph.Canvas do
  begin
    { Заполним фон белым цветом }
    Brush.Color := clBtnFace;
    Brush.Style := bsSolid;
    Fillrect(pbGraph.BoundsRect);

    { Ось координат }
    origin := Point(pbGraph.Width div 2, pbGraph.Height div 2);
    Pen.Color := clBlack;
    Pen.Style := psSolid;
    Pen.Width := 1;
    MoveTo(1, origin.Y);
    LineTo(pbGraph.Width - 1, origin.Y);
    MoveTo(origin.X, 1);
    LineTo(origin.X, pbGraph.Height - 1);

    { Рисуем график }
    Pen.Color := clBlue;
    Pen.Width := 2;
    Polyline(FDrawPoints);
  end;
end;

{ TMyItem }

constructor TMyItem.Create(X, Y: real);
begin
  self.X := X;
  self.Y := Y;
end;

end.
