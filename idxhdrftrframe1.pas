unit IDXHdrFtrFrame1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, ComCtrls,
  ColorFrame1,

  IDXHdrFtrUnit1;

type

  { TIDXHdrFtrFrame }

  TIDXHdrFtrFrame = class(TFrame)
    ColorFrame1: TColorFrame;
    ColorFrame2: TColorFrame;
    FooterSizeLabel: TLabel;
    HeaderSizeLabel: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    IDXFooterFontFacesEdit: TLabeledEdit;
    IDXFooterTextSizeTB: TTrackBar;
    IDXHeaderFontFacesEdit: TLabeledEdit;
    IDXHeaderTextSizeTB: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure IDXFooterTextSizeTBChange(Sender: TObject);
    procedure IDXHeaderTextSizeTBChange(Sender: TObject);
  private
    { private declarations }
    procedure SetTextSizeLabel( aLabel : TLabel; Value : Integer );
  public
    { public declarations }
    procedure Save( Data : TIDXHdrFtr );
    procedure Load( Data : TIDXHdrFtr );
  end;

implementation

{$R *.lfm}

{ TIDXHdrFtrFrame }

procedure TIDXHdrFtrFrame.IDXHeaderTextSizeTBChange(Sender: TObject);
begin
  SetTextSizeLabel( HeaderSizeLabel, IDXHeaderTextSizeTB.Position );
end;

procedure TIDXHdrFtrFrame.IDXFooterTextSizeTBChange(Sender: TObject);
begin
  SetTextSizeLabel( FooterSizeLabel, IDXFooterTextSizeTB.Position );
end;

procedure TIDXHdrFtrFrame.SetTextSizeLabel(aLabel: TLabel; Value: Integer);
begin
  aLabel.Caption := FloatToStrF( Value / 10.0, ffFixed, 4, 1 ) + ' em';
end;

procedure TIDXHdrFtrFrame.Save(Data: TIDXHdrFtr);
begin
  Data.HeaderFontFaces := IDXHeaderFontFacesEdit.Text;
  Data.HeaderTextColor := ColorFrame1.Color;
  Data.HeaderTextSize  := IDXHeaderTextSizeTB.Position;

  Data.FooterFontFaces := IDXFooterFontFacesEdit.Text;
  Data.FooterTextColor := ColorFrame2.Color;
  Data.FooterTextSize  := IDXFooterTextSizeTB.Position;
end;

procedure TIDXHdrFtrFrame.Load(Data: TIDXHdrFtr);
begin
  IDXHeaderFontFacesEdit.Text  := Data.HeaderFontFaces;
  ColorFrame1.Color            := Data.HeaderTextColor;
  IDXHeaderTextSizeTB.Position := Data.HeaderTextSize;

  IDXFooterFontFacesEdit.Text  := Data.FooterFontFaces;
  ColorFrame2.Color            := Data.FooterTextColor;
  IDXFooterTextSizeTB.Position := Data.FooterTextSize;

  SetTextSizeLabel( HeaderSizeLabel, Data.HeaderTextSize );
  SetTextSizeLabel( FooterSizeLabel, Data.FooterTextSize );
end;

end.

