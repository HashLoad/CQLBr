unit test.operators.firebird;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestCQLOperators = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestWhereIsNull;
    [Test]
    procedure TestOrIsNull;
    [Test]
    procedure TestAndIsNull;

    [Test]
    procedure TestWhereIsNotNull;
    [Test]
    procedure TestOrIsNotNull;
    [Test]
    procedure TestAndIsNotNull;
   end;

implementation

uses
  SysUtils,
  cqlbr.interfaces,
  criteria.query.language;

procedure TTestCQLOperators.Setup;
begin

end;

procedure TTestCQLOperators.TearDown;
begin

end;

procedure TTestCQLOperators.TestAndIsNotNull;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (1 = 1) AND (NOME IS NOT NULL)';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('1 = 1')
                                 .&And('NOME').IsNotNull
                                 .AsString);
end;

procedure TTestCQLOperators.TestAndIsNull;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (1 = 1) AND (NOME IS NULL)';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('1 = 1')
                                 .&And('NOME').IsNull
                                 .AsString);
end;

procedure TTestCQLOperators.TestOrIsNotNull;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE ((1 = 1) OR (NOME IS NOT NULL))';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('1 = 1')
                                 .&Or('NOME').IsNotNull
                                 .AsString);
end;

procedure TTestCQLOperators.TestOrIsNull;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE ((1 = 1) OR (NOME IS NULL))';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('1 = 1')
                                 .&Or('NOME').IsNull
                                 .AsString);
end;

procedure TTestCQLOperators.TestWhereIsNotNull;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (NOME IS NOT NULL)';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('NOME').IsNotNull
                                 .AsString);
end;

procedure TTestCQLOperators.TestWhereIsNull;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (NOME IS NULL)';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('NOME').IsNull
                                 .AsString);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestCQLOperators);

end.
