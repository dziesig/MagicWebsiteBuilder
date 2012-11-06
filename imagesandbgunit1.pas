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
unit ImagesAndBGUnit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics,

  Persists1, TextIO1, WebsiteRootUnit1;

type

  { TImagesAndBG }

  TImagesAndBG = class( TWebsiteRoot )
  private
    function GetBackgroundImage: TPicture;
    function GetBlogHeaderImage: TPicture;
    function GetBodyImage: TPicture;
    function GetHeaderImage: TPicture;
    function GetTopImage: TPicture;
    procedure SetBackgroundColor(const AValue: Integer);
    procedure SetBackgroundFileName(const AValue: String);
    procedure SetBackgroundImage(const AValue: TPicture);
    procedure SetBlogHeaderFileName(const AValue: String);
    procedure SetBlogHeaderImage(const AValue: TPicture);
    procedure SetBodyColor(const AValue: Integer);
    procedure SetBodyFileName(const AValue: String);
    procedure SetBodyImage(const AValue: TPicture);
    procedure SetHeaderFileName(const AValue: String);
    procedure SetHeaderImage(const AValue: TPicture);
    procedure SetTopFileName(const AValue: String);
    procedure SetTopImage(const AValue: TPicture);
    protected
      fBackgroundColor : Integer;
      fBodyColor       : Integer;

      fBackgroundImage : String;
      fBodyImage       : String;
      fHeaderImage     : String;
      fTopImage        : String;
      fBlogHeaderImage : String;

      fBackgroundFileName : String;
      fBodyFileName       : String;
      fHeaderFileName     : String;
      fTopFileName        : String;
      fBlogHeaderFileName : String;

      function  GetImage( S : String ) : TPicture;
      function  SetImage( Img : TPicture ) : String;

      function GetBackgroundColor : String;
      function GetBodyColor       : String;
      function GetBackgroundFileName : String;
      function GetBodyFileName       : String;
    public

      procedure MakeNew; override;
      procedure Save( TextIO : TTextIO ); override;
      procedure Read( TextIO : TTextIO; Version : Integer ); override;
//      function  Find( Variable : String; var Gotit : Boolean ) : String; override;
      procedure BuildVarlist;

      property BackgroundColor : Integer read fBackgroundColor write SetBackgroundColor;
      property BodyColor       : Integer read fBodyColor       write SetBodyColor;

      property BackgroundImage : TPicture read GetBackgroundImage write SetBackgroundImage;
      property HeaderImage     : TPicture read GetHeaderImage     write SetHeaderImage;
      property BodyImage       : TPicture read GetBodyImage       write SetBodyImage;
      property TopImage        : TPicture read GetTopImage        write SetTopImage;
      property BlogHeaderImage : TPicture read GetBlogHeaderImage write SetBlogHeaderImage;

      property BackgroundFileName : String read fBackgroundFileName write SetBackgroundFileName;
      property HeaderFileName     : String read fHeaderFileName     write SetHeaderFileName;
      property BodyFileName       : String read fBodyFileName       write SetBodyFileName;
      property TopFileName        : String read fTopFileName        write SetTopFileName;
      property BlogHeaderFileName : String read fBlogheaderFileName write SetBlogHeaderFileName;
  end;

implementation

uses
  ObjectFactory1, StrUtils, Dialogs, Common1, NamedFunctionUnit1, StringSubs;

{ TImagesAndBG }

const
  Version = 2;

function TImagesAndBG.GetBackgroundImage: TPicture;
begin
  Result := GetImage( fBackgroundImage );
end;

function TImagesAndBG.GetBlogHeaderImage: TPicture;
begin
  Result := GetImage( fBlogHeaderImage );
end;

function TImagesAndBG.GetBodyImage: TPicture;
begin
  Result := GetImage( fBodyImage );
end;

function TImagesAndBG.GetHeaderImage: TPicture;
begin
  Result := GetImage( fHeaderImage );
end;

