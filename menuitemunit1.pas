unit MenuItemUnit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls,

  Persists1, Generics1, TextIO1, WebsiteRootUnit1;


type
  THost = ( hoNone,
            hoIdx,
            hoPoint2,
            hoWolfnet,
            hoZhouse );

  TTCWItemEditData = record
    Text : String;
    URL  : String;
    Host : THost;
  end;

  type TIDX_Style = record
    Size : String; { set for CSS units, e.g. px }
    Font : String;
    Color : Integer;
  end;


  { TTCWMenuItem }
type
  TTCWMenuItem = class( TWebsiteRoot )
    private
      fHost             : THost;
      fChildCount       : Integer;
      fURL              : String;

      fChildren         : array of TTCWMenuItem;

      fIDX_HeaderText   : String; { These will go in our own generated IDX HTML   }
      fIDX_HeaderStyle  : TIDX_Style;
      fIDX_FooterText   : String;
      fIDX_FooterStyle  : TIDX_Style;

      fIDXPageTitle     : String;
      function GetChildren(Index: Integer): TTCWMenuItem;
      function GetIDX_FooterFont: String;
      function GetIDX_FooterSize: String;
      function GetIDX_FooterText: String;
      function GetIDX_HeaderFont: String;
      function GetIDX_HeaderSize: String;
      function GetIDX_HeaderText: String;
      function GetNodeCount: Integer;
      function GetURL: String;
      procedure SetChildCount(const AValue: Integer);
      procedure SetIDXPageTitle(const AValue: string);
      procedure SetIDX_FooterColor(const AValue: Integer);
      procedure SetIDX_FooterFont(const AValue: String);
      procedure SetIDX_FooterSize(const AValue: String);
      procedure SetIDX_FooterText(const AValue: String);
      procedure SetIDX_HeaderColor(const AValue: Integer);
      procedure SetIDX_HeaderFont(const AValue: String);
      procedure SetIDX_HeaderSize(const AValue: String);
      procedure SetIDX_HeaderText(const AValue: String);
      procedure SetURL(const AValue: String);

    protected
      procedure BuildVarList; override;

      function FooterColorCSS : String;
      function HeaderColorCSS : String;

      { Child Manipulation }

      function GetChildCapacity : Integer;
      procedure SetChildCapacity( Value : Integer );
      procedure ExpandChildren;
      procedure ClearChildren; // Destroys the children objects on list;

    public
      constructor Create( aName : String; ItemData : TTCWItemEditData); overload;
      constructor Create( aName : String ); overload;
      constructor Create; overload;

      constructor Copy( Source : TTCWMenuItem; CopyChildren : Boolean = True );

      destructor  Destroy; override;

      procedure MakeNew; override;
      procedure Save( TextIO : TTextIO ); override;
      procedure Read( TextIO : TTextIO; Version : Integer ); override;
      procedure Show( Memo : TMemo ); override;

      procedure SetModified( AValue : Boolean );

      function IsModified : Boolean; override;
      procedure UNMODIFY; override;

      { Child Manipulation }
      function  AddChild( theChild : TTCWMenuItem; AllowModify : Boolean = True ) : Integer;

      property HeaderColor : Integer  read fIDX_HeaderStyle.Color  write SetIDX_HeaderColor;
      property HeaderSize  : String   read GetIDX_HeaderSize   write SetIDX_HeaderSize;
      property HeaderFont  : String   read GetIDX_HeaderFont   write SetIDX_HeaderFont;
      property FooterColor : Integer  read fIDX_FooterStyle.Color  write SetIDX_FooterColor;
      property FooterSize  : String   read GetIDX_FooterSize   write SetIDX_FooterSize;
      property FooterFont  : String   read GetIDX_FooterFont   write SetIDX_FooterFont;
//      property IsModified : Boolean read fModified;

      property IDX_HeaderStyle : TIDX_Style read fIDX_HeaderStyle write fIDX_HeaderStyle;
      property IDX_FooterStyle : TIDX_Style read fIDX_FooterStyle write fIDX_FooterStyle;
      property Host : THost read fHost write fHost;

      property URL  : String read GetURL write SetURL;
      property ChildCount : Integer read fChildCount write SetChildCount;

      property IDX_HeaderText : String read GetIDX_HeaderText write SetIDX_HeaderText;
      property IDX_FooterText : String read GetIDX_FooterText write SetIDX_FooterText;

      property IDXPageTitle : string read fIDXPageTitle write SetIDXPageTitle;

      { Child Manipulation }
      property Capacity : Integer read GetChildCapacity write SetChildCapacity;
      property Children[Index:Integer] : TTCWMenuItem read GetChildren;

      property NodeCount : Integer read GetNodeCount;

 end;

