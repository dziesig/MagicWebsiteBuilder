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

unit MenuCSSFrame1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, ComCtrls,
  Dialogs, ColorFrame1,

  MenuCSSUnit1;

type

  { TMenuCSSFrame }

  TMenuCSSFrame = class(TFrame)
    ColorFrame1: TColorFrame;
    ColorFrame2: TColorFrame;
    ColorFrame3: TColorFrame;
    ColorFrame4: TColorFrame;
    ColorFrame5: TColorFrame;
    ColorFrame6: TColorFrame;
    ColorFrame7: TColorFrame;
    ColorFrame8: TColorFrame;
    FontBoldCB: TCheckBox;
    FontFacesEdit: TLabeledEdit;
    GroupBox1: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox16: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    MainSelectedArrowImageCB: TComboBox;
    SubSelectedArrowImageCB: TComboBox;
    SubSelectedSamplePanel: TPanel;
    MainUnselectedArrowImageCB: TComboBox;
    SubUnselectedArrowImageCB: TComboBox;
    MainUnselectedSamplePanel: TPanel;
    MainSelectedSamplePanel: TPanel;
    SubUnselectedSamplePanel: TPanel;
    TextSizeLabel: TLabel;
    TextSizeTB: TTrackBar;
    procedure TextSizeTBChange(Sender: TObject);
  private
    { private declarations }

  protected
    procedure SetForegroundColor( aPanel : TPanel; aColor : Integer );
    procedure SetBackgroundColor( aPanel : TPanel; aColor : Integer );

    procedure MainUnselectedForegroundColorChange( var aColor : Integer );
    procedure MainUnselectedBackgroundColorChange( var aColor : Integer );
    procedure MainSelectedForegroundColorChange( var aColor : Integer );
    procedure MainSelectedBackgroundColorChange( var aColor : Integer );

    procedure SubUnselectedForegroundColorChange( var aColor : Integer );
    procedure SubUnselectedBackgroundColorChange( var aColor : Integer );
    procedure SubSelectedForegroundColorChange( var aColor : Integer );
    procedure SubSelectedBackgroundColorChange( var aColor : Integer );

    procedure SetTextSizeLabel;
  public
    { public declarations }
    constructor Create( AOwner : TComponent ); override;
    procedure Save( Data : TMenuCSSData );
    procedure Load( Data : TMenuCSSData );
  end;

implementation

uses
  Common1;

{$R *.lfm}

{ TMenuCSSFrame }

procedure TMenuCSSFrame.TextSizeTBChange(Sender: TObject);
begin
  SetTextSizeLabel;
end;

procedure TMenuCSSFrame.SetForegroundColor(aPanel: TPanel; aColor: Integer);
begin
  aPanel.Font.Color := aColor;
end;

procedure TMenuCSSFrame.SetBackgroundColor(aPanel: TPanel; aColor: Integer);
begin
  aPanel.Color := aColor;
end;

procedure TMenuCSSFrame.MainUnselectedForegroundColorChange(var aColor: Integer
  );
begin
  SetForegroundColor( MainUnselectedSamplePanel, aColor );
end;

procedure TMenuCSSFrame.MainUnselectedBackgroundColorChange(var aColor: Integer
  );
begin
  SetBackgroundColor( MainUnselectedSamplePanel, aColor );
end;

procedure TMenuCSSFrame.MainSelectedForegroundColorChange(var aColor: Integer);
begin
  SetForegroundColor( MainSelectedSamplePanel, aColor );
end;

procedure TMenuCSSFrame.MainSelectedBackgroundColorChange(var aColor: Integer);
begin
  SetBackgroundColor( MainSelectedSamplePanel, aColor );
end;

procedure TMenuCSSFrame.SubUnselectedForegroundColorChange(var aColor: Integer
  );
begin
  SetForegroundColor( SubUnselectedSamplePanel, aColor );
end;

procedure TMenuCSSFrame.SubUnselectedBackgroundColorChange(var aColor: Integer
  );
begin
  SetBackgroundColor( SubUnselectedSamplePanel, aColor );
end;

procedure TMenuCSSFrame.SubSelectedForegroundColorChange(var aColor: Integer);
begin
  SetForegroundColor( SubSelectedSamplePanel, aColor );
end;

procedure TMenuCSSFrame.SubSelectedBackgroundColorChange(var aColor: Integer);
begin
  SetBackgroundColor( SubSelectedSamplePanel, aColor );
end;

procedure TMenuCSSFrame.SetTextSizeLabel;
begin
  TextSizeLabel.Caption := FloatToStrf( TextSizeTB.Position / 10.0, ffFixed, 4,1 ) + ' em';
end;

