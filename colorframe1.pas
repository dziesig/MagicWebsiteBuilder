unit ColorFrame1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, Dialogs;

type

  { TColorFrame }

  TColorChange = procedure( var NewColor : Integer ) of object;

  TColorFrame = class(TFrame)
    ColorDialog1: TColorDialog;
    ColorEdit: TLabeledEdit;
    Panel1: TPanel;
    procedure ColorEditExit(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private
    fColorChange : TColorChange;
    function GetColor: Integer;
    procedure SetColor(const AValue: Integer);
    { private declarations }
  public
    { public declarations }
    property Color : Integer read GetColor write SetColor;
    property OnColorChange : TColorChange read fColorChange write fColorChange;
  end;

implementation

uses
  StrUtils;

{$R *.lfm}

{ TColorFrame }


procedure TColorFrame.ColorEditExit(Sender: TObject);
var
  C : Integer;
begin
  Color := Hex2Dec( ColorEdit.Text );
  C := Color;
  if Assigned(fColorChange) then OnColorChange( C );
end;

procedure TColorFrame.Panel1Click(Sender: TObject);
var
  C : Integer;
begin
  if ColorDialog1.Execute then
    begin
      Color := ColorDialog1.Color;
      C := Color;
      if Assigned(fColorChange) then OnColorChange( C );
    end;
end;

function TColorFrame.GetColor: Integer;
begin
  Result := Panel1.Color;
end;

procedure TColorFrame.SetColor(const AValue: Integer);
begin
  Panel1.Color := AValue;
  ColorEdit.Text := IntToHex( AValue, 6 );
end;

end.

