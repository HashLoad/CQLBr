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

unit criteria.query.language;

{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  SysUtils,
  cqlbr.operators,
  cqlbr.functions,
  cqlbr.interfaces,
  cqlbr.cases,
  cqlbr.select,
  cqlbr.utils,
  cqlbr.serialize,
  cqlbr.qualifier,
  cqlbr.ast,
  cqlbr.expression;

type
  TDBName = cqlbr.interfaces.TDBName;
  CQL = cqlbr.functions.TCQLFunctions;

  TCQL = class(TInterfacedObject, ICQL)
  strict private
    type
      TSection = (secSelect = 0,
                  secDelete = 1,
                  secInsert = 2,
                  secUpdate = 3,
                  secJoin = 4,
                  secWhere= 5,
                  secGroupBy = 6,
                  secHaving = 7,
                  secOrderBy = 8);
      TSections = set of TSection;
  strict private
    FActiveSection: TSection;
    FActiveOperator: TOperator;
    FActiveExpr: ICQLCriteriaExpression;
    FActiveValues: ICQLNameValuePairs;
    FDatabase: TDBName;
    FOperator: ICQLOperators;
    FFunction: ICQLFunctions;
    FAST: ICQLAST;
    procedure _AssertSection(ASections: TSections);
    procedure _AssertOperator(AOperators: TOperators);
    procedure _AssertHaveName;
    procedure _SetSection(ASection: TSection);
    procedure _DefineSectionSelect;
    procedure _DefineSectionDelete;
    procedure _DefineSectionInsert;
    procedure _DefineSectionUpdate;
    procedure _DefineSectionWhere;
    procedure _DefineSectionGroupBy;
    procedure _DefineSectionHaving;
    procedure _DefineSectionOrderBy;
    function _CreateJoin(AjoinType: TJoinType; const ATableName: string): ICQL;
    function _InternalSet(const AColumnName, AColumnValue: string): ICQL;
  strict private
    class var FDatabaseDafault: TDBName;
  protected
    constructor Create(const ADatabase: TDBName);
  public
    class function New(const ADatabase: TDBName): ICQL; overload;
    class function New: ICQL; overload;
    class procedure SetDatabaseDafault(const ADatabase: TDBName);
    function &And(const AExpression: array of const): ICQL; overload;
    function &And(const AExpression: string): ICQL; overload;
    function &And(const AExpression: ICQLCriteriaExpression): ICQL; overload;
    function &As(const AAlias: string): ICQL;
    function &Case(const AExpression: string = ''): ICQLCriteriaCase; overload;
    function &Case(const AExpression: array of const): ICQLCriteriaCase; overload;
    function &Case(const AExpression: ICQLCriteriaExpression): ICQLCriteriaCase; overload;
    function Clear: ICQL;
    function ClearAll: ICQL;
    function All: ICQL;
    function Column(const AColumnName: string = ''): ICQL; overload;
    function Column(const ATableName: string; const AColumnName: string): ICQL; overload;
    function Column(const AColumnsName: array of const): ICQL; overload;
    function Column(const ACaseExpression: ICQLCriteriaCase): ICQL; overload;
    function Delete: ICQL;
    function Desc: ICQL;
    function Distinct: ICQL;
    function IsEmpty: Boolean;
    function Expression(const ATerm: string = ''): ICQLCriteriaExpression; overload;
    function Expression(const ATerm: array of const): ICQLCriteriaExpression; overload;
    function From(const AExpression: ICQLCriteriaExpression): ICQL; overload;
    function From(const AQuery: ICQL): ICQL; overload;
    function From(const ATableName: string): ICQL; overload;
    function From(const ATableName: string; const AAlias: string): ICQL; overload;
    function GroupBy(const AColumnName: string = ''): ICQL;
    function Having(const AExpression: string = ''): ICQL; overload;
    function Having(const AExpression: array of const): ICQL; overload;
    function Having(const AExpression: ICQLCriteriaExpression): ICQL; overload;
    function Insert: ICQL;
    function Into(const ATableName: string): ICQL;
    function FullJoin(const ATableName: string): ICQL; overload;
    function InnerJoin(const ATableName: string): ICQL; overload;
    function LeftJoin(const ATableName: string): ICQL; overload;
    function RightJoin(const ATableName: string): ICQL; overload;
    function FullJoin(const ATableName: string; const AAlias: string): ICQL; overload;
    function InnerJoin(const ATableName: string; const AAlias: string): ICQL; overload;
    function LeftJoin(const ATableName: string; const AAlias: string): ICQL; overload;
    function RightJoin(const ATableName: string; const AAlias: string): ICQL; overload;
    function &On(const AExpression: string): ICQL; overload;
    function &On(const AExpression: array of const): ICQL; overload;
    function &Or(const AExpression: array of const): ICQL; overload;
    function &Or(const AExpression: string): ICQL; overload;
    function &Or(const AExpression: ICQLCriteriaExpression): ICQL; overload;
    function OrderBy(const AColumnName: string = ''): ICQL; overload;
    function OrderBy(const ACaseExpression: ICQLCriteriaCase): ICQL; overload;
    function Select(const AColumnName: string = ''): ICQL; overload;
    function Select(const ACaseExpression: ICQLCriteriaCase): ICQL; overload;
    function &Set(const AColumnName, AColumnValue: string): ICQL; overload;
    function &Set(const AColumnName: string; AColumnValue: Integer): ICQL; overload;
    function &Set(const AColumnName: string; AColumnValue: Extended; ADecimalPlaces: Integer): ICQL; overload;
    function &Set(const AColumnName: string; AColumnValue: Double; ADecimalPlaces: Integer): ICQL; overload;
    function &Set(const AColumnName: string; AColumnValue: Currency; ADecimalPlaces: Integer): ICQL; overload;
    function &Set(const AColumnName: string; const AColumnValue: array of const): ICQL; overload;
    function &Set(const AColumnName: string; const AColumnValue: TDate): ICQL; overload;
    function &Set(const AColumnName: string; const AColumnValue: TDateTime): ICQL; overload;
    function &Set(const AColumnName: string; const AColumnValue: TGUID): ICQL; overload;
    function Values(const AColumnName, AColumnValue: string): ICQL; overload;
    function Values(const AColumnName: string; const AColumnValue: array of const): ICQL; overload;
    function First(const AValue: Integer): ICQL;
    function Skip(const AValue: Integer): ICQL;
    function Limit(const AValue: Integer): ICQL;
    function Offset(const AValue: Integer): ICQL;
    function Update(const ATableName: string): ICQL;
    function Where(const AExpression: string = ''): ICQL; overload;
    function Where(const AExpression: array of const): ICQL; overload;
    function Where(const AExpression: ICQLCriteriaExpression): ICQL; overload;
    // Operators methods
    function Equal(const AValue: string = ''): ICQL; overload;
    function Equal(const AValue: Extended): ICQL overload;
    function Equal(const AValue: Integer): ICQL; overload;
    function Equal(const AValue: TDate): ICQL; overload;
    function Equal(const AValue: TDateTime): ICQL; overload;
    function Equal(const AValue: TGUID): ICQL; overload;
    function NotEqual(const AValue: string = ''): ICQL; overload;
    function NotEqual(const AValue: Extended): ICQL; overload;
    function NotEqual(const AValue: Integer): ICQL; overload;
    function NotEqual(const AValue: TDate): ICQL; overload;
    function NotEqual(const AValue: TDateTime): ICQL; overload;
    function NotEqual(const AValue: TGUID): ICQL; overload;
    function GreaterThan(const AValue: Extended): ICQL; overload;
    function GreaterThan(const AValue: Integer) : ICQL; overload;
    function GreaterThan(const AValue: TDate): ICQL; overload;
    function GreaterThan(const AValue: TDateTime) : ICQL; overload;
    function GreaterEqThan(const AValue: Extended): ICQL; overload;
    function GreaterEqThan(const AValue: Integer) : ICQL; overload;
    function GreaterEqThan(const AValue: TDate): ICQL; overload;
    function GreaterEqThan(const AValue: TDateTime) : ICQL; overload;
    function LessThan(const AValue: Extended): ICQL; overload;
    function LessThan(const AValue: Integer) : ICQL; overload;
    function LessThan(const AValue: TDate): ICQL; overload;
    function LessThan(const AValue: TDateTime) : ICQL; overload;
    function LessEqThan(const AValue: Extended): ICQL; overload;
    function LessEqThan(const AValue: Integer) : ICQL; overload;
    function LessEqThan(const AValue: TDate): ICQL; overload;
    function LessEqThan(const AValue: TDateTime) : ICQL; overload;
    function IsNull: ICQL;
    function IsNotNull: ICQL;
    function Like(const AValue: string): ICQL;
    function LikeFull(const AValue: string): ICQL;
    function LikeLeft(const AValue: string): ICQL;
    function LikeRight(const AValue: string): ICQL;
    function NotLike(const AValue: string): ICQL;
    function NotLikeFull(const AValue: string): ICQL;
    function NotLikeLeft(const AValue: string): ICQL;
    function NotLikeRight(const AValue: string): ICQL;

    function &In(const AValue: TArray<Double>): ICQL; overload;
    function &In(const AValue: TArray<String>): ICQL; overload;
    function &In(const AValue: string): ICQL; overload;
    function NotIn(const AValue: TArray<Double>): ICQL; overload;
    function NotIn(const AValue: TArray<String>): ICQL; overload;
    function NotIn(const AValue: string): ICQL; overload;
    function Exists(const AValue: string): ICQL; overload;
    function NotExists(const AValue: string): ICQL; overload;
    // Functions methods
    function Count: ICQL;
    function Lower: ICQL;
    function Min: ICQL;
    function Max: ICQL;
    function Upper: ICQL;
    function Substring(const AStart: Integer; const ALength: Integer): ICQL;
    function Date(const AValue: string): ICQL;
    function Day(const AValue: string): ICQL;
    function Month(const AValue: string): ICQL;
    function Year(const AValue: string): ICQL;
    function Concat(const AValue: array of string): ICQL;
    // Result full command sql
    function AsFun: ICQLFunctions;
    function AsString: string;
  end;

implementation

uses
  cqlbr.register;

{ TCQL }

function TCQL.&As(const AAlias: string): ICQL;
begin
  _AssertSection([secSelect, secDelete, secJoin]);
  _AssertHaveName;
  FAST.ASTName.Alias := AAlias;
  Result := Self;
end;

function TCQL.AsFun: ICQLFunctions;
begin
  Result := FFunction;
end;

function TCQL.&Case(const AExpression: string): ICQLCriteriaCase;
var
  LExpression: string;
begin
  LExpression := AExpression;
  if LExpression = '' then
    LExpression := FAST.ASTName.Name;
  Result := TCQLCriteriaCase.Create(Self, LExpression);
  if Assigned(FAST) then
    FAST.ASTName.&Case := Result.&Case;
end;

function TCQL.&Case(const AExpression: array of const): ICQLCriteriaCase;
begin
  Result := &Case(TUtils.SqlParamsToStr(AExpression));
end;

function TCQL.&Case(const AExpression: ICQLCriteriaExpression): ICQLCriteriaCase;
begin
  Result := TCQLCriteriaCase.Create(Self, '');
  Result.&And(AExpression);
end;

function TCQL.&And(const AExpression: ICQLCriteriaExpression): ICQL;
begin
  FActiveOperator := opeAND;
  FActiveExpr.&And(AExpression.Expression);
  Result := Self;
end;

function TCQL.&And(const AExpression: string): ICQL;
begin
  FActiveOperator := opeAND;
  FActiveExpr.&And(AExpression);
  Result := Self;
end;

function TCQL.&And(const AExpression: array of const): ICQL;
begin
  Result := &And(TUtils.SqlParamsToStr(AExpression));
end;

function TCQL.&Or(const AExpression: array of const): ICQL;
begin
  Result := &Or(TUtils.SqlParamsToStr(AExpression));
end;

function TCQL.&Or(const AExpression: string): ICQL;
begin
  FActiveOperator := opeOR;
  FActiveExpr.&Or(AExpression);
  Result := Self;
end;

function TCQL.&Or(const AExpression: ICQLCriteriaExpression): ICQL;
begin
  FActiveOperator := opeOR;
  FActiveExpr.&Or(AExpression.Expression);
  Result := Self;
end;

function TCQL.&Set(const AColumnName: string; const AColumnValue: array of const): ICQL;
begin
  Result := _InternalSet(AColumnName, TUtils.SqlParamsToStr(AColumnValue));
end;

function TCQL.&Set(const AColumnName, AColumnValue: string): ICQL;
begin
  Result := _InternalSet(AColumnName, QuotedStr(AColumnValue));
end;

function TCQL.&On(const AExpression: string): ICQL;
begin
  Result := &And(AExpression);
end;

function TCQL.Offset(const AValue: Integer): ICQL;
begin
  Result := Skip(AValue);
end;

function TCQL.&On(const AExpression: array of const): ICQL;
begin
  Result := &On(TUtils.SqlParamsToStr(AExpression));
end;

function TCQL.&In(const AValue: string): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsIn(AValue));
  Result := Self;