constructor TMenuCSSFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ColorFrame1.OnColorChange := @MainUnselectedForegroundColorChange;
  ColorFrame2.OnColorChange := @MainUnselectedBackgroundColorChange;
  ColorFrame3.OnColorChange := @MainSelectedForegroundColorChange;
  ColorFrame4.OnColorChange := @MainSelectedBackgroundColorChange;

  ColorFrame5.OnColorChange := @SubUnselectedForegroundColorChange;
  ColorFrame6.OnColorChange := @SubUnselectedBackgroundColorChange;
  ColorFrame7.OnColorChange := @SubSelectedForegroundColorChange;
  ColorFrame8.OnColorChange := @SubSelectedBackgroundColorChange;
end;

procedure TMenuCSSFrame.Save(Data: TMenuCSSData);
var
  Index : Integer;
begin
  Data.MainUnselectedTextColor       := ColorFrame1.Color;
  Data.MainUnselectedBackgroundColor := ColorFrame2.Color;
  Data.MainSelectedTextColor         := ColorFrame3.Color;
  Data.MainSelectedBackgroundColor   := ColorFrame4.Color;
  Index := MainUnselectedArrowImageCB.ItemIndex;
  if Index >= 0 then
    Data.MainUnselectedArrowImage    := MainUnselectedArrowImageCB.Items[Index]
  else
    Data.MainUnselectedArrowImage    := '';
  Index := MainSelectedArrowImageCB.ItemIndex;
  if Index >= 0 then
    Data.MainSelectedArrowImage      := MainSelectedArrowImageCB.Items[Index]
  else
    Data.MainSelectedArrowImage      := '';
  Data.SubUnselectedTextColor        := ColorFrame5.Color;
  Data.SubUnselectedBackgroundColor  := ColorFrame6.Color;
  Data.SubSelectedTextColor          := ColorFrame7.Color;
  Data.SubSelectedBackgroundColor    := ColorFrame8.Color;
  Index := SubUnselectedArrowImageCB.ItemIndex;
  if Index >= 0 then
    Data.SubUnselectedArrowImage     := SubUnselectedArrowImageCB.Items[Index]
  else
    Data.SubUnselectedArrowImage     := '';
  Index := SubSelectedArrowImageCB.ItemIndex;
  if Index >= 0 then
    Data.SubSelectedArrowImage       := SubSelectedArrowImageCB.Items[Index]
  else
    Data.SubSelectedArrowImage       := '';
  Data.FontFaces                     := FontFacesEdit.Text;
  Data.FontBold                      := FontBoldCB.Checked;
  Data.Textsize                      := TextSizeTB.Position;
  SetTextSizeLabel;
end;

procedure TMenuCSSFrame.Load(Data: TMenuCSSData);
begin
  ColorFrame1.Color                  := Data.MainUnselectedTextColor;
  ColorFrame2.Color                  := Data.MainUnselectedBackgroundColor;
  ColorFrame3.Color                  := Data.MainSelectedTextColor;
  ColorFrame4.Color                  := Data.MainSelectedBackgroundColor;
  SetPositionCB(MainUnselectedArrowImageCB, Data.MainUnselectedArrowImage);
  SetPositionCB(MainSelectedArrowImageCB, Data.MainSelectedArrowImage);
  ColorFrame5.Color                  := Data.SubUnselectedTextColor;
  ColorFrame6.Color                  := Data.SubUnselectedBackgroundColor;
  ColorFrame7.Color                  := Data.SubSelectedTextColor;
  ColorFrame8.Color                  := Data.SubSelectedBackgroundColor;
  SetPositionCB(SubUnselectedArrowImageCB, Data.SubUnselectedArrowImage);
  SetPositionCB(SubSelectedArrowImageCB, Data.SubSelectedArrowImage);
  FontFacesEdit.Text                 := Data.FontFaces;
  FontBoldCB.Checked                 := Data.FontBold;
  TextSizeTB.Position                := Data.TextSize;

  SetForegroundColor( MainUnselectedSamplePanel, ColorFrame1.Color );
  SetBackgroundColor( MainUnselectedSamplePanel, ColorFrame2.Color );
  SetForegroundColor( MainSelectedSamplePanel, ColorFrame3.Color );
  SetBackgroundColor( MainSelectedSamplePanel, ColorFrame4.Color );
  SetForegroundColor( SubUnselectedSamplePanel, ColorFrame5.Color );
  SetBackgroundColor( SubUnselectedSamplePanel, ColorFrame6.Color );
  SetForegroundColor( SubSelectedSamplePanel, ColorFrame7.Color );
  SetBackgroundColor( SubSelectedSamplePanel, ColorFrame8.Color );

end;

end.

