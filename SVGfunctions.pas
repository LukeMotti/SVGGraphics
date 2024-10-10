unit SVGfunctions;

interface

uses SVGTypes;

function GetScreenY(p : ChartIniPara; yval, min, max : single):integer;

implementation






{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
function GetScreenY(p : ChartIniPara; yval, min, max : single):integer;
var
  v, y1 : single;
begin
   v := (yval-min) / (max-min);

   y1 := p.position.heigth + p.position.top;

   y1 := y1 - v * p.position.heigth;

   result := Round(y1);
end;


end.
