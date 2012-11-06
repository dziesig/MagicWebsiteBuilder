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
unit GeneratorObjectUnit1;

{$mode objfpc}{$H+}

interface

uses
  CustomizedWebsiteUnit1, SysUtils;

type

{ TGenerator }

 TGenerator = class
  private
    function GetLocalTestJavascriptPath: string;
    function GetLocalTestImagePath: string;
    function GetLocalTestPath: string;
    function GetLocalTestStylesheetPath: string;
    function GetStylesheetPath: String;
    function GetWebsitePath: String;
    function GetWorkImagePath: string;
    function GetWorkPath: String;
    function GetDeployPath: String;
    function GetHostPath: String;
   protected
    fWebsite : TCustomizedWebsite;
    function GetTemplatePath: String;
    property TemplatePath : String read GetTemplatePath;
  published
  public
    constructor Create( aWebsite : TCustomizedWebsite ); virtual;

    property Website : TCustomizedWebsite read fWebsite;
    property WebsitePath : String read GetWebsitePath;
    property WorkPath : String read GetWorkPath;
    property DeployPath : String read GetDeployPath;
    property HostPath   : String read GetHostPath;
    property StylesheetPath : String read GetStylesheetPath;
    property LocalTestPath           : string read GetLocalTestPath;
    property LocalTestStylesheetPath : string read GetLocalTestStylesheetPath;
    property LocalTestJavascriptPath : string read GetLocalTestJavascriptPath;
    property LocalTestImagePath      : string read GetLocalTestImagePath;
end;

implementation

uses
  ConfigUnit1, Common1;

{ TGenerator }

constructor TGenerator.Create(aWebsite: TCustomizedWebsite);
begin
  fWebsite := aWebsite;
end;

function TGenerator.GetDeployPath: String;
begin
  Stub('TGenerator.GetDeployPath');
  Result := ConfigData.WebsiteDirectory + DirectorySeparator + 'Deploy';
end;

function TGenerator.GetHostPath: String;
begin
  Debug('TGenerator.GetHostPath');
  Result := ConfigData.WebsiteDirectory + DirectorySeparator + 'Host';
end;

//function TGenerator.GetWorkStylesheetPath: string;
//begin
//  Result := WorkPath + 'Stylesheets' + DirectorySeparator;
//end;

//function TGenerator.GetLocalTestavascriptPath: string;
//begin
//
//end;

function TGenerator.GetLocalTestJavascriptPath: string;
begin
  Result := LocalTestPath + 'Javascripts' + DirectorySeparator;
end;

function TGenerator.GetLocalTestImagePath: string;
begin
  Result := LocalTestPath + 'Images' + DirectorySeparator;
end;

function TGenerator.GetLocalTestPath: string;
begin
  Result := ConfigData.WebsiteDirectory + DirectorySeparator + 'LocalTest' + DirectorySeparator;
end;

function TGenerator.GetLocalTestStylesheetPath: string;
begin
  Result := LocalTestPath + 'Stylesheets' + DirectorySeparator;
end;

function TGenerator.GetStylesheetPath: String;
begin
  Result := ConfigData.WebsiteDirectory + DirectorySeparator + 'StyleSheets';
end;

function TGenerator.GetWebsitePath: String;
begin
//  Result := ConfigData.WebsiteDirectory + DirectorySeparator;
  Result := ConfigData.WebsiteDirectory;
end;

function TGenerator.GetWorkImagePath: string;
begin
  Result := WorkPath + 'Images' + DirectorySeparator;
end;

//function TGenerator.GetWorkJavascriptPath: string;
//begin
//  Result := WorkPath + 'Javascripts' + DirectorySeparator;
//end;

function TGenerator.GetTemplatePath: String;
begin
  Result := ExePath + DirectorySeparator + 'Templates' + DirectorySeparator;
end;

function TGenerator.GetWorkPath: String;
begin
  Result := ConfigData.WebsiteDirectory + 'Work' + DirectorySeparator;
end;

end.

