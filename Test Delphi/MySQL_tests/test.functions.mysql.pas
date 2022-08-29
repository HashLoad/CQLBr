unit test.functions.mysql;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestCQLFunctionsMySQL = class
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

procedure TTestCQLFunctionsMySQL.Setup;
begin

end;

procedure TTestCQLFunctionsMySQL.TearDown;
begin

end;

procedure TTestCQLFunctionsMySQL.TestUpper;
var
  LAsString: String;
begin
  LAsString := 'SELECT UPPER(NOME_CLIENTE) AS NOME FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMySQL)
                                      .Select
                                      .Column('NOME_CLIENTE').Upper
                                      .&As('NOME')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMySQL.TestYearSelect;
var
  LAsString: String;
begin
  LAsString := 'SELECT YEAR(NASCTO) FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMySQL)
                                      .Select
                                      .Column.Year('NASCTO')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMySQL.TestYearWhere;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (YEAR(NASCTO) = 9)';
  Assert.AreEqual(LAsString, TCQL.New(dbnMySQL)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .Where.Year('NASCTO').Equal('9')
                                      .AsString);
end;

procedure TTestCQLFunctionsMySQL.TestMin;
var
  LAsString: String;
begin
  LAsString := 'SELECT MIN(ID_CLIENTE) AS IDCOUNT FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMySQL)
                                      .Select
                                      .Column('ID_CLIENTE').Min
                                      .&As('IDCOUNT')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMySQL.TestMonthWhere;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (MONTH(NASCTO) = 9)';
  Assert.AreEqual(LAsString, TCQL.New(dbnMySQL)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .Where.Month('NASCTO').Equal('9')
                                      .AsString);
end;

procedure TTestCQLFunctionsMySQL.TestMonthSelect;
var
  LAsString: String;
begin
  LAsString := 'SELECT MONTH(NASCTO) FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMySQL)
                                      .Select
                                      .Column.Month('NASCTO')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMySQL.TestSubstring;
var
  LAsString: String;
begin
  LAsString := 'SELECT SUBSTRING(NOME_CLIENTE, 1, 2) AS NOME FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMySQL)
                                      .Select
                                      .Column('NOME_CLIENTE').Substring(1, 2)
                                      .&As('NOME')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMySQL.TestLower;
var
  LAsString: String;
begin
  LAsString := 'SELECT LOWER(NOME_CLIENTE) AS NOME FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMySQL)
                                      .Select
                                      .Column('NOME_CLIENTE').Lower
                                      .&As('NOME')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMySQL.TestMax;
var
  LAsString: String;
begin
  LAsString := 'SELECT MAX(ID_CLIENTE) AS IDCOUNT FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMySQL)
                                      .Select
                                      .Column('ID_CLIENTE').Max
                                      .&As('IDCOUNT')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMySQL.TestConcatSelect;
var
  LAsString: String;
begin
  LAsString := 'SELECT CONCAT(''-'', NOME) FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMySQL)
                                 .Select
                                 .Column.Concat(['''-''', 'NOME'])
                                 .From('CLIENTES')
                                 .AsString);
end;

procedure TTestCQLFunctionsMySQL.TestConcatWhere;
var
  LAsString: String;
begin
  LAsString := 'SELECT CONCAT(''-'', NOME) FROM CLIENTES WHERE (CONCAT(''-'', NOME) = ''-NOME'')';
  Assert.AreEqual(LAsString, TCQL.New(dbnMySQL)
                                 .Select
                                 .Column.Concat(['''-''', 'NOME'])
                                 .From('CLIENTES')
                                 .Where.Concat(['''-''', 'NOME']).Equal('''-NOME''')
                                 .AsString);
end;

procedure TTestCQLFunctionsMySQL.TestCount;
var
  LAsString: String;
begin
  LAsString := 'SELECT COUNT(ID_CLIENTE) AS IDCOUNT FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMySQL)
                                      .Select
                                      .Column('ID_CLIENTE').Count
                                      .&As('IDCOUNT')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMySQL.TestDate;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE DATE_FORMAT(NASCTO, ''yyyy-MM-dd'') = DATE_FORMAT(''2020/11/02'', ''yyyy-MM-dd'')';
  Assert.AreEqual(LAsString, TCQL.New(dbnMySQL)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where.Date('NASCTO')
                                 .Equal.Date('''2020/11/02''')
                                 .AsString);
end;

procedure TTestCQLFunctionsMySQL.TestDaySelect;
var
  LAsString: String;
begin
  LAsString := 'SELECT DAY(NASCTO) FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnMySQL)
                                      .Select
                                      .Column.Day('NASCTO')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsMySQL.TestDayWhere;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (DAY(NASCTO) = 9)';
  Assert.AreEqual(LAsString, TCQL.New(dbnMySQL)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .Where.Day('NASCTO').Equal('9')
                                      .AsString);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestCQLFunctionsMySQL);

end.
