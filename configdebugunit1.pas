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
unit ConfigDebugUnit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TConfigDebugForm }

  TConfigDebugForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BaseDirectoryLabel: TLabel;
    ClientDirectoryLabel: TLabel;
    WebsiteDirectoryLabel: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  ConfigDebugForm: TConfigDebugForm;

implementation

uses
  ConfigUnit1;

{$R *.lfm}

{ TConfigDebugForm }

procedure TConfigDebugForm.FormShow(Sender: TObject);
begin
  BaseDirectoryLabel.Caption    := ConfigData.BaseDirectory;
  ClientDirectoryLabel.Caption  := ConfigData.ClientDirectory;
  WebsiteDirectoryLabel.Caption := ConfigData.WebsiteDirectory;
end;

end.

