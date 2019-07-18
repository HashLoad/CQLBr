unit test.select;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry;

type

  { TTestCQLBrSelect }

  TTestCQLBrSelect= class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestSelectAll;
    procedure TestSelectAllWhere;
    procedure TestSelectAllOrderBy;
    procedure TestSelectColumns;
    procedure TestSelectColumnsCase;
    procedure TestSelectPagingFirebird;
    procedure TestSelectPagingOracle;
    procedure TestSelectPagingMySQL;
  end;

implementation

uses
  cqlbr.interfaces,
  cqlbr.select.firebird,
  cqlbr.select.oracle,
  cqlbr.select.mysql,
  cqlbr.serialize.firebird,
  cqlbr.serialize.oracle,
  cqlbr.serialize.mysql,
  criteria.query.language;

procedure TTestCQLBrSelect.TestSelectAll;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES';
  AssertEquals(LAsString, TCriteria.New(dbnFirebird)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLBrSelect.TestSelectAllWhere;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE ID_CLIENTE = 1';
  AssertEquals(LAsString, TCriteria.New(dbnFirebird)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .Where('ID_CLIENTE = 1')
                                      .AsString);
end;

procedure TTestCQLBrSelect.TestSelectAllOrderBy;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES ORDER BY ID_CLIENTE';
  AssertEquals(LAsString, TCriteria.New(dbnFirebird)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .OrderBy('ID_CLIENTE')
                                      .AsString);
end;

procedure TTestCQLBrSelect.TestSelectColumns;
var
  LAsString: String;
begin
  LAsString := 'SELECT ID_CLIENTE, NOME_CLIENTE FROM CLIENTES';
  AssertEquals(LAsString, TCriteria.New(dbnFirebird)
                                      .Select
                                      .Column('ID_CLIENTE')
                                      .Column('NOME_CLIENTE')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLBrSelect.TestSelectColumnsCase;
var
LAsString: String;
begin
LAsString := 'SELECT ID_CLIENTE, NOME_CLIENTE, (CASE TIPO_CLIENTE WHEN 0 THEN ''FISICA'' WHEN 1 THEN ''JURIDICA'' ELSE ''PRODUTOR'' END) AS TIPO_PESSOA FROM CLIENTES';
AssertEquals(LAsString, TCriteria.New(dbnFirebird)
                                    .Select
                                    .Column('ID_CLIENTE')
                                    .Column('NOME_CLIENTE')
                                    .Column('TIPO_CLIENTE')
                                    .&Case
                                      .When('0').&Then('''FISICA''')
                                      .When('1').&Then('''JURIDICA''')
                                                .&Else('''PRODUTOR''')
                                    .&End
                                    .&As('TIPO_PESSOA')
                                    .From('CLIENTES')
                                    .AsString);
end;

procedure TTestCQLBrSelect.TestSelectPagingFirebird;
var
  LAsString: String;
begin
  LAsString := 'SELECT FIRST 3 SKIP 0 * FROM CLIENTES ORDER BY ID_CLIENTE';
  AssertEquals(LAsString, TCriteria.New(dbnFirebird)
                                      .Select
                                      .All
                                      .First(3).Skip(0)
                                      .From('CLIENTES')
                                      .OrderBy('ID_CLIENTE')
                                      .AsString);
end;

procedure TTestCQLBrSelect.TestSelectPagingOracle;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM (SELECT T.*, ROWNUM AS ROWINI FROM (SELECT * FROM CLIENTES ORDER BY ID_CLIENTE) T) WHERE ROWNUM <= 3 AND ROWINI > 0';
  AssertEquals(LAsString, TCriteria.New(dbnOracle)
                                      .Select
                                      .All
                                      .Limit(3).Offset(0)
                                      .From('CLIENTES')
                                      .OrderBy('ID_CLIENTE')
                                      .AsString);
end;

procedure TTestCQLBrSelect.TestSelectPagingMySQL;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES ORDER BY ID_CLIENTE LIMIT 3 OFFSET 0';
  AssertEquals(LAsString, TCriteria.New(dbnMySQL)
                                      .Select
                                      .All
                                      .Limit(3).Offset(0)
                                      .From('CLIENTES')
                                      .OrderBy('ID_CLIENTE')
                                      .AsString);
end;

procedure TTestCQLBrSelect.SetUp;
begin

end;

procedure TTestCQLBrSelect.TearDown;
begin

end;

initialization

  RegisterTest(TTestCQLBrSelect);
end.