end;

function TCQL.&Set(const AColumnName: string; AColumnValue: Integer): ICQL;
begin
  Result := _InternalSet(AColumnName, IntToStr(AColumnValue));
end;

function TCQL.&Set(const AColumnName: string; AColumnValue: Extended; ADecimalPlaces: Integer): ICQL;
var
  LFormat: TFormatSettings;
begin
  LFormat.DecimalSeparator := '.';
  Result := _InternalSet(AColumnName, Format('%.' + IntToStr(ADecimalPlaces) + 'f', [AColumnValue], LFormat));
end;

function TCQL.&Set(const AColumnName: string; AColumnValue: Double; ADecimalPlaces: Integer): ICQL;
var
  LFormat: TFormatSettings;
begin
  LFormat.DecimalSeparator := '.';
  Result := _InternalSet(AColumnName, Format('%.' + IntToStr(ADecimalPlaces) + 'f', [AColumnValue], LFormat));
end;

function TCQL.&Set(const AColumnName: string; AColumnValue: Currency; ADecimalPlaces: Integer): ICQL;
var
  LFormat: TFormatSettings;
begin
  LFormat.DecimalSeparator := '.';
  Result := _InternalSet(AColumnName, Format('%.' + IntToStr(ADecimalPlaces) + 'f', [AColumnValue], LFormat));
