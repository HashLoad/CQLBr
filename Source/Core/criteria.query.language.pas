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

{ @abstract(CQLBr Framework)
  @created(18 Jul 2019)
  @author(Isaque Pinheiro <isaquesp@gmail.com>)
  @author(Site : https://www.isaquepinheiro.com.br)
}

unit criteria.query.language;

interface

uses
  SysUtils,
  cqlbr.functions,
  cqlbr.interfaces,
  cqlbr.cases,
  cqlbr.select,
  cqlbr.core,
  cqlbr.utils,
  cqlbr.serialize,
  cqlbr.qualifier,
  cqlbr.ast,
  cqlbr.expression;

type
  CQL = cqlbr.functions.CQL;
  TDBName = cqlbr.interfaces.TDBName;

  TCriteria = class(TInterfacedObject, ICriteria)
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
   var
    FActiveSection: TSection;
    FActiveExpr: ICQLCriteriaExpression;
    FActiveValues: ICQLNameValuePairs;
    FDatabase: TDBName;
    FAST: ICQLAST;
    procedure AssertSection(ASections: TSections);
    procedure AssertHaveName;
    function CreateJoin(AjoinType: TJoinType; const ATableName: String): ICriteria;
    function InternalSet(const AColumnName, AColumnValue: String): ICriteria;
    procedure SetSection(ASection: TSection);
  public
    constructor Create(const ADatabase: TDBName);
    class function New(const ADatabase: TDBName): ICriteria;
    function &And(const AExpression: array of const): ICriteria; overload;
    function &And(const AExpression: String): ICriteria; overload;
    function &And(const AExpression: ICQLCriteriaExpression): ICriteria; overload;
    function &As(const AAlias: String): ICriteria;
    function &Case(const AExpression: String = ''): ICQLCriteriaCase; overload;
    function &Case(const AExpression: array of const): ICQLCriteriaCase; overload;
    function &Case(const AExpression: ICQLCriteriaExpression): ICQLCriteriaCase; overload;
    function Clear: ICriteria;
    function ClearAll: ICriteria;
    function All: ICriteria;
    function Column(const AColumnName: String): ICriteria; overload;
    function Column(const ADBName, AColumnName: String): ICriteria; overload;
    function Column(const AColumnsName: array of const): ICriteria; overload;
    function Column(const ACaseExpression: ICQLCriteriaCase): ICriteria; overload;
    function Delete: ICriteria;
    function Desc: ICriteria;
    function Distinct: ICriteria;
    function IsEmpty: Boolean;
    function Expression(const ATerm: String = ''): ICQLCriteriaExpression; overload;
    function Expression(const ATerm: array of const): ICQLCriteriaExpression; overload;
    function From(const AExpression: ICQLCriteriaExpression): ICriteria; overload;
    function From(const AQuery: ICriteria): ICriteria; overload;
    function From(const ATableName: String): ICriteria; overload;
    function GroupBy(const AColumnName: String = ''): ICriteria;
    function Having(const AExpression: String = ''): ICriteria; overload;
    function Having(const AExpression: array of const): ICriteria; overload;
    function Having(const AExpression: ICQLCriteriaExpression): ICriteria; overload;
    function Insert: ICriteria;
    function Into(const ATableName: String): ICriteria;
    function FullJoin(const ATableName: String): ICriteria;
    function InnerJoin(const ATableName: String): ICriteria;
    function LeftJoin(const ATableName: String): ICriteria;
    function RightJoin(const ATableName: String): ICriteria;
    function &On(const AExpression: String): ICriteria; overload;
    function &On(const AExpression: array of const): ICriteria; overload;
    function &Or(const AExpression: array of const): ICriteria; overload;
    function &Or(const AExpression: String): ICriteria; overload;
    function &Or(const AExpression: ICQLCriteriaExpression): ICriteria; overload;
    function OrderBy(const AColumnName: String = ''): ICriteria; overload;
    function OrderBy(const ACaseExpression: ICQLCriteriaCase): ICriteria; overload;
    function Select(const AColumnName: String = ''): ICriteria; overload;
    function Select(const ACaseExpression: ICQLCriteriaCase): ICriteria; overload;
    function &Set(const AColumnName, AColumnValue: String): ICriteria; overload;
    function &Set(const AColumnName: String; const AColumnValue: array of const): ICriteria; overload;
    function Values(const AColumnName, AColumnValue: String): ICriteria; overload;
    function Values(const AColumnName: String; const AColumnValue: array of const): ICriteria; overload;
    function First(AValue: Integer): ICriteria;
    function Skip(AValue: Integer): ICriteria;
    function Limit(AValue: Integer): ICriteria;
    function Offset(AValue: Integer): ICriteria;
    function Update(const ATableName: String): ICriteria;
    function Where(const AExpression: String = ''): ICriteria; overload;
    function Where(const AExpression: array of const): ICriteria; overload;
    function Where(const AExpression: ICQLCriteriaExpression): ICriteria; overload;
    function AsString: String;
//    function AST: ICQLAST;
  end;

implementation

uses
  cqlbr.db.register;

{ TCriteria }

function TCriteria.&As(const AAlias: String): ICriteria;
begin
  AssertSection([secSelect, secDelete, secJoin]);
  AssertHaveName;
  FAST.ASTName.Alias := AAlias;
  Result := Self;
end;

function TCriteria.&Case(const AExpression: String): ICQLCriteriaCase;
var
  LExpression: String;
begin
  LExpression := AExpression;
  if LExpression = '' then
    LExpression := FAST.ASTName.Name;
  Result := TCQLCriteriaCase.Create(Self, LExpression);
  if Assigned(FAST) then
    FAST.ASTName.&Case := Result.&Case;
end;

function TCriteria.&Case(const AExpression: array of const): ICQLCriteriaCase;
begin
  Result := &Case(TUtils.SqlParamsToStr(AExpression));
end;

function TCriteria.&Case(const AExpression: ICQLCriteriaExpression): ICQLCriteriaCase;
begin
  Result := TCQLCriteriaCase.Create(Self, '');
  Result.&And(AExpression);
end;

function TCriteria.&And(const AExpression: ICQLCriteriaExpression): ICriteria;
begin
  FActiveExpr.&And(AExpression.Expression);
  Result := Self;
end;

function TCriteria.&And(const AExpression: String): ICriteria;
begin
  FActiveExpr.&And(AExpression);
  Result := Self;
end;

function TCriteria.&And(const AExpression: array of const): ICriteria;
begin
  Result := &And(TUtils.SqlParamsToStr(AExpression));
end;

function TCriteria.&Or(const AExpression: array of const): ICriteria;
begin
  Result := &Or(TUtils.SqlParamsToStr(AExpression));
end;

function TCriteria.&Or(const AExpression: String): ICriteria;
begin
  FActiveExpr.&Or(AExpression);
  Result := Self;
end;

function TCriteria.&Or(const AExpression: ICQLCriteriaExpression): ICriteria;
begin
  FActiveExpr.&Or(AExpression.Expression);
  Result := Self;
end;

function TCriteria.&Set(const AColumnName: String; const AColumnValue: array of const): ICriteria;
begin
  Result := InternalSet(AColumnName, TUtils.SqlParamsToStr(AColumnValue));
end;

function TCriteria.&Set(const AColumnName, AColumnValue: String): ICriteria;
begin
  Result := InternalSet(AColumnName, QuotedStr(AColumnValue));
end;

function TCriteria.&On(const AExpression: String): ICriteria;
begin
  Result := &And(AExpression);
end;

function TCriteria.Offset(AValue: Integer): ICriteria;
begin
  Result := Skip(AValue);
end;

function TCriteria.&On(const AExpression: array of const): ICriteria;
begin
  Result := &On(TUtils.SqlParamsToStr(AExpression));
end;

function TCriteria.All: ICriteria;
begin
  Result := Column('*');
end;

procedure TCriteria.AssertHaveName;
begin
  if not Assigned(FAST.ASTName) then
    raise Exception.Create('TCriteria: Curernt name is not set');
end;

procedure TCriteria.AssertSection(ASections: TSections);
begin
  if not (FActiveSection in ASections) then
    raise Exception.Create('TCriteria: Not supported in this section');
end;

function TCriteria.AsString: String;
begin
  Result := TDBRegister.GetSerialize(FDatabase).AsString(FAST);
end;

//function TCriteria.AST: ICQLAST;
//begin
//  Result := FAST;
//end;

function TCriteria.Column(const AColumnName: String): ICriteria;
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

function TCriteria.Column(const ADBName, AColumnName: String): ICriteria;
begin
  Result := Column(ADBName + '.' + AColumnName);
end;

function TCriteria.Clear: ICriteria;
begin
  FAST.ASTSection.Clear;
  Result := Self;
end;

function TCriteria.ClearAll: ICriteria;
begin
  FAST.Clear;
  Result := Self;
end;

function TCriteria.Column(const ACaseExpression: ICQLCriteriaCase): ICriteria;
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

function TCriteria.Column(const AColumnsName: array of const): ICriteria;
begin
  Result := Column(TUtils.SqlParamsToStr(AColumnsName));
end;

constructor TCriteria.Create(const ADatabase: TDBName);
begin
  FDatabase := ADatabase;
  FAST := TCQLAST.New(ADatabase);
  FAST.Clear;
end;

function TCriteria.CreateJoin(AjoinType: TJoinType; const ATableName: String): ICriteria;
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

function TCriteria.Delete: ICriteria;
begin
  SetSection(secDelete);
  Result := Self;
end;

function TCriteria.Desc: ICriteria;
begin
  AssertSection([secOrderBy]);
  Assert(FAST.ASTColumns.Count > 0, 'TCriteria.Desc: No columns set up yet');
  (FAST.OrderBy.Columns[FAST.OrderBy.Columns.Count -1] as ICQLOrderByColumn).Direction := dirDescending;
  Result := Self;
end;

function TCriteria.Distinct: ICriteria;
var
  LQualifier: ICQLSelectQualifier;
begin
  AssertSection([secSelect]);
  LQualifier := FAST.Select.Qualifiers.Add;
  LQualifier.Qualifier := sqDistinct;
  Result := Self;
end;

function TCriteria.Expression(const ATerm: array of const): ICQLCriteriaExpression;
begin
  Result := Expression(TUtils.SqlParamsToStr(ATerm));
end;

function TCriteria.Expression(const ATerm: String): ICQLCriteriaExpression;
begin
  Result := TCQLCriteriaExpression.Create(ATerm);
end;

function TCriteria.First(AValue: Integer): ICriteria;
var
  LQualifier: ICQLSelectQualifier;
begin
  AssertSection([secSelect]);
  LQualifier := FAST.Select.Qualifiers.Add;
  LQualifier.Qualifier := sqFirst;
  LQualifier.Value := AValue;
  Result := Self;
end;

function TCriteria.From(const AExpression: ICQLCriteriaExpression): ICriteria;
begin
  Result := From('(' + AExpression.AsString + ')');
end;

function TCriteria.From(const AQuery: ICriteria): ICriteria;
begin
  Result := From('(' + AQuery.AsString + ')');
end;

function TCriteria.From(const ATableName: String): ICriteria;
begin
  AssertSection([secSelect, secDelete]);
  FAST.ASTName := FAST.ASTTableNames.Add;
  FAST.ASTName.Name := ATableName;
  Result := Self;
end;

function TCriteria.FullJoin(const ATableName: String): ICriteria;
begin
  Result := CreateJoin(jtFULL, ATableName);
end;

function TCriteria.GroupBy(const AColumnName: String): ICriteria;
begin
  SetSection(secGroupBy);
  if AColumnName = '' then
    Result := Self
  else
    Result := Column(AColumnName);
end;

function TCriteria.Having(const AExpression: String): ICriteria;
begin
  SetSection(secHaving);
  if AExpression = '' then
    Result := Self
  else
    Result := &And(AExpression);
end;

function TCriteria.Having(const AExpression: array of const): ICriteria;
begin
  Result := Having(TUtils.SqlParamsToStr(AExpression));
end;

function TCriteria.Having(const AExpression: ICQLCriteriaExpression): ICriteria;
begin
  SetSection(secHaving);
  Result := &And(AExpression);
end;

function TCriteria.InnerJoin(const ATableName: String): ICriteria;
begin
  Result := CreateJoin(jtINNER, ATableName);
end;

function TCriteria.Insert: ICriteria;
begin
  SetSection(secInsert);
  Result := Self;
end;

function TCriteria.InternalSet(const AColumnName, AColumnValue: String): ICriteria;
var
  LPair: ICQLNameValue;
begin
  AssertSection([secInsert, secUpdate]);
  LPair := FActiveValues.Add;
  LPair.Name := AColumnName;
  LPair.Value := AColumnValue;
  Result := Self;
end;

function TCriteria.Into(const ATableName: String): ICriteria;
begin
  AssertSection([secInsert]);
  FAST.Insert.TableName := ATableName;
  Result := Self;
end;

function TCriteria.IsEmpty: Boolean;
begin
  Result := FAST.ASTSection.IsEmpty;
end;

function TCriteria.LeftJoin(const ATableName: String): ICriteria;
begin
  Result := CreateJoin(jtLEFT, ATableName);
end;

function TCriteria.Limit(AValue: Integer): ICriteria;
begin
  Result := First(AValue);
end;

class function TCriteria.New(const ADatabase: TDBName): ICriteria;
begin
  Result := Self.Create(ADatabase);
end;

function TCriteria.OrderBy(const ACaseExpression: ICQLCriteriaCase): ICriteria;
begin
  SetSection(secOrderBy);
  Result := Column(ACaseExpression);
end;

function TCriteria.RightJoin(const ATableName: String): ICriteria;
begin
  Result := CreateJoin(jtRIGHT, ATableName);
end;

function TCriteria.OrderBy(const AColumnName: String): ICriteria;
begin
  SetSection(secOrderBy);
  if AColumnName = '' then
    Result := Self
  else
    Result := Column(AColumnName);
end;

function TCriteria.Select(const AColumnName: String): ICriteria;
begin
  SetSection(secSelect);
  if AColumnName = '' then
    Result := Self
  else
    Result := Column(AColumnName);
end;

function TCriteria.Select(const ACaseExpression: ICQLCriteriaCase): ICriteria;
begin
  SetSection(secSelect);
  Result := Column(ACaseExpression);
end;

procedure TCriteria.SetSection(ASection: TSection);
begin
  case ASection of
    secSelect:
      begin
        FAST.ASTSection := FAST.Select;
        FAST.ASTColumns := FAST.Select.Columns;
        FAST.ASTTableNames := FAST.Select.TableNames;
        FActiveExpr := nil;
        FActiveValues := nil;
      end;
    secDelete:
      begin
        FAST.ASTSection := FAST.Delete;
        FAST.ASTColumns := nil;
        FAST.ASTTableNames := FAST.Delete.TableNames;
        FActiveExpr := nil;
        FActiveValues := nil;
      end;
    secInsert:
      begin
        FAST.ASTSection := FAST.Insert;
        FAST.ASTColumns := FAST.Insert.Columns;
        FAST.ASTTableNames := nil;
        FActiveExpr := nil;
        FActiveValues := FAST.Insert.Values;
      end;
    secUpdate:
      begin
        FAST.ASTSection := FAST.Update;
        FAST.ASTColumns := nil;
        FAST.ASTTableNames := nil;
        FActiveExpr := nil;
        FActiveValues := FAST.Update.Values;
      end;
    secWhere:
      begin
        FAST.ASTSection := FAST.Where;
        FAST.ASTColumns := nil;
        FAST.ASTTableNames := nil;
        FActiveExpr := TCQLCriteriaExpression.Create(FAST.Where.Expression);
        FActiveValues := nil;
      end;
    secGroupBy:
      begin
        FAST.ASTSection := FAST.GroupBy;
        FAST.ASTColumns := FAST.GroupBy.Columns;
        FAST.ASTTableNames := nil;
        FActiveExpr := nil;
        FActiveValues := nil;
      end;
    secHaving:
      begin
        FAST.ASTSection := FAST.Having;
        FAST.ASTColumns   := nil;
        FActiveExpr := TCQLCriteriaExpression.Create(FAST.Having.Expression);
        FAST.ASTTableNames := nil;
        FActiveValues := nil;
      end;
    secOrderBy:
      begin
        FAST.ASTSection := FAST.OrderBy;
        FAST.ASTColumns := FAST.OrderBy.Columns;
        FAST.ASTTableNames := nil;
        FActiveExpr := nil;
        FActiveValues := nil;
      end;
    else
      raise Exception.Create('TCriteria.SetSection: Unknown section');
  end;
  FActiveSection := ASection;
end;

function TCriteria.Skip(AValue: Integer): ICriteria;
var
  LQualifier: ICQLSelectQualifier;
begin
  AssertSection([secSelect]);
  LQualifier := FAST.Select.Qualifiers.Add;
  LQualifier.Qualifier := sqSkip;
  LQualifier.Value := AValue;
  Result := Self;
end;

function TCriteria.Update(const ATableName: String): ICriteria;
begin
  SetSection(secUpdate);
  FAST.Update.TableName := ATableName;
  Result := Self;
end;

function TCriteria.Values(const AColumnName: String; const AColumnValue: array of const): ICriteria;
begin
  Result := InternalSet(AColumnName, TUtils.SqlParamsToStr(AColumnValue));
end;

function TCriteria.Values(const AColumnName, AColumnValue: String): ICriteria;
begin
  Result := InternalSet(AColumnName, QuotedStr(AColumnValue));
end;

function TCriteria.Where(const AExpression: String): ICriteria;
begin
  SetSection(secWhere);
  if AExpression = '' then
    Result := Self
  else
    Result := &And(AExpression);
end;

function TCriteria.Where(const AExpression: array of const): ICriteria;
begin
  Result := Where(TUtils.SqlParamsToStr(AExpression));
end;

function TCriteria.Where(const AExpression: ICQLCriteriaExpression): ICriteria;
begin
  SetSection(secWhere);
  Result := &And(AExpression);
end;

end.
