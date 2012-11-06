program MagicWebsiteBuilder;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, printer4lazarus, MWBMain1, CursorStackUnit1, generics1, Common1,
  TextIO1, persists1, ObjectFactory1, CustomizedWebsiteUnit1,
  GeneralWebsiteUnit1, GeneralFrame1, ColorFrame1, ImagesAndBGFrame1,
  ImagesAndBGUnit1, MenusFrame1, MenuSelectFrame1, WebsiteMenusUnit1,
  MenuItemFrame1, GeneralCSSFrame1, MenuCSSFrame1, IDXHdrFtrFrame1,
  GeneralCSSUnit1, MenuCSSUnit1, TCWItemEditUnit1, MenuItemUnit1,
  NamedFunctionUnit1, WebsiteRootUnit1, TCWMenuUnit1, IDXHdrFtrUnit1, GeneratorObjectUnit1, WebsiteGeneratorUnit1, MessageFormUnit1,
  WebsiteDeployUnit1, AboutUnit1, ConfigUnit1, ConfigDebugUnit1;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMWBMain, MWBMain);
  Application.CreateForm(TTCWItemEditForm, TCWItemEditForm);
  Application.CreateForm(TMessageForm, MessageForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TConfigDebugForm, ConfigDebugForm);
  Application.Run;
end.