end;

function TCQL.&Set(const AColumnName: string;
  const AColumnValue: TDate): ICQL;
begin
  Result := _InternalSet(AColumnName, QuotedStr(TUtils.DateToSQLFormat(FDatabase, AColumnValue)));
end;

function TCQL.&Set(const AColumnName: string;
  const AColumnValue: TDateTime): ICQL;
begin
  Result := _InternalSet(AColumnName, QuotedStr(TUtils.DateTimeToSQLFormat(FDatabase, AColumnValue)));
end;

function TCQL.&Set(const AColumnName: string;
  const AColumnValue: TGUID): ICQL;
begin
  Result := _InternalSet(AColumnName, TUtils.GuidStrToSQLFormat(FDatabase, AColumnValue));
end;

class procedure TCQL.SetDatabaseDafault(const ADatabase: TDBName);
begin
  FDatabaseDafault := ADatabase;
end;

function TCQL.All: ICQL;
begin
  if not (FDatabase in [dbnMongoDB]) then
    Result := Column('*')
  else
    Result := Self;
end;

procedure TCQL._AssertHaveName;
begin
  if not Assigned(FAST.ASTName) then
    raise Exception.Create('TCriteria: Current name is not set');
end;

procedure TCQL._AssertOperator(AOperators: TOperators);
begin
  if not (FActiveOperator in AOperators) then
    raise Exception.Create('TCQL: Not supported in this operator');
