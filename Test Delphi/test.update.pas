unit test.update;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestCQLUpdate = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestUpdateFirebird;
    [Test]
    procedure TestUpdateWhereFirebird;
  end;

implementation

uses
  SysUtils,
  cqlbr.interfaces,
  criteria.query.language;

procedure TTestCQLUpdate.Setup;
begin

end;

procedure TTestCQLUpdate.TearDown;
begin

end;

procedure TTestCQLUpdate.TestUpdateFirebird;
var
  LAsString: String;
begin
  LAsString := 'UPDATE CLIENTES SET ID_CLIENTE = ''1'', NOME_CLIENTE = ''MyName''';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                      .Update('CLIENTES')
                                      .&Set('ID_CLIENTE', '1')
                                      .&Set('NOME_CLIENTE', 'MyName')
                                      .AsString);
end;

procedure TTestCQLUpdate.TestUpdateWhereFirebird;
var
  LAsString: String;
begin
  LAsString := 'UPDATE CLIENTES SET ID_CLIENTE = 1, NOME_CLIENTE = ''MyName'' WHERE ID_CLIENTE = 1';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                      .Update('CLIENTES')
                                      .&Set('ID_CLIENTE', 1)
                                      .&Set('NOME_CLIENTE', 'MyName')
                                      .Where('ID_CLIENTE = 1')
                                      .AsString);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestCQLUpdate);

end.
