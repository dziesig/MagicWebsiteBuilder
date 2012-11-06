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

