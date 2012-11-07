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
unit WebsiteMenusUnit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,

  Persists1, TextIO1,
  WebsiteRootUnit1, GeneralCSSUnit1, MenuCSSUnit1, IDXHdrFtrUnit1,
  TCWMenuUnit1;

type
  { TWebsiteMenuData }

  TWebsiteMenuData = class( TWebsiteRoot )
  private
    procedure SetMenuPosition(const AValue: String);

  protected
    fMenuPosition : String; // String because the secondary menu's
                            // position list varies based on the primary
                            // menu's position.
    fGeneralCSSData : TGeneralCSSData;
    fMenuCSSData    : TMenuCSSData;
    fIDXHdrFtrData  : TIDXHdrFtr;
    fTCWMenuData    : TTCWMenuData;
  public

    procedure MakeNew; override;
    procedure Save( TextIO : TTextIO ); override;
    procedure Read( TextIO : TTextIO; Version : Integer ); override;
    procedure BuildVarlist; override;
    function  Find(Variable : String; var Gotit : Boolean ) :String; override;

    function IsModified : Boolean; override;

    property MenuPosition   : String read fMenuPosition write SetMenuPosition;
    property GeneralCSSData : TGeneralCSSData read fGeneralCSSData;
    property MenuCSSData    : TMenuCSSData    read fMenuCSSData;
    property IDXHdrFtrData  : TIDXHdrFtr      read fIDXHdrFtrData;
    property TCWMenuData    : TTCWMenuData    read fTCWMenuData;
  end;

  { TWebsiteMenusData }

  TWebsiteMenusData = class( TWebsiteRoot )
  private

  protected
    fPrimaryMenu   : TWebsiteMenuData;
    fSecondaryMenu : TWebsiteMenuData;
  public
    procedure MakeNew; override;
    procedure Save( TextIO : TTextIO ); override;
    procedure Read( TextIO : TTextIO; Version : Integer ); override;

    function IsModified : Boolean; override;

    procedure BuildVarlist; override;

    property PrimaryMenu   : TWebsiteMenuData read fPrimaryMenu;
    property SecondaryMenu : TWebsiteMenuData read fSecondaryMenu;

  end;

implementation

uses
  ObjectFactory1, Common1, NamedFunctionUnit1, StringSubs;

const
  MenuVersion  = 5;

{ TWebsiteMenuData }

procedure TWebsiteMenuData.SetMenuPosition(const AValue: String);
begin
  if Empty(fMenuPosition) then
    fMenuPosition := AValue
  else
    Update(fMenuPosition,AValue);
end;

procedure TWebsiteMenuData.BuildVarList;
begin
  inherited;
end;

function TWebsiteMenuData.Find(Variable: String; var Gotit: Boolean): String;
begin
  Result := fGeneralCSSData.Find( Variable, GotIt );
  if not GotIt then
    Result := fMenuCSSData.Find( Variable, GotIt );
  if not GotIt then
    Result := fIDXHdrFtrData.Find( Variable, GotIt );
  if not GotIt then
    Result := fTCWMenuData.Find( Variable, GotIt );
end;

procedure TWebsiteMenuData.MakeNew;
begin
  inherited MakeNew;
  if fName = 'PrimaryMenu' then
    fMenuPosition := 'Top'
  else if fName = 'SecondaryMenu' then
    fMenuPosition := 'None'
  else
    fMenuPosition := '';  // Empty string is undefined
  fGeneralCSSData := TGeneralCSSData.Create( Parent, Name, self );
  fMenuCSSData    := TMenuCssData.Create( Parent, Name, self );
  fIDXHdrFtrData  := TIDXHdrFtr.Create( Parent, Name, self );
  fTCWMenuData    := TTCWMenuData.Create( Parent, Name, self );
  fModified := False;
end;

