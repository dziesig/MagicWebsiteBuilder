{==============================================================================}
{ Copyright (c) 2010, 2011, 2012 by Donald R. Ziesig.  All Rights Reserved.    }
{==============================================================================}
{  This file is part of MagicWebsiteBuilder.                                   }
{									       }
{  MagicWebsiteBuilder is free software: you can redistribute it and/or modify }
{  it under the terms of the GNU General Public License as published by	       }
{  the Free Software Foundation, either version 3 of the License, or	       }
{  (at your option) any later version.					       }
{									       }
{  MagicWebsiteBuilder is distributed in the hope that it will be useful,      }
{  but WITHOUT ANY WARRANTY; without even the implied warranty of	       }
{  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the	       }
{  GNU General Public License for more details.				       }
{									       }
{  You should have received a copy of the GNU General Public License	       }
{  along with MagicWebsiteBuilder in file COPYING.  If not, see 	       }
{  <http://www.gnu.org/licenses/>.					       }
{==============================================================================}
unit WebsiteGeneratorUnit1;

//{$mode objfpc}{$H+}
{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils,

  GeneratorObjectUnit1, CustomizedWebsiteUnit1, WebsiteMenusUnit1,
  WebsiteRootUnit1, MenuItemUnit1;

type
  TMenuConfig = ( mcNone,             // May have to add to this if we implement
                  mcSingleTop,        // left or right menus.
                  mcSingleBottom,
                  mcDouble );



  { TWebsiteGenerator }

  TWebsiteGenerator = class( TGenerator )
  protected
    fTestMode : Boolean;

    procedure WriteMenuTree(     Menu : TWebsiteMenuData;
                             var F    : TextFile );
{$ifdef OLD_WRITE_MENU_ITEM}
    procedure WriteMenuItem(     Node   : TTreeNode;
                                 Menu   : TWebsiteMenuData;
                             var F      : TextFile;
                                 Indent : Integer;
                                 Top    : Boolean );
{$else}
    procedure WriteMenuItem(     Item   : TTCWMenuItem;
                                 Menu   : TWebsiteMenuData;
                             var F      : TextFile;
                                 Indent : Integer;
                                 Top    : Boolean );
{$endif}

    procedure GenerateCSS( Obj      : TWebsiteRoot;
                           Template : String;
                           FileName : String = '' );

    procedure GenerateHTML( Menu     : TWebsiteMenuData ); overload;
    procedure GenerateHTML( FilePrefix : String;  { e.g. "IDXHeader" }
                            Config : TMenuConfig ); overload;

    procedure GenerateIDXHeaderFooter;
    procedure GenerateIDXJs( Menu : TWebsiteMenuData; var Dest, Template : TextFile );

    procedure GenerateWebsiteChecklist;

    procedure CreateLocalTest;
    procedure GenerateImages;

    procedure UpdateMenuX( FilePrefix, Flag : String;
                           TheMenu          : TWebsiteMenuData;
                           Script           : Boolean;
                           Test             : Boolean = false );

    procedure ReplaceFileContents( var OutFile, InFile : TextFile; Obj : TWebsiteRoot = nil );
    function  ReplaceVariables( Line, StartDelim, EndDelim : String; Obj : TWebsiteRoot = nil) : String;
    function  Find( Variable, Line : String; Obj : TWebsiteRoot = nil ) : String;

  public
    constructor Create( aWebsite : TCustomizedWebsite ); override;
    procedure   Generate( TestMode : Boolean = false);
  end;

implementation

uses
  Common1, Dialogs, Graphics, StringSubs;

{ TWebsiteGenerator }

constructor TWebsiteGenerator.Create(aWebsite: TCustomizedWebsite);
var
  WebsitePth, WorkPth : String;
begin
  inherited Create(aWebsite);
  WorkPth := WorkPath;
  WebsitePth := WebsitePath;
//  { Remove and recreate the work directory for this website }
  if DirectoryExists(WebsitePth) then
    try
      WalkDirectoryTree(WebsitePth,'','*.*',faAnyFile,True,RmFiles,nil);
    finally

    end;
  RmDir( WebsitePath );
  ForceDirectories( WebsitePth );
  ForceDirectories( WorkPth );
end;

function TWebsiteGenerator.Find(Variable, Line : String; Obj: TWebsiteRoot): String;
var
  GotIt : Boolean;
begin
  Result := '';
  GotIt := False;
  // This order is important so we process the Primary and Secondary menus separately
  if Assigned(Obj) and (Obj <> Website) then
    Result := Obj.Find( Variable, GotIt );
  if not GotIt then
    Result := Website.Find( Variable, GotIt );
  if not GotIt then
    MessageDlg( 'Can''t find variable [' + Variable + '] in Line'#13#10 + Line,mtWarning,[mbOk],0);
end;

procedure TWebsiteGenerator.Generate( TestMode : Boolean = false);
var
  Config : TMenuConfig;
begin
  fTestMode := TestMode;

  GenerateCSS( Website.Menus.PrimaryMenu, 'Menu.csx' );
  GenerateCSS( Website.Menus.SecondaryMenu, 'Menu.csx' );
  GenerateCSS( Website, 'TheCustomizedWebsite.csx', 'TheCustomizedWebsite.css' );
  GenerateHTML( Website.Menus.PrimaryMenu );
  if Website.Menus.SecondaryMenu.MenuPosition <> 'None' then
    begin
      GenerateHTML( Website.Menus.SecondaryMenu );
      Config := mcDouble;
    end
  else if Website.Menus.PrimaryMenu.MenuPosition = 'Top' then
    Config := mcSingleTop
  else
    Config := mcSingleBottom;
  GenerateHTML( 'IDXHeader', Config );
  GenerateHTML( 'IDXFooter', Config );
  GenerateHTML( 'Point2Header', Config );
  GenerateHTML( 'Point2Footer', Config );
  GenerateHTML( 'WolfnetHeader', Config );
  GenerateHTML( 'WolfnetFooter', Config );
  GenerateHTML( 'BrowserBar', mcNone);
  CopyFile( ExePath + 'Templates' + DirectorySeparator + 'ddmenu-P2.js',
            WorkPath + 'ddmenu-P2.js');
  CopyFile( ExePath + 'Templates' + DirectorySeparator + 'ddmenu-IDX.js',
            WorkPath + 'ddmenu-IDX.js');
  GenerateIDXHeaderFooter;
  GenerateWebsiteChecklist;

  CreateLocalTest;
  GenerateImages;

end;

procedure TWebsiteGenerator.GenerateCSS( Obj      : TWebsiteRoot;
                                         Template : String;
                                         FileName : String = '' );
var
  OutFile, InFile : TextFile;
  OutPath, InPath : String;
begin
  if Empty(FileName) then
    OutPath := WorkPath + DirectorySeparator + Obj.Name + '.css'
  else
    OutPath := WorkPath + DirectorySeparator + FileName;
  InPath := ExePath + 'Templates' + DirectorySeparator + Template;
  try
    AssignFile( OutFile, OutPath );
    Rewrite(OutFile);
    AssignFile( InFile,  InPath );
    Reset(InFile);
//    WriteLN(OutFile,'/* ' + OutPath + ' */');    { Don't write anything before the file contents, just in case }
    ReplaceFileContents( OutFile, InFile, Obj);
  finally
    CloseFile(OutFile);
    CloseFile(InFile);
  end;
end;

procedure TWebsiteGenerator.GenerateHTML(Menu: TWebsiteMenuData );
var
  OutFile, InFile : TextFile;
  OutPath, InPath : String;
begin
  try
    OutPath := WorkPath + Menu.Name + '.htm';
    InPath  := ExePath + 'Templates' + DirectorySeparator + 'MenuLeader.htx';
    AssignFile( OutFile, OutPath );
    Rewrite(OutFile);
    AssignFile( InFile,  InPath );
    Reset(InFile);
    ReplaceFileContents( OutFile, InFile, Menu);
    CloseFile(InFile);
    WriteMenuTree( Menu, OutFile );
    InPath  := ExePath + 'Templates' + DirectorySeparator + 'MenuTrailer.htx';
    AssignFile( InFile,  InPath );
    Reset(InFile);
    ReplaceFileContents( OutFile, InFile, Menu);
    CloseFile(InFile);
    CloseFile(OutFile);

    OutPath := WorkPath + Menu.Name + 'Script.htm';
    InPath  := ExePath + 'Templates' + DirectorySeparator + 'MenuScript.htx';
    AssignFile( OutFile, OutPath );
    Rewrite(OutFile);
    AssignFile( InFile,  InPath );
    Reset(InFile);
    ReplaceFileContents( OutFile, InFile, Menu);
  finally
    CloseFile(OutFile);
    CloseFile(InFile);
  end;
end;

procedure TWebsiteGenerator.GenerateHTML(FilePrefix: String;
  Config: TMenuConfig);
var
  OutPath, InPath : String;
  OutFile, InFile : TextFile;
  TestMode : Boolean; // Not yet implemented
  procedure UpdateTopMenu( FilePrefix : String; Menu : TWebsiteMenuData );
  begin
    UpdateMenuX( FilePrefix, '@@@@@@@ TCW Top Menu @@@@@@@', Menu, False, TestMode );
    UpdateMenuX( FilePrefix, '@@@@@@@ TCW Top Menu Script @@@@@@@',Menu, True, TestMode );
  end;
  procedure UpdateBottomMenu( FilePrefix : String; Menu : TWebsiteMenuData );
  begin
    UpdateMenuX( FilePrefix, '@@@@@@@ TCW Bottom Menu @@@@@@@', Menu, False, TestMode );
    UpdateMenuX( FilePrefix, '@@@@@@@ TCW Bottom Menu Script @@@@@@@',Menu, True, TestMode );
  end;
begin
  TestMode := False;
  case Config of
    mcNone:
      begin
        OutPath := WorkPath + 'BrowserBar.htm';
        AssignFile( OutFile, OutPath );
        Rewrite(OutFile);
        InPath := ExePath + 'Templates' + DirectorySeparator + FilePrefix + '.htx';
        AssignFile( InFile, InPath );
        Reset( InFile );
        ReplaceFileContents( OutFile, InFile );
        CloseFile(InFile);
        CloseFile(OutFile);
      end;
    mcSingleTop:
      begin
        OutPath := WorkPath + FilePrefix + '.htx';
        InPath  := ExePath + 'Templates' + DirectorySeparator + FilePrefix + 'TemplateTopMenu.htx';
        CopyFile( InPath, OutPath );
        UpdateTopMenu( FilePrefix, Website.Menus.PrimaryMenu );
      end;
    mcSingleBottom:
      begin
        OutPath := WorkPath +FilePrefix + '.htx';
        InPath  := ExePath + 'Templates' + DirectorySeparator + FilePrefix + 'TemplateBottomMenu.htx';
        CopyFile( InPath, OutPath );
        UpdateBottomMenu( FilePrefix,  Website.Menus.PrimaryMenu );
      end;
    mcDouble:
      begin
        OutPath := WorkPath +FilePrefix + '.htx';
        InPath  := ExePath + 'Templates' + DirectorySeparator + FilePrefix + 'TemplateTwoMenu.htx';
        CopyFile( InPath, OutPath );
        if Website.Menus.PrimaryMenu.MenuPosition = 'Top' then
          begin
            UpdateTopMenu( FilePrefix,  Website.Menus.PrimaryMenu );
          end
        else
          begin
            UpdateBottomMenu( FilePrefix,  Website.Menus.PrimaryMenu );
          end;
        // Rename .htm to .htm~
        if Website.Menus.PrimaryMenu.MenuPosition = 'Bottom' then
          begin
            UpdateTopMenu( FilePrefix,  Website.Menus.SecondaryMenu );
          end
        else
          begin
            UpdateBottomMenu( FilePrefix,  Website.Menus.SecondaryMenu );
          end;
      end;
  end;
end;

procedure TWebsiteGenerator.GenerateIDXHeaderFooter;
var
  Src, Dest, HTemplate, FTemplate : TextFile;
  Line : String;
  P0, P1 : Integer;

begin
  AssignFile(HTemplate,TemplatePath + 'IDXHeaderElement.jsx');
  AssignFile(FTemplate,TemplatePath + 'IDXFooterElement.jsx');
  Reset(HTemplate);
  Reset(FTemplate);
  AssignFile( Src, TemplatePath + DirectorySeparator + 'IDXHeaderFooter.jsx' );
  Reset(Src);
  AssignFile(Dest,WorkPath + 'IDXHeaderFooter.js');
  Rewrite(Dest);

  while Not EOF(Src) do
    begin
      ReadLn(Src,Line);
      P0 := Pos('ZZZZZ IDX Header ZZZZZ',Line);
      P1 := Pos('ZZZZZ IDX Footer ZZZZZ',Line);
      if P0 > 0 then
        begin
          WriteLn(Dest,Line);
          GenerateIDXJs( Website.Menus.PrimaryMenu, Dest,HTemplate );
          GenerateIDXJs( Website.Menus.SecondaryMenu, Dest,HTemplate );
        end
      else if P1 > 0 then
        begin
          WriteLn(Dest,Line);
          GenerateIDXJs( Website.Menus.PrimaryMenu, Dest,FTemplate );
          GenerateIDXJs( Website.Menus.SecondaryMenu, Dest,FTemplate );
        end
      else
        Writeln(Dest,ReplaceVariables(Line, '@~', '~@', Website));
    end;

  CloseFile(Dest);
  CloseFile(Src);
  CloseFile(FTemplate);
  CloseFile(HTemplate);
end;

procedure TWebsiteGenerator.GenerateIDXJs(Menu: TWebsiteMenuData; var Dest,
  Template: TextFile);
var
  I    :Integer;
  Item : TTCWMenuItem;
begin
  for I := 0 to pred(Menu.TCWMenuData.MenuRoot.ChildCount) do
    begin
      Item := Menu.TCWMenuData.MenuRoot.Children[I];
      if (Item.Host = hoIDX) {and not Empty(Item.IDX_FooterText)} then
        begin
          Reset(Template);
          ReplaceFileContents( Dest, Template, Item );
        end;
    end;
end;

procedure TWebsiteGenerator.GenerateWebsiteChecklist;
var
  FileName : String;
  F        : TextFile;
begin
  FileName := WorkPath + Website.Menus.PrimaryMenu.Name + '.csv';
  AssignFile( F, FileName );
  Rewrite(F);
  Writeln(F,'"Website:","',Website.Name,'"');
//  Website.Menus.PrimaryMenu.GenerateMenuCheckList(F);
  Closefile(F);
  FileName := WorkPath + Website.Menus.SecondaryMenu.Name + '.csv';
  AssignFile( F, FileName );
  Rewrite(F);
  Writeln(F,'"Website:","',Website.Name,'"');
//  Website.Menus.SecondaryMenu.GenerateMenuCheckList(F);
  Closefile(F);
end;

procedure TWebsiteGenerator.CreateLocalTest;
var
  WP : String;
begin
  WP := WebsitePath;
  if DirectoryExists(WP + 'LocalTest') then
    try
      WalkDirectoryTree(WP + 'LocalTest','','*.*',faAnyFile,True,RmFiles,nil);
    finally

    end;
  ForceDirectories( WP + 'LocalTest' );
  ForceDirectories( WP + 'LocalTest\Images' );
  ForceDirectories( WP + 'LocalTest\Stylesheets' );
  ForceDirectories( WP + 'LocalTest\Javascripts' );

  //CopyFile( WorkPath + '\Point2Footer.htx', WebsitePath + '\LocalTest\Point2Footer.htm');
  //CopyFile( WorkPath + '\Point2Header.htx', WebsitePath + '\LocalTest\Point2Header.htm');

  CopyFiles( WorkPath,WebsitePath + '\LocalTest', '*.htm' );
  CopyFiles( WorkPath,WebsitePath + '\LocalTest\Stylesheets','*.css');
  CopyFiles( WorkPath,WebsitePath + '\LocalTest\Javascripts','*.js');
  CopyFile( WorkPath + 'Point2Header.htx', WebsitePath + 'LocalTest\Point2Header.htm');
  CopyFile( WorkPath + 'Point2Footer.htx', WebsitePath + 'LocalTest\Point2Footer.htm');
end;

procedure TWebsiteGenerator.GenerateImages;
var
  Pix : TPicture;
//  Mime : String;
  FileName : String;
begin
  FileName := LocalTestImagePath + 'Header.jpg';
  Pix := Website.ImagesAndBG.HeaderImage;
//  Mime := Pix.Graphic.MimeType;
  Pix.SaveToFile( FileName );
end;

procedure TWebsiteGenerator.ReplaceFileContents( var OutFile, InFile: TextFile;
                                                     Obj : TWebsiteRoot = nil);
var
  LineIn, LineOut : String;
begin
  while not EOF(InFile) do
    begin
      Readln(InFile,LineIn);
      LineOut := ReplaceVariables( LineIn, '@~', '~@', Obj );
      Writeln(OutFile,LineOut);
    end;
end;

function TWebsiteGenerator.ReplaceVariables(Line, StartDelim, EndDelim: String;
  Obj : TWebsiteRoot): String;
var
  First, Last : Integer;
  WorkLine    : String;
  Variable    : String;
  VarLen      : Integer;
  VarValue    : String;
  Go          : Boolean;
begin
  WorkLine := Line;
  Go := true;
  while Go do   // Multiple passes in case substitution includes more variables
    begin
      Result   := '';
      Go := False;
      while not Empty(WorkLine) do
        begin
          First := Pos(StartDelim,WorkLine);
          if First = 0 then
            begin
              Result := Result + WorkLine;
              WorkLine := '';
            end
          else
            begin
              Result := Result + Copy(WorkLine,1,First-1);
              Last   := Pos(EndDelim,WorkLine);
              VarLen := Last - (First + Length(StartDelim));
              Variable := Copy(WorkLine,First + Length(StartDelim), VarLen);
              VarValue := Find( Variable, Line, Obj );
              Result := Result + VarValue;
              WorkLine := Copy(WorkLine, Last + Length(EndDelim),Length(WorkLine));
              Go := True;
            end;
        end;
      if Go then
        WorkLine := Result;
    end;
end;

procedure TWebsiteGenerator.UpdateMenuX(FilePrefix, Flag: String;
  TheMenu: TWebsiteMenuData; Script: Boolean; Test: Boolean);
var
  Src, Dest, Menu : TextFile;
  P : Integer;
  Line : String;
  NotCopied : Boolean;
  MenuFile : String;
  SrcFileName, DestFileName : String;
  BaseName : String;
begin
  if Test then
    BaseName := {TestPath //+} FilePrefix
  else
    BaseName := WorkPath + FilePrefix;
  SrcFileName := WorkPath + FilePrefix + '.htx';
  AssignFile( Src, SrcFileName );
  Reset(Src);
  DestFileName := BaseName + '.htm';

  AssignFile( Dest, DestFileName );
  Rewrite(Dest);
  if Script then
    MenuFile := WorkPath + TheMenu.Name + 'Script.htm'
  else
    MenuFile := WorkPath + TheMenu.Name + '.htm';
  AssignFile( Menu, MenuFile );
  Reset(Menu);
  NotCopied := true;
  while not EOF(Src) do
    begin
      ReadLn(Src,Line);
      P := Pos(Flag,Line);
      if P = 0 then
        begin
          WriteLn( Dest, ReplaceVariables( Line, '@~','~@',Website ));
        end
      else
        begin
          Writeln(Dest,Line);
          if NotCopied then
            begin
              while not EOF(Menu) do
                begin
                  ReadLn(Menu,Line);
                  WriteLn(Dest,Line);
                end;
              while not EOF(Src) and NotCopied do
                begin
                  ReadLN(SRC,Line);
                  p := Pos(Flag,Line);
                  NotCopied := P = 0;
                end;
              Writeln(Dest,Line);
            end;
        end;
    end;
  CloseFile(Menu);
  CloseFile(Src);
  CloseFile(Dest);
  DeleteFile( PChar(BaseName+ '.htx') );
  RenameFile( BaseName + '.htm', BaseName + '.htx');
end;

procedure TWebsiteGenerator.WriteMenuItem(Item: TTCWMenuItem;
  Menu: TWebsiteMenuData; var F: TextFile; Indent: Integer; Top: Boolean);
var
  I : Integer;
begin
  Debug( Item.Name + ' has ');
  Debug( Item.ChildCount );
  DebugLn(' children.');
  if Item.ChildCount = 0 then
    begin
      IndentBy(F,Indent);
      System.Write(F,'<li><a href="');
      case Item.Host of
        hoPoint2: System.Write(F,Website.GeneralData.Point2URL);
        hoIDX: System.Write(F,Website.GeneralData.IDXURL);
        hoZHouse : System.Write(F,Website.GeneralData.ZHouseURL);
        hoNone: System.Write(F,Website.GeneralData.NoHostURL);
        hoWolfNet : System.Write(F,Website.GeneralData.WolfNetURL);
      end;
      if Indent = 0 then
        Writeln(F,Item.URL,'" class="',Menu.Name,'_link">',Item.Name,'</a></li>')
      else
        if Top then
          Writeln(F,Item.URL,'" class="',Menu.Name,'_topline">',Item.Name,'</a></li>')
        else
          Writeln(F,Item.URL,'">',Item.Name,'</a></li>')
    end
  else
    begin
      IndentBy(F,Indent);
      Writeln(F,'<li>');
      Indent := Indent+1;
      IndentBy(F,Indent);
      System.Write(F,'<a href="');
      case Item.Host of
        hoPoint2: System.Write(F,Website.GeneralData.Point2URL);
        hoIDX: System.Write(F,Website.GeneralData.IDXURL);
        hoZHouse : System.Write(F,Website.GeneralData.ZHouseURL);
        hoNone: System.Write(F,Website.GeneralData.NoHostURL);
        hoWolfNet : System.Write(F,Website.GeneralData.WolfNetURL);
      end;
      if Indent = 1 then
        if Menu.GeneralCSSData.HorizPosition = hpCentered then
          Writeln(F,Item.URL,'" class="',Menu.Name,'_link">&#x25bc;',Item.Name,'</a>')
        else
          begin
            if Menu.MenuCSSData.UseDownArrowImage then
              Writeln(F,Item.URL,'" class="',Menu.Name,'_link_dd">',Item.Name,'</a>')
            else
              Writeln(F,Item.URL,'" class="',Menu.Name,'_link">&#x25bc;',Item.Name,'</a>')
            end
      else
        begin
          System.Write(F,Item.URL,'" class="',Menu.Name,'_sub"');
          if Top then
            System.Write(F,'" class="',Menu.Name,'_topline"');
          Writeln(F,'">',Item.Name,'</a>');
        end;
      IndentBy(F,Indent);
      Writeln(F,'<ul>');
      Indent := Indent + 1;
      for I := 0 to pred(Item.ChildCount) do
        WriteMenuItem( Item.Children[I],Menu,F,Indent,I=0);
      Indent := Indent - 1;
      IndentBy(F,Indent);
      Writeln(F,'</ul>');
      Indent := Indent - 1;
      IndentBy(F,Indent);
      Writeln(F,'</li>');
    end;
  Flush(F);
end;

procedure TWebsiteGenerator.WriteMenuTree(Menu: TWebsiteMenuData; var F : TextFile );
var
  I : Integer;
  Item : TTCWMenuItem;
begin
  for I := 0 to pred(Menu.TCWMenuData.MenuRoot.ChildCount) do
    begin
      Item := Menu.TCWMenuData.MenuRoot.Children[I];
      WriteMenuItem(Item,Menu,F,0,false);
    end;
end;

end.
