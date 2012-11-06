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
unit ColorFrame1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, Dialogs;

type

  { TColorFrame }

  TColorChange = procedure( var NewColor : Integer ) of object;

  TColorFrame = class(TFrame)
    ColorDialog1: TColorDialog;
    ColorEdit: TLabeledEdit;
    Panel1: TPanel;
    procedure ColorEditExit(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private
    fColorChange : TColorChange;
    function GetColor: Integer;
    procedure SetColor(const AValue: Integer);
    { private declarations }
  public
    { public declarations }
    property Color : Integer read GetColor write SetColor;
    property OnColorChange : TColorChange read fColorChange write fColorChange;
  end;

implementation

uses
  StrUtils;

{$R *.lfm}

{ TColorFrame }


procedure TColorFrame.ColorEditExit(Sender: TObject);
var
  C : Integer;
begin
  Color := Hex2Dec( ColorEdit.Text );
  C := Color;
  if Assigned(fColorChange) then OnColorChange( C );
end;

procedure TColorFrame.Panel1Click(Sender: TObject);
var
  C : Integer;
begin
  if ColorDialog1.Execute then
    begin
      Color := ColorDialog1.Color;
      C := Color;
      if Assigned(fColorChange) then OnColorChange( C );
    end;
end;

function TColorFrame.GetColor: Integer;
begin
  Result := Panel1.Color;
end;

procedure TColorFrame.SetColor(const AValue: Integer);
begin
  Panel1.Color := AValue;
  ColorEdit.Text := IntToHex( AValue, 6 );
end;

end.

