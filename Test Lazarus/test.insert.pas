unit test.insert;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry;

type

  { TTestCQLBrInsert }

  TTestCQLBrInsert= class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestInsertFirebird;
  end;

implementation

uses
  cqlbr.interfaces,
  criteria.query.language;

procedure TTestCQLBrInsert.SetUp;
begin

end;

procedure TTestCQLBrInsert.TearDown;
begin

end;

procedure TTestCQLBrInsert.TestInsertFirebird;
var
  LAsString: String;
begin
  LAsString := 'INSERT INTO CLIENTES (ID_CLIENTE, NOME_CLIENTE) VALUES (''1'', ''MyName'')';
  AssertEquals(LAsString, TCQL.New(dbnFirebird)
                                      .Insert
                                      .Into('CLIENTES')
                                      .&Set('ID_CLIENTE', '1')
                                      .&Set('NOME_CLIENTE', 'MyName')
                                      .AsString);
end;

initialization

  RegisterTest(TTestCQLBrInsert);
end.
