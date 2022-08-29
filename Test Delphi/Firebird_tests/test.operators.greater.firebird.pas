unit test.operators.greater.firebird;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestCQLOperatorsGreater = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestGreaterThanFloat;
    [Test]
    procedure TestGreaterThanInteger;
    [Test]
    procedure TestGreaterEqualThanFloat;
    [Test]
    procedure TestGreaterEqualThanInteger;
   end;

implementation

uses
  SysUtils,
  cqlbr.interfaces,
  criteria.query.language;

procedure TTestCQLOperatorsGreater.Setup;
begin

end;

procedure TTestCQLOperatorsGreater.TearDown;
begin

end;

procedure TTestCQLOperatorsGreater.TestGreaterEqualThanFloat;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR >= 10.9)';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').GreaterEqThan(10.9)
                                 .AsString);
end;

procedure TTestCQLOperatorsGreater.TestGreaterEqualThanInteger;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR >= 10)';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').GreaterEqThan(10)
                                 .AsString);
end;

procedure TTestCQLOperatorsGreater.TestGreaterThanFloat;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR > 10.9)';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').GreaterThan(10.9)
                                 .AsString);
end;

procedure TTestCQLOperatorsGreater.TestGreaterThanInteger;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR > 10)';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').GreaterThan(10)
                                 .AsString);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestCQLOperatorsGreater);

end.
