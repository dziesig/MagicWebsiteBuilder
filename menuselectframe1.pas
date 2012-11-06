unit MenuSelectFrame1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, ComCtrls, ExtCtrls,
  Dialogs,

  WebsiteMenusUnit1, MenusFrame1;

type

  { TMenuSelectFrame }

  TMenuSelectFrame = class(TFrame)
    MenusFrame1: TMenusFrame;
    MenusFrame2: TMenusFrame;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    PrimaryMenuPositionRG: TRadioGroup;
    SecondaryMenuPositionRG: TRadioGroup;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure PrimaryMenuPositionRGClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    constructor Create( AOwner : TComponent ); override;
    procedure Save( Data : TWebsiteMenusData );
    procedure Load( Data : TWebsiteMenusData );
end;
implementation

uses
  Common1;

{$R *.lfm}

{ TMenuSelectFrame }

procedure TMenuSelectFrame.PrimaryMenuPositionRGClick(Sender: TObject);
var
  I : Integer;
begin
  SecondaryMenuPositionRG.Items.Clear;
  SecondaryMenuPositionRG.Items.Add('None');
  for I := 0 to PrimaryMenuPositionRG.Items.Count - 1 do
    if I <> PrimaryMenuPositionRG.ItemIndex then
      SecondaryMenuPositionRG.Items.Add(PrimaryMenuPositionRG.Items[I]);
  SecondaryMenuPositionRG.ItemIndex := 0;
end;

constructor TMenuSelectFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  PageControl1.TabIndex := 0;
end;

procedure TMenuSelectFrame.Save(Data: TWebsiteMenusData);
var
  I : Integer;
begin
  I := PageControl1.TabIndex;    // Hack to work around inability to set
  if I < 0 then                  // PageControl's TabIndex in constructor.
    PageControl1.TabIndex := 0;
  Data.PrimaryMenu.MenuPosition := PrimaryMenuPositionRG.Items[PrimaryMenuPositionRG.ItemIndex];
  Data.SecondaryMenu.MenuPosition := SecondaryMenuPositionRG.Items[SecondaryMenuPositionRG.ItemIndex];
  MenusFrame1.SetData( Data.PrimaryMenu );
  MenusFrame2.SetData( Data.SecondaryMenu );
  MenusFrame1.Save( Data.PrimaryMenu ); // LOOK HERE need to separate Primary from Secondary
  MenusFrame2.Save( Data.SecondaryMenu ); // LOOK HERE need to separate Primary from Secondary
end;

procedure TMenuSelectFrame.Load(Data: TWebsiteMenusData);
var
  I : Integer;
begin
  I := PageControl1.TabIndex;    // Hack to work around inability to set
  if I < 0 then                  // PageControl's TabIndex in constructor.
    PageControl1.TabIndex := 0;

  SetPositionRG( PrimaryMenuPositionRG, Data.PrimaryMenu.MenuPosition );
  PrimaryMenuPositionRGClick( nil );
  SetPositionRG( SecondaryMenuPositionRG, Data.SecondaryMenu.MenuPosition );

  MenusFrame1.SetData( Data.PrimaryMenu );
  MenusFrame2.SetData( Data.SecondaryMenu );
  MenusFrame1.Load( Data.PrimaryMenu ); // LOOK HERE need to separate Primary from Secondary
  MenusFrame2.Load( Data.SecondaryMenu ); // LOOK HERE need to separate Primary from Secondary

end;

end.
