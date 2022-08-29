unit test.update.firebird;

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
  LDate: TDate;
  LDateTime: TDateTime;
begin
  LAsString := 'UPDATE CLIENTES SET ID_CLIENTE = ''1'', NOME_CLIENTE = ''MyName'', DATA_CADASTRO = ''12/31/2021'', DATA_ALTERACAO = ''12/31/2021 23:59:59''';
  LDate := EncodeDate(2021, 12, 31);
  LDateTime := EncodeDate(2021, 12, 31)+EncodeTime(23, 59, 59, 0);
  Assert.AreEqual(LAsString, TCQL.New(dbnFirebird)
                                      .Update('CLIENTES')
                                      .&Set('ID_CLIENTE', '1')
                                      .&Set('NOME_CLIENTE', 'MyName')
                                      .&Set('DATA_CADASTRO', LDate)
                                      .&Set('DATA_ALTERACAO', LDateTime)
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
