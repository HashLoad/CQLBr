unit test.operators.equal.firebird;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestCQLOperatorsEqual = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestEqualIntegerField;
    [Test]
    procedure TestEqualFloatField;
    [Test]
    procedure TestEqualStringField;
    [Test]
    procedure TestNotEqualIntegerField;
    [Test]
    procedure TestNotEqualFloatField;
    [Test]
    procedure TestNotEqualStringField;
   end;

implementation

uses
  SysUtils,
  cqlbr.interfaces,
  criteria.query.language;

procedure TTestCQLOperatorsEqual.Setup;
begin

end;

procedure TTestCQLOperatorsEqual.TearDown;
begin

end;


procedure TTestCQLOperatorsEqual.TestEqualFloatField;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR = 10.9)';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').Equal(10.9)
                                 .AsString);
end;

procedure TTestCQLOperatorsEqual.TestEqualIntegerField;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR = 10)';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').Equal(10)
                                 .AsString);
end;

procedure TTestCQLOperatorsEqual.TestEqualStringField;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (NOME = ''VALUE'')';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('NOME').Equal('''VALUE''')
                                 .AsString);
end;

procedure TTestCQLOperatorsEqual.TestNotEqualFloatField;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR <> 10.9)';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').NotEqual(10.9)
                                 .AsString);
end;

procedure TTestCQLOperatorsEqual.TestNotEqualIntegerField;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR <> 10)';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').NotEqual(10)
                                 .AsString);
end;

procedure TTestCQLOperatorsEqual.TestNotEqualStringField;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (NOME <> ''VALUE'')';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('NOME').NotEqual('''VALUE''')
                                 .AsString);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestCQLOperatorsEqual);

end.