end;

procedure TCQL._AssertSection(ASections: TSections);
begin
  if not (FActiveSection in ASections) then
    raise Exception.Create('TCQL: Not supported in this section');
end;

function TCQL.AsString: string;
begin
  FActiveOperator := opeNone;
  Result := TCQLBrRegister.Serialize(FDatabase).AsString(FAST);
end;

function TCQL.Column(const AColumnName: string): ICQL;
begin
  if Assigned(FAST) then
  begin
    FAST.ASTName := FAST.ASTColumns.Add;
    FAST.ASTName.Name := AColumnName;
  end
  else
    raise Exception.CreateFmt('Current section [%s] does not support COLUMN.', [FAST.ASTSection.Name]);
  Result := Self;
end;

function TCQL.Column(const ATableName: string; const AColumnName: string): ICQL;
begin
  Result := Column(ATableName + '.' + AColumnName);
end;

function TCQL.Clear: ICQL;
begin
  FAST.ASTSection.Clear;
  Result := Self;
end;

function TCQL.ClearAll: ICQL;
begin
  FAST.Clear;
  Result := Self;
end;

function TCQL.Column(const ACaseExpression: ICQLCriteriaCase): ICQL;
begin
  if Assigned(FAST.ASTColumns) then
  begin
    FAST.ASTName := FAST.ASTColumns.Add;
    FAST.ASTName.&Case := ACaseExpression.&Case;
  end
  else
    raise Exception.CreateFmt('Current section [%s] does not support COLUMN.', [FAST.ASTSection.Name]);
  Result := Self;
end;

function TCQL.Concat(const AValue: array of string): ICQL;
begin
  _AssertSection([secSelect, secJoin, secWhere]);
  _AssertHaveName;
  case FActiveSection of
    secSelect: FAST.ASTName.Name := FFunction.Concat(AValue);
    secWhere: FActiveExpr.&Fun(FFunction.Concat(AValue));
  end;
  Result := Self;
end;

function TCQL.Count: ICQL;
begin
  _AssertSection([secSelect, secDelete, secJoin]);
  _AssertHaveName;
  FAST.ASTName.Name := FFunction.Count(FAST.ASTName.Name);
  Result := Self;
end;

function TCQL.Column(const AColumnsName: array of const): ICQL;
begin
  Result := Column(TUtils.SqlParamsToStr(AColumnsName));
end;

constructor TCQL.Create(const ADatabase: TDBName);
begin
  FDatabase := ADatabase;
  FActiveOperator := opeNone;
  FAST := TCQLAST.New(ADatabase);
  FAST.Clear;
  FOperator := TCQLOperators.New(FDatabase);
  FFunction := TCQLFunctions.New(FDatabase);
end;

function TCQL._CreateJoin(AjoinType: TJoinType; const ATableName: string): ICQL;
var
  LJoin: ICQLJoin;
begin
  FActiveSection := secJoin;
  LJoin := FAST.Joins.Add;
  LJoin.JoinType := AjoinType;
  FAST.ASTName := LJoin.JoinedTable;
  FAST.ASTName.Name := ATableName;
  FAST.ASTSection := LJoin;
  FAST.ASTColumns := nil;
  FActiveExpr := TCQLCriteriaExpression.Create(LJoin.Condition);
  Result := Self;
