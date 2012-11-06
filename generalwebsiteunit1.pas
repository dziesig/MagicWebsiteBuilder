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
unit GeneralWebsiteUnit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,

  Persists1, TextIO1, WebsiteRootUnit1;

type

  { TGeneralWebsiteData }

  TGeneralWebsiteData = class( TWebsiteRoot )
  private
    procedure SetClientName(const AValue: String);
    procedure SetCopyrightInitialYear(const AValue: Integer);
    procedure SetCopyrightBy(const AValue: String);
    procedure SetCustomizationLink(const AValue: String);
    procedure SetDefaultTitle(const AValue: String);
    procedure SetHoverBackgroundColor(const AValue: Integer);
    procedure SetHoverForegroundColor(const AValue: Integer);
    procedure SetIDXURL(const AValue: String);
    procedure SetLinkForegroundColor(const AValue: Integer);
    procedure setNoHostURL(const AValue: String);
    procedure SetPoint2URL(const AValue: String);
    procedure SetWolfnetURL(const AValue: string);
    procedure SetZHouseURL(const AValue: String);
    protected

      fTestMode        : Boolean;

      fClientName      : String;
      fPoint2URL       : String;
      fIDXURL          : String;
      fWolfnetURL      : String;
      fZHouseURL       : String;
      fNoHostURL       : String;

      fCustomizationLink    : string;
      fLinkForegroundColor  : Integer;
      fHoverForegroundColor : Integer;
      fHoverBackgroundColor : Integer;

      fDefaultTitle         : String;
      fCopyrightInitialYear : Integer;
      fCopyrightBy          : String;

    protected
      function GetCopyrightYears       : String;
      function GetClientName           : String;
      function GetCopyrightBy          : String;
      function GetPoint2URL            : String;
      function GetIDXURL               : String;
      function GetWolfnetURL           : String;
      function GetZHouseURL            : String;
      function GetNoHostURL            : String;
      function GetCustomizationLink    : String;
      function GetLinkForegroundColor  : String;
      function GetHoverForegroundColor : String;
      function GetHoverBackgroundColor : String;
      function GetDefaultTitle         : String;
      function GetUpdateDate           : String;
      function GetName                 : String;

      function DeployBaseURL           : String;
      function DeployURL               : String;

      function TopImageCSS             : String;
    public
      constructor Create( AParent : TPersists = nil ); override;

      procedure BuildVarlist;
      procedure MakeNew; override;
      procedure Save( TextIO : TTextIO ); override;
      procedure Read( TextIO : TTextIO; Version : Integer ); override;

      property TestMode    : Boolean read fTestMode write fTestMode;
      property ClientName  : String read fClientName write SetClientName;
      property Point2URL   : String read fPoint2URL  write SetPoint2URL;
      property IDXURL      : String read fIDXURL     write SetIDXURL;
      property WolfnetURL  : string read fWolfnetURL write SetWolfnetURL;
      property ZHouseURL   : String read fZHouseURL  write SetZHouseURL;
      property NoHostURL   : String read fNoHostURL  write setNoHostURL;

      property CustomizationLink    : String  read fCustomizationLink    write SetCustomizationLink;
      property LinkForegroundColor  : Integer read fLinkForegroundColor  write SetLinkForegroundColor;
      property HoverForegroundColor : Integer read fHoverForegroundColor write SetHoverForegroundColor;
      property HoverBackgroundColor : Integer read fHoverBackgroundColor write SetHoverBackgroundColor;

      property DefaultTitle         : String read fDefaultTitle          write SetDefaultTitle;
      property CopyrightInitialYear : Integer read fCopyrightInitialYear write SetCopyrightInitialYear;
      property CopyrightBy          : String  read fCopyrightBy          write SetCopyrightBy;
  end;

implementation

uses
  ObjectFactory1, NamedFunctionUnit1, Common1;

{ TGeneralWebsiteData }

const
  Version = 1;

procedure TGeneralWebsiteData.SetClientName(const AValue: String);
begin
  Update(fClientName,AValue);
end;

