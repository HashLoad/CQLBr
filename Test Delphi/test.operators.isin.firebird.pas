unit test.operators.isin.firebird;

interface
uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TTestCQLOperatorsIN = class(TObject)
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestInInteger;
    [Test]
    procedure TestInFloat;
    [Test]
    procedure TestInString;
    [Test]
    procedure TestInSubQuery;
    [Test]
    procedure TestNotInInteger;
    [Test]
    procedure TestNotInFloat;
    [Test]
    procedure TestNotInString;
    [Test]
    procedure TestNotInSubQuery;
  end;

implementation

uses
  SysUtils,
  cqlbr.interfaces,
  criteria.query.language;

procedure TTestCQLOperatorsIN.Setup;
begin
end;

procedure TTestCQLOperatorsIN.TearDown;
begin
end;


procedure TTestCQLOperatorsIN.TestInFloat;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR IN (1.5, 2.7, 3))';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').&In([1.5, 2.7, 3])
                                 .AsString);
end;

procedure TTestCQLOperatorsIN.TestInInteger;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR IN (1, 2, 3))';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').&In([1, 2, 3])
                                 .AsString);
end;

procedure TTestCQLOperatorsIN.TestInString;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR IN (''VALUE.1'', ''VALUE,2'', ''VALUE3''))';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').&In(['VALUE.1', 'VALUE,2', 'VALUE3'])
                                 .AsString);
end;

procedure TTestCQLOperatorsIN.TestInSubQuery;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (ID IN (SELECT IDCLIENTE FROM PEDIDOS))';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('ID').&In( TCQL.New(dbnFirebird)
                                                        .Select
                                                        .Column('IDCLIENTE')
                                                        .From('PEDIDOS').AsString)
                                 .AsString);
end;

procedure TTestCQLOperatorsIN.TestNotInFloat;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR NOT IN (1.5, 2.7, 3))';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').NotIn([1.5, 2.7, 3])
                                 .AsString);
end;

procedure TTestCQLOperatorsIN.TestNotInInteger;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR NOT IN (1, 2, 3))';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').NotIn([1, 2, 3])
                                 .AsString);
end;

procedure TTestCQLOperatorsIN.TestNotInString;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR NOT IN (''VALUE.1'', ''VALUE,2'', ''VALUE3''))';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').NotIn(['VALUE.1', 'VALUE,2', 'VALUE3'])
                                 .AsString);
end;

procedure TTestCQLOperatorsIN.TestNotInSubQuery;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (ID NOT IN (SELECT IDCLIENTE FROM PEDIDOS))';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('ID').NotIn( TCQL.New(dbnFirebird)
                                                        .Select
                                                        .Column('IDCLIENTE')
                                                        .From('PEDIDOS').AsString)
                                 .AsString);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestCQLOperatorsIN);
end.
