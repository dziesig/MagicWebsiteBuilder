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

unit MenuSelectFrame1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, ComCtrls, ExtCtrls,
  Dialogs,

  WebsiteMenusUnit1, MenusFrame1;

type

  { TMenuSelectFrame }

  TMenuSelectFrame = class(TFrame)
    MenusFrame1: TMenusFrame;
    MenusFrame2: TMenusFrame;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    PrimaryMenuPositionRG: TRadioGroup;
    SecondaryMenuPositionRG: TRadioGroup;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure PrimaryMenuPositionRGClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    constructor Create( AOwner : TComponent ); override;
    procedure Save( Data : TWebsiteMenusData );
    procedure Load( Data : TWebsiteMenusData );
end;
implementation

uses
  Common1;

{$R *.lfm}

{ TMenuSelectFrame }

procedure TMenuSelectFrame.PrimaryMenuPositionRGClick(Sender: TObject);
var
  I : Integer;
begin
  SecondaryMenuPositionRG.Items.Clear;
  SecondaryMenuPositionRG.Items.Add('None');
  for I := 0 to PrimaryMenuPositionRG.Items.Count - 1 do
    if I <> PrimaryMenuPositionRG.ItemIndex then
      SecondaryMenuPositionRG.Items.Add(PrimaryMenuPositionRG.Items[I]);
  SecondaryMenuPositionRG.ItemIndex := 0;
end;

constructor TMenuSelectFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  PageControl1.TabIndex := 0;
end;

procedure TMenuSelectFrame.Save(Data: TWebsiteMenusData);
var
  I : Integer;
begin
  I := PageControl1.TabIndex;    // Hack to work around inability to set
  if I < 0 then                  // PageControl's TabIndex in constructor.
    PageControl1.TabIndex := 0;
  Data.PrimaryMenu.MenuPosition := PrimaryMenuPositionRG.Items[PrimaryMenuPositionRG.ItemIndex];
  Data.SecondaryMenu.MenuPosition := SecondaryMenuPositionRG.Items[SecondaryMenuPositionRG.ItemIndex];
  MenusFrame1.SetData( Data.PrimaryMenu );
  MenusFrame2.SetData( Data.SecondaryMenu );
  MenusFrame1.Save( Data.PrimaryMenu ); // LOOK HERE need to separate Primary from Secondary
  MenusFrame2.Save( Data.SecondaryMenu ); // LOOK HERE need to separate Primary from Secondary
end;

procedure TMenuSelectFrame.Load(Data: TWebsiteMenusData);
var
  I : Integer;
begin
  I := PageControl1.TabIndex;    // Hack to work around inability to set
  if I < 0 then                  // PageControl's TabIndex in constructor.
    PageControl1.TabIndex := 0;

  SetPositionRG( PrimaryMenuPositionRG, Data.PrimaryMenu.MenuPosition );
  PrimaryMenuPositionRGClick( nil );
  SetPositionRG( SecondaryMenuPositionRG, Data.SecondaryMenu.MenuPosition );

  MenusFrame1.SetData( Data.PrimaryMenu );
  MenusFrame2.SetData( Data.SecondaryMenu );
  MenusFrame1.Load( Data.PrimaryMenu ); // LOOK HERE need to separate Primary from Secondary
  MenusFrame2.Load( Data.SecondaryMenu ); // LOOK HERE need to separate Primary from Secondary

end;

end.