end;

function TCQL.Date(const AValue: string): ICQL;
begin
  _AssertSection([secSelect, secJoin, secWhere]);
  _AssertHaveName;
  case FActiveSection of
    secSelect: FAST.ASTName.Name := FFunction.Date(AValue);
    secWhere: FActiveExpr.&Fun(FFunction.Date(AValue));
  end;
  Result := Self;
end;

function TCQL.Day(const AValue: string): ICQL;
begin
  _AssertSection([secSelect, secJoin, secWhere]);
  _AssertHaveName;
  case FActiveSection of
    secSelect: FAST.ASTName.Name := FFunction.Day(AValue);
    secWhere: FActiveExpr.&Fun(FFunction.Day(AValue));
  end;
  Result := Self;
end;

procedure TCQL._DefineSectionDelete;
begin
  ClearAll();
  FAST.ASTSection := FAST.Delete;
  FAST.ASTColumns := nil;
  FAST.ASTTableNames := FAST.Delete.TableNames;
  FActiveExpr := nil;
  FActiveValues := nil;
end;

procedure TCQL._DefineSectionGroupBy;
begin
  FAST.ASTSection := FAST.GroupBy;
  FAST.ASTColumns := FAST.GroupBy.Columns;
  FAST.ASTTableNames := nil;
  FActiveExpr := nil;
  FActiveValues := nil;
end;

procedure TCQL._DefineSectionHaving;
begin
  FAST.ASTSection := FAST.Having;
  FAST.ASTColumns   := nil;
  FActiveExpr := TCQLCriteriaExpression.Create(FAST.Having.Expression);
  FAST.ASTTableNames := nil;
  FActiveValues := nil;
end;

procedure TCQL._DefineSectionInsert;
begin
  ClearAll();
  FAST.ASTSection := FAST.Insert;
  FAST.ASTColumns := FAST.Insert.Columns;
  FAST.ASTTableNames := nil;
  FActiveExpr := nil;
  FActiveValues := FAST.Insert.Values;
end;

procedure TCQL._DefineSectionOrderBy;
begin
  FAST.ASTSection := FAST.OrderBy;
  FAST.ASTColumns := FAST.OrderBy.Columns;
  FAST.ASTTableNames := nil;
  FActiveExpr := nil;
  FActiveValues := nil;
end;

procedure TCQL._DefineSectionSelect;
begin
  ClearAll();
  FAST.ASTSection := FAST.Select;
  FAST.ASTColumns := FAST.Select.Columns;
  FAST.ASTTableNames := FAST.Select.TableNames;
  FActiveExpr := nil;
  FActiveValues := nil;
end;

procedure TCQL._DefineSectionUpdate;
begin
  ClearAll();
  FAST.ASTSection := FAST.Update;
  FAST.ASTColumns := nil;
  FAST.ASTTableNames := nil;
  FActiveExpr := nil;
  FActiveValues := FAST.Update.Values;
end;

procedure TCQL._DefineSectionWhere;
begin
  FAST.ASTSection := FAST.Where;
  FAST.ASTColumns := nil;
  FAST.ASTTableNames := nil;
  FActiveExpr := TCQLCriteriaExpression.Create(FAST.Where.Expression);
  FActiveValues := nil;
end;

function TCQL.Delete: ICQL;
begin
  _SetSection(secDelete);
  Result := Self;
end;

function TCQL.Desc: ICQL;
begin
  _AssertSection([secOrderBy]);
  Assert(FAST.ASTColumns.Count > 0, 'TCriteria.Desc: No columns set up yet');
  (FAST.OrderBy.Columns[FAST.OrderBy.Columns.Count -1] as ICQLOrderByColumn).Direction := dirDescending;
  Result := Self;
end;

function TCQL.Distinct: ICQL;
var
  LQualifier: ICQLSelectQualifier;
begin
  _AssertSection([secSelect]);
  LQualifier := FAST.Select.Qualifiers.Add;
  LQualifier.Qualifier := sqDistinct;
  // Esse método tem que Add o Qualifier já todo parametrizado.
  FAST.Select.Qualifiers.Add(LQualifier);
  Result := Self;
end;

function TCQL.Equal(const AValue: Integer): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsEqual(AValue));
  Result := Self;
end;

function TCQL.Equal(const AValue: Extended): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsEqual(AValue));
  Result := Self;
end;

function TCQL.Equal(const AValue: string): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  if AValue = '' then
    FActiveExpr.&Fun(FOperator.IsEqual(AValue))
  else
    FActiveExpr.&Ope(FOperator.IsEqual(AValue));
  Result := Self;
end;

function TCQL.Exists(const AValue: string): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsExists(AValue));
  Result := Self;