function TImagesAndBG.GetTopImage: TPicture;
begin
  Result := GetImage( fTopImage );
end;

procedure TImagesAndBG.SetBackgroundColor(const AValue: Integer);
begin
  Update(fBackgroundColor,AValue);
end;

procedure TImagesAndBG.SetBackgroundFileName(const AValue: String);
begin
  Update(fBackgroundFileName,AValue);
end;

procedure TImagesAndBG.SetBackgroundImage(const AValue: TPicture);
var
  S : String;
begin
  S := SetImage( AValue );
  if Empty(fBackgroundImage) then
    fBackgroundImage := S
  else
    Update( fBackgroundImage, S );
end;

procedure TImagesAndBG.SetBlogHeaderFileName(const AValue: String);
begin
  Update(fBlogheaderFileName,AValue);
end;

procedure TImagesAndBG.SetBlogHeaderImage(const AValue: TPicture);
var
  S : String;
begin
  S := SetImage( AValue );
  if Empty(fBodyImage) then
    fBodyImage := S
  else
    Update( fBlogHeaderImage, S );
end;

procedure TImagesAndBG.SetBodyColor(const AValue: Integer);
begin
  Update(fBodyColor,AValue);
end;

procedure TImagesAndBG.SetBodyFileName(const AValue: String);
begin
  Update(fBodyFileName,AValue);
end;

procedure TImagesAndBG.SetBodyImage(const AValue: TPicture);
var
  S : String;
begin
  S := SetImage( AValue );
  if Empty(fBodyImage) then
    fBodyImage := S
  else
    Update( fBodyImage, S );
end;

procedure TImagesAndBG.SetHeaderFileName(const AValue: String);
begin
  Update(fHeaderFileName,AValue);
end;

procedure TImagesAndBG.SetHeaderImage(const AValue: TPicture);
var
  S : String;
begin
  S := SetImage( AValue );
  if Empty(fHeaderImage) then
    fHeaderImage := S
  else
    Update( fHeaderImage, S );

end;

procedure TImagesAndBG.SetTopFileName(const AValue: String);
begin
  Update(fTopFileName,AValue);
end;

procedure TImagesAndBG.SetTopImage(const AValue: TPicture);
var
  S : String;
begin
  S := SetImage( AValue );
  if Empty(fTopImage) then
    fTopImage := S
  else
    Update( fTopImage, S );
end;

procedure HexStringToByteArray( var A : array of Byte; S : String );
var
  Size : Integer;
  I    : Integer;
  B    : Byte;
  Q    : String;
begin
  Size := Length(S);
  for I := 0 to pred(Size div 2) do
    begin
      Q := Copy(S,I*2+1,2);
      B := Hex2Dec( Q );
      A[I] := B;
    end;
end;

function TImagesAndBG.GetImage( S : String ) : TPicture;
var
  Stream : TMemoryStream;
  Size   : Integer;
  P      : array of Byte;
begin
  Size := Length(S);
  if Size < 1 then
    begin
      Result := nil;
      exit;
    end;
  Result := TPicture.Create;
  Stream := TMemoryStream.Create;
  SetLength(P,Size div 2);
  HexStringToByteArray( P, S );
  Stream.Seek(0,soFromBeginning);
  Stream.WriteBuffer( P[0], Size div 2 );
  Stream.Seek(0,soFromBeginning);
//  Result.LoadFromStream( Stream );
  Result.LoadFromStreamWithFileExt( Stream, 'jpg' );
  Stream.Free;
end;

function TImagesAndBG.SetImage(Img: TPicture): String;
var
  Stream : TMemoryStream;
  P, A   : array of Byte;
  Size   : Integer;
  I      : Integer;
  QQQ    : TPicture;
begin
  Result := '';
  Stream := TMemoryStream.Create;
