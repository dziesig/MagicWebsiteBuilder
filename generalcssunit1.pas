unit GeneralCSSUnit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,

  Persists1, TextIO1, WebsiteRootUnit1;

type

{ TGeneralCSSData }

TGeneralCSSData = class( TWebsiteRoot )
  private
    procedure SetBarColor(const AValue: Integer);
    procedure SetBorderColor(const AValue: Integer);
    procedure SetBorderSize(const AValue: Integer);
    procedure SetBottomSize(const AValue: Integer);
    procedure SetCustomCSS(const AValue: String);
    procedure SetDDTop(const AValue: Integer);
    procedure SetDDWidth(const AValue: Integer);
    procedure SetEvenSpacingBoxWidth(const AValue: Integer);
    procedure SetHorizPosition(const AValue: THorizontalPositioning);
    procedure SetLeftSize(const AValue: Integer);
    procedure SetRightSize(const AValue: Integer);
    procedure SetSeparator(const AValue: Integer);
    procedure SetSepSize(const AValue: Integer);
    procedure SetTopSize(const AValue: Integer);
    procedure SetZIndex(const AValue: Integer);

  protected
    fBarColor   : Integer;
    fBorderSize : Integer;
    fSeparator  : Integer;
    fSepSize    : Integer;

    fCustomCSS  : String;

    fBorderColor : Integer;
    fTopSize     : Integer;
    fBottomSize  : Integer;
    fLeftSize    : Integer;
    fRightSize   : Integer;

    fZIndex      : Integer;
    fHorizPosition : THorizontalPositioning;
    fEvenSpacingBoxWidth : Integer;
    fDDTop : Integer;
    fDDWidth : Integer;

    procedure BuildVarList; override;

    function  GetBarCSS        : String;
    function  GetName          : String;
    function  GetZIndexStr     : String;

    function  MenuBarBottomCSS : String;
    function  MenuBarTopCSS    : String;
    function  MenuBarLeftCSS   : String;
    function  MenuBarRightCSS  : String;
    function  MenuFloatCSS     : String;

    function  BarBorderBottomSize : Integer;
    function  BarBorderTopSize    : Integer;
    function  BarBorderLeftSize   : Integer;
    function  BarBorderRightSize  : Integer;

    function  BarBorderColor      : Integer;

    function  DisplayBlockCSS     : String;

    function  GetSeparator        : String;

    function  DropDownTopCSS      : String;
    function  DropDownWidthCSS    : String;
    function  DropDownArrowPos    : String;

    function  GetBorderSize       : String;

    function  MainMenuPaddingCSS  : String;
    function  EvenSpacingBoxWidthCSS : String;
    function  HorizontalPositioningCSS : String;
    function  MainMenuDropDownPaddingCSS : String;

    function  UseDownArrowImage          : Boolean;
  public
    procedure MakeNew; override;
    procedure Save( TextIO : TTextIO ); override;
    procedure Read( TextIO : TTextIO; Version : Integer ); override;

    property BarColor   : Integer read fBarColor write SetBarColor;
    property BorderSize : Integer read fBorderSize write SetBorderSize;
    property Separator  : Integer read fSeparator  write SetSeparator;
    property SepSize    : Integer read fSepSize    write SetSepSize;

    property CustomCSS  : String  read fCustomCSS  write SetCustomCSS;

    property BorderColor : Integer read fBorderColor write SetBorderColor;
    property TopSize     : Integer read fTopSize     write SetTopSize;
    property BottomSize  : Integer read fBottomSize  write SetBottomSize;
    property LeftSize    : Integer read fLeftSize    write SetLeftSize;
    property RightSize   : Integer read fRightSize   write SetRightSize;

    property ZIndex              : Integer read fZIndex              write SetZIndex;
    property HorizPosition       : THorizontalPositioning read fHorizPosition       write SetHorizPosition;
    property EvenSpacingBoxWidth : Integer read fEvenSpacingBoxWidth write SetEvenSpacingBoxWidth;
    property DDTop               : Integer read fDDTop               write SetDDTop;
    property DDWidth             : Integer read fDDWidth             write SetDDWidth;

end;



implementation

