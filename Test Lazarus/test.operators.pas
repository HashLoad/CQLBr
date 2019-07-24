unit test.operators;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry;

type

  { TTestCQLBrInsert }

  { TTestCQLBrOperators }

  TTestCQLBrOperators= class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestWhereIsNull;
    procedure TestOrIsNull;
    procedure TestAndIsNull;

    procedure TestWhereIsNotNull;
    procedure TestOrIsNotNull;
    procedure TestAndIsNotNull;
  end;

implementation

uses
  cqlbr.interfaces,
  criteria.query.language;

procedure TTestCQLBrOperators.SetUp;
begin

end;

procedure TTestCQLBrOperators.TearDown;
begin

end;

procedure TTestCQLBrOperators.TestWhereIsNull;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (NOME IS NULL)';
  AssertEquals(LAsString, UpperCase(TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('NOME').IsNull
                                 .AsString));
end;

procedure TTestCQLBrOperators.TestOrIsNull;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE ((1 = 1) OR (NOME IS NULL))';
  AssertEquals(LAsString, UpperCase(TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('1 = 1')
                                 .&Or('NOME').IsNull
                                 .AsString));
end;

procedure TTestCQLBrOperators.TestAndIsNull;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (1 = 1) AND (NOME IS NULL)';
  AssertEquals(LAsString, UpperCase(TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('1 = 1')
                                 .&And('NOME').IsNull
                                 .AsString));
end;

procedure TTestCQLBrOperators.TestWhereIsNotNull;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (NOME IS NOT NULL)';
  AssertEquals(LAsString, UpperCase(TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('NOME').IsNotNull
                                 .AsString));
end;

procedure TTestCQLBrOperators.TestOrIsNotNull;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE ((1 = 1) OR (NOME IS NOT NULL))';
  AssertEquals(LAsString, UpperCase(TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('1 = 1')
                                 .&Or('NOME').IsNotNull
                                 .AsString));
end;

procedure TTestCQLBrOperators.TestAndIsNotNull;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (1 = 1) AND (NOME IS NOT NULL)';
  AssertEquals(LAsString, UpperCase(TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('1 = 1')
                                 .&And('NOME').IsNotNull
                                 .AsString));
end;

initialization

  RegisterTest(TTestCQLBrOperators);
end.
