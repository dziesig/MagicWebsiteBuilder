unit inidataunit0;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, IniFiles;

{==============================================================================}
{ The Directory Tree associated with the IniFile is as follows:                }
{                                                                              }
{ DefaultSaveLocation ( in windows will be "My Documents" )                    }
{                                                                              }
{ RootDirectory ( typical will be "Websites" )                                 }
{                                                                              }
{ Site Owner ( for example AnnaBella )                                         }
{                                                                              }
{------------------------------------------------------------------------------}
{ The default location of the .ncw file will be:                               }
{                                                                              }
{ DefaultSaveLocation\Websites\AnnaBella                                       }
{                                                                              }
{ This directory will also contain the "Generated" and "Deployed" directories  }
{                                                                              }
{------------------------------------------------------------------------------}
{                                                                              }
{==============================================================================}

type

  { TIniData }

  TIniData = class(TForm)
    BitBtn1: TBitBtn;
    DoneButton: TBitBtn;
    DeployDirectoryEdit: TLabeledEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    HostDirectoryEdit: TLabeledEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DefaultSaveLocationLabel: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    StylesheetEdit1: TLabeledEdit;
    SiteOwnerEdit1: TLabeledEdit;
    RootDirectoryEdit1: TLabeledEdit;
    TestDirectoryEdit: TLabeledEdit;
    WorkDirectoryEdit: TLabeledEdit;
    procedure DeployDirectoryEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);
    procedure HostDirectoryEditChange(Sender: TObject);
    procedure TestDirectoryEditChange(Sender: TObject);
    procedure WorkDirectoryEditChange(Sender: TObject);
  private
    IniFile : TIniFile;
    function GetAllWebsiteRoot: String;
    function GetSiteOwner: String;
    function GetStylesheetDir: String;
    function GetStylesheetPath: String;
    procedure Open;
    procedure Save;

    function GetFTPHide: Boolean;
    function GetFTPShow: Boolean;
    function GetImagePath: String;
    function GetWebsitePath: String;
    procedure SetAllWebsiteRoot(const AValue: String);
    procedure SetFTPHide(const Value: Boolean);
    procedure SetFTPShow(const Value: Boolean);
    procedure SetImagePath(const Value: String);
    procedure SetSiteOwner(const AValue: String);
//    procedure SetWebsitePath(const Value: String);
    function GetDeployRoot: String;
    function GetTestRoot: String;
    function GetWorkRoot: String;
    procedure SetDeployRoot(const Value: String);
    procedure SetStylesheetDir(AValue: String);
//    procedure SetStylesheetPath(AValue: String);
    procedure SetTestRoot(const Value: String);
    procedure SetWebsitePath(const AValue: String);
    procedure SetWorkRoot(const Value: String);
    function GetWorkPathRoot: String;
    function GetDeployPathRoot: String;
    function GetTestPathRoot: String;
    function GetHostPathRoot: String;
    function GetHostRoot: String;
    procedure SetHostRoot(const Value: String);
  protected
    property WorkRoot : String read GetWorkRoot write SetWorkRoot;
    property TestRoot : String read GetTestRoot write SetTestRoot;
    property DeployRoot : String read GetDeployRoot write SetDeployRoot;
    property HostRoot : String read GetHostRoot write SetHostRoot;
    property AllWebsiteRoot : String read GetAllWebsiteRoot write SetAllWebsiteRoot;
    property SiteOwnerRoot : String read GetSiteOwner write SetSiteOwner;

    procedure CheckBlanks;
  public
    { Public declarations }

    function Execute : Integer;

    property WebsitePath : String read GetWebsitePath write SetWebsitePath;
    property ImagePath : String read GetImagePath write SetImagePath;
    property FTPShow   : Boolean read GetFTPShow write SetFTPShow;
    property FTPHide   : Boolean read GetFTPHide write SetFTPHide;

    property DeployPathRoot : String read GetDeployPathRoot;
    property HostPathRoot : String read GetHostPathRoot;
    property TestPathRoot : String read GetTestPathRoot;
    property WorkPathRoot : String read GetWorkPathRoot;

    property StylesheetDir : String read GetStylesheetDir write SetStylesheetDir;
    Property StylesheetPath : String read GetStylesheetPath;
  end;