procedure TWebsiteMenuData.Save(TextIO: TTextIO);
begin
  SaveHeader( TextIO, MenuVersion );
  TextIO.WriteLn( fMenuPosition );
  // MenuVersion 2
  fGeneralCSSData.Save( TextIO );
  // MenuVersion 3
  fMenuCssData.Save( TextIO );
  // MenuVersion 4
  fIDXHdrFtrData.Save( TextIO );
  // MenuVersion 5
  fTCWMenuData.Save( TextIO );
  UNMODIFY;
  SaveTrailer( TextIO );
end;

procedure TWebsiteMenuData.Read(TextIO: TTextIO; Version: Integer);
var
  T : TPersists;
  N : String;
begin
  MakeNew;
  if Version >= 1 then
    begin
      TextIO.ReadLn( fMenuPosition );
    end;
  if Version >= 2 then
    begin
      fGeneralCSSData.Free;
      fGeneralCSSData := TGeneralCSSData.Load( TextIO ) as TGeneralCSSData;
//      fGeneralCSSData.Name := 'GeneralCSSData';
      fGeneralCSSData.RootMenu := self;
    end;
  if Version >= 3 then
    begin
      fMenuCssData.Free;
      fMenuCssData := TMenuCSSData.Load( TextIO ) as TMenuCSSData;
//      fMenuCSSData.Name := 'MenuCSSData';
      fMenuCssData.RootMenu := self;
    end;
  if Version >= 4 then
    begin
      fIDXHdrFtrData.Free;
      fIDXHdrFtrData := TIDXHdrFtr.Load( TextIO ) as TIDXHdrFtr;
//      fIDXHdrFtrData.Name := 'IDXHdrFtrData';
      fIDXHdrFtrData.RootMenu := self;
    end;
  if Version >= 5 then
    begin
      fTCWMenuData.Free;
//     fTCWMenuData := TTCWMenuData.Load( TextIO ) as TTCWMenuData;
      T := TTCWMenuData.Load( TextIO );
      N := T.ClassName;
      fTCWMenuData := T as TTCWMenuData;
//      fTCWMenuData.Name := 'TCWMenuData';
      fTCWMenuData.RootMenu := self;
    end;
end;

function TWebsiteMenuData.IsModified: Boolean;
begin
  Result:=inherited IsModified;
  Result := Result or fGeneralCSSData.Modified;
  Result := Result or fMenuCSSData.Modified;
  Result := Result or fIDXHdrFtrData.Modified;
  Result := Result or fTCWMenuData.Modified;
end;

{ TWebsiteMenusData }

const
  MenusVersion = 1;

procedure TWebsiteMenusData.MakeNew;
begin
  inherited MakeNew;
  fPrimaryMenu   := TWebsiteMenuData.Create( Parent, 'PrimaryMenu' );
  fSecondaryMenu := TWebsiteMenuData.Create( Parent, 'SecondaryMenu' );
  BuildVarlist;
end;

procedure TWebsiteMenusData.Save(TextIO: TTextIO);
begin
  SaveHeader( TextIO, MenusVersion );
  fPrimaryMenu.Save( TextIO );
  fSecondaryMenu.Save( TextIO );
  SaveTrailer( TextIO );
end;

procedure TWebsiteMenusData.Read(TextIO: TTextIO; Version: Integer);
begin
  MakeNew;
  if Version >= 1 then
    begin
      fPrimaryMenu.Free;
      fSecondaryMenu.Free;
      fPrimaryMenu   := TWebsiteMenuData.Load( TextIO ) as TWebsiteMenuData;
      fSecondaryMenu := TWebsiteMenuData.Load( TextIO ) as TWebsiteMenuData;
    end;
end;

function TWebsiteMenusData.IsModified: Boolean;
begin
  Result:=inherited IsModified;
  Result := Result or PrimaryMenu.Modified;
  Result := Result or SecondaryMenu.Modified;;
end;

procedure TWebsiteMenusData.BuildVarlist;
begin
  inherited;
end;

initialization
  ObjectFactory.RegisterClass( TWebsiteMenusData );
  ObjectFactory.RegisterClass( TWebsiteMenuData );
end.