implementation

uses
  NamedFunctionUnit1, Common1, ObjectFactory1;

{ TTCWMenuItem }

const
  DefaultIDXHeaderSize = '20px';
  DefaultIDXFooterSize = '15px';
  DefaultIDXHeaderColor = 0;
  DefaultIDXFooterColor = 0;
  DefaultIDXHeaderFont = 'Verdana, Arial, sans-serif';
  DefaultIDXFooterFont = 'Verdana, Arial, sans-serif';
  DefaultHost = hoNone;
  DefaultHostURL = '#';
  DefaultIDX_HeaderText = '';
  DefaultIDX_FooterText = '';
  DefaultIDXPageTitle = '';

  DefaultIDXHeaderStyle : TIDX_Style = ( Size : DefaultIDXHeaderSize; Font : DefaultIDXHeaderFont; Color : DefaultIDXHeaderColor );
  DefaultIDXFooterStyle : TIDX_Style = ( Size : DefaultIDXFooterSize; Font : DefaultIDXFooterFont; Color :  DefaultIDXFooterColor );

  Version = 1;


function TTCWMenuItem.GetIDX_FooterFont: String;
begin
  Result := fIDX_FooterStyle.Font;
end;

function TTCWMenuItem.GetChildren(Index: Integer): TTCWMenuItem;
var
  N : String;
  L : Integer;
begin
  L := Length(fChildren);
  if (Index < 0) or (Index >= Capacity) then
    raise exception.Create('TTCWMenuItem Child index out of bounds ' + IntToStr(Index) );
  Result := fChildren[Index];
  N := Result.Name;
end;

function TTCWMenuItem.GetIDX_FooterSize: String;
begin
  Result := fIDX_FooterStyle.Size
end;

function TTCWMenuItem.GetIDX_FooterText: String;
begin
  Result := fIDX_FooterText;
end;

function TTCWMenuItem.GetIDX_HeaderFont: String;
begin
  Result := fIDX_HeaderStyle.Font;
end;

function TTCWMenuItem.GetIDX_HeaderSize: String;
begin
  Result := fIDX_HeaderStyle.Size
end;

function TTCWMenuItem.GetIDX_HeaderText: String;
begin
  Result := fIDX_HeaderText;
end;

function TTCWMenuItem.GetNodeCount: Integer;
var
  I : Integer;
  C : Integer;
begin
  C := ChildCount;
  Result := C;
  for I := 0 to pred(C) do
    Result := Result + Children[I].GetNodeCount;
end;

function TTCWMenuItem.GetURL: String;
begin
  Result := fURL;
end;

procedure TTCWMenuItem.SetChildCount(const AValue: Integer);
begin
  Update(FChildCount,AValue);
end;

procedure TTCWMenuItem.SetIDXPageTitle(const AValue: string);
begin
  Update(fIDXPageTitle,AValue);
end;

procedure TTCWMenuItem.SetIDX_FooterColor(const AValue: Integer);
begin
  Update(fIDX_FooterStyle.Color, AValue);
end;

procedure TTCWMenuItem.SetIDX_FooterFont(const AValue: String);
begin
  Update(fIDX_FooterStyle.Font, aValue);
end;

procedure TTCWMenuItem.SetIDX_FooterSize(const AValue: String);
begin
  Update(fIDX_FooterStyle.Size, aValue);
end;

procedure TTCWMenuItem.SetIDX_FooterText(const AValue: String);
begin
  Update( fIDX_FooterText, aValue );
end;

procedure TTCWMenuItem.SetIDX_HeaderColor(const AValue: Integer);
begin
  Update(fIDX_HeaderStyle.Color, aValue);
end;

procedure TTCWMenuItem.SetIDX_HeaderFont(const AValue: String);
begin
  Update(fIDX_HeaderStyle.Font, aValue);
end;