uses
  ObjectFactory1, Common1, MenuCSSUnit1;

{ TGeneralCSSData }

const
  Version = 1;

procedure TGeneralCSSData.SetBarColor(const AValue: Integer);
begin
  Update(fBarColor,AValue );
end;

procedure TGeneralCSSData.SetBorderColor(const AValue: Integer);
begin
  Update(fBorderColor,AValue );
end;

procedure TGeneralCSSData.SetBorderSize(const AValue: Integer);
begin
  Update(fBorderSize,AValue );
end;

procedure TGeneralCSSData.SetBottomSize(const AValue: Integer);
begin
  Update(fBottomSize,AValue );
end;

procedure TGeneralCSSData.SetCustomCSS(const AValue: String);
begin
  Update(fCustomCSS,AValue );
end;

procedure TGeneralCSSData.SetDDTop(const AValue: Integer);
begin
  Update(fDDTop,AValue );
end;

procedure TGeneralCSSData.SetDDWidth(const AValue: Integer);
begin
  Update(fDDWidth,AValue );
end;

procedure TGeneralCSSData.SetEvenSpacingBoxWidth(const AValue: Integer);
begin
  Update(fEvenSpacingBoxWidth,AValue );
end;

procedure TGeneralCSSData.SetHorizPosition(const AValue: THorizontalPositioning);
begin
  if fHorizPosition <> AValue then
    begin
      Modify; // fModified := true;
      fHorizPosition := AValue;
    end;
end;

procedure TGeneralCSSData.SetLeftSize(const AValue: Integer);
begin
  Update(fLeftSize,AValue );
end;

procedure TGeneralCSSData.SetRightSize(const AValue: Integer);
begin
  Update(fRightSize,AValue );
end;

procedure TGeneralCSSData.SetSeparator(const AValue: Integer);
begin
  Update(fSeparator,AValue );
end;

procedure TGeneralCSSData.SetSepSize(const AValue: Integer);
begin
  Update(fSepSize,AValue );
end;

procedure TGeneralCSSData.SetTopSize(const AValue: Integer);
begin
  Update(fTopSize,AValue );
end;

procedure TGeneralCSSData.SetZIndex(const AValue: Integer);
begin
  Update(fZIndex,AValue );
end;

function TGeneralCSSData.UseDownArrowImage: Boolean;
begin
  Result := False; { todo -oDonz : implement  TGeneralCSSData.UseDownArrowImage }
end;

function TGeneralCSSData.BarBorderBottomSize: Integer;
begin
  Result := fBottomSize;
end;

function TGeneralCSSData.BarBorderColor: Integer;
begin
  Result := fBorderColor;
end;

function TGeneralCSSData.BarBorderLeftSize: Integer;
begin
  Result := fLeftSize;
end;

function TGeneralCSSData.BarBorderRightSize: Integer;
begin
  Result := fRightSize;
end;

function TGeneralCSSData.BarBorderTopSize: Integer;
begin
  Result := fTopSize;
end;

procedure TGeneralCSSData.BuildVarList;
begin
  inherited;
  VarList.AddFunction('BarCSS',                          @GetBarCSS);
  VarList.AddFunction('MenuBarTopCSS',                   @MenuBarTopCSS);
  VarList.AddFunction('MenuBarBottomCSS',                @MenuBarBottomCSS);
  VarList.AddFunction('MenuBarLeftCSS',                  @MenuBarLeftCSS);
  VarList.AddFunction('MenuBarRightCSS',                 @MenuBarRightCSS);
  VarList.AddFunction('MenuName',                        @GetName);
  VarList.AddFunction('ZIndex',                          @GetZIndexStr);
  VarList.AddFunction('DisplayBlock',                    @DisplayBlockCSS);
  VarList.AddFunction('Separator',                       @GetSeparator);
  VarList.AddFunction('DropDownTop',                     @DropDownTopCSS);
  VarList.AddFunction('DropDownWidth',                   @DropDownWidthCSS);
  VarList.AddFunction('DropDownArrowPos',                @DropDownArrowPos);
  VarList.AddFunction('BorderSize',                      @GetBorderSize);
  VarList.AddFunction('MainMenuPadding',                 @MainMenuPaddingCSS);
  VarList.AddFunction('EvenSpacingBoxWidth',             @EvenSpacingBoxWidthCSS);
  VarList.AddFunction('MainMenuTextAlign',               @HorizontalPositioningCSS);
  VarList.AddFunction('MainMenuDropDownPadding',         @MainMenuDropDownPaddingCSS);
  VarList.AddFunction('MenuFloat',                       @MenuFloatCSS);
