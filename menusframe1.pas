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

unit MenusFrame1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, ComCtrls, ExtCtrls, StdCtrls,
  MenuItemFrame1,

  WebsiteMenusUnit1, GeneralCSSFrame1, MenuCSSFrame1,
  IDXHdrFtrFrame1;

type

  { TMenusFrame }

  TMenusFrame = class(TFrame)
    Button1: TButton;
    GeneralCSSFrame1: TGeneralCSSFrame;
    IDXHdrFtrFrame1: TIDXHdrFtrFrame;
    Label7: TLabel;
    MenuCSSFrame1: TMenuCSSFrame;
    MenuItemFrame1: TMenuItemFrame;
    PageControl1: TPageControl;
    Panel1: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
  private
    { private declarations }
    fData : TWebsiteMenuData;
  public
    { public declarations }
    constructor Create( AOwner : TComponent ); override;
    procedure Save( Data : TWebsiteMenuData );
    procedure Load( Data : TWebsiteMenuData );
    procedure SetData( Data : TWebsiteMenuData );
  end;

implementation

uses
  MWBMain1; // For debug

{$R *.lfm}

{ TMenusFrame }

procedure TMenusFrame.Button1Click(Sender: TObject);
begin
  MWBMain.MWBData.Menus.PrimaryMenu.TCWMenuData.Show(MWBMain.Memo1);
end;

procedure TMenusFrame.PageControl1Change(Sender: TObject);
begin

end;

procedure TMenusFrame.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
var
  ActivePage : Integer;
begin
  AllowChange := True;
  if not Assigned( fData ) then exit;
  ActivePage := PageControl1.TabIndex;
  case ActivePage of
  0:  MenuItemFrame1.Save( fData.TCWMenuData );
  1:  GeneralCSSFrame1.Save( fData.GeneralCSSData );
  2:  MenuCSSFrame1.Save( fData.MenuCSSData );
  3:  IDXHdrFtrFrame1.Save( fData.IDXHdrFtrData );
  end;

end;

constructor TMenusFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  PageControl1.TabIndex := 0;  // For some reason this doesn't work here.
                               // See load and save for workaround hack.
end;

procedure TMenusFrame.Save(Data: TWebsiteMenuData);
var
  I : Integer;
begin
  I := PageControl1.TabIndex;    // Hack to work around inability to set
  if I < 0 then                  // PageControl's TabIndex in constructor.
    PageControl1.TabIndex := 0;

  GeneralCSSFrame1.Save( Data.GeneralCSSData );
  MenuCSSFrame1.Save( Data.MenuCSSData );
  IDXHdrFtrFrame1.Save( Data.IDXHdrFtrData );
  MenuItemFrame1.Save( Data.TCWMenuData );
end;

procedure TMenusFrame.Load(Data: TWebsiteMenuData);
var
  I : Integer;
begin
  I := PageControl1.TabIndex;    // Hack to work around inability to set
  if I < 0 then                  // PageControl's TabIndex in constructor.
    PageControl1.TabIndex := 0;

  GeneralCSSFrame1.Load( Data.GeneralCSSData );
  MenuCSSFrame1.Load( Data.MenuCSSData );
  IDXHdrFtrFrame1.Load( Data.IDXHdrFtrData );
  MenuItemFrame1.Load( Data.TCWMenuData );
end;

procedure TMenusFrame.SetData(Data: TWebsiteMenuData);
begin
  fData := Data;
end;

end.