procedure TTCWMenuItem.SetIDX_HeaderSize(const AValue: String);
begin
  Update(fIDX_HeaderStyle.Size, aValue);
end;

procedure TTCWMenuItem.SetIDX_HeaderText(const AValue: String);
begin
  Update( fIDX_HeaderText, aValue );
end;

procedure TTCWMenuItem.SetURL(const AValue: String);
begin
  Update( fURL, aValue );
end;

procedure TTCWMenuItem.BuildVarList;
begin
  inherited;
  VarList.AddFunction('IDXFooterText',                @GetIDX_FooterText);
  VarList.AddFunction('URLFile',                      @GetURL);
  VarList.AddFunction('IDXFooterFont',                @GetIDX_FooterFont);
  VarList.AddFunction('IDXFooterSize',                @GetIDX_FooterSize);
  VarList.AddFunction('IDXFooterColor',               @FooterColorCSS);

  VarList.AddFunction('IDXHeaderText',                @GetIDX_HeaderText);
  VarList.AddFunction('IDXHeaderFont',                @GetIDX_HeaderFont);
  VarList.AddFunction('IDXHeaderSize',                @GetIDX_HeaderSize);
  VarList.AddFunction('IDXHeaderColor',               @HeaderColorCSS);
end;

function TTCWMenuItem.FooterColorCSS: String;
begin
  Result := CSSColor( fIDX_FooterStyle.Color );
end;

function TTCWMenuItem.HeaderColorCSS: String;
begin
  Result := CSSColor( fIDX_HeaderStyle.Color );
end;

function TTCWMenuItem.GetChildCapacity: Integer;
begin
  Result := Length(fChildren);
end;

procedure TTCWMenuItem.SetChildCapacity(Value: Integer);
begin
  SetLength( fChildren, Value );
end;

procedure TTCWMenuItem.ExpandChildren;
begin
  Capacity := Capacity + 1; //* 2 +1;
end;

procedure TTCWMenuItem.ClearChildren;
var
  I : Integer;
  C : TTCWMenuItem;
begin
  for I := 0 to pred(fChildCount) do
    begin
      C := fChildren[I];
      C.Free;   // memory leak until re-enabled
      fChildren[I] := nil;
    end;
  fChildCount := 0;
end;

constructor TTCWMenuItem.Create(aName : String; ItemData: TTCWItemEditData);
begin
  MakeNew;
  fName := aName;
  fURL := ItemData.URL;
  fHost := ItemData.Host;
  Capacity := 0;
  BuildVarList;
end;

constructor TTCWMenuItem.Create(aName : String );
begin
  Create;
  MakeNew;
  fName := aName;
  Capacity := 0;
  BuildVarList;
end;

constructor TTCWMenuItem.Create;
begin
  Capacity := 0;
  BuildVarList;
end;

constructor TTCWMenuItem.Copy(Source: TTCWMenuItem; CopyChildren : Boolean );
  procedure CpyChildren( S : TTCWMenuItem );
  var
    I : Integer;
  begin
    for I := 0 to pred( S.ChildCount ) do
      AddChild( TTCWMenuItem.Copy( S.Children[I] ),False );
  end;
begin
  Create( Source.Name );
  Capacity := 4;
  fHost             := Source.Host;
  fURL              := Source.fURL;

  if CopyChildren then
    CpyChildren( Source );

  fIDX_HeaderText   := Source.fIDX_HeaderText;
  fIDX_HeaderStyle  := Source.fIDX_HeaderStyle;
  fIDX_FooterText   := Source.fIDX_FooterText;
  fIDX_FooterStyle  := Source.fIDX_FooterStyle;

  fIDXPageTitle     := Source.fIDXPageTitle;
  fModified         := Source.fModified;
  BuildVarList;
end;

destructor TTCWMenuItem.Destroy;
begin
  ClearChildren;
//  SetLength( fChildren, 0 );
  inherited Destroy;
end;

procedure TTCWMenuItem.MakeNew;
begin
  inherited MakeNew;
  fName := 'Undefined';
  fURL  := DefaultHostURL;
  fHost := DefaultHost;
  fIDX_HeaderText := '';
  fIDX_FooterText := '';
  fIDX_HeaderStyle.Color := 0;
  fIDX_FooterStyle.Color := 0;
  fIDX_HeaderStyle := DefaultIDXHeaderStyle;
  fIDX_FooterStyle := DefaultIDXFooterStyle;
  fIDXPageTitle := DefaultIDXPageTitle;

  ClearChildren;

