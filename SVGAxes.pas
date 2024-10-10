unit SVGAxes;

interface


uses SVGTypes, System.Classes;


type
  CSVGAxis = class(TObject)

  private

  protected

  public




     para : AxisPara;


     constructor Create(a : AxisPara);

     procedure Draw(p : ChartIniPara);
  end;



implementation


uses System.SysUtils, SVGfunctions;



{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
constructor CSVGAxis.Create(a : AxisPara);
begin
  para := a;
end;





{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CSVGAxis.Draw(p : ChartIniPara);
var
  v : single;
  n : single;

  linecolor, xtra : string;
  sx1, sy1, sx2, sy2 : integer;
begin
  v := para.minValue;

  n := para.minValue;
  while (n <= para.MaxValue) do
  begin
    if (para.itype = LEFT_AXIS) then
    begin
      sx1 := Round(p.position.left - para.GridMajor.lenghtOutside);
      sx2 := p.position.left + p.position.width;

      sy1 := GetScreenY(p, n, para.minValue, para.maxValue);
      sy2 := sy1;

      linecolor := '#000000';
      xtra := '';


      p.OutPutTS.Add('<line x1="'+IntToStr(sx1)+'" y1="'+IntToStr(sy1)+'" x2="'+IntToStr(sx2)+'" y2="'+IntToStr(sy2)+'" style="stroke:'+linecolor+';stroke-width:2; '+xtra+'" />');
    end;
    n := n + para.GridMajor.GridLineDistance;
  end;


  n := para.minValue;
  while (n <= para.MaxValue) do
  begin
    if (para.itype = LEFT_AXIS) then
    begin
      sx1 := Round(p.position.left - para.GridMajor.lenghtOutside);
      sx2 := Round(p.position.left + para.GridMajor.lenghtOutside);

      sy1 := GetScreenY(p, n, para.minValue, para.maxValue);
      sy2 := sy1;

      linecolor := '#000000';
      xtra := '';


      p.OutPutTS.Add('<line x1="'+IntToStr(sx1)+'" y1="'+IntToStr(sy1)+'" x2="'+IntToStr(sx2)+'" y2="'+IntToStr(sy2)+'" style="stroke:'+linecolor+';stroke-width:2; '+xtra+'" />');
    end;
    n := n + para.GridMinor.GridLineDistance;
  end;


end;


end.
