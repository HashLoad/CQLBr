unit test.insert.firebird;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestCQLInsert = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestInsertFirebird;
  end;

implementation

uses
  SysUtils,
  cqlbr.interfaces,
  criteria.query.language;

procedure TTestCQLInsert.Setup;
begin

end;

procedure TTestCQLInsert.TearDown;
begin

end;

procedure TTestCQLInsert.TestInsertFirebird;
var
  LAsString: String;
begin
  LAsString := 'INSERT INTO CLIENTES (ID_CLIENTE, NOME_CLIENTE) VALUES (1, ''MyName'')';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                      .Insert
                                      .Into('CLIENTES')
                                      .&Set('ID_CLIENTE', 1)
                                      .&Set('NOME_CLIENTE', 'MyName')
                                      .AsString);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestCQLInsert);

end.
