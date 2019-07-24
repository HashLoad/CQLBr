program TestCQLBr;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, GuiTestRunner, test.select, test.insert, test.update,
  test.delete, test.operators, test.operators.like;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

