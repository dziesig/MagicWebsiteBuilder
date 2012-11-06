unit TCWMenuUnit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls,

  Persists1, TextIO1, WebsiteRootUnit1, MenuItemUnit1;

type

  { TTCWMenuData }

  TTCWMenuData = class( TWebsiteRoot )
    private
      fMenuRoot : TTCWMenuItem; // This is just to get list of siblings
                                // It does not contain normal menu data

    protected

    public
      constructor Create( aParent : TPersists = nil); override; overload;
      procedure MakeNew; override;
      procedure BuildVarList; override;

      procedure Save( TextIO : TTextIO ); override;
      procedure Read( TextIO : TTextIO; Version : Integer ); override;

      function  IsModified : Boolean; override;

      procedure Show( Memo : TMemo ); override;

      property MenuRoot : TTCWMenuItem read fMenuRoot;
  end;

implementation

uses
  ObjectFactory1;

{ TTCWMenuData }

const
  Version = 1;

constructor TTCWMenuData.Create(aParent: TPersists);
begin
  inherited;
  fMenuRoot := nil;
  MakeNew;
end;

procedure TTCWMenuData.MakeNew;
begin
  inherited MakeNew;
  if fMenuRoot <> nil then
    fMenuRoot.Free;
  fMenuRoot := TTCWMenuItem.Create;
end;

procedure TTCWMenuData.BuildVarList;
begin
  inherited BuildVarList;
end;

procedure TTCWMenuData.Save(TextIO: TTextIO);
begin
  SaveHeader( TextIO, Version );
  fMenuRoot.Save( TextIO );
  UNMODIFY;
  SaveTrailer( TextIO );
end;

procedure TTCWMenuData.Read(TextIO: TTextIO; Version: Integer);
begin
  MakeNew;
  fMenuRoot.Free;
  fMenuRoot := TTCWMenuItem.Load( TextIO ) as TTCWMenuItem;
end;

function TTCWMenuData.IsModified: Boolean;
begin
  Result:=inherited IsModified;
  Result := fMenuRoot.IsModified;
end;

procedure TTCWMenuData.Show(Memo: TMemo);
begin
  Memo.Clear;
  Memo.Lines.Add('TTCWMenuData');
  fMenuRoot.Show(Memo);
end;

initialization
  ObjectFactory.RegisterClass( TTCWMenuData.ClassType );

end.

