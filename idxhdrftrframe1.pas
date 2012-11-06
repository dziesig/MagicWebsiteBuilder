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
unit IDXHdrFtrFrame1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, ComCtrls,
  ColorFrame1,

  IDXHdrFtrUnit1;

type

  { TIDXHdrFtrFrame }

  TIDXHdrFtrFrame = class(TFrame)
    ColorFrame1: TColorFrame;
    ColorFrame2: TColorFrame;
    FooterSizeLabel: TLabel;
    HeaderSizeLabel: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    IDXFooterFontFacesEdit: TLabeledEdit;
    IDXFooterTextSizeTB: TTrackBar;
    IDXHeaderFontFacesEdit: TLabeledEdit;
    IDXHeaderTextSizeTB: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure IDXFooterTextSizeTBChange(Sender: TObject);
    procedure IDXHeaderTextSizeTBChange(Sender: TObject);
  private
    { private declarations }
    procedure SetTextSizeLabel( aLabel : TLabel; Value : Integer );
  public
    { public declarations }
    procedure Save( Data : TIDXHdrFtr );
    procedure Load( Data : TIDXHdrFtr );
  end;

implementation

{$R *.lfm}

{ TIDXHdrFtrFrame }

procedure TIDXHdrFtrFrame.IDXHeaderTextSizeTBChange(Sender: TObject);
begin
  SetTextSizeLabel( HeaderSizeLabel, IDXHeaderTextSizeTB.Position );
end;

procedure TIDXHdrFtrFrame.IDXFooterTextSizeTBChange(Sender: TObject);
begin
  SetTextSizeLabel( FooterSizeLabel, IDXFooterTextSizeTB.Position );
end;

procedure TIDXHdrFtrFrame.SetTextSizeLabel(aLabel: TLabel; Value: Integer);
begin
  aLabel.Caption := FloatToStrF( Value / 10.0, ffFixed, 4, 1 ) + ' em';
end;

procedure TIDXHdrFtrFrame.Save(Data: TIDXHdrFtr);
begin
  Data.HeaderFontFaces := IDXHeaderFontFacesEdit.Text;
  Data.HeaderTextColor := ColorFrame1.Color;
  Data.HeaderTextSize  := IDXHeaderTextSizeTB.Position;

  Data.FooterFontFaces := IDXFooterFontFacesEdit.Text;
  Data.FooterTextColor := ColorFrame2.Color;
  Data.FooterTextSize  := IDXFooterTextSizeTB.Position;
end;

procedure TIDXHdrFtrFrame.Load(Data: TIDXHdrFtr);
begin
  IDXHeaderFontFacesEdit.Text  := Data.HeaderFontFaces;
  ColorFrame1.Color            := Data.HeaderTextColor;
  IDXHeaderTextSizeTB.Position := Data.HeaderTextSize;

  IDXFooterFontFacesEdit.Text  := Data.FooterFontFaces;
  ColorFrame2.Color            := Data.FooterTextColor;
  IDXFooterTextSizeTB.Position := Data.FooterTextSize;

  SetTextSizeLabel( HeaderSizeLabel, Data.HeaderTextSize );
  SetTextSizeLabel( FooterSizeLabel, Data.FooterTextSize );
end;

end.

