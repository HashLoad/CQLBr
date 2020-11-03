unit test.operators.less.firebird;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestCQLOperatorsLess = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestLessThanFloat;
    [Test]
    procedure TestLessThanInteger;
    [Test]
    procedure TestLessEqualThanFloat;
    [Test]
    procedure TestLessEqualThanInteger;
   end;

implementation

uses
  SysUtils,
  cqlbr.interfaces,
  criteria.query.language;

procedure TTestCQLOperatorsLess.Setup;
begin

end;

procedure TTestCQLOperatorsLess.TearDown;
begin

end;

procedure TTestCQLOperatorsLess.TestLessEqualThanFloat;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR <= 10.9)';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').LessEqThan(10.9)
                                 .AsString);
end;

procedure TTestCQLOperatorsLess.TestLessEqualThanInteger;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR <= 10)';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').LessEqThan(10)
                                 .AsString);
end;

procedure TTestCQLOperatorsLess.TestLessThanFloat;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR < 10.9)';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').LessThan(10.9)
                                 .AsString);
end;

procedure TTestCQLOperatorsLess.TestLessThanInteger;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (VALOR < 10)';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('VALOR').LessThan(10)
                                 .AsString);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestCQLOperatorsLess);

end.
