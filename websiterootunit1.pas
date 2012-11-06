unit WebsiteRootUnit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,

  Persists1, TextIO1, NamedFunctionUnit1;

type
  THorizontalPositioning = ( hpLeft,
                             hpRight,
                             hpCentered,
                             hpEven );

  TBarSeparatorStyle = ( bssNone,
                         bssLeft,
                         bssRight );

type

  { TWebsiteRoot }

  TWebsiteRoot = class( TPersists )
  protected
    VarList : TNamedFunctions;
    fMenu   : TWebsiteRoot;
  public
    constructor Create( AParent : TPersists; TheName : String ); override; overload;
    constructor Create( AParent : TPersists; TheName : String; TheMenu : TWebsiteRoot ); virtual; overload;
    function Find( Variable : String; var GotIt : Boolean ) : String; virtual;
    procedure MakeNew; override;
    procedure BuildVarlist; virtual;

    property RootMenu : TWebsiteRoot read fMenu write fMenu;
  end;

implementation

{ TWebsiteRoot }

function TWebsiteRoot.Find(Variable: String; var GotIt: Boolean): String;
begin
  GotIt := VarList.Execute( Result, Variable);
end;

procedure TWebsiteRoot.MakeNew;
begin
  inherited MakeNew;
  BuildVarlist;
end;

constructor TWebsiteRoot.Create(AParent: TPersists; TheName: String);
begin
  inherited Create( AParent, TheName );
  fModified := false;
  VarList := nil;
  MakeNew;
end;

constructor TWebsiteRoot.Create(AParent: TPersists; TheName: String;
  TheMenu: TWebsiteRoot);
begin
  Create( AParent, TheName );
  fMenu := TheMenu;
end;

procedure TWebsiteRoot.BuildVarlist;
begin
  if Assigned( VarList ) then Varlist.Free;
  VarList := TNamedFunctions.Create;
end;


end.