end;

function TCQL.Expression(const ATerm: array of const): ICQLCriteriaExpression;
begin
  Result := Expression(TUtils.SqlParamsToStr(ATerm));
end;

function TCQL.Expression(const ATerm: string): ICQLCriteriaExpression;
begin
  Result := TCQLCriteriaExpression.Create(ATerm);
end;

function TCQL.From(const AExpression: ICQLCriteriaExpression): ICQL;
begin
  Result := From('(' + AExpression.AsString + ')');
end;

function TCQL.From(const AQuery: ICQL): ICQL;
begin
  Result := From('(' + AQuery.AsString + ')');
end;

function TCQL.From(const ATableName: string): ICQL;
begin
  _AssertSection([secSelect, secDelete]);
  FAST.ASTName := FAST.ASTTableNames.Add;
  FAST.ASTName.Name := ATableName;
  Result := Self;
end;

function TCQL.FullJoin(const ATableName: string): ICQL;
begin
  Result := _CreateJoin(jtFULL, ATableName);
end;

function TCQL.GreaterEqThan(const AValue: Integer): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsGreaterEqThan(AValue));
  Result := Self;
end;

function TCQL.GreaterEqThan(const AValue: Extended): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsGreaterEqThan(AValue));
  Result := Self;
end;

function TCQL.GreaterThan(const AValue: Integer): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsGreaterThan(AValue));
  Result := Self;
end;

function TCQL.GreaterThan(const AValue: Extended): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsGreaterThan(AValue));
  Result := Self;
end;

function TCQL.GroupBy(const AColumnName: string): ICQL;
begin
  _SetSection(secGroupBy);
  if AColumnName = '' then
    Result := Self
  else
    Result := Column(AColumnName);
end;

function TCQL.Having(const AExpression: string): ICQL;
begin
  _SetSection(secHaving);
  if AExpression = '' then
    Result := Self
  else
    Result := &And(AExpression);
end;

function TCQL.Having(const AExpression: array of const): ICQL;
begin
  Result := Having(TUtils.SqlParamsToStr(AExpression));
end;

function TCQL.Having(const AExpression: ICQLCriteriaExpression): ICQL;
begin
  _SetSection(secHaving);
  Result := &And(AExpression);
end;

function TCQL.InnerJoin(const ATableName: string): ICQL;
begin
  Result := _CreateJoin(jtINNER, ATableName);
end;

function TCQL.InnerJoin(const ATableName, AAlias: string): ICQL;
begin
  InnerJoin(ATableName).&As(AAlias);
  Result := Self;
end;

function TCQL.Insert: ICQL;
begin
  _SetSection(secInsert);
  Result := Self;
end;

function TCQL._InternalSet(const AColumnName, AColumnValue: string): ICQL;
var
  LPair: ICQLNameValue;
begin
  _AssertSection([secInsert, secUpdate]);
  LPair := FActiveValues.Add;
  LPair.Name := AColumnName;
  LPair.Value := AColumnValue;
  Result := Self;
end;

function TCQL.Into(const ATableName: string): ICQL;
begin
  _AssertSection([secInsert]);
  FAST.Insert.TableName := ATableName;
  Result := Self;
end;

function TCQL.IsEmpty: Boolean;
begin
  Result := FAST.ASTSection.IsEmpty;
end;

function TCQL.&In(const AValue: TArray<String>): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsIn(AValue));
  Result := Self;
end;

function TCQL.&In(const AValue: TArray<Double>): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsIn(AValue));
  Result := Self;
end;

function TCQL.IsNotNull: ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsNotNull);
  Result := Self;
end;

function TCQL.IsNull: ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsNull);
  Result := Self;
end;

function TCQL.LeftJoin(const ATableName: string): ICQL;
begin
  Result := _CreateJoin(jtLEFT, ATableName);
end;

function TCQL.LeftJoin(const ATableName, AAlias: string): ICQL;
begin
  LeftJoin(ATableName).&As(AAlias);
  Result := Self;
end;

function TCQL.LessEqThan(const AValue: Integer): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsLessEqThan(AValue));
  Result := Self;
end;

function TCQL.LessEqThan(const AValue: Extended): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsLessEqThan(AValue));
  Result := Self;
end;

function TCQL.LessThan(const AValue: Integer): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsLessThan(AValue));
  Result := Self;
end;

function TCQL.LessThan(const AValue: Extended): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsLessThan(AValue));
  Result := Self;
end;

function TCQL.Like(const AValue: string): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsLike(AValue));
  Result := Self;
end;

function TCQL.LikeFull(const AValue: string): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsLikeFull(AValue));
  Result := Self;
end;

function TCQL.LikeLeft(const AValue: string): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsLikeLeft(AValue));
  Result := Self;
end;

function TCQL.LikeRight(const AValue: string): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsLikeRight(AValue));
  Result := Self;
