unit test.functions.mssql;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestCQLFunctionsMSSQL = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestCount;
    [Test]
    procedure TestLower;
    [Test]
    procedure TestUpper;
    [Test]
    procedure TestMax;
    [Test]
    procedure TestMin;
    [Test]
    procedure TestSubstring;
    [Test]
    procedure TestMonthWhere;
    [Test]
    procedure TestMonthSelect;
    [Test]
    procedure TestDayWhere;
    [Test]
    procedure TestDaySelect;
    [Test]
    procedure TestYearWhere;
    [Test]
    procedure TestYearSelect;
    [Test]
    procedure TestDate;
    [Test]
    procedure TestConcatSelect;
    [Test]
    procedure TestConcatWhere;
   end;

implementation

uses
  SysUtils,
  cqlbr.interfaces,
  criteria.query.language;

procedure TTestCQLFunctionsMSSQL.Setup;
begin

end;

procedure TTestCQLFunctionsMSSQL.TearDown;
begin

end;

procedure TTestCQLFunctionsMSSQL.TestUpper;
var
  LAsString: String;
begin
  LAsString := 'SELECT UPPER(NOME_CLIENTE) AS NOME FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMSSQL)
                                      .Select
                                      .Column('NOME_CLIENTE').Upper
                                      .&As('NOME')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMSSQL.TestYearSelect;
var
  LAsString: String;
begin
  LAsString := 'SELECT YEAR(NASCTO) FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMSSQL)
                                      .Select
                                      .Column.Year('NASCTO')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMSSQL.TestYearWhere;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (YEAR(NASCTO) = 9)';
  Assert.AreEqual(LAsString, TCQL.New(dbnMSSQL)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .Where.Year('NASCTO').Equal('9')
                                      .AsString);
end;

procedure TTestCQLFunctionsMSSQL.TestMin;
var
  LAsString: String;
begin
  LAsString := 'SELECT MIN(ID_CLIENTE) AS IDCOUNT FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMSSQL)
                                      .Select
                                      .Column('ID_CLIENTE').Min
                                      .&As('IDCOUNT')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMSSQL.TestMonthWhere;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (MONTH(NASCTO) = 9)';
  Assert.AreEqual(LAsString, TCQL.New(dbnMSSQL)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .Where.Month('NASCTO').Equal('9')
                                      .AsString);
end;

procedure TTestCQLFunctionsMSSQL.TestMonthSelect;
var
  LAsString: String;
begin
  LAsString := 'SELECT MONTH(NASCTO) FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMSSQL)
                                      .Select
                                      .Column.Month('NASCTO')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMSSQL.TestSubstring;
var
  LAsString: String;
begin
  LAsString := 'SELECT SUBSTRING(NOME_CLIENTE, 1, 2) AS NOME FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMSSQL)
                                      .Select
                                      .Column('NOME_CLIENTE').Substring(1, 2)
                                      .&As('NOME')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMSSQL.TestLower;
var
  LAsString: String;
begin
  LAsString := 'SELECT LOWER(NOME_CLIENTE) AS NOME FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMSSQL)
                                      .Select
                                      .Column('NOME_CLIENTE').Lower
                                      .&As('NOME')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMSSQL.TestMax;
var
  LAsString: String;
begin
  LAsString := 'SELECT MAX(ID_CLIENTE) AS IDCOUNT FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMSSQL)
                                      .Select
                                      .Column('ID_CLIENTE').Max
                                      .&As('IDCOUNT')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMSSQL.TestConcatSelect;
var
  LAsString: String;
begin
  LAsString := 'SELECT CONCAT(''-'', NOME) FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMSSQL)
                                 .Select
                                 .Column.Concat(['''-''', 'NOME'])
                                 .From('CLIENTES')
                                 .AsString);
end;

procedure TTestCQLFunctionsMSSQL.TestConcatWhere;
var
  LAsString: String;
begin
  LAsString := 'SELECT CONCAT(''-'', NOME) FROM CLIENTES WHERE (CONCAT(''-'', NOME) = ''-NOME'')';
  Assert.AreEqual(LAsString, TCQL.New(dbnMSSQL)
                                 .Select
                                 .Column.Concat(['''-''', 'NOME'])
                                 .From('CLIENTES')
                                 .Where.Concat(['''-''', 'NOME']).Equal('''-NOME''')
                                 .AsString);
end;

procedure TTestCQLFunctionsMSSQL.TestCount;
var
  LAsString: String;
begin
  LAsString := 'SELECT COUNT(ID_CLIENTE) AS IDCOUNT FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMSSQL)
                                      .Select
                                      .Column('ID_CLIENTE').Count
                                      .&As('IDCOUNT')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMSSQL.TestDate;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE NASCTO = ''02/11/2020''';
  Assert.AreEqual(LAsString, TCQL.New(dbnMSSQL)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where.Date('NASCTO').Equal.Date('''02/11/2020''')
                                 .AsString);
end;

procedure TTestCQLFunctionsMSSQL.TestDaySelect;
var
  LAsString: String;
begin
  LAsString := 'SELECT DAY(NASCTO) FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMSSQL)
                                      .Select
                                      .Column.Day('NASCTO')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMSSQL.TestDayWhere;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (DAY(NASCTO) = 9)';
  Assert.AreEqual(LAsString, TCQL.New(dbnMSSQL)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .Where.Day('NASCTO').Equal('9')
                                      .AsString);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestCQLFunctionsMSSQL);

end.
