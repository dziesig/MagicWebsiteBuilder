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
unit CustomizedWebsiteUnit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls,

  Persists1, Generics1, GeneralWebsiteUnit1, TextIO1, ImagesAndBGUnit1,
  WebsiteMenusUnit1, WebsiteRootUnit1;

type

  { TCustomizedWebsite }

  TCustomizedWebsite = class( TWebsiteRoot )
    protected
      fGeneralData : TGeneralWebsiteData;
      fImagesAndBG : TImagesAndBG;
      fMenus       : TWebsiteMenusData;
      function GetName : String;
    public
      constructor Create( AParent : TPersists = nil ); override;
      destructor  Destroy; override;

      procedure MakeNew; override;
      procedure BuildVarlist; override;
      function  IsModified : Boolean; override;
      procedure UNMODIFY; override;

      procedure Save( TextIO : TTextIO ); override;
      procedure Read( TextIO : TTextIO; Version : Integer ); override;
      procedure Show( Memo : TMemo ); override;

      function  Find( Variable: String; var GotIt : Boolean) : String; override;

      property GeneralData : TGeneralWebsiteData read fGeneralData;
      property ImagesAndBG : TImagesAndBG        read fImagesAndBG;
      property Menus       : TWebsiteMenusData   read fMenus;
  end;



implementation

uses
  ObjectFactory1, NamedFunctionUnit1, Common1;

{ TCustomizedWebsite }

const
  Version = 4;

function TCustomizedWebsite.GetName: String;
begin
  Result := Name;
end;

constructor TCustomizedWebsite.Create(AParent: TPersists);
begin
  inherited Create(AParent);
  MakeNew;
  BuildVarList;
end;

destructor TCustomizedWebsite.Destroy;
begin
  fGeneralData.Free;
  inherited Destroy;
end;

procedure TCustomizedWebsite.MakeNew;
begin
  inherited MakeNew;
  fGeneralData := TGeneralWebsiteData.Create( Parent );
  fImagesAndBg := TImagesAndBG.Create( Parent );
  fMenus       := TWebsiteMenusData.Create( Parent );
end;

procedure TCustomizedWebsite.BuildVarlist;
begin
  inherited;
  VarList.AddFunction('CSSFileName',@GetName);
end;

function TCustomizedWebsite.IsModified: Boolean;
begin
  Result:=inherited IsModified;
  Result := Result or fGeneralData.Modified;
  Result := Result or fImagesAndBg.Modified;
  Result := Result or fMenus.Modified;
end;

procedure TCustomizedWebsite.UNMODIFY;
begin
  inherited UNMODIFY;
  fGeneralData.UNMODIFY;
  fImagesAndBG.UNMODIFY;
  fMenus.UNMODIFY;
end;

procedure TCustomizedWebsite.Save(TextIO: TTextIO);
var
  FileName : String;
begin
  SaveHeader( TextIO, Version );
  fGeneralData.Save( TextIO );
  // Version 2
  fImagesAndBG.Save( TextIO );
  // Version 3
  fMenus.Save( TextIO );
  // Version 4
  FileName := RemoveExt(ExtractFileName( TextIO.Path ));
  fName := FileName;
  TextIO.WriteLn( FileName );
  UNMODIFY;
  SaveTrailer( TextIO );
end;

procedure TCustomizedWebsite.Read(TextIO: TTextIO; Version: Integer);
begin
  MakeNew;
  BuildVarlist;
  if Version >= 1 then
    begin
      fGeneralData.Free;
      fGeneralData := TGeneralWebsiteData.Load( TextIO ) as TGeneralWebsiteData;
      fGeneralData.BuildVarlist;
    end;
  if Version >= 2 then
    begin
      fImagesAndBG.Free;
      fImagesAndBG := TImagesAndBG.Load( TextIO ) as TImagesAndBG;
    end;
  if Version >= 3 then
    begin
      fMenus.Free;
      fMenus := TWebsiteMenusData.Load( TextIO ) as TWebsiteMenusData;
      fMenus.BuildVarlist;
    end;
  if Version >= 4 then
    begin
      TextIo.ReadLn( fName );
    end;
end;

procedure TCustomizedWebsite.Show(Memo: TMemo);
begin
  fGeneralData.Show( Memo );
end;

function TCustomizedWebsite.Find(Variable: String; var GotIt: Boolean ) : String;
begin
  GotIt := VarList.Execute( Result, Variable);
  if not GotIt then
    Result := fGeneralData.Find( Variable, GotIt );
  if not GotIt then
    Result := fImagesAndBG.Find( Variable, GotIt );
  if not GotIt then
    Result := fMenus.Find( Variable, GotIt );
end;

initialization
  ObjectFactory.RegisterClass( TCustomizedWebsite );
end.