end;

function TCQL.Limit(const AValue: Integer): ICQL;
begin
  Result := First(AValue);
end;

function TCQL.Lower: ICQL;
begin
  _AssertSection([secSelect, secDelete, secJoin]);
  _AssertHaveName;
  FAST.ASTName.Name := FFunction.Lower(FAST.ASTName.Name);
  Result := Self;
end;

function TCQL.Max: ICQL;
begin
  _AssertSection([secSelect, secDelete, secJoin]);
  _AssertHaveName;
  FAST.ASTName.Name := FFunction.Max(FAST.ASTName.Name);
  Result := Self;
end;

function TCQL.Min: ICQL;
begin
  _AssertSection([secSelect, secDelete, secJoin]);
  _AssertHaveName;
  FAST.ASTName.Name := FFunction.Min(FAST.ASTName.Name);
  Result := Self;
end;

function TCQL.Month(const AValue: string): ICQL;
begin
  _AssertSection([secSelect, secJoin, secWhere]);
  _AssertHaveName;
  case FActiveSection of
    secSelect: FAST.ASTName.Name := FFunction.Month(AValue);
    secWhere: FActiveExpr.&Fun(FFunction.Month(AValue));
  end;
  Result := Self;
end;

class function TCQL.New(const ADatabase: TDBName): ICQL;
begin
  Result := Self.Create(ADatabase);
end;

function TCQL.NotEqual(const AValue: string): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsNotEqual(AValue));
  Result := Self;
end;

function TCQL.NotEqual(const AValue: Extended): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsNotEqual(AValue));
  Result := Self;
end;

function TCQL.NotEqual(const AValue: Integer): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsNotEqual(AValue));
  Result := Self;
end;

function TCQL.NotExists(const AValue: string): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsNotExists(AValue));
  Result := Self;
end;

function TCQL.NotIn(const AValue: TArray<String>): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsNotIn(AValue));
  Result := Self;
end;

function TCQL.NotIn(const AValue: TArray<Double>): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsNotIn(AValue));
  Result := Self;
end;

function TCQL.NotLike(const AValue: string): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsNotLike(AValue));
  Result := Self;
end;

function TCQL.NotLikeFull(const AValue: string): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsNotLikeFull(AValue));
  Result := Self;
end;

function TCQL.NotLikeLeft(const AValue: string): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsNotLikeLeft(AValue));
  Result := Self;
end;

function TCQL.NotLikeRight(const AValue: string): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsNotLikeRight(AValue));
  Result := Self;
end;

function TCQL.OrderBy(const ACaseExpression: ICQLCriteriaCase): ICQL;
begin
  _SetSection(secOrderBy);
  Result := Column(ACaseExpression);
end;

function TCQL.RightJoin(const ATableName, AAlias: string): ICQL;
begin
  RightJoin(ATableName).&As(AAlias);
  Result := Self;
end;

function TCQL.RightJoin(const ATableName: string): ICQL;
begin
  Result := _CreateJoin(jtRIGHT, ATableName);
end;

function TCQL.OrderBy(const AColumnName: string): ICQL;
begin
  _SetSection(secOrderBy);
  if AColumnName = '' then
    Result := Self
  else
    Result := Column(AColumnName);
end;

function TCQL.Select(const AColumnName: string): ICQL;
begin
  _SetSection(secSelect);
  if AColumnName = '' then
    Result := Self
  else
    Result := Column(AColumnName);
end;

function TCQL.Select(const ACaseExpression: ICQLCriteriaCase): ICQL;
begin
  _SetSection(secSelect);
  Result := Column(ACaseExpression);
end;

procedure TCQL._SetSection(ASection: TSection);
begin
  case ASection of
    secSelect:  _DefineSectionSelect;
    secDelete:  _DefineSectionDelete;
    secInsert:  _DefineSectionInsert;
    secUpdate:  _DefineSectionUpdate;
    secWhere:   _DefineSectionWhere;
    secGroupBy: _DefineSectionGroupBy;
    secHaving:  _DefineSectionHaving;
    secOrderBy: _DefineSectionOrderBy;
  else
      raise Exception.Create('TCriteria.SetSection: Unknown section');
  end;
  FActiveSection := ASection;
end;

function TCQL.First(const AValue: Integer): ICQL;
var
  LQualifier: ICQLSelectQualifier;
begin
  _AssertSection([secSelect, secWhere, secOrderBy]);
  LQualifier := FAST.Select.Qualifiers.Add;
  LQualifier.Qualifier := sqFirst;
  LQualifier.Value := AValue;
  // Esse método tem que Add o Qualifier já todo parametrizado.
  FAST.Select.Qualifiers.Add(LQualifier);
  Result := Self;
end;

function TCQL.Skip(const AValue: Integer): ICQL;
var
  LQualifier: ICQLSelectQualifier;
