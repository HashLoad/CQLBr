unit test.functions.oracle;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestCQLFunctionsOracle = class
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

procedure TTestCQLFunctionsOracle.Setup;
begin

end;

procedure TTestCQLFunctionsOracle.TearDown;
begin

end;

procedure TTestCQLFunctionsOracle.TestUpper;
var
  LAsString: String;
begin
  LAsString := 'SELECT UPPER(NOME_CLIENTE) AS NOME FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .Column('NOME_CLIENTE').Upper
                                      .&As('NOME')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsOracle.TestYearSelect;
var
  LAsString: String;
begin
  LAsString := 'SELECT EXTRACT(YEAR FROM NASCTO) FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .Column.Year('NASCTO')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsOracle.TestYearWhere;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (EXTRACT(YEAR FROM NASCTO) = 9)';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .Where.Year('NASCTO').Equal('9')
                                      .AsString);
end;

procedure TTestCQLFunctionsOracle.TestMin;
var
  LAsString: String;
begin
  LAsString := 'SELECT MIN(ID_CLIENTE) AS IDCOUNT FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .Column('ID_CLIENTE').Min
                                      .&As('IDCOUNT')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsOracle.TestMonthWhere;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (EXTRACT(MONTH FROM NASCTO) = 9)';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .Where.Month('NASCTO').Equal('9')
                                      .AsString);
end;

procedure TTestCQLFunctionsOracle.TestMonthSelect;
var
  LAsString: String;
begin
  LAsString := 'SELECT EXTRACT(MONTH FROM NASCTO) FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .Column.Month('NASCTO')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsOracle.TestSubstring;
var
  LAsString: String;
begin
  LAsString := 'SELECT SUBSTR(NOME_CLIENTE, 1, 2) AS NOME FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .Column('NOME_CLIENTE').Substring(1, 2)
                                      .&As('NOME')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsOracle.TestLower;
var
  LAsString: String;
begin
  LAsString := 'SELECT LOWER(NOME_CLIENTE) AS NOME FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .Column('NOME_CLIENTE').Lower
                                      .&As('NOME')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsOracle.TestMax;
var
  LAsString: String;
begin
  LAsString := 'SELECT MAX(ID_CLIENTE) AS IDCOUNT FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .Column('ID_CLIENTE').Max
                                      .&As('IDCOUNT')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsOracle.TestConcatSelect;
var
  LAsString: String;
begin
  LAsString := 'SELECT ''-'' || NOME FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                 .Select
                                 .Column.Concat(['''-''', 'NOME'])
                                 .From('CLIENTES')
                                 .AsString);
end;

procedure TTestCQLFunctionsOracle.TestConcatWhere;
var
  LAsString: String;
begin
  LAsString := 'SELECT ''-'' || NOME FROM CLIENTES WHERE (''-'' || NOME = ''-NOME'')';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                 .Select
                                 .Column.Concat(['''-''','NOME'])
                                 .From('CLIENTES')
                                 .Where.Concat(['''-''', 'NOME']).Equal('''-NOME''')
                                 .AsString);
end;

procedure TTestCQLFunctionsOracle.TestCount;
var
  LAsString: String;
begin
  LAsString := 'SELECT COUNT(ID_CLIENTE) AS IDCOUNT FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .Column('ID_CLIENTE').Count
                                      .&As('IDCOUNT')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsOracle.TestDate;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE TO_DATE(NASCTO, ''dd/MM/yyyy'') = TO_DATE(''02/11/2020'', ''dd/MM/yyyy'')';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where.Date('NASCTO').Equal.Date('''02/11/2020''')
                                 .AsString);
end;

procedure TTestCQLFunctionsOracle.TestDaySelect;
var
  LAsString: String;
begin
  LAsString := 'SELECT EXTRACT(DAY FROM NASCTO) FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .Column.Day('NASCTO')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLFunctionsOracle.TestDayWhere;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (EXTRACT(DAY FROM NASCTO) = 9)';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .Where.Day('NASCTO').Equal('9')
                                      .AsString);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestCQLFunctionsOracle);

end.