var
  IniData : TIniData;

implementation

{$R *.lfm}

uses
  Common1;

{ IniData }

function TIniData.Execute: Integer;
begin
  DefaultSaveLocationLabel.Caption := DefaultSaveLocation;
  DeployDirectoryEdit.Text  := DeployRoot;
  TestDirectoryEdit.Text    := TestRoot;
  WorkDirectoryEdit.Text    := WorkRoot;
  HostDirectoryEdit.Text    := HostRoot;
  RootDirectoryEdit1.Text   := AllWebsiteRoot;
  SiteOwnerEdit1.Text       := SiteOwnerRoot;
  StyleSheetEdit1.Text      := StylesheetDir;
  CheckBlanks;
  Result := ShowModal;
  if Result = mrOk then
    begin
      DeployRoot := DeployDirectoryEdit.Text;
      HostRoot   := HostDirectoryEdit.Text;
      TestRoot   := TestDirectoryEdit.Text;
      WorkRoot   := WorkDirectoryEdit.Text;
      AllWebsiteRoot := RootDirectoryEdit1.Text;
      SiteOwnerRoot  := SiteOwnerEdit1.Text;
      StylesheetDir := StylesheetEdit1.Text;
      CheckBlanks;
    end;
end;

procedure TIniData.FormCreate(Sender: TObject);
begin
  IniFile := nil;
end;

procedure TIniData.DeployDirectoryEditChange(Sender: TObject);
begin
    CheckBlanks;
end;

procedure TIniData.GroupBox1Click(Sender: TObject);
begin

end;

procedure TIniData.HostDirectoryEditChange(Sender: TObject);
begin
  CheckBlanks;
end;

procedure TIniData.TestDirectoryEditChange(Sender: TObject);
begin
    CheckBlanks;
end;

procedure TIniData.WorkDirectoryEditChange(Sender: TObject);
begin
  CheckBlanks;
end;

function TIniData.GetDeployPathRoot: String;
begin
  Result := DefaultSaveLocation + '\' + DeployRoot  +'\';
end;

function TIniData.GetDeployRoot: String;
begin
  Open;
  Result := IniFile.ReadString('Roots','Deploy','Deploy');
  Save;
end;

function TIniData.GetFTPHide: Boolean;
begin
  Open;
  Result := IniFile.ReadBool('Options','FTPHide',false);
  Save;
end;

function TIniData.GetFTPShow: Boolean;
begin
  Open;
  Result := IniFile.ReadBool('Options','FTPShow',false);
  Save;
end;

function TIniData.GetHostPathRoot: String;
begin
  Result := WebsitePath + '\' + HostRoot  +'\';
end;

function TIniData.GetHostRoot: String;
begin
  Open;
  Result := IniFile.ReadString('Roots','Host','Host');
  Save;
end;

function TIniData.GetImagePath: String;
begin
  Open;
  Result := IniFile.ReadString('Images','Path',DefaultSaveLocation);
  Save;
end;

function TIniData.GetTestPathRoot: String;
begin
  Result := DefaultSaveLocation + '\' + TestRoot  +'\';
end;

function TIniData.GetTestRoot: String;
begin
  Open;
  Result := IniFile.ReadString('Roots','Test','Test');
  Save;
end;

function TIniData.GetWebsitePath: String;
begin
  Result := DefaultSaveLocation + DirectorySeparator + AllWebsiteRoot +
            DirectorySeparator + SiteOwnerRoot + DirectorySeparator;
end;

procedure TIniData.SetAllWebsiteRoot(const AValue: String);
begin
  Open;
  IniFile.WriteString( 'Roots','Websites', aValue );
  Save;
end;

function TIniData.GetWorkPathRoot : String;
begin
  Result := WebsitePath + WorkRoot + DirectorySeparator;
end;

function TIniData.GetWorkRoot: String;
begin
  Open;
  Result := IniFile.ReadString('Roots','Work','Work');
  Save;
end;

procedure TIniData.Open;
var
  FileName : String; // For debug of paths
