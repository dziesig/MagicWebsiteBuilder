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
unit TCWItemEditUnit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons,

  MenuItemUnit1;

type

  TItemEditKind = (ieAdd, ieAddChild, ieInsert );

  { TTCWItemEditForm }

  TTCWItemEditForm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CheckBox1: TCheckBox;
    HostRG: TRadioGroup;
    LabeledEdit1: TLabeledEdit;
    SecondaryPastePartialURLButton: TButton;
    URLEdit1: TLabeledEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure SecondaryPastePartialURLButtonClick(Sender: TObject);
  private
    function GetContinue: Boolean;
    function GetHost: THost;
    function GetHostURL: String;
    function GetItemEditData: TTCWItemEditData;
    function GetText: String;
    { private declarations }
  public
    { public declarations }
    procedure Clear;
    function Execute( Kind : TItemEditKind ) : Boolean;

    property Text : String read GetText;
    property Host : THost read GetHost;
    property HostURL : String read GetHostURL;

    property ItemEditData : TTCWItemEditData read GetItemEditData;

    property Continue : Boolean read GetContinue;
  end;

var
  TCWItemEditForm: TTCWItemEditForm;

implementation

uses
  StringSubs;

{$R *.lfm}

{ TTCWItemEditForm }

procedure TTCWItemEditForm.FormCloseQuery(Sender: TObject; var CanClose: boolean
  );
begin
  CanClose := (not Empty( LabeledEdit1.Text )) or (ModalResult = mrCancel);
end;

procedure TTCWItemEditForm.BitBtn2Click(Sender: TObject);
begin
  CheckBox1.Checked := False;
end;

procedure TTCWItemEditForm.FormShow(Sender: TObject);
begin
  FocusControl(LabeledEdit1);
end;

procedure TTCWItemEditForm.SecondaryPastePartialURLButtonClick(Sender: TObject);
var
  I, P, P0, P1, P2 : Integer;
  S : String;
begin
  URLEdit1.Clear;
  URLEdit1.PasteFromClipboard;
  S := URLEdit1.Text;
  P0 := 0;
  P1 := 0;
  P2 := 0;
  for I := 1 to Length(S) do
    if S[I] = '/' then
      begin
        P2 := P1;
        P1 := P0;
        P0 := I;
      end;
  P := Pos('IDX',UpperCase(S));
  if P > 0 then
    begin
      URLEdit1.Text := Copy(S,P0+1,32767);
      HostRG.ItemIndex := ord(hoIDX);
    end
  else
    begin
      P := Pos('/WELCOME/',UpperCase(S)) + Pos('/PAGE/',UpperCase(S));
      if P > 0 then
        begin
          URLEdit1.Text := Copy(S,P2+1,32767);
          HostRG.ItemIndex := ord(hoZHouse);
        end
      else
        begin
          URLEdit1.Text := Copy(S,P1+1,32767);
          HostRG.ItemIndex := ord(hoPoint2);
        end;
    end;
end;

function TTCWItemEditForm.GetContinue: Boolean;
begin
  Result := CheckBox1.Checked;
end;

function TTCWItemEditForm.GetHost: THost;
begin
  Result := THost( HostRG.ItemIndex );
end;

function TTCWItemEditForm.GetHostURL: String;
begin
  Result := URLEdit1.Text;
end;

function TTCWItemEditForm.GetItemEditData: TTCWItemEditData;
begin
  Result.Host := Host;
  Result.Text := Text;
  Result.URL  := HostURL;
end;

function TTCWItemEditForm.GetText: String;
begin
  Result := LabeledEdit1.Text;
end;

procedure TTCWItemEditForm.Clear;
begin
  LabeledEdit1.Text := '';
  HostRG.ItemIndex := 3;
  URLEdit1.Text := '###';
end;

function TTCWItemEditForm.Execute(Kind: TItemEditKind): Boolean;
begin
  Clear;
  CheckBox1.Visible := Kind <> ieInsert;
  case Kind of
    ieAdd:      Caption := 'Add Menu Item';
    ieAddChild: Caption := 'Add Child Menu Item';
    ieInsert:   Caption := 'Insert Menu Item' ;
  end;
  Result := ShowModal = mrOk;
end;

end.