end;

function TGeneralCSSData.DisplayBlockCSS: String;
begin
  if fHorizPosition = hpEven then
    Result := 'display:block;'
  else
    Result := '';
end;

function TGeneralCSSData.DropDownArrowPos: String;
begin
  Result := IntToStr( fDDWidth - 10 );
end;

function TGeneralCSSData.DropDownTopCSS: String;
begin
  Result := IntToStr( fDDTop );
end;

function TGeneralCSSData.DropDownWidthCSS: String;
begin
  Result := IntToStr( fDDWidth );
end;

function TGeneralCSSData.EvenSpacingBoxWidthCSS: String;
begin
  Result := IntToStr( fEvenSpacingBoxWidth );
end;

function TGeneralCSSData.GetBarCSS: String;
begin
  Result := fCustomCSS;
end;

function TGeneralCSSData.GetBorderSize: String;
begin
  Result := IntToStr( fBorderSize );
end;

function TGeneralCSSData.GetName: String;
begin
  Result := fName;
end;

function TGeneralCSSData.GetSeparator: String;
begin
  case TBarSeparatorStyle(fSeparator) of
    bssNone :  Result := '';
    bssLeft :  Result := 'border-left : ' + IntToStr(fSepSize) + 'px solid #' +
                         CSSColor(TMenuCSSData(FMenu).MainUnselectedTextColor) + ';';
    bssRight :  Result := 'border-right : ' + IntToStr(fSepSize) + 'px solid #' +
                          CSSColor(TMenuCSSData(FMenu).MainUnselectedTextColor) + ';';
  end;
end;

function TGeneralCSSData.GetZIndexStr: String;
begin
  Result := IntToStr(fZIndex);
end;

function TGeneralCSSData.HorizontalPositioningCSS: String;
begin
  case THorizontalPositioning(fHorizPosition) of
    hpLeft: Result := 'left';
    hpRight:
{      if MenuPosition = mpHorizontal then }{ todo -oDonz : implement vertical menus }
        Result := 'right'
{      else
        Result := 'left'} ;
    hpCentered: Result := 'left';
    hpEven: Result := 'left';
  end;
end;

function TGeneralCSSData.MainMenuDropDownPaddingCSS: String;
begin

  case THorizontalPositioning(fHorizPosition) of
    hpLeft: result := '0px 7px 0px 7px';
    hpRight:
  {      if MenuPosition = mpHorizontal then             }
        Result := '0px 7px 0px 7px'
  {      else
        Result := '0px 7px 0px 7px'};
    hpCentered: result := '0px 5px 0px 5px' ;
    hpEven:
      if UseDownArrowImage then
        result := '0px 2px 0px 11px'
      else
        result := '0px 1px 0px 1px';
  end;

end;

function TGeneralCSSData.MainMenuPaddingCSS: String;
begin
  case THorizontalPositioning(fHorizPosition) of
    hpLeft: result := '0px 7px 0px 7px';
    hpRight:
   {   if MenuPosition = mpHorizontal then }
        Result := '0px 7px 0px 7px'
   {   else
        Result := '0px 7px 0px 7px'};
    hpCentered: result := Format('0px %dpx 0px %dpx',[fEvenSpacingBoxWidth,fEvenSpacingBoxWidth+1]) ;
    hpEven: result := '0px 5px 0px 5px';
  end;
end;

procedure TGeneralCSSData.MakeNew;
begin
  inherited MakeNew;
  fBarColor := $ffffff;
  fBorderSize := 0;
  fSeparator := 0;
  fSepSize := 0;
  fCustomCSS := '';
  fBorderColor := $000000;
  fTopSize := 0;
  fBottomSize := 0;
  fLeftSize := 0;
  fRightSize := 0;
  fZIndex := 0;
  fHorizPosition := hpCentered;
  fEvenSpacingBoxWidth := 0;
  fDDTop  := 0;
  fDDWidth := 120;
