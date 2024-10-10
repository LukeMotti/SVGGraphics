unit SVGtypes;

interface


uses System.Classes;


const
  TOP : integer = 1002;
  BOTTOM : integer = 1003;
  LEFT : integer = 1004;
  RIGHT : integer = 1005;


  TOP_AXIS : integer = 1101;
  LEFT_AXIS : integer = 1102;
  BOTTOM_AXIS : integer = 1103;
  RIGHT_AXIS : integer = 1104;


type
  svgpos = record
    x, y : integer;
  end;


type
  myrect = record

  left, top : integer;
  heigth, width : integer;
end;


type
  svgImage = record


  position : svgpos;
  url : string;
end;



type
  FontRec = record


  size : single;
  color : string;
  font_name : string;
end;




type
  titleRec = record


  posX, posY : single;

  text : string;

  font : FontRec;
end;


type
  GridLinesRec = record


  lenghtOutside : single; //screen coordinates;
  lengthInside : single; // if boolMaxLength then LengthInside = chartHeight/width


  GridLineDistance : single;  //axis scale  f.e. axis 0-100 years

  LabelOnEvery : integer; // 1 = every, 2 = every second, 3 = every third...
end;






type
  AxisPara = record


  itype : integer; //left,top,bottom,right, horiz, verti
  minValue, maxValue : single;


  GridMajor : GridLinesRec;
  GridMinor : GridLinesRec;


  AxisTitle : titleRec;
end;



type
  PanelPara = record


  strokeWidth : single;
  strokeColor : string;

  opacity : single;
  pcolor : string;


  boolImage : boolean;
  img : svgImage;
end;



type
  ChartIniPara = record


  drawAreaWidth : integer;   //Piirtoalue
  drawAreaHeight : integer;

  position : myrect; //Chartin sijainti ja koko piirtoalueella

  backGround : PanelPara;

  OutPutTS : TStringList;
end;


implementation

end.
