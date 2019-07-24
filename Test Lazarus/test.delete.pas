unit test.delete;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry;

type

  { TTestCQLBrDelete }

  TTestCQLBrDelete= class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestDeleteFirebird;
    procedure TestDeleteWhereFirebird;
  end;

implementation

uses
  cqlbr.interfaces,
  criteria.query.language;

procedure TTestCQLBrDelete.SetUp;
begin

end;

procedure TTestCQLBrDelete.TearDown;
begin

end;

procedure TTestCQLBrDelete.TestDeleteFirebird;
var
  LAsString: String;
begin
  LAsString := 'DELETE FROM CLIENTES';
  AssertEquals(LAsString, TCQL.New(dbnFirebird)
                                      .Delete
                                      .From('CLIENTES')
                                      .AsString);
end;

procedure TTestCQLBrDelete.TestDeleteWhereFirebird;
var
  LAsString: String;
begin
  LAsString := 'DELETE FROM CLIENTES WHERE ID_CLIENTE = 1';
  AssertEquals(LAsString, TCQL.New(dbnFirebird)
                                      .Delete
                                      .From('CLIENTES')
                                      .Where('ID_CLIENTE = 1')
                                      .AsString);
end;

initialization

  RegisterTest(TTestCQLBrDelete);
end.
