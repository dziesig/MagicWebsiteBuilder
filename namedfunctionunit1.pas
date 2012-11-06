unit NamedFunctionUnit1;

//{$mode objfpc}{$H+}
{$mode delphi}{$H+}

interface

uses
  Classes;

type
  TMethodCall   = function : String of Object;

  TMethodObject   = class
    vMethod : TMethodCall;
    constructor Create( Method : TMethodCall );
    function Execute : String;
  end;

  TNamedFunctions = class(TStringList)
    procedure AddFunction( Name : String; Func : TMethodCall ); overload;
    function  Execute( var Value : String; Name : String ) : Boolean;
  end;

implementation

{ TNamedFunctions }
procedure TNamedFunctions.AddFunction(Name: String; Func: TMethodCall);
var
  Obj : TMethodObject;
begin
  Obj := TMethodObject.Create(Func);
  AddObject( Name, Obj );
  Sort;
end;

function TNamedFunctions.Execute( var Value : String; Name : String ): Boolean;
var
  Func : TMethodObject;
  I    : Integer;
begin
  Result := Find(Name,I);
  if Result then
    begin
      Func := TMethodObject(Objects[I]);
      Value := Func.Execute;
    end;
end;

{ TMethodObject }

constructor TMethodObject.Create(Method: TMethodCall);
begin
  vMethod := Method;
end;

function TMethodObject.Execute: String;
begin
  Result := TMethodCall(vMethod);
end;

end.
