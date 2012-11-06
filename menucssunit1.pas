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

unit MenuCSSUnit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,

  Persists1, TextIO1, WebsiteRootUnit1;

type

  { TMenuCSSData }

  TMenuCSSData = class( TWebsiteRoot )
  private
    function GetUseDownArrowImage: Boolean;
    procedure SetFontBold(const AValue: Boolean);
    procedure SetFontFaces(const AValue: String);
    procedure SetMainSelectedArrowImage(const AValue: String);
    procedure SetMainSelectedBackgroundColor(const AValue: Integer);
    procedure SetMainSelectedTextColor(const AValue: Integer);
    procedure SetMainUnselectedArrowImage(const AValue: String);
    procedure SetMainUnselectedBackgroundColor(const AValue: Integer);
    procedure SetMainUnselectedTextColor(const AValue: Integer);
    procedure SetSubSelectedArrowImage(const AValue: String);
    procedure SetSubSelectedBackgroundColor(const AValue: Integer);
    procedure SetSubSelectedTextColor(const AValue: Integer);
    procedure SetSubUnselectedArrowImage(const AValue: String);
    procedure SetSubUnselectedBackgroundColor(const AValue: Integer);
    procedure SetSubUnselectedTextColor(const AValue: Integer);
    procedure SetTextSize(const AValue: Integer);

  protected
    fMainUnselectedTextColor       : Integer;
    fMainUnselectedBackgroundColor : Integer;
    fMainSelectedTextColor         : Integer;
    fMainSelectedBackgroundColor   : Integer;
    fMainUnselectedArrowImage      : String;
    fMainSelectedArrowImage        : String;
    fSubUnselectedTextColor        : Integer;
    fSubUnselectedBackgroundColor  : Integer;
    fSubSelectedTextColor          : Integer;
    fSubSelectedBackgroundColor    : Integer;
    fSubUnselectedArrowImage       : String;
    fSubSelectedArrowImage         : String;
    fFontFaces                     : String;
    fFontBold                      : Boolean;
    fTextSize                      : Integer;  // LSB = 0.1 em

    procedure BuildVarList; override;

    function  GetFontFaces                       : String;
    function  GetFontWeightCSS                   : String;
    function  GetTextHeight                      : String;
    function  GetUnselectedTextColorCSS          : String;
    function  GetUnselectedBackgroundColorCSS    : String;
    function  GetSelectedTextColorCSS            : String;
    function  GetSelectedBackgroundColorCSS      : String;
    function  GetSubSelectedTextColorCSS         : String;
    function  GetSubSelectedBackgroundColorCSS   : String;
    function  GetSubUnselectedTextColorCSS       : String;
    function  GetSubUnSelectedBackgroundColorCSS : String;

    function  GetMainSelectedArrowImage          : String;
    function  GetMainUnselectedArrowImage        : String;
    function  GetSubSelectedArrowImage           : String;
    function  GetSubUnselectedArrowImage         : String;
    function  MainMenuArrowPosCSS                : String;
  public
    procedure MakeNew; override;
    procedure Save( TextIO : TTextIO ); override;
    procedure Read( TextIO : TTextIO; Version : Integer ); override;

    property MainUnselectedTextColor       : Integer read fMainUnselectedTextColor       write SetMainUnselectedTextColor;
    property MainUnselectedBackgroundColor : Integer read fMainUnselectedBackgroundColor write SetMainUnselectedBackgroundColor;
    property MainSelectedTextColor         : Integer read fMainSelectedTextColor         write SetMainSelectedTextColor;
    property MainSelectedBackgroundColor   : Integer read fMainSelectedBackgroundColor   write SetMainSelectedBackgroundColor;
    property MainUnselectedArrowImage      : String  read fMainUnselectedArrowImage      write SetMainUnselectedArrowImage;
    property MainSelectedArrowImage        : String  read fMainSelectedArrowImage        write SetMainSelectedArrowImage;
    property SubUnselectedTextColor        : Integer read fSubUnselectedTextColor        write SetSubUnselectedTextColor;
    property SubUnselectedBackgroundColor  : Integer read fSubUnselectedBackgroundColor  write SetSubUnselectedBackgroundColor;
    property SubSelectedTextColor          : Integer read fSubSelectedTextColor          write SetSubSelectedTextColor;
    property SubSelectedBackgroundColor    : Integer read fSubSelectedBackgroundColor    write SetSubSelectedBackgroundColor;
    property SubUnselectedArrowImage       : String  read fSubUnselectedArrowImage       write SetSubUnselectedArrowImage;
    property SubSelectedArrowImage         : String  read fSubSelectedArrowImage         write SetSubSelectedArrowImage;
    property FontFaces                     : String  read fFontFaces                     write SetFontFaces;
    property FontBold                      : Boolean read fFontBold                      write SetFontBold;
    property TextSize                      : Integer read fTextSize                      write SetTextSize;
    property UseDownArrowImage             : Boolean read GetUseDownArrowImage;
