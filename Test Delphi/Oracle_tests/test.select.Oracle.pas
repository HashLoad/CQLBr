unit test.select.Oracle;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestCQLSelectOracle = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestSelectAll;
    [Test]
    procedure TestSelectAllWhere;
    [Test]
    procedure TestSelectAllWhereAndOr;
    [Test]
    procedure TestSelectAllWhereAndAnd;
    [Test]
    procedure TestSelectAllOrderBy;
    [Test]
    procedure TestSelectColumns;
    [Test]
    procedure TestSelectColumnsCase;
    [Test]
    procedure TestSelectPagingOracle;
  end;

implementation

uses
  SysUtils,
  cqlbr.interfaces,
  criteria.query.language;

procedure TTestCQLSelectOracle.Setup;
begin
end;

procedure TTestCQLSelectOracle.TearDown;
begin
end;

procedure TTestCQLSelectOracle.TestSelectAll;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES AS CLI';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .All
                                      .From('CLIENTES').&As('CLI')
                                      .AsString);
end;

procedure TTestCQLSelectOracle.TestSelectAllOrderBy;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES ORDER BY ID_CLIENTE';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .OrderBy('ID_CLIENTE')
                                      .AsString);
end;

procedure TTestCQLSelectOracle.TestSelectAllWhere;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE ID_CLIENTE = 1';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .Where('ID_CLIENTE = 1')
                                      .AsString);
end;

procedure TTestCQLSelectOracle.TestSelectAllWhereAndAnd;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (ID_CLIENTE = 1) AND (ID >= 10) AND (ID <= 20)';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .Where('ID_CLIENTE = 1')
                                      .&And('ID').GreaterEqThan(10)
                                      .&And('ID').LessEqThan(20)
                                      .AsString);
end;

procedure TTestCQLSelectOracle.TestSelectAllWhereAndOr;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (ID_CLIENTE = 1) AND ((ID >= 10) OR (ID <= 20))';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .Where('ID_CLIENTE = 1')
                                      .&And('ID').GreaterEqThan(10)
                                      .&Or('ID').LessEqThan(20)
                                      .AsString);
end;

procedure TTestCQLSelectOracle.TestSelectColumns;
var
  LAsString: String;
begin
  LAsString := 'SELECT ID_CLIENTE, NOME_CLIENTE FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .Column('ID_CLIENTE')
                                      .Column('NOME_CLIENTE')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLSelectOracle.TestSelectColumnsCase;
var
  LAsString: String;
begin
  LAsString := 'SELECT ID_CLIENTE, NOME_CLIENTE, (CASE TIPO_CLIENTE WHEN 0 THEN ''FISICA'' WHEN 1 THEN ''JURIDICA'' ELSE ''PRODUTOR'' END) AS TIPO_PESSOA FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .Column('ID_CLIENTE')
                                      .Column('NOME_CLIENTE')
                                      .Column('TIPO_CLIENTE')
                                      .&Case
                                        .When('0').&Then(CQL.Q('FISICA'))
                                        .When('1').&Then(CQL.Q('JURIDICA'))
                                                  .&Else('''PRODUTOR''')
                                      .&End
                                      .&As('TIPO_PESSOA')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLSelectOracle.TestSelectPagingOracle;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM (SELECT T.*, ROWNUM AS ROWINI FROM (SELECT * FROM CLIENTES ORDER BY ID_CLIENTE) T) WHERE ROWNUM <= 3 AND ROWINI > 0';
  Assert.AreEqual(LAsString, TCQL.New(dbnOracle)
                                      .Select
                                      .All
                                      .Limit(3).Offset(0)
                                      .From('CLIENTES')
                                      .OrderBy('ID_CLIENTE')
                                      .AsString);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestCQLSelectOracle);

end.