procedure TGeneralWebsiteData.SetCopyrightInitialYear(const AValue: Integer);
begin
  Update(fCopyrightInitialYear,AValue);
end;

procedure TGeneralWebsiteData.SetCopyrightBy(const AValue: String);
begin
  Update(fCopyrightBy,AValue);
end;

procedure TGeneralWebsiteData.SetCustomizationLink(const AValue: String);
begin
  Update(fCustomizationLink,AValue);
end;

procedure TGeneralWebsiteData.SetDefaultTitle(const AValue: String);
begin
  Update(fDefaultTitle,AValue);
end;

procedure TGeneralWebsiteData.SetHoverBackgroundColor(const AValue: Integer);
begin
  Update(fHoverBackgroundColor,AValue);
end;

procedure TGeneralWebsiteData.SetHoverForegroundColor(const AValue: Integer);
begin
  Update(fHoverForegroundColor,AValue);
end;

procedure TGeneralWebsiteData.SetIDXURL(const AValue: String);
begin
  Update(fIDXURL,AValue);
end;

procedure TGeneralWebsiteData.SetLinkForegroundColor(const AValue: Integer);
begin
  Update(fLinkForegroundColor,AValue);
end;

procedure TGeneralWebsiteData.setNoHostURL(const AValue: String);
begin
  Update(fNoHostURL,AValue);
end;

procedure TGeneralWebsiteData.SetPoint2URL(const AValue: String);
begin
  Update(fPoint2URL,AValue);
end;

procedure TGeneralWebsiteData.SetWolfnetURL(const AValue: string);
begin
  Update(fWolfnetURL,AValue);
end;

procedure TGeneralWebsiteData.SetZHouseURL(const AValue: String);
begin
  Update(fZHouseURL,AValue);
end;

function TGeneralWebsiteData.TopImageCSS: String;
begin
  Result := ''; { TODO 1 -odonz : Implement this correctly.  Needs to look at the images unit to see if the top image has been loaded. }
end;

function TGeneralWebsiteData.GetCopyrightYears: String;
begin
  result := IntToStr( fCopyrightInitialYear );
end;

function TGeneralWebsiteData.GetClientName: String;
begin
  Result := fClientName;
end;

function TGeneralWebsiteData.GetCopyrightBy: String;
begin
  Result := fCopyrightBy;
end;

function TGeneralWebsiteData.GetPoint2URL: String;
begin
  Result := fPoint2URL;
end;

function TGeneralWebsiteData.GetIDXURL: String;
begin
  Result := fIDXURL;
end;

function TGeneralWebsiteData.GetWolfnetURL: String;
begin
  Result := fWolfnetURL;
end;

function TGeneralWebsiteData.GetZHouseURL: String;
begin
  Result := fZHouseURL;
end;

function TGeneralWebsiteData.GetNoHostURL: String;
begin
  Result := fNoHostURL;
end;

function TGeneralWebsiteData.GetCustomizationLink: String;
begin
  Result := fCustomizationLink;
end;

function TGeneralWebsiteData.GetLinkForegroundColor: String;
begin
  Result := CSSColor(ColorSwap(fLinkForegroundColor));
end;

function TGeneralWebsiteData.GetHoverForegroundColor: String;
begin
  Result := CSSColor(ColorSwap(fHoverForegroundColor));
end;

function TGeneralWebsiteData.GetHoverBackgroundColor: String;
begin
  Result := CSSColor(ColorSwap(fHoverBackgroundColor));
end;

function TGeneralWebsiteData.GetDefaultTitle: String;
begin
  Result := fDefaultTitle;
end;

function TGeneralWebsiteData.GetUpdateDate: String;
begin
  Result := DateTimeToStr(Now);
end;

function TGeneralWebsiteData.GetName: String;
begin
  Result := Name;
end;

constructor TGeneralWebsiteData.Create(AParent : TPersists = nil);
begin
  inherited Create(AParent);
  BuildVarlist;
end;

function TGeneralWebsiteData.DeployBaseURL: String;
begin
  if TestMode then
    Result := ''
  else
    Result := 'http://www.customizewebsite.com/' +'/';
end;

