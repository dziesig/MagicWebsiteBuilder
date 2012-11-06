unit AboutUnit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type

  { TAboutForm }

  TAboutForm = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ConfigFileLabel: TLabel;
    Label5: TLabel;
    DefaultSaveLocationLabel: TLabel;
    Label7: TLabel;
    LastBuildLabel: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.lfm}

uses
  Common1;

{ TAboutForm }

procedure TAboutForm.FormShow(Sender: TObject);
begin
  ConfigFileLabel.Caption := GetAppConfigFile( False );
  LastBuildLabel.Caption  := BuildDateTime;
  DefaultSaveLocationLabel.Caption := DefaultSaveLocation;
end;

end.

