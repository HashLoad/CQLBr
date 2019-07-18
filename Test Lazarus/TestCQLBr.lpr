program TestCQLBr;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, GuiTestRunner, test.select;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