end;

procedure TGeneralCSSData.Save(TextIO: TTextIO);
begin
  SaveHeader( TextIO, Version );
  TextIO.WriteLn( fBarColor );
  TextIO.WriteLn( fBorderSize );
  TextIO.WriteLn( fSeparator );
  TextIO.WriteLn( fSepSize );
  TextIO.WriteLn( fCustomCSS );
  TextIO.WriteLn( fBorderColor );
  TextIO.WriteLn( fTopSize );
  TextIO.WriteLn( fBottomSize );
  TextIO.WriteLn( fLeftSize );
  TextIO.WriteLn( fRightSize );
  TextIO.WriteLn( fZIndex );
  TextIO.WriteLn( ord(fHorizPosition) );
  TextIO.WriteLn( fEvenSpacingBoxWidth );
  TextIO.WriteLn( fDDTop );
  TextIO.WriteLn( fDDWidth );
  UNMODIFY;
  SaveTrailer( TextIO );
end;

procedure TGeneralCSSData.Read(TextIO: TTextIO; Version: Integer);
var
  Temp : Integer;
begin
  MakeNew;
  if Version >= 1 then
    begin
      TextIO.ReadLn( fBarColor );
      TextIO.ReadLn( fBorderSize );
      TextIO.ReadLn( fSeparator );
      TextIO.ReadLn( fSepSize );
      TextIO.ReadLn( fCustomCSS );
      TextIO.ReadLn( fBorderColor );
      TextIO.ReadLn( fTopSize );
      TextIO.ReadLn( fBottomSize );
      TextIO.ReadLn( fLeftSize );
      TextIO.ReadLn( fRightSize );
      TextIO.ReadLn( fZIndex );
      TextIO.ReadLn( Temp );
      fHorizPosition := THorizontalPositioning( Temp );
      TextIO.ReadLn( fEvenSpacingBoxWidth );
      TextIO.ReadLn( fDDTop );
      TextIO.ReadLn( fDDWidth );
    end;
end;

function TGeneralCSSData.MenuBarBottomCSS: String;
begin
  if BarBorderBottomSize > 0 then
    Result := '.'+Name+'_bar {border-bottom-width : '+ IntToStr(BarBorderBottomSize)+
              'px; border-bottom-style : solid; border-bottom-color : #' +
              IntToHex(BarBorderColor,6) +'; }'
    else
      Result := '';
end;

function TGeneralCSSData.MenuBarLeftCSS: String;
begin
  if BarBorderLeftSize > 0 then
    Result := '.'+Name+'_bar {border-left-width : '+ IntToStr(BarBorderLeftSize)+
              'px; border-left-style : solid; border-Left-color : #' +
              IntToHex(BarBorderColor,6) +'; }'
    else
      Result := '';
end;

function TGeneralCSSData.MenuBarRightCSS: String;
begin
  if BarBorderRightSize > 0 then
    Result := '.'+Name+'_bar {border-right-width : '+ IntToStr(BarBorderRightSize)+
              'px; border-right-style : solid; border-Right-color : #' +
              IntToHex(BarBorderColor,6) +'; }'
    else
      Result := '';
end;

function TGeneralCSSData.MenuBarTopCss: String;
begin
  if BarBordertopSize > 0 then
    Result := '.'+Name+'_bar {border-top-width : '+ IntToStr(BarBordertopSize)+
              'px; border-top-style : solid; border-top-color : #' +
              IntToHex(BarBorderColor,6) +'; }'
    else
      Result := '';
end;

function TGeneralCSSData.MenuFloatCSS: String;
begin
  case fHorizPosition of
    hpLeft: Result := 'left';
    hpRight:
{      if MenuPosition = mpHorizontal then }
        Result := 'right'
{      else
        Result := 'left' };
    hpCentered: Result := 'left';
    hpEven: Result := 'left';

  end;
end;

initialization
  ObjectFactory.RegisterClass( TGeneralCSSData.ClassType );
end.

