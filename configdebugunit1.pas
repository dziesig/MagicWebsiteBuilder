unit ConfigDebugUnit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TConfigDebugForm }

  TConfigDebugForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BaseDirectoryLabel: TLabel;
    ClientDirectoryLabel: TLabel;
    WebsiteDirectoryLabel: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  ConfigDebugForm: TConfigDebugForm;

implementation

uses
  ConfigUnit1;

{$R *.lfm}

{ TConfigDebugForm }

procedure TConfigDebugForm.FormShow(Sender: TObject);
begin
  BaseDirectoryLabel.Caption    := ConfigData.BaseDirectory;
  ClientDirectoryLabel.Caption  := ConfigData.ClientDirectory;
  WebsiteDirectoryLabel.Caption := ConfigData.WebsiteDirectory;
end;

end.