end;

implementation

uses
  ObjectFactory1, Common1;

{ TMenuCSSData }

const
  Version = 1;

function TMenuCSSData.GetUseDownArrowImage: Boolean;
begin
  Result := False; { TODO 3 -oDonz -cUnimplemented : Figure out what this was supposed to do and implement same. }
end;

function TMenuCSSData.MainMenuArrowPosCSS: String;
begin
  Result :=  IntToStr((fTextSize+1) div 2);  { TODO 1 -odonz : Convert from px to em. }
end;

procedure TMenuCSSData.SetFontBold(const AValue: Boolean);
begin
  Update(fFontBold,AValue );
end;

procedure TMenuCSSData.SetFontFaces(const AValue: String);
begin
  Update(fFontFaces,AValue );
end;

procedure TMenuCSSData.SetMainSelectedArrowImage(const AValue: String);
begin
  Update(fMainSelectedArrowImage,AValue );
end;

procedure TMenuCSSData.SetMainSelectedBackgroundColor(const AValue: Integer);
begin
  Update(fMainSelectedBackgroundColor,AValue );
end;

procedure TMenuCSSData.SetMainSelectedTextColor(const AValue: Integer);
begin
  Update(fMainSelectedTextColor,AValue );
end;

procedure TMenuCSSData.SetMainUnselectedArrowImage(const AValue: String);
begin
  Update(fMainUnselectedArrowImage,AValue );
end;

procedure TMenuCSSData.SetMainUnselectedBackgroundColor(const AValue: Integer);
begin
  Update(fMainUnselectedBackgroundColor,AValue );
end;

procedure TMenuCSSData.SetMainUnselectedTextColor(const AValue: Integer);
begin
  Update(fMainUnselectedTextColor,AValue );
end;

procedure TMenuCSSData.SetSubSelectedArrowImage(const AValue: String);
begin
  Update(fSubSelectedArrowImage,AValue );
end;

procedure TMenuCSSData.SetSubSelectedBackgroundColor(const AValue: Integer);
begin
  Update(fSubSelectedBackgroundColor,AValue );
end;

procedure TMenuCSSData.SetSubSelectedTextColor(const AValue: Integer);
begin
  Update(fSubSelectedTextColor,AValue );
end;

procedure TMenuCSSData.SetSubUnselectedArrowImage(const AValue: String);
begin
  Update(fSubUnselectedArrowImage,AValue );
end;

procedure TMenuCSSData.SetSubUnselectedBackgroundColor(const AValue: Integer);
begin
  Update(fSubUnselectedBackgroundColor,AValue );
end;

procedure TMenuCSSData.SetSubUnselectedTextColor(const AValue: Integer);
begin
  Update(fSubUnselectedTextColor,AValue );
end;

procedure TMenuCSSData.SetTextSize(const AValue: Integer);
begin
  Update(fTextSize,AValue );
end;

procedure TMenuCSSData.BuildVarList;
begin
  inherited;
  VarList.AddFunction('SelectedTextHeight',              @GetTextHeight);
  VarList.AddFunction('FontName',                        @GetFontFaces);
  VarList.AddFunction('FontWeight',                      @GetFontWeightCSS);
  VarList.AddFunction('UnselectedTextColorCSS',          @GetUnselectedTextColorCSS);
  VarList.AddFunction('UnselectedBackgroundColorCSS',    @GetUnselectedBackgroundColorCSS);
  VarList.AddFunction('SelectedTextColorCSS',            @GetSelectedTextColorCSS);
  VarList.AddFunction('SelectedBackgroundColorCSS',      @GetSelectedBackgroundColorCSS);
  VarList.AddFunction('DropDownUnsTextColorCSS',         @GetSubUnselectedTextColorCSS);
  VarList.AddFunction('DropDownUnsBGColorCSS',           @GetSubUnselectedBackgroundColorCSS);
  VarList.AddFunction('DropDownUnsArrowImage',           @GetSubUnselectedArrowImage);
  VarList.AddFunction('DropDownSelTextColorCSS',         @GetSubSelectedTextColorCSS);
  VarList.AddFunction('DropDownSelBGColorCSS',           @GetSubSelectedBackgroundColorCSS);
  VarList.AddFunction('DropDownSelArrowImage',           @GetSubSelectedArrowImage);
  VarList.AddFunction('UnselectedArrowImage',            @GetMainUnselectedArrowImage);
  VarList.AddFunction('SelectedArrowImage',              @GetMainSelectedArrowImage);
  VarList.AddFunction('MainMenuArrowPos',                @MainMenuArrowPosCSS);
end;

function TMenuCSSData.GetFontFaces: String;
begin
  Result := fFontFaces;
end;

function TMenuCSSData.GetFontWeightCSS: String;
begin
  if fFontBold then
    Result := 'font-weight: bold'
  else
    Result := 'font-weight: normal';
end;

function TMenuCSSData.GetMainSelectedArrowImage: String;
begin
  Result := fMainSelectedArrowImage;
