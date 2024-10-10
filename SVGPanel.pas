unit SVGPanel;

interface


uses SVGtypes, System.Classes;



type
  CSVGPanel = class(TObject)

  private

  protected

  public
    para : PanelPara;

    position : myrect;

    procedure Draw(var ts : TStringList);

    constructor Create(var p : PanelPara);
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
constructor CSVGPanel.Create(var p : PanelPara);
begin
  para := p;
end;





{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CSVGPanel.Draw(var ts : TStringList);
var
  line : string;
begin
   line := '<rect x="'+IntToStr(position.left)+'" y="'+IntToStr(position.top)+'" width="'+IntToStr(position.width)+'" height="'+IntToStr(position.heigth)+'" stroke="'+para.strokecolor+'" stroke-width="'+FormatFloat('#0.0', para.strokewidth)+'" fill="'+para.pcolor+'" />';


   ts.Add(line);
end;



end.
