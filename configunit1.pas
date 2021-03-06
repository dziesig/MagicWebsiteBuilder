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
unit ConfigUnit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TConfigData }

  TConfigData = class
  private
    function GetBaseDirectory: String;
    function GetClientDirectory: String;
    function GetImagePath: String;
    function GetWebsiteDirectory: String;
    procedure SetBaseDirectory(AValue: String);
    procedure SetClientDirectory(AValue: String);
    procedure SetImagePath(AValue: String);
    procedure SetWebsiteDirectory(AValue: String);
    public
      property ImagePath : String read GetImagePath write SetImagePath;

{==============================================================================}
{  Examples:                                                                   }
{                                                                              }
{    BaseDirectory                                                             }
{      c:\Documents and Settings\Donald R. Ziesig\MagicWebsiteBuilder\         }
{                                                                              }
{    ClientDirectory:                                                          }
{      BaseDirectory + Client Name\                                            }
{                                                                              }
{    WebsiteDirectory                                                          }
{      ClientDirectory + WebsiteName\ -- WebsiteName same as WebsiteName.ncw   }
{                                                                              }
{                                                                              }
{                                                                              }
{==============================================================================}

      property WebsiteDirectory : String read GetWebsiteDirectory write SetWebsiteDirectory;
      property ClientDirectory  : String read GetClientDirectory  write SetClientDirectory;
      property BaseDirectory    : String read GetBaseDirectory    write SetBaseDirectory;
  end;

var
  ConfigData : TConfigData;

implementation

uses
  Common1, StringSubs;

{ TConfigData }

function TConfigData.GetBaseDirectory: String;
begin
  Result := GetConfig('Paths','Base',DefaultSaveLocation);
end;

function TConfigData.GetClientDirectory: String;
begin
  Result := BaseDirectory + GetConfig('Paths','Client','Client') + DirectorySeparator;
end;

function TConfigData.GetImagePath: String;
begin
  Result := GetConfig('Images','Path',DefaultSaveLocation);
end;

function TConfigData.GetWebsiteDirectory: String;
var
  Website : String;
begin
  Website := GetConfig('Paths','Website','');
  if Empty(Website) then
    Result := DefaultSaveLocation
  else
    Result := ClientDirectory + Website + DirectorySeparator;
end;

procedure TConfigData.SetBaseDirectory(AValue: String);
begin
  if AValue = '' then exit;
  SetConfig('Paths','Base',AValue);
end;

procedure TConfigData.SetClientDirectory(AValue: String);
var
  Name : String;
begin
  if AValue = '' then exit;
  Name := ExtractFileOrDirectory(-1,AValue);
  SetConfig('Paths','Client',Name);
end;

procedure TConfigData.SetImagePath(AValue: String);
begin
  SetConfig('Images','Path',AValue);
end;

procedure TConfigData.SetWebsiteDirectory(AValue: String);
var
  Name : String;
begin
  if AValue = 'UNTITLED' then exit;
  Name := ExtractFileOrDirectory(-1,AValue);
  SetConfig('Paths','Website',Name);
end;

initialization
  ConfigData := TConfigData.Create;
finalization
  ConfigData.Free;
end.

