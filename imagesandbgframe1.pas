unit ImagesAndBGFrame1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, ExtDlgs,
  ColorFrame1,

  ImagesAndBGUnit1;

type

  { TImagesAndBGFrame }

  TImagesAndBGFrame = class(TFrame)
    BlogHeaderImage: TImage;
    BackgroundColorFrame: TColorFrame;
    BodyColorFrame: TColorFrame;
    ImportBackgroundButton: TButton;
    ClearHeaderButton: TButton;
    ImportBodyButton: TButton;
    ImportBlogHeaderButton: TButton;
    ImportTopButton: TButton;
    ImportHeaderButton: TButton;
    ClearBackgroundButton: TButton;
    ClearBodyButton: TButton;
    ClearBlogHeaderButton: TButton;
    ClearTopButton: TButton;
    GroupBox1: TGroupBox;
    BackgroundImage: TImage;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    HeaderImage: TImage;
    BodyImage: TImage;
    LowerSelectedDDImage: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    UpperSelectedDDImage: TImage;
    LowerDropDownImage: TImage;
    LowerMenuImage: TImage;
    UpperDropDownImage: TImage;
    UpperMenuImage: TImage;
    TopImage: TImage;
    procedure ClearBackgroundButtonClick(Sender: TObject);
    procedure ClearBlogHeaderButtonClick(Sender: TObject);
    procedure ClearBodyButtonClick(Sender: TObject);
    procedure ClearHeaderButtonClick(Sender: TObject);
    procedure ClearTopButtonClick(Sender: TObject);
    procedure HeaderImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImportBackgroundButtonClick(Sender: TObject);
    procedure ImportBlogHeaderButtonClick(Sender: TObject);
    procedure ImportBodyButtonClick(Sender: TObject);
    procedure ImportHeaderButtonClick(Sender: TObject);
    procedure ImportTopButtonClick(Sender: TObject);
  private
    { private declarations }
    fBackgroundFileName    : string;
    fBodyFileName          : String;
    fTopFileName           : String;
    fHeaderFileName        : String;
    fBlogHeaderFileName    : String;

    procedure BGColorChange( var AColor : Integer );
    procedure BodyColorChange( var AColor : Integer );
    procedure SetImageBackgroundColor( Img : TImage; AColor : Integer );
  public
    { public declarations }
    constructor Create( AOwner : TComponent ); override;
    procedure Save( Data : TImagesAndBG );
    procedure Load( Data : TImagesAndBG );
  end;

implementation

uses
  Graphics, ConfigUnit1;

{$R *.lfm}

{ TImagesAndBGFrame }

procedure TImagesAndBGFrame.ImportBackgroundButtonClick(Sender: TObject);
begin
  OpenPictureDialog1.InitialDir := ConfigData.ImagePath;
  if OpenPictureDialog1.Execute then
    begin
      BackgroundImage.Picture.LoadFromFile( OpenPictureDialog1.FileName );
      BackgroundImage.Stretch := True;
      fBackgroundFileName := ExtractFileName(OpenPictureDialog1.FileName);
      ConfigData.ImagePath := ExtractFilePath(OpenPictureDialog1.FileName);
    end;
end;

procedure TImagesAndBGFrame.ClearBackgroundButtonClick(Sender: TObject);
begin
  BackgroundImage.Picture := nil;
  fBackgroundFileName      := 'UNASSIGNED';
end;

procedure TImagesAndBGFrame.ClearBlogHeaderButtonClick(Sender: TObject);
begin
  BlogHeaderImage.Picture := nil;
  fBlogHeaderFileName      := 'UNASSIGNED';
end;

procedure TImagesAndBGFrame.ClearBodyButtonClick(Sender: TObject);
begin
  BodyImage.Picture := nil;
  fBodyFileName      := 'UNASSIGNED';
end;

procedure TImagesAndBGFrame.ClearHeaderButtonClick(Sender: TObject);
begin
  HeaderImage.Picture := nil;
  fHeaderFileName      := 'UNASSIGNED';
end;

procedure TImagesAndBGFrame.ClearTopButtonClick(Sender: TObject);
begin
  TopImage.Picture := nil;
  fTopFileName      := 'UNASSIGNED';
end;

procedure TImagesAndBGFrame.HeaderImageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TImagesAndBGFrame.ImportBlogHeaderButtonClick(Sender: TObject);
begin
  OpenPictureDialog1.InitialDir := ConfigData.ImagePath;
  if OpenPictureDialog1.Execute then
    begin
      BlogHeaderImage.Picture.LoadFromFile( OpenPictureDialog1.FileName );
      BlogHeaderImage.Stretch := True;
      fBlogHeaderFileName := ExtractFileName(OpenPictureDialog1.FileName);
      ConfigData.ImagePath := ExtractFilePath(OpenPictureDialog1.FileName);
    end;
end;