end;

function TMenuCSSData.GetMainUnselectedArrowImage: String;
begin
  Result := fMainUnselectedArrowImage;
end;

function TMenuCSSData.GetSelectedBackgroundColorCSS: String;
begin
  Result := CSSColor( fMainSelectedBackgroundColor )
end;

function TMenuCSSData.GetSelectedTextColorCSS: String;
begin
  Result := CSSColor( fMainSelectedTextColor )
end;

function TMenuCSSData.GetSubSelectedArrowImage: String;
begin
  Result := fSubSelectedArrowImage;
end;

function TMenuCSSData.GetSubSelectedBackgroundColorCSS: String;
begin
  Result := CSSColor(fSubSelectedBackgroundColor);
end;

function TMenuCSSData.GetSubSelectedTextColorCSS: String;
begin
  Result := CSSColor(fSubSelectedTextColor);
end;

function TMenuCSSData.GetSubUnselectedArrowImage: String;
begin
  Result := fSubUnselectedArrowImage;
end;

function TMenuCSSData.GetSubUnSelectedBackgroundColorCSS: String;
begin
  Result := CSSColor(fSubUnselectedBackgroundColor);
end;

function TMenuCSSData.GetSubUnselectedTextColorCSS: String;
begin
  Result := CSSColor(fSubUnselectedTextColor);
end;

function TMenuCSSData.GetTextHeight: String;
begin
  Result := IntToStr( fTextSize );
end;

function TMenuCSSData.GetUnselectedBackgroundColorCSS: String;
begin
  Result := CSSColor( fMainUnselectedBackgroundColor )
end;

function TMenuCSSData.GetUnselectedTextColorCSS: String;
begin
  Result := CSSColor( fMainUnselectedTextColor );
end;

procedure TMenuCSSData.MakeNew;
begin
  inherited MakeNew;
  fMainUnselectedTextColor := $000000;
  fMainUnselectedBackgroundColor := $ffffff;
  fMainSelectedTextColor         := $ffffff;
  fMainSelectedBackgroundColor   := $000000;
  fMainUnselectedArrowImage      := '';
  fMainSelectedArrowImage        := '';
  fSubUnselectedTextColor        := $ffffff;
  fSubUnselectedBackgroundColor  := $000000;
  fSubSelectedTextColor          := $000000;
  fSubSelectedBackgroundColor    := $ffffff;
  fSubUnselectedArrowImage       := '';
  fSubSelectedArrowImage         := '';
  fFontFaces                     := '';
  fFontBold                      := False;
  fTextSize                      := 10; // = 1 em
end;

procedure TMenuCSSData.Save(TextIO: TTextIO);
begin
  SaveHeader( TextIO, Version );
  TextIO.WriteLn( fMainUnselectedTextColor );
  TextIO.WriteLn( fMainUnselectedBackgroundColor );
  TextIO.WriteLn( fMainSelectedTextColor );
  TextIO.WriteLn( fMainSelectedBackgroundColor );
  TextIO.WriteLn( fMainUnselectedArrowImage );
  TextIO.WriteLn( fMainSelectedArrowImage );
  TextIO.WriteLn( fSubUnselectedTextColor );
  TextIO.WriteLn( fSubUnselectedBackgroundColor );
  TextIO.WriteLn( fSubSelectedTextColor );
  TextIO.WriteLn( fSubSelectedBackgroundColor );
  TextIO.WriteLn( fSubUnselectedArrowImage );
  TextIO.WriteLn( fSubSelectedArrowImage );
  TextIO.WriteLn( fFontFaces );
  TextIO.WriteLn( fFontBold );
  TextIO.WriteLn( fTextSize );
  UNMODIFY;
  SaveTrailer( TextIO );
end;

procedure TMenuCSSData.Read(TextIO: TTextIO; Version: Integer);
begin
  MakeNew;
  if Version >= 1 then
    begin
      TextIO.ReadLn( fMainUnselectedTextColor );
      TextIO.ReadLn( fMainUnselectedBackgroundColor );
      TextIO.ReadLn( fMainSelectedTextColor );
      TextIO.ReadLn( fMainSelectedBackgroundColor );
      TextIO.ReadLn( fMainUnselectedArrowImage );
      TextIO.ReadLn( fMainSelectedArrowImage );
      TextIO.ReadLn( fSubUnselectedTextColor );
      TextIO.ReadLn( fSubUnselectedBackgroundColor );
      TextIO.ReadLn( fSubSelectedTextColor );
      TextIO.ReadLn( fSubSelectedBackgroundColor );
      TextIO.ReadLn( fSubUnselectedArrowImage );
      TextIO.ReadLn( fSubSelectedArrowImage );
      TextIO.ReadLn( fFontFaces );
      TextIO.ReadLn( fFontBold );
      TextIO.ReadLn( fTextSize );
    end;
end;

initialization
  ObjectFactory.RegisterClass( TMenuCSSData.ClassType );

end.

