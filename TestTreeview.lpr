program TestTreeview;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, TestTreeviewMainUnit1, MenuItemUnit1, WebsiteRootUnit1,
  NamedFunctionUnit1, TCWMenuUnit1, generics1, Common1, persists1, TextIO1
  { you can add units after this };

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

