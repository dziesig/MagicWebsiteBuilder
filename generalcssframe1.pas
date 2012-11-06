unit GeneralCSSFrame1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, Dialogs,
  ComCtrls, ColorFrame1, GeneralCSSUnit1;

type

  { TGeneralCSSFrame }

  TGeneralCSSFrame = class(TFrame)
    BarBorderBottomSizeEdit: TLabeledEdit;
    BarBorderBottomSizeUD: TUpDown;
    BarBorderLeftSizeEdit: TLabeledEdit;
    BarBorderLeftSizeUD: TUpDown;
    BarBorderRightSizeEdit: TLabeledEdit;
    BarBorderRightSizeUD: TUpDown;
    BarBorderSizeEdit: TLabeledEdit;
    BarBorderSizeUD: TUpDown;
    BarBorderTopSizeEdit: TLabeledEdit;
    BarBorderTopSizeUD: TUpDown;
    BarCustomCSSEdit: TLabeledEdit;
    BarSeparatorRG: TRadioGroup;
    BarSepSizeEdit: TLabeledEdit;
    BarSepSizeUD: TUpDown;
    ColorEdit: TLabeledEdit;
    ColorFrame1: TColorFrame;
    ColorFrame2: TColorFrame;
    DropDownTopEdit: TLabeledEdit;
    DropdownTopUD: TUpDown;
    DropDownWidthEdit: TLabeledEdit;
    EvenSpacingBoxWidthEdit: TLabeledEdit;
    GroupBox1: TGroupBox;
    GroupBox11: TGroupBox;
    GroupBox17: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    HorizontalPositioningRG: TRadioGroup;
    Label1: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    PrimaryRestoreDefaultCSSLabel: TLabel;
    ZIndexEdit: TLabeledEdit;
    ZIndexUD: TUpDown;
  private
    { private declarations }
  public
    { public declarations }
    procedure Save( Data : TGeneralCSSData );
    procedure Load( Data : TGeneralCSSData );
  end;

implementation

uses
  WebsiteRootUnit1;

{$R *.lfm}

{ TGeneralCSSFrame }

procedure TGeneralCSSFrame.Save(Data: TGeneralCSSData);
begin
  Data.BarColor    := ColorFrame1.Color;
  Data.BorderSize  := StrToInt(BarBorderSizeEdit.Text);
  Data.Separator   := BarSeparatorRG.ItemIndex;
  Data.SepSize     := StrToInt(BarSepSizeEdit.Text);
  Data.CustomCSS   := BarCustomCSSEdit.Text;
  Data.BorderColor := ColorFrame2.Color;
  Data.TopSize     := StrToInt( BarBorderTopSizeEdit.Text );
  Data.BottomSize     := StrToInt( BarBorderBottomSizeEdit.Text );
  Data.LeftSize     := StrToInt( BarBorderLeftSizeEdit.Text );
  Data.RightSize     := StrToInt( BarBorderRightSizeEdit.Text );

  Data.ZIndex        := StrToInt( ZIndexEdit.Text );
  Data.HorizPosition := THorizontalPositioning(HorizontalPositioningRG.ItemIndex);
  Data.EvenSpacingBoxWidth := StrToInt( EvenSpacingBoxWidthEdit.Text );
  Data.DDTop               := StrToInt( DropDownTopEdit.Text );
  Data.DDWidth             := StrToInt( DropDownWidthEdit.Text );
end;

procedure TGeneralCSSFrame.Load(Data: TGeneralCSSData);
begin
  ColorFrame1.Color := Data.BarColor;
  BarBorderSizeEdit.Text := IntToStr(Data.BorderSize );
  BarSeparatorRG.ItemIndex :=Data.Separator;
  BarSepSizeEdit.Text := IntToStr(Data.SepSize);
  BarCustomCSSEdit.Text  := Data.CustomCSS;
  ColorFrame2.Color := Data.BorderColor;
  BarBorderTopSizeEdit.Text := IntToStr( Data.TopSize );
  BarBorderBottomSizeEdit.Text := IntToStr( Data.BottomSize );
  BarBorderLeftSizeEdit.Text := IntToStr( Data.LeftSize  );
  BarBorderRightSizeEdit.Text := IntToStr( Data.RightSize );
  ZIndexEdit.Text             := IntToStr( Data.ZIndex );
  HorizontalPositioningRG.ItemIndex := ord(Data.HorizPosition);
  EvenSpacingBoxWidthEdit.Text := IntToStr( Data.EvenSpacingBoxWidth );
  DropDownTopEdit.Text         := IntToStr( Data.DDTop );
  DropDownWidthEdit.Text       := IntToStr( Data.DDWidth );
end;

end.

