program TestCQLBr;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, GuiTestRunner, test.select, test.insert, test.update,
  test.delete, test.operators, test.operators.like, cqlbr.functions.abstract,
  cqlbr.name, cqlbr.namevalue, cqlbr.register, cqlbr.section,
  cqlbr.functions.db2, cqlbr.functions.firebird, cqlbr.functions.interbase,
  cqlbr.functions.mssql, cqlbr.functions.mysql, cqlbr.functions.oracle,
  cqlbr.functions.postgresql, cqlbr.functions.sqlite, cqlbr.qualifier.db2,
  cqlbr.qualifier.firebird, cqlbr.qualifier.interbase, cqlbr.qualifier.mongodb,
  cqlbr.qualifier.mssql, cqlbr.qualifier.mysql, cqlbr.qualifier.oracle,
  cqlbr.qualifier.sqlite, cqlbr.select.db2, cqlbr.select.firebird,
  cqlbr.select.interbase, cqlbr.select.mongodb, cqlbr.select.mssql,
  cqlbr.select.mysql, cqlbr.select.oracle, cqlbr.select.sqlite,
  cqlbr.serialize.db2, cqlbr.serialize.firebird, cqlbr.serialize.interbase,
  cqlbr.serialize.mongodb, cqlbr.serialize.mssql, cqlbr.serialize.mysql,
  cqlbr.serialize.oracle, cqlbr.serialize.sqlite;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