begin
  if IniFile <> nil then
    Save;
  FileName := GetAppConfigFile( False );
  ForceDirectories( ExtractFilePath( FileName ) );
  IniFile := TIniFile.Create(FileName);
end;

function TIniData.GetAllWebsiteRoot: String;
begin
  Open;
  Result := IniFile.ReadString('Roots','Primary','Websites');
  Save;
end;

function TIniData.GetSiteOwner: String;
begin
  Open;
  Result := IniFile.ReadString('Roots','Site Owner','Site Owner');
  Save;
end;

function TIniData.GetStylesheetDir: String;
begin
  Open;
  Result := IniFile.ReadString('Paths','Stylesheets','Stylesheets');
  Save;
end;

function TIniData.GetStylesheetPath: String;
begin
  Open;
  Result := AllWebsiteRoot + DirectorySeparator + SiteOwnerRoot + DirectorySeparator +
            WorkRoot + DirectorySeparator + StylesheetDir + DirectorySeparator;
  Save;
end;

procedure TIniData.Save;
begin
  IniFile.Free;
  IniFile := nil;
end;

procedure TIniData.SetDeployRoot(const Value: String);
begin
  Open;
  IniFile.WriteString( 'Roots','Deploy', Value );
  Save;
end;

procedure TIniData.SetFTPHide(const Value: Boolean);
begin
  Open;
  IniFile.WriteBool('Options','FTPHide', Value );
  Save;
end;

procedure TIniData.SetFTPShow(const Value: Boolean);
begin
  Open;
  IniFile.WriteBool('Options','FTPShow', Value );
  Save;
end;

procedure TIniData.SetHostRoot(const Value: String);
begin
  Open;
  IniFile.WriteString('Roots','Host', Value );
  Save;
end;

procedure TIniData.CheckBlanks;
begin
  DoneButton.Enabled := True;
  if Empty( WorkDirectoryEdit.Text ) then
    begin
      WorkDirectoryEdit.Color := clRed;
      DoneButton.Enabled := False;
    end
  else
    WorkDirectoryEdit.Color := clWhite;
   if Empty( TestDirectoryEdit.Text ) then
    begin
      TestDirectoryEdit.Color := clRed;
      DoneButton.Enabled := False;
    end
  else
    TestDirectoryEdit.Color := clWhite;
   if Empty( DeployDirectoryEdit.Text ) then
    begin
      DeployDirectoryEdit.Color := clRed;
      DoneButton.Enabled := False;
    end
  else
    DeployDirectoryEdit.Color := clWhite;
   if Empty( HostDirectoryEdit.Text ) then
    begin
      HostDirectoryEdit.Color := clRed;
      DoneButton.Enabled := False;
    end
  else
    HostDirectoryEdit.Color := clWhite;

end;

procedure TIniData.SetImagePath(const Value: String);
begin
  Open;
  IniFile.WriteString( 'Images','Path', Value );
  Save;
end;

procedure TIniData.SetSiteOwner(const AValue: String);
begin
  Open;
  IniFile.WriteString( 'Roots','Site Owner', aValue );
  Save;
end;

procedure TIniData.SetStylesheetDir(AValue: String);
begin
  Open;
  IniFile.WriteString( 'Roots','Deploy', AValue );
  Save;
end;

procedure TIniData.SetTestRoot(const Value: String);
begin
  Open;
  IniFile.WriteString( 'Roots','Test', Value );
  Save;
end;

procedure TIniData.SetWebsitePath(const AValue: String);
var
  S1, s2 : String;
begin
  S1 := ExtractFileOrDirectory(-1,AValue);
  S2 := ExtractFileOrDirectory(-2,AValue);
  SiteOwnerRoot := S1;
  AllWebsiteRoot := S2;
  DeployRoot := GetDeployRoot;
  HostRoot   := GetHostRoot;
  TestRoot   := GetTestRoot;
  WorkRoot   := GetWorkRoot;
end;

procedure TIniData.SetWorkRoot(const Value: String);
begin
  Open;
  IniFile.WriteString( 'Roots','Work', Value );
  Save;
end;
end.

