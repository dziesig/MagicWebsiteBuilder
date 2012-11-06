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