begin
  _AssertSection([secSelect, secWhere, secOrderBy]);
  LQualifier := FAST.Select.Qualifiers.Add;
  LQualifier.Qualifier := sqSkip;
  LQualifier.Value := AValue;
  // Esse método tem que Add o Qualifier já todo parametrizado.
  FAST.Select.Qualifiers.Add(LQualifier);
  Result := Self;
end;

function TCQL.Substring(const AStart, ALength: Integer): ICQL;
begin
  _AssertSection([secSelect, secDelete, secJoin]);
  _AssertHaveName;
  FAST.ASTName.Name := FFunction.Substring(FAST.ASTName.Name, AStart, ALength);
  Result := Self;
end;

function TCQL.Update(const ATableName: string): ICQL;
begin
  _SetSection(secUpdate);
  FAST.Update.TableName := ATableName;
  Result := Self;
end;

function TCQL.Upper: ICQL;
begin
  _AssertSection([secSelect, secDelete, secJoin]);
  _AssertHaveName;
  FAST.ASTName.Name := FFunction.Upper(FAST.ASTName.Name);
  Result := Self;
end;

function TCQL.Values(const AColumnName: string; const AColumnValue: array of const): ICQL;
begin
  Result := _InternalSet(AColumnName, TUtils.SqlParamsToStr(AColumnValue));
end;

function TCQL.Values(const AColumnName, AColumnValue: string): ICQL;
begin
  Result := _InternalSet(AColumnName, QuotedStr(AColumnValue));
end;

function TCQL.Where(const AExpression: string): ICQL;
begin
  _SetSection(secWhere);
  FActiveOperator := opeWhere;
  if AExpression = '' then
    Result := Self
  else
    Result := &And(AExpression);
end;

function TCQL.Where(const AExpression: array of const): ICQL;
begin
  Result := Where(TUtils.SqlParamsToStr(AExpression));
end;

function TCQL.Where(const AExpression: ICQLCriteriaExpression): ICQL;
begin
  _SetSection(secWhere);
  FActiveOperator := opeWhere;
  Result := &And(AExpression);
end;

function TCQL.Year(const AValue: string): ICQL;
begin
  _AssertSection([secSelect, secJoin, secWhere]);
  _AssertHaveName;
  case FActiveSection of
    secSelect: FAST.ASTName.Name := FFunction.Year(AValue);
    secWhere: FActiveExpr.&Fun(FFunction.Year(AValue));
  end;
  Result := Self;
end;

function TCQL.From(const ATableName, AAlias: string): ICQL;
begin
  From(ATableName).&As(AAlias);
  Result := Self;
end;

function TCQL.FullJoin(const ATableName, AAlias: string): ICQL;
begin
  FullJoin(ATableName).&As(AAlias);
  Result := Self;
end;

function TCQL.NotIn(const AValue: string): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsNotIn(AValue));
  Result := Self;
end;

function TCQL.Equal(const AValue: TDateTime): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsEqual(AValue));
  Result := Self;
end;

function TCQL.Equal(const AValue: TDate): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsEqual(AValue));
  Result := Self;
end;

function TCQL.GreaterEqThan(const AValue: TDateTime): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsGreaterEqThan(AValue));
  Result := Self;
end;

function TCQL.GreaterEqThan(const AValue: TDate): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsGreaterEqThan(AValue));
  Result := Self;
end;

function TCQL.GreaterThan(const AValue: TDate): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsGreaterThan(AValue));
  Result := Self;
end;

function TCQL.GreaterThan(const AValue: TDateTime): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsGreaterThan(AValue));
  Result := Self;
end;

function TCQL.LessEqThan(const AValue: TDateTime): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsLessEqThan(AValue));
  Result := Self;
end;

function TCQL.LessEqThan(const AValue: TDate): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsLessEqThan(AValue));
  Result := Self;
end;

function TCQL.LessThan(const AValue: TDateTime): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsLessThan(AValue));
  Result := Self;
end;

function TCQL.LessThan(const AValue: TDate): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsLessThan(AValue));
  Result := Self;
end;

function TCQL.NotEqual(const AValue: TDate): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsNotEqual(AValue));
  Result := Self;
end;

function TCQL.NotEqual(const AValue: TDateTime): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsNotEqual(AValue));
  Result := Self;
end;

function TCQL.Equal(const AValue: TGUID): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsEqual(AValue));
  Result := Self;
end;

class function TCQL.New: ICQL;
begin
  Result := Self.Create(FDatabaseDafault);
end;

function TCQL.NotEqual(const AValue: TGUID): ICQL;
begin
  _AssertOperator([opeWhere, opeAND, opeOR]);
  FActiveExpr.&Ope(FOperator.IsNotEqual(AValue));
  Result := Self;
end;

end.

