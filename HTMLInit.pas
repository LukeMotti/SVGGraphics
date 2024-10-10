unit HTMLInit;

interface

uses System.Classes, System.SysUtils


{$IF defined(MLBWORLD)}
, MLBFunctions
{$ENDIF}
;



type
  HTMLInitOptions = record


  boolBack : boolean;
  boolCreated : boolean;

end;



type
  CStyle = class(TObject) //Luokka HTML tiedoston määrittelyihin
  private
    procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings) ;
  public
    lines : TStringList;
    name, strPost : string;

    constructor Create(n : string; divi : string=' .');
    destructor Destroy();

    procedure ExportStyle(var ts : TStringList);
    procedure AddDefinitionLine(l : string; pp : string='');
end;



type
  CNaviItem = class(TObject)

  private

  public
    link : string;
    caption : string;


    constructor Create(l, c : string);

    procedure ExportItem(var ts : TStringList);
end;



type
  CNavigationMenu = class(TObject) //
  private


  public
    itemlist : TList;
    headerStyle, linkStyle : string;
    itype : integer; // 0 = RR, 1 = SplitView

    strFont : string;

    procedure ExportStyle(ts : TStringList);
    procedure ExportBody(ts : TStringList);

    procedure AddMenu(link, caption : string);

    constructor Create(i : integer);
end;




type
  CHTMLInit = class(TObject) //Luokka HTML tiedoston määrittelyihin
  private

  public
    styles : TList;
    navigation : CNavigationMenu;

    title : string;

    options : HTMLInitOptions;

    extras : TStringList;


    constructor Create();overload;
    constructor Create(o : HTMLInitOptions);overload;
    destructor Destroy();


    procedure AddStyle(s : CStyle);
    procedure AddNavigation(n : CNavigationMenu);
    procedure ExportHTML(var ts : TStringList);
end;


implementation



{$IF defined(SPORTSANALYSER)}
uses MyFunctions;
{$ENDIF}



//


