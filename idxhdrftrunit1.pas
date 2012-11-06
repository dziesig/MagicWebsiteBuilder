unit IDXHdrFtrUnit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,

  Persists1, TextIO1, WebsiteRootUnit1;

type

  { TIDXHdrFtr }

  TIDXHdrFtr = class( TWebsiteRoot )
  private
    fFooterFontFaces: String;
    fFooterTextColor: Integer;
    fFooterTextSize: Integer;
    fHeaderFontFaces: String;
    fHeaderTextColor: Integer;
    fHeaderTextSize: Integer;
    procedure SetFooterFontFaces(const AValue: String);
    procedure SetFooterTextColor(const AValue: Integer);
    procedure SetFooterTextSize(const AValue: Integer);
    procedure SetHeaderFontFaces(const AValue: String);
    procedure SetHeaderTextColor(const AValue: Integer);
    procedure SetHeaderTextSize(const AValue: Integer);
    public

    procedure MakeNew; override;
    procedure Save( TextIO : TTextIO ); override;
    procedure Read( TextIO : TTextIO; Version : Integer ); override;

    property HeaderFontFaces : String  read fHeaderFontFaces  write SetHeaderFontFaces;
    property HeaderTextColor : Integer read fHeaderTextColor  write SetHeaderTextColor;
    property HeaderTextSize  : Integer read fHeaderTextSize   write SetHeaderTextSize;

    property FooterFontFaces : String  read fFooterFontFaces  write SetFooterFontFaces;
    property FooterTextColor : Integer read fFooterTextColor  write SetFooterTextColor;
    property FooterTextSize  : Integer read fFooterTextSize   write SetFooterTextSize;

  end;

implementation

uses
  ObjectFactory1;

{ TIDXHdrFtr }

const
  Version = 1;

procedure TIDXHdrFtr.SetFooterFontFaces(const AValue: String);
begin
  Update(fFooterFontFaces,AValue);
end;

procedure TIDXHdrFtr.SetFooterTextColor(const AValue: Integer);
begin
  Update(fFooterTextColor,AValue);
end;

procedure TIDXHdrFtr.SetFooterTextSize(const AValue: Integer);
begin
  Update(fFooterTextSize,AValue);
end;

procedure TIDXHdrFtr.SetHeaderFontFaces(const AValue: String);
begin
  Update(fHeaderFontFaces,AValue);
end;

procedure TIDXHdrFtr.SetHeaderTextColor(const AValue: Integer);
begin
  Update(fHeaderTextColor,AValue);
end;

procedure TIDXHdrFtr.SetHeaderTextSize(const AValue: Integer);
begin
  Update(fHeaderTextSize,AValue);
end;

procedure TIDXHdrFtr.MakeNew;
begin
  inherited MakeNew;
  fHeaderFontFaces := '';
  fHeaderTextColor := $00000;
  fHeaderTextSize  := 10; // 1.0 em
  fFooterFontFaces := '';
  fFooterTextColor := $00000;
  fFooterTextSize  := 10; // 1.0 em
end;

procedure TIDXHdrFtr.Save(TextIO: TTextIO);
begin
  SaveHeader( TextIO, Version );
  TextIO.WriteLn( fHeaderFontFaces );
  TextIO.WriteLn( fHeaderTextColor );
  TextIO.WriteLn( fHeaderTextSize );

  TextIO.WriteLn( fFooterFontFaces );
  TextIO.WriteLn( fFooterTextColor );
  TextIO.WriteLn( fFooterTextSize );
  UNMODIFY;
  SaveTrailer( TextIO );
end;

procedure TIDXHdrFtr.Read(TextIO: TTextIO; Version: Integer);
begin
  MakeNew;
  if Version >= 1 then
    begin
      TextIO.ReadLn( fHeaderFontFaces );
      TextIO.ReadLn( fHeaderTextColor );
      TextIO.ReadLn( fHeaderTextSize );

      TextIO.ReadLn( fFooterFontFaces );
      TextIO.ReadLn( fFooterTextColor );
      TextIO.ReadLn( fFooterTextSize );
    end;

end;

initialization

  ObjectFactory.RegisterClass( TIDXHdrFtr.ClassType );
end.

