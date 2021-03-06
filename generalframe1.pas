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
unit GeneralFrame1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, Dialogs,

  GeneralWebsiteUnit1, ColorFrame1;

type

  { TGeneralFrame }

  TGeneralFrame = class(TFrame)
    ColorDialog1: TColorDialog;
    ColorEdit: TLabeledEdit;
    HoverBackgroundFrame: TColorFrame;
    HoverForegroundFrame: TColorFrame;
    LinkBackgroundFrame: TColorFrame;
    DefaultTitleEdit: TEdit;
    GroupBox1: TGroupBox;
    ClientEdit: TLabeledEdit;
    GroupBox2: TGroupBox;
    CustomizationLinkMemo: TMemo;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    CopyrightInitialYearEdit: TLabeledEdit;
    CopyrightByEdit: TLabeledEdit;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    Panel1: TPanel;
    Point2URLEdit: TLabeledEdit;
    IDXURLEdit: TLabeledEdit;
    WolfnetURLEdit: TLabeledEdit;
    ZHouseURLEdit: TLabeledEdit;
    NoHostURLEdit: TLabeledEdit;
  private
    { private declarations }
  public
    { public declarations }
    constructor Create(TheOwner: TComponent); override;
    procedure Save( Data : TGeneralWebsiteData );
    procedure Load( Data : TGeneralWebsiteData );
  end; 

implementation

{$R *.lfm}

{ TGeneralFrame }

constructor TGeneralFrame.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
end;

procedure TGeneralFrame.Save(Data: TGeneralWebsiteData);
begin
  Data.ClientName := ClientEdit.Text;
  Data.Point2URL  := Point2URLEdit.Text;
  Data.IDXURL     := IDXURLEdit.Text;
  Data.WolfnetURL := WolfnetURLEdit.Text;
  Data.ZHouseURL  := ZHouseURLEdit.Text;
  Data.NoHostURL  := NoHostURLEdit.Text;

  Data.CustomizationLink    := CustomizationLinkMemo.Text;
  Data.DefaultTitle         := DefaultTitleEdit.Text;
  Data.CopyrightInitialYear := StrToInt( CopyrightInitialYearEdit.Text );
  Data.CopyrightBy          := CopyrightByEdit.Text;

  Data.LinkForegroundColor  := LinkBackgroundFrame.Color;
  Data.HoverBackgroundColor := HoverBackgroundFrame.Color;
  Data.HoverForegroundColor := HoverForegroundFrame.Color;
end;

procedure TGeneralFrame.Load(Data: TGeneralWebsiteData);
begin
  ClientEdit.Text     := Data.ClientName;
  Point2URLEdit.Text  := Data.Point2URL;
  IDXURLEdit.Text     := Data.IDXURL;
  WolfnetURLEdit.Text := Data.WolfnetURL;
  ZHouseURLEdit.Text  := Data.ZHouseURL;
  NoHostURLEdit.Text  := Data.NoHostURL;

  CustomizationLinkMemo.Text    := Data.CustomizationLink;
  DefaultTitleEdit.Text         := Data.DefaultTitle;
  CopyrightInitialYearEdit.Text := IntToStr( Data.CopyrightInitialYear );
  CopyrightByEdit.Text          := Data.CopyrightBy;

  LinkBackgroundFrame.Color     := Data.LinkForegroundColor;
  HoverBackgroundFrame.Color    := Data.HoverBackgroundColor;
  HoverForegroundFrame.Color    := Data.HoverForegroundColor;
end;

end.