function TGeneralWebsiteData.DeployURL: String;
begin
  if TestMode then
    Result := ''
  else
    Result := 'http://customizewebsite.com/' + Name +'/';
end;

procedure TGeneralWebsiteData.BuildVarlist;
begin
  inherited;
  VarList.AddFunction('CopyrightYears',@GetCopyrightYears);
  VarList.AddFunction('CopyrightBy',@GetCopyrightBy);
  VarList.AddFunction('ClientName',@GetClientName);
  VarList.AddFunction('TCWCustomizationLink',@getCustomizationLink);
  VarList.AddFunction('CustomizationLinkColor',@GetLinkForegroundColor);
  VarList.AddFunction('CustomizationLinkHoverColor',@GetHoverForegroundColor);
  VarList.AddFunction('CustomizationLinkHoverBackground',@GetHoverBackgroundColor);
  VarList.AddFunction('Title',@GetDefaultTitle);
  VarList.AddFunction('IDXRootURL',@GetIDXURL);
  VarList.AddFunction('UpdateDate',@GetUpdateDate);
  VarList.AddFunction('DeployBaseURL',@DeployBaseURL);
  VarList.AddFunction('DeployURL',@DeployURL);

  VarList.AddFunction('TopImageCSS',@TopImageCSS);

end;

procedure TGeneralWebsiteData.MakeNew;
begin
  inherited MakeNew;
  fClientName := 'A Client';
  fPoint2URL  := 'Point2';
  fIDXURL     := 'IDX';
  fWolfnetURL := 'Wolfnet';
  fZHouseURL  := 'ZHouse';
  fNoHostURL  := '#';

  fCustomizationLink := '/* None Specified */';
  fLinkForegroundColor := $FFFFFF;
  fHoverForegroundColor := $000000;
  fHoverBackgroundColor := $ffffff;

  fDefaultTitle := 'Default Title';
  fCopyrightInitialYear := 2012;
  fCopyrightBy          := 'The Customized Website';

  fTestMode := True; // LOOK HERE
end;

procedure TGeneralWebsiteData.Save(TextIO: TTextIO);
begin
  SaveHeader( TextIO, Version );
  TextIO.WriteLn(fClientName);
  TextIO.WriteLN(fPoint2URL);
  TextIO.WriteLn(fIDXURL);
  TextIO.Writeln(fWolfnetURL);
  TextIO.Writeln(fZHouseURL);
  TextIO.Writeln(fNoHostURL);
  TextIO.Writeln(fCustomizationLink);
  TextIO.Writeln(fLinkForegroundColor);
  TextIO.Writeln(fHoverForegroundColor);
  TextIO.Writeln(fHoverBackgroundColor);
  TextIO.Writeln(fDefaultTitle);
  TextIO.Writeln(fCopyrightInitialYear);
  TextIO.Writeln(fCopyrightBy);
  UNMODIFY;
  SaveTrailer( TextIO );
end;

procedure TGeneralWebsiteData.Read( TextIO : TTextIO; Version : Integer );
begin
  MakeNew;
  if Version >= 1 then
    begin
      TextIO.ReadLn(fClientName);
      TextIO.ReadLn(fPoint2URL);
      TextIO.ReadLn(fIDXURL);
      TextIO.ReadLn(fWolfnetURL);
      TextIO.ReadLn(fZHouseURL);
      TextIO.ReadLn(fNoHostURL);
      TextIO.ReadLn(fCustomizationLink);
      TextIO.ReadLn(fLinkForegroundColor);
      TextIO.ReadLn(fHoverForegroundColor);
      TextIO.ReadLn(fHoverBackgroundColor);
      TextIO.ReadLn(fDefaultTitle);
      TextIO.ReadLn(fCopyrightInitialYear);
      TextIO.ReadLn(fCopyrightBy);
    end;

end;

//function TGeneralWebsiteData.Find(Variable: String; var GotIt: Boolean
//  ): String;
//begin
//  GotIt := VarList.Execute( Result, Variable);
//end;

initialization
  ObjectFactory.RegisterClass( TGeneralWebsiteData.ClassType );
end.

