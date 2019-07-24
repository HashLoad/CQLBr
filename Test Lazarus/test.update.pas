unit test.update;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry;

type

  { TTestCQLBrInsert }

  { TTestCQLBrUpdate }

  TTestCQLBrUpdate= class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestUpdateFirebird;
    procedure TestUpdateWhereFirebird;
  end;

implementation

uses
  cqlbr.interfaces,
  criteria.query.language;

procedure TTestCQLBrUpdate.SetUp;
begin

end;

procedure TTestCQLBrUpdate.TearDown;
begin

end;

procedure TTestCQLBrUpdate.TestUpdateFirebird;
var
  LAsString: String;
begin
  LAsString := 'UPDATE CLIENTES SET ID_CLIENTE = ''1'', NOME_CLIENTE = ''MyName''';
  AssertEquals(LAsString, TCQL.New(dbnFirebird)
                                      .Update('CLIENTES')
                                      .&Set('ID_CLIENTE', '1')
                                      .&Set('NOME_CLIENTE', 'MyName')
                                      .AsString);
end;

procedure TTestCQLBrUpdate.TestUpdateWhereFirebird;
var
  LAsString: String;
begin
  LAsString := 'UPDATE CLIENTES SET ID_CLIENTE = ''1'', NOME_CLIENTE = ''MyName'' WHERE ID_CLIENTE = 1';
  AssertEquals(LAsString, TCQL.New(dbnFirebird)
                                      .Update('CLIENTES')
                                      .&Set('ID_CLIENTE', '1')
                                      .&Set('NOME_CLIENTE', 'MyName')
                                      .Where('ID_CLIENTE = 1')
                                      .AsString);
end;

initialization

  RegisterTest(TTestCQLBrUpdate);
end.
