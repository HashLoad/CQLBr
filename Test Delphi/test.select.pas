unit test.select;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestCriteriaQueryLanguage = class
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
    procedure TestSelectAllOrderBy;
    [Test]
    procedure TestSelectColumns;
    [Test]
    procedure TestSelectColumnsCase;
    [Test]
    procedure TestSelectPagingFirebird;
    [Test]
    procedure TestSelectPagingOracle;
    [Test]
    procedure TestSelectPagingMySQL;
//    [Test]
//    [TestCase('TestA','1,2')]
//    [TestCase('TestB','3,4')]
    procedure Test2(const AValue1 : Integer;const AValue2 : Integer);
  end;

implementation

uses
  SysUtils,
  cqlbr.interfaces,
  criteria.query.language;

procedure TTestCriteriaQueryLanguage.Setup;
begin
end;

procedure TTestCriteriaQueryLanguage.TearDown;
begin
end;

procedure TTestCriteriaQueryLanguage.TestSelectAll;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES';
  Assert.AreEqual(LAsString, TCriteria.New(dbnFirebird)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCriteriaQueryLanguage.TestSelectAllOrderBy;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES ORDER BY ID_CLIENTE';
  Assert.AreEqual(LAsString, TCriteria.New(dbnFirebird)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .OrderBy('ID_CLIENTE')
                                      .AsString);
end;

procedure TTestCriteriaQueryLanguage.TestSelectAllWhere;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE ID_CLIENTE = 1';
  Assert.AreEqual(LAsString, TCriteria.New(dbnFirebird)
                                      .Select
                                      .All
                                      .From('CLIENTES')
                                      .Where('ID_CLIENTE = 1')
                                      .AsString);
end;

procedure TTestCriteriaQueryLanguage.TestSelectColumns;
var
  LAsString: String;
begin
  LAsString := 'SELECT ID_CLIENTE, NOME_CLIENTE FROM CLIENTES';
  Assert.AreEqual(LAsString, TCriteria.New(dbnFirebird)
                                      .Select
                                      .Column('ID_CLIENTE')
                                      .Column('NOME_CLIENTE')
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCriteriaQueryLanguage.TestSelectColumnsCase;
var
  LAsString: String;
begin
  LAsString := 'SELECT ID_CLIENTE, NOME_CLIENTE, (CASE TIPO_CLIENTE WHEN 0 THEN ''FISICA'' WHEN 1 THEN ''JURIDICA'' ELSE ''PRODUTOR'' END) AS TIPO_PESSOA FROM CLIENTES';
  Assert.AreEqual(LAsString, TCriteria.New(dbnFirebird)
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

procedure TTestCriteriaQueryLanguage.TestSelectPagingFirebird;
var
  LAsString: String;
begin
  LAsString := 'SELECT FIRST 3 SKIP 0 * FROM CLIENTES ORDER BY ID_CLIENTE';
  Assert.AreEqual(LAsString, TCriteria.New(dbnFirebird)
                                      .Select
                                      .All
                                      .First(3).Skip(0)
                                      .From('CLIENTES')
                                      .OrderBy('ID_CLIENTE')
                                      .AsString);
end;

procedure TTestCriteriaQueryLanguage.TestSelectPagingMySQL;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM CLIENTES ORDER BY ID_CLIENTE LIMIT 3 OFFSET 0';
  Assert.AreEqual(LAsString, TCriteria.New(dbnMySQL)
                                      .Select
                                      .All
                                      .Limit(3).Offset(0)
                                      .From('CLIENTES')
                                      .OrderBy('ID_CLIENTE')
                                      .AsString);
end;

procedure TTestCriteriaQueryLanguage.TestSelectPagingOracle;
var
  LAsString: String;
begin
  LAsString := 'SELECT * FROM (SELECT T.*, ROWNUM AS ROWINI FROM (SELECT * FROM CLIENTES ORDER BY ID_CLIENTE) T) WHERE ROWNUM <= 3 AND ROWINI > 0';
  Assert.AreEqual(LAsString, TCriteria.New(dbnOracle)
                                      .Select
                                      .All
                                      .Limit(3).Offset(0)
                                      .From('CLIENTES')
                                      .OrderBy('ID_CLIENTE')
                                      .AsString);
end;

procedure TTestCriteriaQueryLanguage.Test2(const AValue1 : Integer;const AValue2 : Integer);
begin

end;

initialization
  TDUnitX.RegisterTestFixture(TTestCriteriaQueryLanguage);

end.
