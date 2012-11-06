unit MessageFormUnit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type

  { TMessageForm }

  TMessageForm = class(TForm)
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    procedure BitBtn1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    procedure Message( What : String );
  end;

var
  MessageForm: TMessageForm;

implementation

{$R *.lfm}

{ TMessageForm }

procedure TMessageForm.BitBtn1Click(Sender: TObject);
begin
  Hide;
end;

procedure TMessageForm.Message(What: String);
begin
  Memo1.Lines.Add(What);
  Show;
end;

end.