{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
constructor CNaviItem.Create(l, c : string);
begin
  self.link := l;
  self.caption := c;
end;



{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CNaviItem.ExportItem(var ts : TStringList);
begin
  if (Pos('#', link)=0) then
  begin
    ts.Add('<BR>'+link+caption+'</FONT><BR>');
  end
  else
  begin
    ts.Add('<a href="'+link+'" class="mvmenuitem" onclick="closeNav()">'+caption+'</a>');
  end;
end;




{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
constructor CNavigationMenu.Create(i : integer);
begin
   itemlist := TList.Create;


   strFont := '<FONT size="4">';


   itype := i;


   headerStyle := 'margin: 10px 0 1px; color: #79cbee;';
   linkStyle := 'color: #f2f2f2; text-decoration: none; padding: 1px 15px 1px 0;';
end;


{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CNavigationMenu.AddMenu(link, caption : string);
var
  ni : CNaviItem;
begin
  if (link = '') then link := strFont;
  

  ni := CNaviItem.Create(link, caption);

  self.itemlist.Add(ni);
end;






{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CNavigationMenu.ExportStyle(ts : TStringList);
begin

  if (itype = 0) then
  begin
    ts.Add('#mvmenu {position: fixed; top: 0; background-color: #404040; padding: 10px 0; display: block; width: 100%;}');
    ts.Add('#mvmenu p {' + headerStyle + '}');
    ts.Add('#mvmenu a {' + linkStyle + '}');

    ts.add('#mvmenuwrapper {margin: 0 auto; text-align: center; padding: 0 0px;}');
    ts.Add('a.mvmenuitem {}');

    ts.Add('#mvmenu p {display: none;}');
    ts.Add('#mvmenumobbutton{display: inline; padding: 1px 0; display: block;}');
  end;

  if (itype = 1) then
  begin
      ts.Add('');
      ts.Add('');
      ts.Add('body {');
      ts.Add('  font-family: "Lato", sans-serif;');
      ts.Add('}');
      ts.Add('');
      ts.Add('.sidenav {');
       ts.Add('  height: 100%;');
       ts.Add('  width: 0;');
       ts.Add('  position: fixed;');
       ts.Add('  z-index: 1;');
       ts.Add('  top: 0;');
       ts.Add('  left: 0;');
       ts.Add('  background-color: #111;');
       ts.Add('  overflow-x: hidden;');
       ts.Add('  transition: 0.5s;');
       ts.Add('  padding-top: 60px;');
       ts.Add('}');
       ts.Add('');
       ts.Add('.sidenav a {');
       ts.Add('  padding: 8px 8px 8px 32px;');
       ts.Add('  text-decoration: none;');
       ts.Add('  font-size: 25px;');
       ts.Add('  color: #818181;');
       ts.Add('  display: block;');
       ts.Add('  transition: 0.3s;');
       ts.Add('}');


      ts.Add('');
      ts.Add('.sidenav bb {');
      ts.Add('  padding: 18px 18px 18px 32px;');
      ts.Add('  text-decoration: none;');
      ts.Add('  font-size: 15px;');
      ts.Add('  color: #e6be1b;');
      ts.Add('  display: block;');
      ts.Add('  margin-left: 50px;');
      ts.Add('  }');

       ts.Add('');
       ts.Add('.sidenav a:hover {');
       ts.Add('  color: #f1f1f1;');
       ts.Add('}');
       ts.Add('');
       ts.Add('.sidenav .closebtn {');
       ts.Add('  position: absolute;');
       ts.Add('  top: 0;');
       ts.Add('  right: 25px;');
       ts.Add('  font-size: 36px;');
       ts.Add('  margin-left: 50px;');
       ts.Add('}');
       ts.Add('');
       ts.Add('@media screen and (max-height: 450px) {');
       ts.Add('  .sidenav {padding-top: 15px;}');
       ts.Add('  .sidenav a {font-size: 18px;}');
       ts.Add('}');
  end;
end;


{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CNavigationMenu.ExportBody(ts : TStringList);
var
  ii : integer;
  ni : CNaviItem;
begin
  if (itype = 0) then
  begin
     ts.Add('<div id="mvmenu">');
     ts.Add(' <div id="mvmenuwrapper">');
     ts.Add('<p></p>');          //header
     ts.Add('   <div id="mvmenumobbutton" onclick="openNav()"></div>');

     for ii := 0 to itemlist.count-1 do
     begin
         ni := itemlist[ii];
         ni.ExportItem(ts);
     end;

        ts.Add(' </div>');
     ts.Add('</div>');
  end;

  if (itype = 1) then
  begin
      ts.Add('');
     ts.Add('<span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776;</span>');
     ts.Add('');
     ts.Add('');
     ts.Add('<script>');
     ts.Add('function openNav() {');
     ts.Add('  document.getElementById("mySidenav").style.width = "250px";');
     ts.Add('}');
     ts.Add('');
     ts.Add('function closeNav() {');
     ts.Add('  document.getElementById("mySidenav").style.width = "0";');
     ts.Add('}');
     ts.Add('</script>');
     ts.Add('');

     ts.Add('');
     ts.Add('');
     ts.Add('');
     ts.Add('<div id="mySidenav" class="sidenav">');
     ts.Add('  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>');
     ts.Add('');
     for ii := 0 to itemlist.count-1 do
     begin
         ni := itemlist[ii];
         ni.ExportItem(ts);
     end;
     ts.Add(' ');
     ts.Add('</div>');
     ts.Add('');

  end;
end;


{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
constructor CStyle.Create(n : string; divi : string);
begin
   name := n;
   strPost := divi;
   lines := TStringList.Create;
end;


{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
destructor CStyle.Destroy();
begin
   lines.Clear;
   lines.Free;
end;




{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CStyle.AddDefinitionLine(l : string; pp : string);
var
  line : string;
  ts2 : TStringList;
  ii: Integer;
begin
  if (pp='') then
  begin
    line := strPost+name+' {'+l+'}';
  end
  else
  begin
    ts2 := TStringList.Create();
    Split(';', pp, ts2);

    line := '';
    for ii := 0 to ts2.Count-1 do
    begin
       if (ii>0) then line := line + ', ';
       
       line := line + strPost+name+' '+ts2[ii];
    end;

    line := line +' {'+l+'}';
  end;

  lines.Add(line);
end;



{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus: Pilkkoo merkkijonon osamerkkijonoiksi
  Result:    None
-----------------------------------------------------------------------------}
procedure CStyle.Split(Delimiter: Char; Str: string; ListOfStrings: TStrings) ;
begin
   ListOfStrings.Clear;
   ListOfStrings.Delimiter       := Delimiter;
   ListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
   ListOfStrings.DelimitedText   := Str;
end;

{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CStyle.ExportStyle(var ts : TStringList);
var
  line : string;
  ii: Integer;
begin
   for ii := 0 to self.lines.Count-1 do
   begin
      line := lines[ii];
      ts.Add(line);
   end;
end;







{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
constructor CHTMLInit.Create();
begin
   styles := TList.Create;
   extras := TStringList.Create;
   navigation := nil;

   title := '';

   options.boolBack := false;
   options.boolCreated := false;
end;



{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
constructor CHTMLInit.Create(o : HTMLInitOptions);
begin
  options := o;

   extras := TStringList.Create;

   styles := TList.Create;
   navigation := nil;

   title := '';
end;


{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
destructor CHTMLInit.Destroy();
begin

end;



{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CHTMLInit.AddStyle(s : CStyle);
begin
   styles.Add(s);
end;





{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CHTMLInit.ExportHTML(var ts : TStringList);
var
  ii: Integer;
  s : CStyle;
begin
    ts.Add('<HTML>');

    if not(title = '') then
    begin
      ts.Add('<title>'+title+'</title>');
    end;
    ts.Add('<head>');
    ts.Add('<meta charset="utf-8">');
    ts.Add('<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">');
    ts.Add('<link rel="preconnect" href="https://fonts.gstatic.com">');
    ts.Add('<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">');
    ts.Add('');
    ts.Add('<style>');

    for ii := 0 to styles.Count-1 do
    begin
       s := styles[ii];
       s.ExportStyle(ts);
    end;


    if not(navigation = nil) then
    begin
       navigation.ExportStyle(ts);
    end;

    for ii := 0 to extras.Count-1 do
    begin
        ts.Add(extras[ii]);
    end;

    ts.Add('</style>');
    ts.Add('<body>');


    if not(navigation = nil) then
    begin
       navigation.ExportBody(ts);
    end;


    if (options.boolCreated) then
    begin
       ts.Add(GetHTMLtimeStamp());
    end;

    if (options.boolBack) then
    begin
      ts.Add('<br><A HREF="javascript:javascript:history.go(-1)" style="text-decoration:none"><< BACK</A><br><br>');
    end;


end;




{-----------------------------------------------------------------------------
  Procedure:
  Vastuu hlö:    ml
  Argumentit:
  Kuvaus:
  Result:    None
-----------------------------------------------------------------------------}
procedure CHTMLInit.AddNavigation(n : CNavigationMenu);
begin
  self.navigation := n;
end;


end.
