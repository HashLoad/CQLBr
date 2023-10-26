{
         CQL Brasil - Criteria Query Language for Delphi/Lazarus


                   Copyright (c) 2019, Isaque Pinheiro
                          All rights reserved.

                    GNU Lesser General Public License
                      Versão 3, 29 de junho de 2007

       Copyright (C) 2007 Free Software Foundation, Inc. <http://fsf.org/>
       A todos é permitido copiar e distribuir cópias deste documento de
       licença, mas mudá-lo não é permitido.

       Esta versão da GNU Lesser General Public License incorpora
       os termos e condições da versão 3 da GNU General Public License
       Licença, complementado pelas permissões adicionais listadas no
       arquivo LICENSE na pasta principal.
}

{
  @abstract(CQLBr Framework)
  @created(18 Jul 2019)
  @source(Inspired by and based on "GpSQLBuilder" project - https://github.com/gabr42/GpSQLBuilder)
  @source(Author of CQLBr Framework: Isaque Pinheiro <isaquesp@gmail.com>)
  @source(Author's Website: https://www.isaquepinheiro.com.br)
}

unit cqlbr.expression;

{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  SysUtils,
  cqlbr.interfaces;

type
  TCQLExpression = class(TInterfacedObject, ICQLExpression)
  strict private
    FOperation: TExpressionOperation;
    FLeft: ICQLExpression;
    FRight: ICQLExpression;
    FTerm: string;
    function _SerializeWhere(AAddParens: Boolean): string;
    function _SerializeAND: string;
    function _SerializeOR: string;
    function _SerializeOperator: string;
    function _SerializeFunction: string;
  protected
    function GetLeft: ICQLExpression;
    function GetOperation: TExpressionOperation;
    function GetRight: ICQLExpression;
    function GetTerm: string;
    procedure SetLeft(const AValue: ICQLExpression);
    procedure SetOperation(const AValue: TExpressionOperation);
    procedure SetRight(const AValue: ICQLExpression);
    procedure SetTerm(const AValue: string);
  public
    class function New: ICQLExpression;
    procedure Assign(const ANode: ICQLExpression);
    procedure Clear;
    function IsEmpty: Boolean;
    function Serialize(AAddParens: Boolean = False): string;
    property Term: string read GetTerm write SetTerm;
    property Operation: TExpressionOperation read GetOperation write SetOperation;
    property Left: ICQLExpression read GetLeft write SetLeft;
    property Right: ICQLExpression read GetRight write SetRight;
  end;

  TCQLCriteriaExpression = class(TInterfacedObject, ICQLCriteriaExpression)
  strict private
    FExpression: ICQLExpression;
    FLastAnd: ICQLExpression;
  protected
    function FindRightmostAnd(const AExpression: ICQLExpression): ICQLExpression;
  public
    constructor Create(const AExpression: string = ''); overload;
    constructor Create(const AExpression: ICQLExpression); overload;
    function &And(const AExpression: array of const): ICQLCriteriaExpression; overload;
    function &And(const AExpression: string): ICQLCriteriaExpression; overload;
    function &And(const AExpression: ICQLExpression): ICQLCriteriaExpression; overload;
    function &Or(const AExpression: array of const): ICQLCriteriaExpression; overload;
    function &Or(const AExpression: string): ICQLCriteriaExpression; overload;
    function &Or(const AExpression: ICQLExpression): ICQLCriteriaExpression; overload;
    function &Ope(const AExpression: array of const): ICQLCriteriaExpression; overload;
    function &Ope(const AExpression: string): ICQLCriteriaExpression; overload;
    function &Ope(const AExpression: ICQLExpression): ICQLCriteriaExpression; overload;
    function &Fun(const AExpression: array of const): ICQLCriteriaExpression; overload;
    function &Fun(const AExpression: string): ICQLCriteriaExpression; overload;
    function &Fun(const AExpression: ICQLExpression): ICQLCriteriaExpression; overload;
    function AsString: string;
    function Expression: ICQLExpression;
  end;

implementation

uses
  cqlbr.utils;

{ TCQLExpression }

procedure TCQLExpression.Assign(const ANode: ICQLExpression);
begin
  FLeft := ANode.Left;
  FRight := ANode.Right;
  FTerm := ANode.Term;
  FOperation := ANode.Operation;
end;

procedure TCQLExpression.Clear;
begin
  FOperation := opNone;
  FTerm := '';
  FLeft := nil;
  FRight := nil;
end;

function TCQLExpression.GetLeft: ICQLExpression;
begin
  Result := FLeft;
end;

function TCQLExpression.GetOperation: TExpressionOperation;
begin
  Result := FOperation;
end;

function TCQLExpression.GetRight: ICQLExpression;
begin
  Result := FRight;
end;

function TCQLExpression.GetTerm: string;
begin
  Result := FTerm;
end;

function TCQLExpression.IsEmpty: Boolean;
begin
  // Caso não exista a chamada do WHERE é considerado Empty.
  Result := (FOperation = opNone) and (FTerm = '');
end;

class function TCQLExpression.New: ICQLExpression;
begin
  Result := Self.Create;
end;

function TCQLExpression.Serialize(AAddParens: Boolean): string;
begin
  if IsEmpty then
    Result := ''
  else
    case FOperation of
      opNone:
        Result := _SerializeWhere(AAddParens);
      opAND:
        Result := _SerializeAND;
      opOR:
        Result := _SerializeOR;
      opOperation:
        Result := _SerializeOperator;
      opFunction:
        Result := _SerializeFunction;
      else
        raise Exception.Create('TCQLExpression.Serialize: Unknown operation');
    end;
end;

function TCQLExpression._SerializeAND: string;
begin
  Result := TUtils.Concat([FLeft.Serialize(True),
                           'AND',
                           FRight.Serialize(True)]);
end;

function TCQLExpression._SerializeFunction: string;
begin
  Result := TUtils.Concat([FLeft.Serialize(False),
                           FRight.Serialize(False)]);
end;

function TCQLExpression._SerializeOperator: string;
begin
  Result := '(' + TUtils.Concat([FLeft.Serialize(False),
                                 FRight.Serialize(False)]) + ')';
end;

function TCQLExpression._SerializeOR: string;
begin
  Result := '(' + TUtils.Concat([FLeft.Serialize(True),
                                 'OR',
                                 FRight.Serialize(True)]) + ')';
end;

function TCQLExpression._SerializeWhere(AAddParens: Boolean): string;
begin
  if AAddParens then
    Result := TUtils.concat(['(', FTerm, ')'], '')
  else
    Result := FTerm;
end;

procedure TCQLExpression.SetLeft(const AValue: ICQLExpression);
begin
  FLeft := AValue;
end;

procedure TCQLExpression.SetOperation(const AValue: TExpressionOperation);
begin
  FOperation := AValue;
end;

procedure TCQLExpression.SetRight(const AValue: ICQLExpression);
begin
  FRight := AValue;
end;

procedure TCQLExpression.SetTerm(const AValue: string);
begin
  FTerm := AValue;
end;

{ TCQLCriteriaExpression }

function TCQLCriteriaExpression.&And(const AExpression: ICQLExpression): ICQLCriteriaExpression;
var
  LNode: ICQLExpression;
  LRoot: ICQLExpression;
begin
  LRoot := FExpression;
  if LRoot.IsEmpty then
  begin
    LRoot.Assign(AExpression);
    FLastAnd := LRoot;
  end
  else
  begin
    LNode := TCQLExpression.New;
    LNode.Assign(LRoot);
    LRoot.Left := LNode;
    LRoot.Operation := opAND;
    LRoot.Right := AExpression;
    FLastAnd := LRoot.Right;
  end;
  Result := Self;
end;

function TCQLCriteriaExpression.&And(const AExpression: string): ICQLCriteriaExpression;
var
  LNode: ICQLExpression;
begin
  LNode := TCQLExpression.New;
  LNode.Term := AExpression;
  Result := &And(LNode);
end;

function TCQLCriteriaExpression.&And(const AExpression: array of const): ICQLCriteriaExpression;
begin
  Result := &And(TUtils.SqlParamsToStr(AExpression));
end;

function TCQLCriteriaExpression.AsString: string;
begin
  Result := FExpression.Serialize;
end;

constructor TCQLCriteriaExpression.Create(const AExpression: ICQLExpression);
begin
  FExpression := AExpression;
  FLastAnd := FindRightmostAnd(AExpression);
end;

function TCQLCriteriaExpression.Expression: ICQLExpression;
begin
  Result := FExpression;
end;

constructor TCQLCriteriaExpression.Create(const AExpression: string);
begin
  FExpression := TCQLExpression.New;
  if AExpression <> '' then
    &And(AExpression);
end;

function TCQLCriteriaExpression.FindRightmostAnd(const AExpression: ICQLExpression): ICQLExpression;
begin
  if AExpression.Operation = opNone then
    Result := FExpression
  else
  if AExpression.Operation = opOR then
    Result := FExpression
  else
    Result := FindRightmostAnd(AExpression.Right);
end;

function TCQLCriteriaExpression.Fun(const AExpression: array of const): ICQLCriteriaExpression;
begin
  Result := &Fun(TUtils.SqlParamsToStr(AExpression));
end;

function TCQLCriteriaExpression.Fun(const AExpression: string): ICQLCriteriaExpression;
var
  LNode: ICQLExpression;
begin
  LNode := TCQLExpression.New;
  LNode.Term := AExpression;
  Result := &Fun(LNode);
end;

function TCQLCriteriaExpression.Fun(const AExpression: ICQLExpression): ICQLCriteriaExpression;
var
  LNode: ICQLExpression;
begin
  LNode := TCQLExpression.New;
  LNode.Assign(FLastAnd);
  FLastAnd.Left := LNode;
  FLastAnd.Operation := opFunction;
  FLastAnd.Right := AExpression;
  Result := Self;
end;

function TCQLCriteriaExpression.&Or(const AExpression: array of const): ICQLCriteriaExpression;
begin
  Result := &Or(TUtils.SqlParamsToStr(AExpression));
end;

function TCQLCriteriaExpression.&Or(const AExpression: string): ICQLCriteriaExpression;
var
  LNode: ICQLExpression;
begin
  LNode := TCQLExpression.New;
  LNode.Term := AExpression;
  Result := &Or(LNode);
end;

function TCQLCriteriaExpression.&Ope(const AExpression: array of const): ICQLCriteriaExpression;
begin
  Result := &Ope(TUtils.SqlParamsToStr(AExpression));
end;

function TCQLCriteriaExpression.&Ope(const AExpression: string): ICQLCriteriaExpression;
var
  LNode: ICQLExpression;
begin
  LNode := TCQLExpression.New;
  LNode.Term := AExpression;
  Result := &Ope(LNode);
end;

function TCQLCriteriaExpression.&Ope(const AExpression: ICQLExpression): ICQLCriteriaExpression;
var
  LNode: ICQLExpression;
begin
  LNode := TCQLExpression.New;
  LNode.Assign(FLastAnd);
  FLastAnd.Left := LNode;
  FLastAnd.Operation := opOperation;
  FLastAnd.Right := AExpression;
  Result := Self;
end;

function TCQLCriteriaExpression.&Or(const AExpression: ICQLExpression): ICQLCriteriaExpression;
var
  LNode: ICQLExpression;
  LRoot: ICQLExpression;
begin
  LRoot := FLastAnd;
  LNode := TCQLExpression.New;
  LNode.Assign(LRoot);
  LRoot.Left := LNode;
  LRoot.Operation := opOR;
  LRoot.Right := AExpression;
  FLastAnd := LRoot.Right;
  Result := Self;
end;

end.
