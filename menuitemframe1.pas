unit MenuItemFrame1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, ActnList, Menus, Graphics,

  ColorFrame1, MenuItemUnit1, TCWMenuUnit1;

type

  { TMenuItemFrame }

  TMenuItemFrame = class(TFrame)
    ActionList1: TActionList;
    Add1: TMenuItem;
    Add2: TAction;
    AddButton: TButton;
    AddChild1: TMenuItem;
    AddChild2: TAction;
    AddChildButton: TButton;
    AutoPasteCheckBox: TCheckBox;
    Button1: TButton;
    ColorFrame1: TColorFrame;
    ColorFrame2: TColorFrame;
    ContractButton: TButton;
    CopyNode1: TMenuItem;
    CopyNode2: TAction;
    Delete1: TMenuItem;
    Delete2: TAction;
    DeleteButton: TBitBtn;
    ExpandButton: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox21: TGroupBox;
    GroupBox3: TGroupBox;
    HostRG: TRadioGroup;
    HostURLEdit: TLabeledEdit;
    IDXPageTitleEdit: TEdit;
    IDX_FooterFontEdit: TLabeledEdit;
    IDX_FooterSizeEdit: TLabeledEdit;
    IDX_FooterTextEdit: TLabeledEdit;
    IDX_FooterUseDefaultButton: TButton;
    IDX_HeaderFontEdit: TLabeledEdit;
    IDX_HeaderSizeEdit: TLabeledEdit;
    IDX_HeaderTextEdit: TLabeledEdit;
    IDX_HeaderUseDefaultButton: TButton;
    Insert1: TMenuItem;
    Insert2: TAction;
    InsertButton: TButton;
    Label1: TLabel;
    MoveDown1Button: TSpeedButton;
    MoveUp1Button: TSpeedButton;
    N3: TMenuItem;
    N4: TMenuItem;
    N8: TMenuItem;
    PasteChildrenOnly1: TMenuItem;
    PasteChildrenOnly2: TAction;
    PasteNode1: TMenuItem;
    PasteNode2: TAction;
    PasteNodeatRoot1: TMenuItem;
    PasteNodeAtRoot2: TAction;
    PopupMenu1: TPopupMenu;
    TreeView1: TTreeView;
    procedure Add2Click(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure AddButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AddChild2Execute(Sender: TObject);
    procedure AddChildButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure ContractButtonClick(Sender: TObject);
    procedure CopyNode2Execute(Sender: TObject);
    procedure Delete2Execute(Sender: TObject);
    procedure DeleteButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ExpandButtonClick(Sender: TObject);
    procedure IDX_HeaderUseDefaultButtonClick(Sender: TObject);
    procedure Insert2Execute(Sender: TObject);
    procedure InsertButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MoveDown1ButtonClick(Sender: TObject);
    procedure MoveUp1ButtonClick(Sender: TObject);
    procedure PasteChildrenOnly2Execute(Sender: TObject);
    procedure PasteNode2Execute(Sender: TObject);
    procedure PasteNodeAtRoot2Execute(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Changing(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TreeView1Click(Sender: TObject);
    procedure TreeView1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TreeView1Edited(Sender: TObject; Node: TTreeNode; var S: string);
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { private declarations }

    SourceNode : TTreeNode;
    vActiveNode : TTreeNode;

//    Menu       : TTCWMenuData;

    function GetHost: THost;
    function getHostURL: String;
    function GetIDXFooterColor: TColor;
    function GetIDXFooterFont: String;
    function GetIDXFooterSize: String;
    function GetIDXFooterText: String;
    function GetIDXHeaderColor: TColor;
    function GetIDXHeaderFont: String;
    function GetIDXHeaderSize: String;
    function GetIDXHeaderText: String;
    function GetIDXPageTitle: String;
    procedure SetActiveNode(const AValue: TTreeNode);
    procedure SetHost(const AValue: THost);
    procedure SetHostURL(const AValue: String);
    procedure SetIDXFooterColor(const AValue: TColor);
    procedure SetIDXFooterFont(const AValue: String);
    procedure SetIDXFooterSize(const AValue: String);
    procedure SetIDXFooterText(const AValue: String);
    procedure SetIDXHeaderColor(const AValue: TColor);
    procedure SetIDXHeaderFont(const AValue: String);
    procedure SetIDXHeaderSize(const AValue: String);
    procedure SetIDXHeaderText(const AValue: String);
    procedure SetIDXPageTitle(const AValue: String);
    procedure SetupPopupMenu;
    procedure CopyMenuNode(OldNode, NewNode: TTreeNode);
    procedure ControlsToMenuItem;
    procedure ControlsFromMenuItem;
    procedure ControlsToMenu;
    procedure ControlsFromMenu;
    procedure ClearTreeView( TV : TTreeView );
  public
    { public declarations }
    procedure Save( Data : TTCWMenuData );
    procedure Load( Data : TTCWMenuData );

    property Host           : THost     read GetHost           write SetHost;
    property HostURL        : String    read getHostURL        write SetHostURL;
    property IDXPageTitle   : String    read GetIDXPageTitle   write SetIDXPageTitle;
    property IDXHeaderText  : String    read GetIDXHeaderText  write SetIDXHeaderText;
    property IDXHeaderColor : TColor    read GetIDXHeaderColor write SetIDXHeaderColor;
    property IDXHeaderSize  : String    read GetIDXHeaderSize  write SetIDXHeaderSize;
    property IDXHeaderFont  : String    read GetIDXHeaderFont  write SetIDXHeaderFont;
    property IDXFooterText  : String    read GetIDXFooterText  write SetIDXFooterText;
    property IDXFooterColor : TColor    read GetIDXFooterColor write SetIDXFooterColor;
    property IDXFooterSize  : String    read GetIDXFooterSize  write SetIDXFooterSize;
    property IDXFooterFont  : String    read GetIDXFooterFont  write SetIDXFooterFont;
    property ActiveNode : TTreeNode read vActiveNode write SetActiveNode;
  end; 

implementation

uses
  Dialogs, TCWItemEditUnit1, Common1;

{$R *.lfm}

{ TMenuItemFrame }

procedure TMenuItemFrame.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  MoveDown1Button.Enabled := (TreeView1.Selected <> nil) and
    (TreeView1.Selected.getNextSibling <> nil);
  MoveUp1Button.Enabled := (TreeView1.Selected <> nil) and
    (TreeView1.Selected.getPrevSibling <> nil);
end;

procedure TMenuItemFrame.TreeView1Changing(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  ControlsToMenuItem;
end;

procedure TMenuItemFrame.Add2Click(Sender: TObject);
var
  Node, NewNode : TTreeNode;
  MenuItem : TTCWMenuItem;
begin
  repeat
    if TCWItemEditForm.Execute( ieAdd ) then
      begin
        Node := TreeView1.Selected;
        NewNode := TreeView1.Items.Add( Node, TCWItemEditForm.Text );
        MenuItem := TTCWMenuItem.Create(  NewNode.Text, TCWItemEditForm.ItemEditData );
//        MenuItem.IDX_HeaderStyle := fIDX_HeaderStyleDefault;
//        MenuItem.IDX_FooterStyle := fIDX_FooterStyleDefault;
        NewNode.Data := MenuItem;
        ControlsFromMenuItem;
//        Menu.IsModified := True;
        TreeView1.FullExpand;
        TreeView1.Selected := NewNode;
        TreeView1Click( Sender );
      end;
  until not TCWItemEditForm.Continue;
end;

procedure TMenuItemFrame.AddButtonClick(Sender: TObject);
begin

end;

procedure TMenuItemFrame.AddButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Add2Click( Sender );
end;

procedure TMenuItemFrame.AddChild2Execute(Sender: TObject);
var
  Node, NewNode : TTreeNode;
  MenuItem : TTCWMenuItem;
begin
  if TCWItemEditForm.Execute( ieAddChild) then
    begin
      Node := TreeView1.Selected;
      NewNode := TreeView1.Items.AddChild( Node, TCWItemEditForm.Text );
      MenuItem := TTCWMenuItem.Create(  NewNode.Text, TCWItemEditForm.ItemEditData );
      NewNode.Data := MenuItem;
      TreeView1.Selected := NewNode;
      ControlsFromMenuItem;
//      Menu.IsModified := True;
      TreeView1Click( Sender );
    end;
 if TCWItemEditForm.Continue then
   Add2Click( Sender );
end;

procedure TMenuItemFrame.AddChildButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  AddChild2Execute( Sender );
end;

procedure TMenuItemFrame.Button1Click(Sender: TObject);
begin
  ControlsToMenuItem;
end;

procedure TMenuItemFrame.ContractButtonClick(Sender: TObject);
begin
  Treeview1.FullCollapse;
end;

procedure TMenuItemFrame.CopyNode2Execute(Sender: TObject);
begin
 SourceNode := TreeView1.Selected;
 SetupPopupMenu;
end;

procedure TMenuItemFrame.Delete2Execute(Sender: TObject);
var
  Node : TTreeNode;
begin
  if MessageDlg( 'Delete Menu Item'#13#10'Are you sure?',
                 mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      Node := TreeView1.Selected;
      if Node <> nil then
        begin
          TTCWMenuItem(Node.Data).Free;
          Node.Data := nil;
          Node.Delete;
          TreeView1.Selected := nil;
          ActiveNode := nil;
          TreeView1Click( Sender );
        end;
    end;
end;

procedure TMenuItemFrame.DeleteButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Delete2Execute( Sender );
end;

procedure TMenuItemFrame.ExpandButtonClick(Sender: TObject);
begin
  Treeview1.FullExpand;
end;

procedure TMenuItemFrame.IDX_HeaderUseDefaultButtonClick(Sender: TObject);
begin
  Stub('Use IDX Header Default');
end;

procedure TMenuItemFrame.Insert2Execute(Sender: TObject);
var
  Node, NewNode : TTreeNode;
  MenuItem : TTCWMenuItem;
begin
  if TCWItemEditForm.Execute( ieInsert ) then
    begin
      Node := TreeView1.Selected;
      NewNode := TreeView1.Items.Insert( Node, TCWItemEditForm.Text );
      MenuItem := TTCWMenuItem.Create(  NewNode.Text, TCWItemEditForm.ItemEditData );
      NewNode.Data := MenuItem;
      TreeView1.Selected := NewNode;
      ControlsFromMenuItem;
      TreeView1Click( Sender );
    end;
end;

procedure TMenuItemFrame.InsertButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Insert2Execute( Sender );
end;

procedure TMenuItemFrame.MoveDown1ButtonClick(Sender: TObject);
begin
  TreeView1.Selected.GetNextSibling.MoveTo(TreeView1.Selected,naInsert);
  TreeView1Change( Sender, nil );
end;

procedure TMenuItemFrame.MoveUp1ButtonClick(Sender: TObject);
begin
  TreeView1.Selected.MoveTo(TreeView1.Selected.GetPrevSibling,naInsert);
  TreeView1Change( Sender, nil );
end;

procedure TMenuItemFrame.PasteChildrenOnly2Execute(Sender: TObject);
var
  DestNode : TTreeNode;
begin
  DestNode := CopySubtree( SourceNode, TreeView1, TreeView1.Selected, @CopyMenuNode, false);
  TreeView1.Selected := DestNode;
  TreeView1Change( Sender, nil );
end;

procedure TMenuItemFrame.PasteNode2Execute(Sender: TObject);
var
  DestNode : TTreeNode;
begin
  DestNode := CopySubtree( SourceNode, TreeView1, TreeView1.Selected, @CopyMenuNode, true);
  TreeView1.Selected := DestNode;
  TreeView1Change( Sender, nil );
end;

procedure TMenuItemFrame.PasteNodeAtRoot2Execute(Sender: TObject);
var
  DestNode : TTreeNode;
begin
  DestNode := CopySubtree( SourceNode, TreeView1, nil, @CopyMenuNode,true);
  TreeView1.Selected := DestNode;
  TreeView1Change( Sender, nil );
end;

procedure TMenuItemFrame.TreeView1Click(Sender: TObject);
begin
  ControlsToMenuItem;
  ActiveNode           := TreeView1.Selected;
  SetupPopupMenu;
end;

procedure TMenuItemFrame.TreeView1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
   AnItem: TTreeNode;
   AttachMode: TNodeAttachMode;
   HT: THitTests;
begin
   if TreeView1.Selected = nil then Exit;
   HT := TreeView1.GetHitTestInfoAt(X, Y) ;
   AnItem := TreeView1.GetNodeAt(X, Y) ;
   if (HT - [htOnItem, htOnIcon, htNowhere, htOnIndent] <> HT) then
     begin
       AttachMode := naAdd; // To remove anoying compiler warning
       if (htOnItem in HT) or
          (htOnIcon in HT) then
           AttachMode := naAddChild
       else if htNowhere in HT then
         AttachMode := naAdd
       else if htOnIndent in HT then
         AttachMode := naInsert;
       TreeView1.Selected.MoveTo(AnItem, AttachMode) ;
     end;
end;

procedure TMenuItemFrame.TreeView1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if State in [dsDragEnter, dsDragLeave, dsDragMove] then
    Accept := Source = TreeView1;
end;

procedure TMenuItemFrame.TreeView1Edited(Sender: TObject; Node: TTreeNode;
  var S: string);
var
  Item : TTCWMenuItem;
begin
  Item := TTCWMenuItem(Node.Data);
  if Item <> nil then
    Item.Name := S
  else
    MessageBox( 'nil Item in TMenuItemFrame.TreeView1Edited' );
end;

procedure TMenuItemFrame.TreeView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  MousePos : TPoint;
begin
  if Button = mbRight then
    begin
      MousePos := Mouse.CursorPos;
      PopupMenu.Popup(MousePos.X,MousePos.Y);
    end;
end;

procedure TMenuItemFrame.SetupPopupMenu;
begin
  Insert2.Enabled := Assigned(ActiveNode);
  AddChild2.Enabled := Assigned(ActiveNode);
  Delete2.Enabled := Assigned(ActiveNode);
  CopyNode2.Enabled := Assigned(ActiveNode);
  PasteNode2.Enabled := Assigned(ActiveNode) and Assigned(SourceNode);
  PasteChildrenOnly2.Enabled := Assigned(ActiveNode) and Assigned(SourceNode);
  PasteNodeAtRoot2.Enabled := Assigned(SourceNode);
end;

procedure TMenuItemFrame.SetActiveNode(const AValue: TTreeNode);
begin
  if vActiveNode=AValue then exit;
  vActiveNode:=AValue;
  inherited;
  SetupPopupMenu;
  ControlsFromMenuItem;
end;

function TMenuItemFrame.GetHost: THost;
begin
  Result := THost(HostRG.ItemIndex);
end;

function TMenuItemFrame.getHostURL: String;
begin
  Result := HostURLEdit.Text;
end;

function TMenuItemFrame.GetIDXFooterColor: TColor;
begin
  Result := ColorFrame2.Color;
end;

function TMenuItemFrame.GetIDXFooterFont: String;
begin
  Result := IDX_FooterFontEdit.Text;
end;

function TMenuItemFrame.GetIDXFooterSize: String;
begin
  Result := IDX_FooterSizeEdit.Text;
end;

function TMenuItemFrame.GetIDXFooterText: String;
begin
  Result := IDX_FooterTextEdit.Text;
end;

function TMenuItemFrame.GetIDXHeaderColor: TColor;
begin
  Result := ColorFrame1.Color;
end;

function TMenuItemFrame.GetIDXHeaderFont: String;
begin
  Result := IDX_HeaderFontEdit.Text;
end;

function TMenuItemFrame.GetIDXHeaderSize: String;
begin
  Result := IDX_HeaderSizeEdit.Text
end;

function TMenuItemFrame.GetIDXHeaderText: String;
begin
  Result := IDX_HeaderTextEdit.Text;
end;

function TMenuItemFrame.GetIDXPageTitle: String;
begin
  Result := IDXPageTitleEdit.Text;
end;

procedure TMenuItemFrame.SetHost(const AValue: THost);
begin
  HostRG.ItemIndex := Integer(aValue);
end;

procedure TMenuItemFrame.SetHostURL(const AValue: String);
begin
  HostURLEdit.Text := aValue;
end;

procedure TMenuItemFrame.SetIDXFooterColor(const AValue: TColor);
begin
  ColorFrame2.Color := AValue;
end;

procedure TMenuItemFrame.SetIDXFooterFont(const AValue: String);
begin
  IDX_FooterFontEdit.Text := aValue;
end;

procedure TMenuItemFrame.SetIDXFooterSize(const AValue: String);
begin
  IDX_FooterSizeEdit.Text := aValue;
end;

procedure TMenuItemFrame.SetIDXFooterText(const AValue: String);
begin
    IDX_FooterTextEdit.Text := aValue;
end;

procedure TMenuItemFrame.SetIDXHeaderColor(const AValue: TColor);
begin
  ColorFrame1.Color := AValue;
end;

procedure TMenuItemFrame.SetIDXHeaderFont(const AValue: String);
begin
  IDX_HeaderFontEdit.Text := aValue;
end;

procedure TMenuItemFrame.SetIDXHeaderSize(const AValue: String);
begin
  IDX_HeaderSizeEdit.Text :=  aValue;
end;

procedure TMenuItemFrame.SetIDXHeaderText(const AValue: String);
begin
  IDX_HeaderTextEdit.Text := aValue;
end;

procedure TMenuItemFrame.SetIDXPageTitle(const AValue: String);
begin
  IDXPageTitleEdit.Text := aValue;
end;

procedure TMenuItemFrame.CopyMenuNode(OldNode, NewNode: TTreeNode);
begin
  NewNode.Assign(OldNode);
  NewNode.Data := OldNode.Data; //TTCWMenuItem.Create(  NewNode );
end;

procedure TMenuItemFrame.ControlsToMenuItem;
var
  MenuItem : TTCWMenuItem;
begin
  if not Assigned(vActiveNode) then exit;

  MenuItem := TTCWMenuItem(vActiveNode.Data);
  MenuItem.Host             := Host;
  MenuItem.URL              := HostURL;
  MenuItem.IDXPageTitle     := IDXPageTitle;

  MenuItem.HeaderColor      := IDXHeaderColor;
  MenuItem.HeaderSize       := IDXHeaderSize;
  MenuItem.HeaderFont       := IDXHeaderFont;
  MenuItem.IDX_HeaderText   := IDXHeaderText;
  MenuItem.FooterColor      := IDXFooterColor;
  MenuItem.FooterSize       := IDXFooterSize;
  MenuItem.FooterFont       := IDXFooterFont;
  MenuItem.IDX_FooterText   := IDXFooterText;
end;

procedure TMenuItemFrame.ControlsFromMenuItem;
var
  MenuItem : TTCWMenuItem;
begin
  if Assigned(vActiveNode) then
    begin

      MenuItem := TTCWMenuItem(vActiveNode.Data);
      Host                      := MenuItem.Host;
      HostURL                   := MenuItem.URL;
      IDXPageTitle              := MenuItem.IDXPageTitle;
      IDXHeaderText             := MenuItem.IDX_HeaderText;
      IDXHeaderColor            := MenuItem.HeaderColor;
      IDXHeaderSize             := MenuItem.HeaderSize;
      IDXHeaderFont             := MenuItem.HeaderFont;
      IDXFooterText             := MenuItem.IDX_FooterText;
      IDXFooterColor            := MenuItem.FooterColor;
      IDXFooterSize             := MenuItem.FooterSize;
      IDXFooterFont             := MenuItem.FooterFont;

    end
  else
  begin

    MenuItem := nil;
    Host                      := hoNone;
    HostURL                   := '';
    IDXPageTitle              := '';
    IDXHeaderText             := '';
    IDXHeaderColor            := $000000;
    IDXHeaderSize             := '';
    IDXHeaderFont             := '';
    IDXFooterText             := '';
    IDXFooterColor            := $000000;
    IDXFooterSize             := '';
    IDXFooterFont             := '';

  end;
  TreeView1.Selected := ActiveNode;
end;

procedure TMenuItemFrame.ControlsToMenu;
begin
//  CopyTreeview(TreeView1,Menu.MenuTree,MenuTreeCopyProc);
end;

procedure TMenuItemFrame.ControlsFromMenu;
begin

end;

procedure TMenuItemFrame.ClearTreeView(TV: TTreeView);
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
  ActiveNode := nil;
end;

procedure TMenuItemFrame.Save(Data: TTCWMenuData);
  procedure AddChildren( N : TTreeNode; Parent : TTCWMenuItem );
  var
    Node : TTreeNode;
    Item : TTCWMenuItem;
  begin
    Node := N.GetFirstChild;
    while Node <> nil do
      begin
        Item := TTCWMenuItem.Copy(TTCWMenuItem( Node.Data ), False);
        Item.Name := Node.Text;
        Parent.AddChild(Item, False);
        AddChildren( Node, Item );
        Node := Node.GetNextSibling;
      end;
  end;
var
  Root : TTCWMenuItem;
  Node : TTreeNode;
  Item : TTCWMenuItem;
  OC   : Integer;
  IsMod : Boolean;
begin
  Root := Data.MenuRoot;
  OC   := Root.NodeCount;
  IsMod := Root.IsModified;
  Root.MakeNew;
  Root.SetModified( IsMod );
  if TreeView1.Items.Count > 0 then
    begin
      Node := TreeView1.Items.GetFirstNode;
      while Node <> nil do
        begin
          Item := TTCWMenuItem.Copy(TTCWMenuItem( Node.Data), False );
          Item.Name := Node.Text;
          Root.AddChild( Item, False );
          AddChildren( Node, Item );
          Node := Node.GetNextSibling;
        end;
    end;
  if (not Root.IsModified) and ( OC <> Root.NodeCount ) then
    Root.SetModified( true );
end;

procedure TMenuItemFrame.Load(Data: TTCWMenuData);
  procedure LoadChildren( N : TTreeNode; Itm : TTCWMenuItem );
  var
    I : Integer;
    Node : TTreeNode;
    Item : TTCWMenuItem;
    S    : String;
    C : Integer;
  begin
    C := Itm.ChildCount;
    for I := 0 to pred( C ) do
      begin
//        IX := Itm.Children[I];
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
  CC   : Integer;
begin
  ClearTreeView( TreeView1 );
  Root := Data.MenuRoot;
  CC   := Root.ChildCount;
  for I := 0 to pred( CC ) do
    begin
      Item := TTCWMenuItem.Copy(Root.Children[I]);
      S := Item.Name;
      Node := TreeView1.Items.AddObject( nil, S, Item );
      LoadChildren( Node, Item );
    end;
  TreeView1.FullExpand;
  ActiveNode := nil;
  ControlsFromMenuItem;
end;

end.
