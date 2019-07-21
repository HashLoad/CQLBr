program TestCQLBr;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}
uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  test.select in 'test.select.pas',
  cqlbr.ast in '..\Source\Core\cqlbr.ast.pas',
  cqlbr.cases in '..\Source\Core\cqlbr.cases.pas',
  cqlbr.core in '..\Source\Core\cqlbr.core.pas',
  cqlbr.delete in '..\Source\Core\cqlbr.delete.pas',
  cqlbr.expression in '..\Source\Core\cqlbr.expression.pas',
  cqlbr.functions in '..\Source\Core\cqlbr.functions.pas',
  cqlbr.groupby in '..\Source\Core\cqlbr.groupby.pas',
  cqlbr.having in '..\Source\Core\cqlbr.having.pas',
  cqlbr.insert in '..\Source\Core\cqlbr.insert.pas',
  cqlbr.interfaces in '..\Source\Core\cqlbr.interfaces.pas',
  cqlbr.joins in '..\Source\Core\cqlbr.joins.pas',
  cqlbr.orderby in '..\Source\Core\cqlbr.orderby.pas',
  criteria.query.language in '..\Source\Core\criteria.query.language.pas',
  cqlbr.qualifier in '..\Source\Core\cqlbr.qualifier.pas',
  cqlbr.select in '..\Source\Core\cqlbr.select.pas',
  cqlbr.serialize in '..\Source\Core\cqlbr.serialize.pas',
  cqlbr.update in '..\Source\Core\cqlbr.update.pas',
  cqlbr.where in '..\Source\Core\cqlbr.where.pas',
  cqlbr.qualifier.firebird in '..\Source\Database\cqlbr.qualifier.firebird.pas',
  cqlbr.qualifier.oracle in '..\Source\Database\cqlbr.qualifier.oracle.pas',
  cqlbr.qualifier.mysql in '..\Source\Database\cqlbr.qualifier.mysql.pas',
  cqlbr.select.oracle in '..\Source\Database\cqlbr.select.oracle.pas',
  cqlbr.utils in '..\Source\Core\cqlbr.utils.pas',
  cqlbr.serialize.oracle in '..\Source\Database\cqlbr.serialize.oracle.pas',
  cqlbr.serialize.firebird in '..\Source\Database\cqlbr.serialize.firebird.pas',
  cqlbr.serialize.mysql in '..\Source\Database\cqlbr.serialize.mysql.pas',
  cqlbr.db.register in '..\Source\Core\cqlbr.db.register.pas',
  cqlbr.select.firebird in '..\Source\Database\cqlbr.select.firebird.pas',
  cqlbr.select.mysql in '..\Source\Database\cqlbr.select.mysql.pas',
  cqlbr.select.mongodb in '..\Source\Database\cqlbr.select.mongodb.pas',
  cqlbr.qualifier.mongodb in '..\Source\Database\cqlbr.qualifier.mongodb.pas',
  cqlbr.serialize.mongodb in '..\Source\Database\cqlbr.serialize.mongodb.pas',
  test.insert in 'test.insert.pas',
  test.update in 'test.update.pas',
  test.delete in 'test.delete.pas',
  cqlbr.select.mssql in '..\Source\Database\cqlbr.select.mssql.pas',
  cqlbr.serialize.mssql in '..\Source\Database\cqlbr.serialize.mssql.pas',
  cqlbr.qualifier.mssql in '..\Source\Database\cqlbr.qualifier.mssql.pas';

{$IFNDEF TESTINSIGHT}
var
  runner : ITestRunner;
  results : IRunResults;
  logger : ITestLogger;
  nunitLogger : ITestLogger;
{$ENDIF}
begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
{$ELSE}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //tell the runner how we will log things
    //Log to the console window
    logger := TDUnitXConsoleLogger.Create(true);
    runner.AddLogger(logger);
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);
    runner.FailsOnNoAsserts := False; //When true, Assertions must be made during tests;

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
{$ENDIF}

end.
