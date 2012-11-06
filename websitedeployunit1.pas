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