procedure TImagesAndBGFrame.ImportBodyButtonClick(Sender: TObject);
begin
  OpenPictureDialog1.InitialDir := ConfigData.ImagePath;
  if OpenPictureDialog1.Execute then
    begin
      BodyImage.Picture.LoadFromFile( OpenPictureDialog1.FileName );
      BodyImage.Stretch := True;
      fBodyFileName := ExtractFileName(OpenPictureDialog1.FileName);
      ConfigData.ImagePath := ExtractFilePath(OpenPictureDialog1.FileName);
    end;
end;

procedure TImagesAndBGFrame.ImportHeaderButtonClick(Sender: TObject);
begin
  OpenPictureDialog1.InitialDir := ConfigData.ImagePath;
  if OpenPictureDialog1.Execute then
    begin
      HeaderImage.Picture.LoadFromFile( OpenPictureDialog1.FileName );
      HeaderImage.Stretch := True;
      fHeaderFileName := ExtractFileName(OpenPictureDialog1.FileName);
      HeaderImage.Hint := fHeaderFileName;
      ConfigData.ImagePath := ExtractFilePath(OpenPictureDialog1.FileName);
    end;
end;

procedure TImagesAndBGFrame.ImportTopButtonClick(Sender: TObject);
begin
  OpenPictureDialog1.InitialDir := ConfigData.ImagePath;
  if OpenPictureDialog1.Execute then
    begin
      TopImage.Picture.LoadFromFile( OpenPictureDialog1.FileName );
      TopImage.Stretch := True;
      fTopFileName := ExtractFileName(OpenPictureDialog1.FileName);
      ConfigData.ImagePath := ExtractFilePath(OpenPictureDialog1.FileName);
    end;
end;

procedure TImagesAndBGFrame.BGColorChange(var AColor: Integer);
begin
  SetImageBackgroundColor( BackgroundImage, AColor );
end;

procedure TImagesAndBGFrame.BodyColorChange(var AColor: Integer);
begin
  SetImageBackgroundColor( BodyImage, AColor );
end;

procedure TImagesAndBGFrame.SetImageBackgroundColor(Img: TImage;
  AColor: Integer);
begin
  Img.Canvas.Brush.Color := AColor;
  Img.Canvas.Brush.Style := bsSolid;
  Img.Canvas.FillRect( 0,0,BackgroundImage.Width, BackgroundImage.Height );
end;

constructor TImagesAndBGFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BackgroundColorFrame.OnColorChange := @BGColorChange;
  BodyColorFrame.OnColorChange       := @BodyColorChange;
end;

procedure TImagesAndBGFrame.Save(Data: TImagesAndBG);
begin
  Data.BackgroundColor := BackgroundColorFrame.Color;
  Data.BodyColor       := BodyColorFrame.Color;
  Data.BackgroundImage := BackgroundImage.Picture;
  Data.HeaderImage     := HeaderImage.Picture;
  Data.BodyImage       := BodyImage.Picture;
  Data.TopImage        := TopImage.Picture;
  Data.BlogHeaderImage := BlogHeaderImage.Picture;

  Data.BackgroundFileName := fBackgroundFileName;
  Data.HeaderFileName     := fHeaderFileName;
  Data.BodyFileName       := fBodyFileName;
  Data.TopFileName        := fTopFileName;
  Data.BlogHeaderFileName := fBlogHeaderFileName;
end;

procedure TImagesAndBGFrame.Load(Data: TImagesAndBG);
begin
  BackgroundColorFrame.Color := Data.BackgroundColor;
  BodyColorFrame.Color       := Data.BodyColor;

  if Data.BackgroundImage = nil then
    BackgroundImage.Picture  := nil;
  SetImageBackgroundColor( BackgroundImage, Data.BackgroundColor );
  SetImageBackgroundColor( BodyImage, Data.BackgroundColor );
  if Data.BackgroundImage <> nil then
    BackgroundImage.Picture  := Data.BackgroundImage;
  BackgroundImage.Stretch    := true;
  HeaderImage.Picture        := nil;
  HeaderImage.Picture        := Data.HeaderImage;
  HeaderImage.Stretch        := true;
  if Data.BodyImage = nil then
    BodyImage.Picture        := nil
  else
    BodyImage.Picture        := Data.BodyImage;
  BodyImage.Stretch          := true;
  TopImage.Picture           := nil;
  TopImage.Picture           := Data.TopImage;
  TopImage.Stretch           := true;
  BlogHeaderImage.Picture    := nil;
  BlogHeaderImage.Picture    := Data.BlogHeaderImage;
  BlogHeaderImage.Stretch    := true;

  fBackgroundFileName        := Data.BackgroundFileName;
  fHeaderFileName            := Data.HeaderFileName;
  HeaderImage.Hint           := fHeaderFileName;
  fBodyFileName              := Data.BodyFileName;
  fTopFileName               := Data.TopFileName;
  fBlogHeaderFileName        := Data.BlogHeaderFileName;

end;

end.

