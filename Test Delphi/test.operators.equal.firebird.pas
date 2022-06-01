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
    procedure TestEqualDateField;
    [Test]
    procedure TestEqualDateTimeField;
    [Test]
    procedure TestNotEqualIntegerField;
    [Test]
    procedure TestNotEqualFloatField;
    [Test]
    procedure TestNotEqualStringField;
    [Test]
    procedure TestNotEqualDateField;
    [Test]
    procedure TestNotEqualDateTimeField;
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


procedure TTestCQLOperatorsEqual.TestEqualDateField;
var
  LAsString : string;
  LDate: TDate;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (DATA_CADASTRO = ''12/31/2021'')';
  LDate := EncodeDate(2021, 12, 31);
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('DATA_CADASTRO').Equal(LDate)
                                 .AsString);
end;

procedure TTestCQLOperatorsEqual.TestEqualDateTimeField;
var
  LAsString : string;
  LDateTime: TDateTime;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (DATA_CADASTRO = ''12/31/2021 23:59:59'')';
  LDateTime := EncodeDate(2021, 12, 31)+EncodeTime(23, 59, 59, 0);
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('DATA_CADASTRO').Equal(LDateTime)
                                 .AsString);
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

procedure TTestCQLOperatorsEqual.TestNotEqualDateField;
var
  LAsString : string;
  LDate: TDate;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (DATA_CADASTRO <> ''12/31/2021'')';
  LDate := EncodeDate(2021, 12, 31);
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('DATA_CADASTRO').NotEqual(LDate)
                                 .AsString);
end;

procedure TTestCQLOperatorsEqual.TestNotEqualDateTimeField;
var
  LAsString : string;
  LDateTime: TDateTime;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (DATA_CADASTRO <> ''12/31/2021 23:59:59'')';
  LDateTime := EncodeDate(2021, 12, 31)+EncodeTime(23, 59, 59, 0);
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('DATA_CADASTRO').NotEqual(LDateTime)
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
