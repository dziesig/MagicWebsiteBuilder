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
unit WebsiteDeployUnit1;

{$mode objfpc}{$H+}

interface

uses
  CustomizedWebsiteUnit1, GeneratorObjectUnit1;

type TWebsiteDeploy = class(TGenerator)
  private
  protected
    property Website : TCustomizedWebsite read fWebsite;
  public
    constructor Create( aWebsite : TCustomizedWebsite ); override;

    procedure Deploy;

    procedure Upload;
 end;

implementation

uses
  Common1, SysUtils, Graphics;

{ TWebsiteDeploy }

constructor TWebsiteDeploy.Create(aWebsite: TCustomizedWebsite);
begin
  inherited Create( AWebsite );
{ Remove and recreate the Deployment directory for this website }
  if DirectoryExists(DeployPath) then
    try
      WalkDirectoryTree(DeployPath,'','*.*',faAnyFile,True,@RmFiles,nil);
    finally

    end;
  ForceDirectories( DeployPath );
  ForceDirectories( DeployPath + '\Stylesheets');
  ForceDirectories( DeployPath + '\Html');
  ForceDirectories( DeployPath + '\Javascripts');
  ForceDirectories( DeployPath + '\Images');

  ForceDirectories( HostPath );
end;

procedure TWebsiteDeploy.Deploy;
//var
//  Image : TPicture;
begin
  if FileExists( WorkPath + '\WolfnetHeader.htx') then
    CopyFile( WorkPath + '\WolfnetHeader.htx', DeployPath + '\Html\WolfnetHeader.htm');
  if FileExists( WorkPath + '\WolfnetFooter.htx') then
    CopyFile( WorkPath + '\WolfnetFooter.htx', DeployPath + '\Html\WolfnetFooter.htm');
  CopyFile( WorkPath + '\BrowserBar.htm', DeployPath + '\Html\BrowserBar.htm');
  CopyFile( WorkPath + '\IDXHeaderFooter.js', DeployPath + '\Javascripts\IDXHeaderFooter.js');
  CopyFile( WorkPath + '\TheCustomizedWebsite.css', DeployPath + '\Stylesheets\TheCustomizedWebsite.css');
  CopyFile( WorkPath + '\primary.css', DeployPath + '\Stylesheets\primarymenu.css');
  CopyFile( WorkPath + '\secondary.css', DeployPath + '\Stylesheets\secondarymenu.css');

  CopyFile( WorkPath + '\Point2Footer.htx', HostPath + '\Point2Footer.htm');
  CopyFile( WorkPath + '\Point2Header.htx', HostPath + '\Point2Header.htm');
  CopyFile( WorkPath + '\IDXFooter.htx', HostPath + '\IDXFooter.htm');
  CopyFile( WorkPath + '\IDXHeader.htx', HostPath + '\IDXHeader.htm');

  //Image := fWebsite.BackgroundImage;
  //if (Image <> nil) and (Image.Graphic <> nil ) then
  //  Image.SaveToFile( DeployPath + '\Images\Background.jpg');
  //Image := fWebsite.BodyImage;
  //if (Image <> nil) and (Image.Graphic <> nil ) then
  //  Image.SaveToFile( DeployPath + '\Images\Body.jpg');
  //Image := fWebsite.TopImage;
  //if (Image <> nil) and (Image.Graphic <> nil ) then
  //  Image.SaveToFile( DeployPath + '\Images\Top.jpg');
  //Image := fWebsite.HeaderImage;
  //if (Image <> nil) and (Image.Graphic <> nil ) then
  //  Image.SaveToFile( DeployPath + '\Images\Header.jpg');
  //Image := fWebsite.BlogHeaderImage;
  //if (Image <> nil) and (Image.Graphic <> nil ) then
  //  Image.SaveToFile( DeployPath + '\Images\BlogHeader.jpg');

end;

procedure TWebsiteDeploy.Upload;
begin

end;

end.

