unit SVGChart;

interface


uses System.Classes, SVGtypes, SVGPanel, uSVGChart, SVGAxes;




type
  CSVGChart = class(uCSVGChart)

  private

  protected
   
  protected
     procedure DrawPanel();
  public
    panel : CSVGPanel;

    axises : TList;


    procedure Draw();
    procedure DrawGrid();
    procedure DrawAxises();
    procedure DrawItems();
    procedure DrawSeries();


    procedure AddPanel(p : CSVGPanel);
    procedure AddAxis(var a : CSVGAxis);


    constructor Create(var p : ChartIniPara);
  end;

implementation


uses System.SysUtils;




{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
constructor CSVGChart.Create(var p : ChartIniPara);
begin
  iniPara := p;

  panel := nil;

  axises := TList.Create;
end;





{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CSVGChart.AddAxis(var a : CSVGAxis);
begin
   axises.Add(a);
end;



{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CSVGChart.AddPanel(p : CSVGPanel);
begin



  panel := p;
  panel.position := self.iniPara.position;

end;



{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CSVGChart.Draw();
begin
   with (iniPara.OutPutTS) do
   begin
     Add('<svg width="'+IntToStr(iniPara.drawAreaWidth)+'" height="'+IntToStr(iniPara.drawAreaHeight)+'" version="1.1" xmlns="http://www.w3.org/2000/svg">');

     DrawPanel();
//     DrawGrid();
     DrawAxises();
//     DrawItems();
//     DrawSeries();

     Add('</svg>');
   end;
end;




{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CSVGChart.DrawPanel();
begin
  if not(panel = nil) then
  begin
    panel.Draw(iniPara.OutPutTS);
  end;
end;




{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CSVGChart.DrawGrid();
begin
end;



{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CSVGChart.DrawAxises();
var
  ii : integer;
  a : CSVGAxis;
begin


  for ii := 0 to self.axises.Count-1 do
  begin
    a := axises[ii];
    a.Draw(self.iniPara)
  end;
end;



{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CSVGChart.DrawItems();
begin
end;



{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CSVGChart.DrawSeries();
begin
end;


end.
