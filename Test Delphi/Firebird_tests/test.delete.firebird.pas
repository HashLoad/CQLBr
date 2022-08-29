unit test.delete.firebird;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestCQLDelete = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestDeleteFirebird;
    [Test]
    procedure TestDeleteWhereFirebird;
  end;

implementation

uses
  SysUtils,
  cqlbr.interfaces,
  criteria.query.language;

procedure TTestCQLDelete.Setup;
begin

end;

procedure TTestCQLDelete.TearDown;
begin

end;

procedure TTestCQLDelete.TestDeleteFirebird;
var
  LAsString: String;
begin
  LAsString := 'DELETE FROM CLIENTES';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                      .Delete
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLDelete.TestDeleteWhereFirebird;
var
  LAsString: String;
begin
  LAsString := 'DELETE FROM CLIENTES WHERE ID_CLIENTE = 1';
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                      .Delete
                                      .From('CLIENTES')
                                      .Where('ID_CLIENTE = 1')
                                      .AsString);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestCQLDelete);

end.