//  Img.SaveToStream( Stream );
  Img.SaveToStreamWithFileExt( Stream, 'jpg' );
  Size := Stream.Size;
  Stream.Seek(0,soFromBeginning);

  SetLength( P, Size );
  Stream.ReadBuffer( P[0],Size);
  for I := 0 to pred(Size) do
    Result := Result + IntToHex(P[I],2);
  SetLength( A, Size );
  HexStringToByteArray( A, Result );
  for I := 0 to pred(Size) do
    if P[I] <> A[I] then
      MessageDlg('Mismatch at ' + IntToStr(I) + ' Got ' + IntToStr( A[I] ) + ' expected ' + IntToStr( P[I] ),
      mtConfirmation, [mbOk],0);
  Stream.Free;
end;

function TImagesAndBG.GetBackgroundColor: String;
begin
  Result := CSSColor(ColorSwap(fBackgroundColor));
end;

function TImagesAndBG.GetBodyColor: String;
begin
  Result := CSSColor(ColorSwap(fBodyColor));
end;

function TImagesAndBG.GetBackgroundFileName: String;
begin
  Result := fBackgroundFileName;
end;

function TImagesAndBG.GetBodyFileName: String;
begin
  Result := fBodyFileName;
end;

procedure TImagesAndBG.MakeNew;
begin
  inherited MakeNew;
  fBackgroundColor := $ffffff;
  fBodyColor := $ffffff;
  fBackgroundImage := '';
  fBodyImage := '';
  fHeaderImage := '';
  fTopImage := '';
  fBlogHeaderImage := '';

  fBackgroundFileName := 'UNASSIGNED';
  fBodyFileName       := 'UNASSIGNED';
  fHeaderFileName     := 'UNASSIGNED';
  fTopFileName        := 'UNASSIGNED';
  fBlogHeaderFileName := 'UNASSIGNED';

  BuildVarlist;
  fModified := False;
end;

procedure TImagesAndBG.Save(TextIO: TTextIO);
begin
  SaveHeader( TextIO, Version );
  TextIO.WriteLn(fBackgroundColor);
  TextIO.WriteLN(fBodyColor);
  TextIO.WriteLn(fBackgroundImage);
  TextIO.Writeln(fBodyImage);
  TextIO.Writeln(fHeaderImage);
  TextIO.Writeln(fTopImage);
  TextIO.Writeln(fBlogHeaderImage);
  // Version 2
  TextIO.WriteLn(fBackgroundFileName);
  TextIO.Writeln(fBodyFileName);
  TextIO.Writeln(fHeaderFileName);
  TextIO.Writeln(fTopFileName);
  TextIO.Writeln(fBlogHeaderFileName);

  UNMODIFY;
  SaveTrailer( TextIO );
end;

procedure TImagesAndBG.Read(TextIO: TTextIO; Version: Integer);
begin
  MakeNew;
  if Version >= 1 then
    begin
      TextIO.ReadLn(fBackgroundColor);
      TextIO.ReadLn(fBodyColor);
      TextIO.ReadLn(fBackgroundImage);
      TextIO.ReadLn(fBodyImage);
      TextIO.ReadLn(fHeaderImage);
      TextIO.ReadLn(fTopImage);
      TextIO.ReadLn(fBlogHeaderImage);
    end;
  if Version >= 2 then
    begin
      TextIO.ReadLn(fBackgroundFileName);
      TextIO.ReadLn(fBodyFileName);
      TextIO.ReadLn(fHeaderFileName);
      TextIO.ReadLn(fTopFileName);
      TextIO.ReadLn(fBlogHeaderFileName);
    end;
end;

procedure TImagesAndBG.BuildVarlist;
begin
  inherited;
  VarList.AddFunction('CenterBGColor',@GetBodyColor);
  VarList.AddFunction('SideBGColor',@GetBackgroundColor);
  VarList.AddFunction('SideBGImage',@GetBackgroundFileName);
  VarList.AddFunction('CenterBGImage',@GetBodyFileName);
end;

initialization

  ObjectFactory.RegisterClass( TImagesAndBG.ClassType );

end.

