unit TestTreeviewMainUnit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, ExtCtrls,

  TCWMenuUnit1;

type

  { TForm1 }

  TForm1 = class(TForm)
    InitTest1Button: TButton;
    ClearButton: TButton;
    InitTest2Button: TButton;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LoadButton: TButton;
    Button5: TButton;
    Memo1: TMemo;
    SaveButton: TButton;
    HostRG: TRadioGroup;
    LabeledEdit1: TLabeledEdit;
    TreeView1: TTreeView;
    procedure InitTest1ButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure InitTest2ButtonClick(Sender: TObject);
    procedure LoadButtonClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
  private
    { private declarations }
    Data : TTCWMenuData;

    procedure WriteLn( S : String );
    procedure WriteLn( I : Integer );
    procedure WriteLn( P : Pointer );

    procedure ClearTreeView( TV : TTreeView );
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

uses
  MenuItemUnit1, Common1;

const
  DebugFileName = 'F:\Documents and Settings\Donald R. Ziesig\My Documents\Lazarus\Test\MenuItem.txt';

{$R *.lfm}

{ TForm1 }

procedure TForm1.InitTest1ButtonClick(Sender: TObject);
var
  I : Integer;
  MenuItem : TTCWMenuItem;
  S : String;
begin
  for I := 1 to 5 do
    begin
      S := '1-'+IntToStr(I);
      MenuItem := TTCWMenuItem.Create(  S );
      MenuItem.Host := THost( (I-1) mod 5);
      TreeView1.Items.AddObject( nil, S, MenuItem );
    end;
end;

procedure TForm1.ClearButtonClick(Sender: TObject);
begin
  ClearTreeView( TreeView1 );
end;

procedure TForm1.InitTest2ButtonClick(Sender: TObject);
var
  I, J : Integer;
  N : TTreeNode;
  MenuItem : TTCWMenuItem;
  S : String;
begin
  for I := 1 to 5 do
    begin
      S := '1-'+IntToStr(I);
      MenuItem := TTCWMenuItem.Create( S );
      MenuItem.Host := THost( (I-1) mod 5);
      N := TreeView1.Items.AddObject( nil, S, MenuItem );
      for J := 1 to pred(I) do
        begin
          S := IntToStr(I) + '-' + IntToStr(J);
          MenuItem := TTCWMenuItem.Create( S );
          MenuItem.Host := THost( ((I-1) + (J-1)) mod 5);
          TreeView1.Items.AddChildObject( N, S, MenuItem);

        end;
    end;
  TreeView1.FullExpand;
end;

procedure TForm1.LoadButtonClick(Sender: TObject);
  procedure LoadChildren( N : TTreeNode; Itm : TTCWMenuItem );
  var
    I : Integer;
    Node : TTreeNode;
    Item, IX : TTCWMenuItem;
    S    : String;
    C    : Integer;
  begin
    C := Itm.ChildCount;
    for I := 0 to pred( Itm.ChildCount ) do
      begin
        IX := Itm.Children[I];
        Item := TTCWMenuItem.Copy(Itm.Children[I]);
        S    := Item.Name;
        Node := TreeView1.Items.AddChildObject( N, S, Item );
        LoadChildren( Node, Item );
      end;
  end;
var
  Root : TTCWMenuItem;
  Node : TTreeNode;
  Item : TTCWMenuItem;
  I    : Integer;
  S    : String;
  C0, C1    : Integer;

begin
  ClearTreeView( TreeView1 );
  Root := Data.MenuRoot;
  Root.Show( Memo1 );
  for I := 0 to pred( Root.ChildCount ) do
    begin
      C0 := Root.Children[I].ChildCount;
      Item := TTCWMenuItem.Copy(Root.Children[I]);
      C1 := Root.Children[I].ChildCount;
      S := Item.Name;
      Node := TreeView1.Items.AddObject( nil, S, Item );
      LoadChildren( Node, Item );
      if C1 <> C0 then
        MessageBox( 'C0, C1:  ' + IntToStr( C0 ) + ', ' + IntToStr( C1 ) );
    end;
  TreeView1.FullExpand;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  F : Text;
begin
  Data := TTCWMenuData.Create;
  AssignFile( F, DebugFileName);
  ReWrite( F );
  CloseFile( F );
end;

procedure TForm1.SaveButtonClick(Sender: TObject);
var
  Root : TTCWMenuItem;
  Node : TTreeNode;
  Item : TTCWMenuItem;
  I    : Integer;
  procedure AddChildren( N : TTreeNode; Parent : TTCWMenuItem );
  var
    I : Integer;
    Node : TTreeNode;
    Item : TTCWMenuItem;
  begin
    Node := N.GetFirstChild;
    while Node <> nil do
      begin
        Item := TTCWMenuItem.Copy(TTCWMenuItem( Node.Data ));
        Item.Name := Node.Text;
        Parent.AddChild(Item);
        AddChildren( Node, Item );
        Node := Node.GetNextSibling;
      end;
  end;

begin
  Root := Data.MenuRoot;
  Root.MakeNew;
  if TreeView1.Items.Count > 0 then
    begin
      Node := TreeView1.Items.GetFirstNode;
      while Node <> nil do
        begin
          Item := TTCWMenuItem.Copy(TTCWMenuItem( Node.Data ));
          Item.Name := Node.Text;
          WriteLn( Item.Name );
          WriteLn( Pointer(Item) );
          Root.AddChild( Item );
          AddChildren( Node, Item );
          Node := Node.GetNextSibling;
        end;
    end;
  Root.Show( Memo1 );
end;

procedure TForm1.TreeView1Click(Sender: TObject);
var
  N : TTreeNode;
  M : TTCWMenuItem;
  S : String;
begin
  N := TreeView1.Selected;
  M := TTCWMenuItem( N.Data );
  S := M.Name;
  LabeledEdit1.Text := S;
  HostRG.ItemIndex := ord(M.Host);
  LabeledEdit2.Text := M.URL;
  LabeledEdit3.Text := M.IDX_HeaderText;
  LabeledEdit4.Text := M.IDX_FooterText;

end;

procedure TForm1.WriteLn(S: String);
var
  F : Text;
begin
  AssignFile( F, DebugFileName);
  Append( F );
  System.WriteLn( F, S );
  CloseFile( F );
end;

procedure TForm1.WriteLn(I: Integer);
var
  F : Text;
begin
  AssignFile( F, DebugFileName);
  Append( F );
  System.WriteLn( F, I );
  CloseFile( F );
end;

procedure TForm1.WriteLn(P: Pointer);
var
  F : Text;
begin
  AssignFile( F, DebugFileName);
  Append( F );
  System.WriteLn( F, IntToHex( Integer( P ), 8 ) );
  CloseFile( F );
end;

procedure TForm1.ClearTreeView(TV: TTreeView);
var
  Count : Integer;
  I     : Integer;
  N     : TTreeNode;
  M     : TTCWMenuItem;
begin
  Count := 0;
  for I := 0 to pred( TV.Items.Count) do
    begin
      N := TV.Items[I];
      M := TTCWMenuItem( N.Data );
      M.Free;
      N.Data := nil;
      Inc(Count);
    end;
  TV.Items.Clear;
  Memo1.Lines.Add( IntToStr( Count ) + ' TreeNodes Data have been freed' );
end;

end.