end;

procedure TTCWMenuItem.Save(TextIO: TTextIO);
var
  I : Integer;
  C : TTCWMenuItem;
begin
  SaveHeader( TextIO, Version );
  TextIO.WriteLn( fName );
  TextIO.WriteLn( ord(fHost) );
  TextIO.WriteLn( fURL );
  TextIO.WriteLn( fIDX_HeaderText );
  TextIO.WriteLn( fIDX_HeaderStyle.Size );
  TextIO.WriteLn( fIDX_HeaderStyle.Font );
  TextIO.WriteLn( fIDX_HeaderStyle.Color );
  TextIO.WriteLn( fIDX_FooterText );
  TextIO.WriteLn( fIDX_FooterStyle.Size );
  TextIO.WriteLn( fIDX_FooterStyle.Font );
  TextIO.WriteLn( fIDX_FooterStyle.Color );
  TextIO.WriteLn( fIDXPageTitle );
  TextIO.WriteLn( fChildCount );

  for I := 0 to pred( fChildCount ) do
    begin
      c := fChildren[I];
      C.Save( TextIO );
    end;

  SaveTrailer( TextIO );
end;

procedure TTCWMenuItem.Read(TextIO: TTextIO; Version: Integer);
var
  I : Integer;
  CC : Integer;
  Item : TTCWMenuItem;
begin
  MakeNew;
  if version >= 1 then
    begin
      TextIO.ReadLn( fName );
      TextIO.ReadLn( I );
      fHost := THost( I );
      TextIO.ReadLn( fURL );
      TextIO.ReadLn( fIDX_HeaderText );
      TextIO.ReadLn( fIDX_HeaderStyle.Size );
      TextIO.ReadLn( fIDX_HeaderStyle.Font );
      TextIO.ReadLn( fIDX_HeaderStyle.Color );
      TextIO.ReadLn( fIDX_FooterText );
      TextIO.ReadLn( fIDX_FooterStyle.Size );
      TextIO.ReadLn( fIDX_FooterStyle.Font );
      TextIO.ReadLn( fIDX_FooterStyle.Color );
      TextIO.ReadLn( fIDXPageTitle );
      TextIO.ReadLn( CC ); // the Child Count in the file

      for I := 0 to pred( CC ) do
        begin
          Item := TTCWMenuItem.Load( TextIO ) as TTCWMenuItem;
          AddChild( Item, false );
        end;

    end;
end;

procedure TTCWMenuItem.Show(Memo: TMemo);
var
  I : Integer;
begin
  Memo.Lines.Add( 'TTCWMenuItem ' + Name );
  Memo.Lines.Add( 'Has ' + IntToStr( ChildCount ) + 'Children' );
  for I := 0 to pred(ChildCount) do
    Children[I].Show( memo );
  Memo.Lines.Add('End of TTCWMenuItem ' + Name );
end;

procedure TTCWMenuItem.SetModified(AValue: Boolean);
begin
  if AValue then
    Modify
  else
    fModified := false;
end;

function TTCWMenuItem.IsModified: Boolean;
var
  I : Integer;
begin
  Result:=inherited IsModified;
//  Result := ;
  for I := 0 to pred( ChildCount ) do
    Result := Result or Children[I].IsModified;
end;

procedure TTCWMenuItem.UNMODIFY;
var
  I : Integer;
begin
  inherited UNMODIFY;
  for I := 0 to pred( ChildCount ) do
    Children[I].UNMODIFY;
end;

function  TTCWMenuItem.AddChild(theChild: TTCWMenuItem; AllowModify : Boolean) : Integer;
begin
  if (fChildCount >= Capacity) or (Capacity = 0) then
    ExpandChildren;
  fChildren[fChildCount] := theChild;
  Result := fChildCount;
  if AllowModify then
    ChildCount := ChildCount + 1
  else
    begin
      Inc(fChildCount);
      SetLength( fChildren, fChildcount );
    end;
end;

initialization
  ObjectFactory.RegisterClass( TTCWMenuItem.ClassType );

end.
