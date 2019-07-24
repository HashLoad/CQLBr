unit test.operators.like;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry;

type

  { TTestCQLBrOperatorsLike }

  TTestCQLBrOperatorsLike= class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestLikeFull;
    procedure TestLikeRight;
    procedure TestLikeLeft;
    procedure TestNotLikeFull;
    procedure TestNotLikeRight;
    procedure TestNotLikeLeft;
  end;

implementation

uses
  cqlbr.interfaces,
  criteria.query.language;

procedure TTestCQLBrOperatorsLike.SetUp;
begin

end;

procedure TTestCQLBrOperatorsLike.TearDown;
begin

end;

procedure TTestCQLBrOperatorsLike.TestLikeFull;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (NOME LIKE ''%VALUE%'')';
  AssertEquals(LAsString, UpperCase(TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('NOME').LikeFull('VALUE')
                                 .AsString));
end;

procedure TTestCQLBrOperatorsLike.TestLikeRight;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (NOME LIKE ''VALUE%'')';
  AssertEquals(LAsString, UpperCase(TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('NOME').LikeRight('VALUE')
                                 .AsString));
end;

procedure TTestCQLBrOperatorsLike.TestLikeLeft;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (NOME LIKE ''%VALUE'')';
  AssertEquals(LAsString, UpperCase(TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('NOME').LikeLeft('VALUE')
                                 .AsString));
end;

procedure TTestCQLBrOperatorsLike.TestNotLikeFull;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (NOME NOT LIKE ''%VALUE%'')';
  AssertEquals(LAsString, UpperCase(TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('NOME').NotLikeFull('VALUE')
                                 .AsString));
end;

procedure TTestCQLBrOperatorsLike.TestNotLikeRight;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (NOME NOT LIKE ''VALUE%'')';
  AssertEquals(LAsString, UpperCase(TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('NOME').NotLikeRight('VALUE')
                                 .AsString));
end;

procedure TTestCQLBrOperatorsLike.TestNotLikeLeft;
var
  LAsString : string;
begin
  LAsString := 'SELECT * FROM CLIENTES WHERE (NOME NOT LIKE ''%VALUE'')';
  AssertEquals(LAsString, UpperCase(TCQL.New(dbnFirebird)
                                 .Select
                                 .All
                                 .From('CLIENTES')
                                 .Where('NOME').NotLikeLeft('VALUE')
                                 .AsString));
end;

initialization

  RegisterTest(TTestCQLBrOperatorsLike);
end.
