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
unit NamedFunctionUnit1;

//{$mode objfpc}{$H+}
{$mode delphi}{$H+}

interface

uses
  Classes;

type
  TMethodCall   = function : String of Object;

  TMethodObject   = class
    vMethod : TMethodCall;
    constructor Create( Method : TMethodCall );
    function Execute : String;
  end;

  TNamedFunctions = class(TStringList)
    procedure AddFunction( Name : String; Func : TMethodCall ); overload;
    function  Execute( var Value : String; Name : String ) : Boolean;
  end;

implementation

{ TNamedFunctions }
procedure TNamedFunctions.AddFunction(Name: String; Func: TMethodCall);
var
  Obj : TMethodObject;
begin
  Obj := TMethodObject.Create(Func);
  AddObject( Name, Obj );
  Sort;
end;

function TNamedFunctions.Execute( var Value : String; Name : String ): Boolean;
var
  Func : TMethodObject;
  I    : Integer;
begin
  Result := Find(Name,I);
  if Result then
    begin
      Func := TMethodObject(Objects[I]);
      Value := Func.Execute;
    end;
end;

{ TMethodObject }

constructor TMethodObject.Create(Method: TMethodCall);
begin
  vMethod := Method;
end;

function TMethodObject.Execute: String;
begin
  Result := TMethodCall(vMethod);
end;

end.
