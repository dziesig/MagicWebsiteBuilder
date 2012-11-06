unit MWBMain1;

{$mode objfpc}{$H+}

{==============================================================================}
{ This is the main unit for Z-House Realty Group's Magic Website Builder.      }
{                                                                              }
{ The latest update (of this header ;) was made on 2 October 2012.             }
{                                                                              }
{ The major revision in this update is to the file structure used for work,    }
{ generation and deployment.                                                   }
{                                                                              }
{ The root directory for a given agent is:                                     }
{                                                                              }
{ SaveLocation\ClientName -- where SaveLocation and ClientName are extracted   }
{ from the most recently saved website.                                        }
{                                                                              }
{ Since an agent may have more than one website, the entire file path will be  }
{                                                                              }
{ SaveLocation\ClientName\website.ncw                                          }
{ and                                                                          }
{ SaveLocation\ClientName\website\LocalTest\         -- Html Files             }
{ SaveLocation\ClientName\website\LocalTest\Images   -- Local copy of images   }
{ SaveLocation\ClientName\website\LocalTest\Javascripts                        }
{ SaveLocation\ClientName\website\LocalTest\Stylesheets                        }
{                                                                              }
{ SaveLocation\ClientName\website\Work     -- intermediate files               }
{                                                                              }
{ SaveLocation\ClientName\website\Test     -- html files pointing to Deploy    }
{ SaveLocation\ClientName\website\Deploy   -- mirror image of host storage     }
{                                                                              }
{                                                                              }
{==============================================================================}
interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ActnList,
  Menus, ComCtrls, StdCtrls, PrintersDlgs,

  CursorStackUnit1, CustomizedWebsiteUnit1, GeneralFrame1, ImagesAndBGFrame1,
  MenuSelectFrame1, ExtCtrls,Buttons;

type

  { TMWBMain }

  TMWBMain = class(TForm)
    HelpAbout1: TAction;
    MenuItem13: TMenuItem;
    MenuItem16: TMenuItem;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton9: TToolButton;
    WebsiteDeploy1: TAction;
    WebsiteGenerate1: TAction;
    Button1: TButton;
    Button10: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    FilePrint1: TAction;
    FilePrinterSetup: TAction;
    FilePreferences1: TAction;
    FileExit1: TAction;
    FileSaveAs1: TAction;
    FileSave1: TAction;
    FileOpen1: TAction;
    FileNew1: TAction;
    ActionList1: TActionList;
    GeneralFrame1: TGeneralFrame;
    ImageList1: TImageList;
    ImagesAndBGFrame1: TImagesAndBGFrame;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    WebsiteMenuItem1: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuSelectFrame1: TMenuSelectFrame;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    procedure BackgroundImageClick(Sender: TObject);
    procedure EditCopy1Execute(Sender: TObject);
    procedure EditCut1Execute(Sender: TObject);
    procedure EditPaste1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure FileNew1Execute(Sender: TObject);
    procedure FileOpen1Execute(Sender: TObject);
    procedure FilePreferences1Execute(Sender: TObject);
    procedure FilePrint1Execute(Sender: TObject);
    procedure FilePrinterSetupExecute(Sender: TObject);
    procedure FileSave1Execute(Sender: TObject);
    procedure FileSaveAs1Execute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure WebsiteDeploy1Execute(Sender: TObject);
    procedure WebsiteGenerate1Execute(Sender: TObject);
  private
    { private declarations }
    CursorStack : TFormCursorStack;

    fMWBData : TCustomizedWebsite;

    procedure AppHint( Sender : TObject);
    function GetDeployable: Boolean;
    function GetFileName: String;
    function GetModified: Boolean;
    procedure SetFileName(const AValue: String);
    procedure UpdateFrames;
    procedure SaveActiveFrame( Index : Integer );

    procedure SetupDirectories;
  public
    { public declarations }

    procedure DebugToMemo( Message : String );
    property FileName : String read GetFileName write SetFileName;
    property MWBData  : TCustomizedWebsite read fMWBData;
    property Modified : Boolean read GetModified;
    property Deployable : Boolean read GetDeployable;  // Includes "Generatable"
  end;

var
  MWBMain: TMWBMain;

implementation

uses
  TextIO1, ConfigUnit1, WebsiteGeneratorUnit1, Common1, WebsiteDeployUnit1,
  AboutUnit1, ConfigDebugUnit1;

{$R *.lfm}

const
  UntitledFile = 'UNTITLED';
  ModifiedWebsite = 'MODIFIED';

{ TMWBMain }

procedure TMWBMain.FileNew1Execute(Sender: TObject);
var
  Ans : Integer;
begin
  SaveActiveFrame( PageControl1.TabIndex );
  Ans := mrYes;
  if Modified then
    Ans := MessageDlg( 'Data for file ' + FileName + ' has been modified.'#13#10 +
                       'Continue creating new file? (All changes will be lost)',
                       mtConfirmation, [mbYes,mbNo], 0);
  if Ans = mrYes then
    begin
      fMWBData.Free;
      fMWBData := TCustomizedWebsite.Create;
      FileName := UntitledFile;
      UpdateFrames;
    end;
end;

procedure TMWBMain.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TMWBMain.EditCopy1Execute(Sender: TObject);
begin

end;

procedure TMWBMain.EditCut1Execute(Sender: TObject);
begin

end;

procedure TMWBMain.EditPaste1Execute(Sender: TObject);
begin

end;

procedure TMWBMain.FileOpen1Execute(Sender: TObject);
var
  TextIO : TTextIO;
  Ans    : Integer;
  Path   : String;
begin
  SaveActiveFrame( PageControl1.TabIndex );
  Ans := mrYes;
  if Modified then
    Ans := MessageDlg( 'Data for file ' + FileName + ' has been modified.'#13#10 +
                       'Continue opening a different file? (All changes will be lost)',
                       mtConfirmation, [mbYes,mbNo], 0);
  if Ans <> mrYes then exit;

  Path := ConfigData.ClientDirectory;
  OpenDialog1.InitialDir := Path;
  if OpenDialog1.Execute then
    begin
      CursorStack.Push( crHourGlass );
      FileName := OpenDialog1.FileName;
      SetupDirectories;
      TextIO := TTextIO.Create( FileName, False );
      fMWBData.Free;
      fMWBData := TCustomizedWebsite.Load( TextIO ) as TCustomizedWebsite;
      TextIO.Free;
      CursorStack.Pop;
      UpdateFrames;
    end;
end;

procedure TMWBMain.FilePreferences1Execute(Sender: TObject);
begin
  ConfigDebugForm.Show;
end;

procedure TMWBMain.FilePrint1Execute(Sender: TObject);
begin
  if PrintDialog1.Execute then
    begin

    end;
end;

procedure TMWBMain.FilePrinterSetupExecute(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    begin

    end;
end;

procedure TMWBMain.FileSave1Execute(Sender: TObject);
var
  TextIO : TTextIO;
begin
  if FileName = UntitledFile then
    FileSaveAs1Execute( Sender )
  else
    begin
      CursorStack.Push( crHourglass );
      SaveActiveFrame( PageControl1.TabIndex );
      TextIO := TTextIO.Create( FileName, True );
      fMWBData.Save( TextIO );
      TextIO.Free;
      CursorStack.Pop;
//      ConfigData.WebsiteDirectory := ExtractFilePath( FileName );
      SetupDirectories;
      Modified;
      Deployable;
    end;
end;

procedure TMWBMain.FileSaveAs1Execute(Sender: TObject);
var
  Path : String;
begin
  Path := ConfigData.WebsiteDirectory;
  SetupDirectories;
  SaveDialog1.InitialDir := Path;
  if SaveDialog1.Execute then
    begin
      FileName := SaveDialog1.FileName;
      FileSave1Execute( Sender );
    end;
end;

procedure TMWBMain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var
  mr : Integer;
begin
  SaveActiveFrame( PageControl1.TabIndex );
  CanClose := not Modified;
  if not CanClose then
    begin
      mr := MessageDlg( 'Data for ' + FileName + ' has been modified.'#13#10+
                        'Continue exiting?',mtConfirmation,[mbYes,mbNO],0);
      CanClose := mr = mrYes;
    end;
end;

procedure TMWBMain.FormCreate(Sender: TObject);
begin
  Application.OnHint := @AppHint;
  FileName := UntitledFile;
  CursorStack := TFormCursorStack.Create( self );
  fMWBData := nil;
  Height := Min( Height, 735 );
  FileNew1Execute( Sender );
end;

procedure TMWBMain.FormResize(Sender: TObject);
begin
  Height := Min( Height, 735 );
  StatusBar1.Panels[1].Width := StatusBar1.ClientWidth - StatusBar1.Panels[0].Width - 80;
end;

procedure TMWBMain.HelpAbout1Execute(Sender: TObject);
begin
  AboutForm.Show;
end;

function TMWBMain.GetDeployable: Boolean;
begin
  Result := (FileName <> UntitledFile) and (not Modified);
  WebsiteGenerate1.enabled := Result;
  WebsiteDeploy1.Enabled := Result;
  WebsiteMenuItem1.Enabled := Result;
end;

procedure TMWBMain.PageControl1Change(Sender: TObject);
begin
  case PageControl1.TabIndex of
    0: GeneralFrame1.Load( fMWBData.GeneralData );
    1: ImagesAndBGFrame1.Load( fMWBData.ImagesAndBG );
    2: MenuSelectFrame1.Load( fMWBData.Menus );
  end;
end;

procedure TMWBMain.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  SaveActiveFrame( PageControl1.TabIndex );
  AllowChange := True;
end;

procedure TMWBMain.WebsiteDeploy1Execute(Sender: TObject);
var
  Deployer : TWebsiteDeploy;
begin
  SaveActiveFrame( PageControl1.TabIndex );
  CursorStack.Push( crHourGlass );
  StatusBar1.Panels[0].Text := 'Deploying Website';
  Deployer := TWebsiteDeploy.Create( fMWBData );
  Deployer.Deploy;
//  OnlineStorageForm.Deploy(Website.Name,Deployer.DeployPath,true);
  Deployer.Free;
  StatusBar1.Panels[0].Text := 'Deploying Website - DONE';
  CursorStack.Pop;
  Application.ProcessMessages;
end;

procedure TMWBMain.WebsiteGenerate1Execute(Sender: TObject);
var
  Generator : TWebsiteGenerator;
begin
  SaveActiveFrame( PageControl1.TabIndex );
  CursorStack.Push( crHourGlass );
  StatusBar1.Panels[0].Text := 'Generating Website';
  Application.ProcessMessages;
  Generator := TWebsiteGenerator.Create( fMWBData );
  Generator.Generate;
  Generator.Free;
  StatusBar1.Panels[0].Text := 'Generating Website - DONE';
  CursorStack.Pop;
  Application.ProcessMessages;

end;

procedure TMWBMain.AppHint(Sender: TObject);
begin
  StatusBar1.Panels[0].Text:= Application.Hint;
end;

procedure TMWBMain.BackgroundImageClick(Sender: TObject);
begin

end;

function TMWBMain.GetFileName: String;
begin
  Result := StatusBar1.Panels[1].Text;
end;

function TMWBMain.GetModified: Boolean;
begin
  Result := (fMWBData <> nil) and fMWBData.Modified;
  if Result then
    StatusBar1.Panels[2].Text := ModifiedWebsite
  else
    StatusBar1.Panels[2].Text := '';
end;

procedure TMWBMain.SetFileName(const AValue: String);
var
  Ok : Boolean;
  Path : String;
  I    : integer;
  Count : Integer;
begin
  StatusBar1.Panels[1].Text := AValue;
  Ok :=  Deployable;
  WebsiteGenerate1.enabled := Ok;
  WebsiteDeploy1.Enabled := Ok;
  WebsiteMenuItem1.Enabled := Ok;

  ConfigData.WebsiteDirectory := RemoveExt(ExtractFileOrDirectory( -1, AValue ));
  ConfigData.ClientDirectory := ExtractFileOrDirectory( -2, AValue );
  Path := '';
  Count := CountFilesOrDirectories( AValue );
  for I := -3 downto -Count do
    Path := ExtractFileOrDirectory( I, AValue ) + DirectorySeparator + Path;
  ConfigData.BaseDirectory := Path;
end;

procedure TMWBMain.UpdateFrames;
begin
  GeneralFrame1.Load( fMWBData.GeneralData );
  ImagesAndBGFrame1.Load( fMWBData.ImagesAndBG );
  MenuSelectFrame1.Load( fMWBData.Menus )
end;

procedure TMWBMain.SaveActiveFrame(Index: Integer);
begin
  if fMWBData = nil then exit;
  case Index of
    0: GeneralFrame1.Save( fMWBData.GeneralData );
    1: ImagesAndBGFrame1.Save( fMWBData.ImagesAndBG );
    2: MenuSelectFrame1.Save( fMWBData.Menus );
  end;
  Modified;
  Deployable;
end;

procedure TMWBMain.SetupDirectories;
var
  Path : String;
begin
  Path := ConfigData.WebsiteDirectory;
  if not DirectoryExists( Path ) then
    ForceDirectories( Path );
end;

//function TMWBMain.CheckModified: Boolean;
//begin
//  Result := (fMWBData <> nil) and fMWBData.Modified;
//  if Result then
//    StatusBar1.Panels[2].Text := 'MODIFIED'
//  else
//    StatusBar1.Panels[2].Text := '';
//end;

procedure TMWBMain.DebugToMemo(Message: String);
begin
  Memo1.Lines.Add(Message);
end;

end.

