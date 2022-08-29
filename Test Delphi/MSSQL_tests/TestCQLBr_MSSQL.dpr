program TestCQLBr_MSSQL;

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
  cqlbr.ast in '..\..\Source\Core\cqlbr.ast.pas',
  cqlbr.cases in '..\..\Source\Core\cqlbr.cases.pas',
  cqlbr.delete in '..\..\Source\Core\cqlbr.delete.pas',
  cqlbr.expression in '..\..\Source\Core\cqlbr.expression.pas',
  cqlbr.functions.abstract in '..\..\Source\Core\cqlbr.functions.abstract.pas',
  cqlbr.groupby in '..\..\Source\Core\cqlbr.groupby.pas',
  cqlbr.having in '..\..\Source\Core\cqlbr.having.pas',
  cqlbr.insert in '..\..\Source\Core\cqlbr.insert.pas',
  cqlbr.interfaces in '..\..\Source\Core\cqlbr.interfaces.pas',
  cqlbr.joins in '..\..\Source\Core\cqlbr.joins.pas',
  cqlbr.orderby in '..\..\Source\Core\cqlbr.orderby.pas',
  criteria.query.language in '..\..\Source\Core\criteria.query.language.pas',
  cqlbr.qualifier in '..\..\Source\Core\cqlbr.qualifier.pas',
  cqlbr.select in '..\..\Source\Core\cqlbr.select.pas',
  cqlbr.serialize in '..\..\Source\Core\cqlbr.serialize.pas',
  cqlbr.update in '..\..\Source\Core\cqlbr.update.pas',
  cqlbr.where in '..\..\Source\Core\cqlbr.where.pas',
  cqlbr.utils in '..\..\Source\Core\cqlbr.utils.pas',
  cqlbr.register in '..\..\Source\Core\cqlbr.register.pas',
  cqlbr.operators in '..\..\Source\Core\cqlbr.operators.pas',
  cqlbr.qualifier.firebird in '..\..\Source\Drivers\cqlbr.qualifier.firebird.pas',
  cqlbr.qualifier.mongodb in '..\..\Source\Drivers\cqlbr.qualifier.mongodb.pas',
  cqlbr.qualifier.mssql in '..\..\Source\Drivers\cqlbr.qualifier.mssql.pas',
  cqlbr.qualifier.mysql in '..\..\Source\Drivers\cqlbr.qualifier.mysql.pas',
  cqlbr.qualifier.oracle in '..\..\Source\Drivers\cqlbr.qualifier.oracle.pas',
  cqlbr.qualifier.sqlite in '..\..\Source\Drivers\cqlbr.qualifier.sqlite.pas',
  cqlbr.select.mongodb in '..\..\Source\Drivers\cqlbr.select.mongodb.pas',
  cqlbr.select.mssql in '..\..\Source\Drivers\cqlbr.select.mssql.pas',
  cqlbr.select.mysql in '..\..\Source\Drivers\cqlbr.select.mysql.pas',
  cqlbr.select.oracle in '..\..\Source\Drivers\cqlbr.select.oracle.pas',
  cqlbr.select.sqlite in '..\..\Source\Drivers\cqlbr.select.sqlite.pas',
  cqlbr.serialize.mongodb in '..\..\Source\Drivers\cqlbr.serialize.mongodb.pas',
  cqlbr.serialize.mssql in '..\..\Source\Drivers\cqlbr.serialize.mssql.pas',
  cqlbr.serialize.mysql in '..\..\Source\Drivers\cqlbr.serialize.mysql.pas',
  cqlbr.serialize.oracle in '..\..\Source\Drivers\cqlbr.serialize.oracle.pas',
  cqlbr.serialize.sqlite in '..\..\Source\Drivers\cqlbr.serialize.sqlite.pas',
  cqlbr.serialize.firebird in '..\..\Source\Drivers\cqlbr.serialize.firebird.pas',
  cqlbr.select.firebird in '..\..\Source\Drivers\cqlbr.select.firebird.pas',
  cqlbr.functions.firebird in '..\..\Source\Drivers\cqlbr.functions.firebird.pas',
  cqlbr.functions in '..\..\Source\Core\cqlbr.functions.pas',
  cqlbr.functions.interbase in '..\..\Source\Drivers\cqlbr.functions.interbase.pas',
  cqlbr.functions.mysql in '..\..\Source\Drivers\cqlbr.functions.mysql.pas',
  cqlbr.functions.mssql in '..\..\Source\Drivers\cqlbr.functions.mssql.pas',
  cqlbr.functions.sqlite in '..\..\Source\Drivers\cqlbr.functions.sqlite.pas',
  cqlbr.functions.oracle in '..\..\Source\Drivers\cqlbr.functions.oracle.pas',
  cqlbr.functions.db2 in '..\..\Source\Drivers\cqlbr.functions.db2.pas',
  cqlbr.functions.postgresql in '..\..\Source\Drivers\cqlbr.functions.postgresql.pas',
  cqlbr.select.interbase in '..\..\Source\Drivers\cqlbr.select.interbase.pas',
  cqlbr.qualifier.interbase in '..\..\Source\Drivers\cqlbr.qualifier.interbase.pas',
  cqlbr.serialize.interbase in '..\..\Source\Drivers\cqlbr.serialize.interbase.pas',
  cqlbr.select.db2 in '..\..\Source\Drivers\cqlbr.select.db2.pas',
  cqlbr.qualifier.db2 in '..\..\Source\Drivers\cqlbr.qualifier.db2.pas',
  cqlbr.serialize.db2 in '..\..\Source\Drivers\cqlbr.serialize.db2.pas',
  test.functions.mssql in 'test.functions.mssql.pas',
  cqlbr.section in '..\..\Source\Core\cqlbr.section.pas',
  cqlbr.name in '..\..\Source\Core\cqlbr.name.pas',
  cqlbr.namevalue in '..\..\Source\Core\cqlbr.namevalue.pas',
  test.select.mssql in 'test.select.mssql.pas';

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
