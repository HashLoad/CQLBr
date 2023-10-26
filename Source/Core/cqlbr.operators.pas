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

unit cqlbr.operators;


{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  SysUtils,
  StrUtils,
  Variants,
  cqlbr.interfaces,
  cqlbr.utils;

type
  TCQLOperator = class(TInterfacedObject, ICQLOperator)
  strict private
    FDatabase: TDBName;
    function _GetColumnName: string;
    function _GetCompare: TCQLOperatorCompare;
    function _GetValue: Variant;
    function _GetDataType: TCQLDataFieldType;
    procedure _SetColumnName(const Value: string);
    procedure _SetCompare(const Value: TCQLOperatorCompare);
    procedure _SetValue(const Value: Variant);
    procedure _SetdataType(const Value: TCQLDataFieldType);
    function _ArrayValueToString: string;
    constructor CreatePrivate(const ADatabase: TDBName);
  protected
    FColumnName: string;
    FCompare: TCQLOperatorCompare;
    FValue: Variant;
    FDataType: TCQLDataFieldType;
    function GetOperator: string;
    function GetCompareValue: string; virtual;
  public
    class function New(const ADatabase: TDBName): ICQLOperator;
    destructor Destroy; override;
    constructor Create;
    property ColumnName:String read _GetColumnName write _SetColumnName;
    property Compare: TCQLOperatorCompare read _GetCompare write _SetCompare;
    property Value: Variant read _GetValue write _SetValue;
    property DataType: TCQLDataFieldType read _GetDataType write _SetdataType;
    function AsString: string;
  end;

  TCQLOperators = class(TInterfacedObject, ICQLOperators)
  private
    FDatabase: TDBName;
    constructor CreatePrivate(const ADatabase: TDBName);
    function CreateOperator(const AColumnName: string;
      const AValue: Variant;
      const ACompare: TCQLOperatorCompare;
      const ADataType: TCQLDataFieldType): ICQLOperator;
  public
    class function New(const ADatabase: TDBName): ICQLOperators;
    function IsEqual(const AValue: Extended) : string; overload;
    function IsEqual(const AValue: Integer): string; overload;
    function IsEqual(const AValue: string): string; overload;
    function IsEqual(const AValue: TDate): string; overload;
    function IsEqual(const AValue: TDateTime): string; overload;
    function IsEqual(const AValue: TGUID): string; overload;
    function IsNotEqual(const AValue: Extended): string; overload;
    function IsNotEqual(const AValue: Integer): string; overload;
    function IsNotEqual(const AValue: string): string; overload;
    function IsNotEqual(const AValue: TDate): string; overload;
    function IsNotEqual(const AValue: TDateTime): string; overload;
    function IsNotEqual(const AValue: TGUID): string; overload;
    function IsGreaterThan(const AValue: Extended): string; overload;
    function IsGreaterThan(const AValue: Integer): string; overload;
    function IsGreaterThan(const AValue: TDate): string; overload;
    function IsGreaterThan(const AValue: TDateTime): string; overload;
    function IsGreaterEqThan(const AValue: Extended): string; overload;
    function IsGreaterEqThan(const AValue: Integer): string; overload;
    function IsGreaterEqThan(const AValue: TDate): string; overload;
    function IsGreaterEqThan(const AValue: TDateTime): string; overload;
    function IsLessThan(const AValue: Extended): string; overload;
    function IsLessThan(const AValue: Integer): string; overload;
    function IsLessThan(const AValue: TDate): string; overload;
    function IsLessThan(const AValue: TDateTime): string; overload;
    function IsLessEqThan(const AValue: Extended): string; overload;
    function IsLessEqThan(const AValue: Integer) : string; overload;
    function IsLessEqThan(const AValue: TDate) : string; overload;
    function IsLessEqThan(const AValue: TDateTime) : string; overload;
    function IsNull: string;
    function IsNotNull: string;
    function IsLike(const AValue: string): string;
    function IsLikeFull(const AValue: string): string;
    function IsLikeLeft(const AValue: string): string;
    function IsLikeRight(const AValue: string): string;
    function IsNotLike(const AValue: string): string;
    function IsNotLikeFull(const AValue: string): string;
    function IsNotLikeLeft(const AValue: string): string;
    function IsNotLikeRight(const AValue: string): string;

    function IsIn(const AValue: TArray<Double>): string; overload;

    function IsIn(const AValue: TArray<String>): string; overload;
    function IsIn(const AValue: string): string; overload;
    function IsNotIn(const AValue: TArray<Double>): string; overload;
    function IsNotIn(const AValue: TArray<String>): string; overload;
    function IsNotIn(const AValue: string): string; overload;
    function IsExists(const AValue: string): string; overload;
    function IsNotExists(const AValue: string): string; overload;
  end;

implementation

{ TCQLOperator }

function TCQLOperator.AsString: string;
begin
  Result := TUtils.Concat([FColumnName, GetOperator, GetCompareValue] );
end;

constructor TCQLOperator.Create;
begin
end;

constructor TCQLOperator.CreatePrivate(const ADatabase: TDBName);
begin
  FDatabase := ADatabase;
end;

destructor TCQLOperator.Destroy;
begin

  inherited;
end;

function TCQLOperator._GetColumnName: string;
begin
  Result := FColumnName;
end;

function TCQLOperator._GetCompare: TCQLOperatorCompare;
begin
  Result := FCompare;
end;

function TCQLOperator.GetCompareValue: string;
begin
  if VarIsNull(FValue) then
    Exit;
  case FDataType of
    dftString:
      begin
        Result := VarToStrDef(FValue, EmptyStr);
        case FCompare of
          fcLike,
          fcNotLike:      Result := QuotedStr(TUtils.Concat([Result], EmptyStr));
          fcLikeFull,
          fcNotLikeFull:  Result := QuotedStr(TUtils.Concat(['%', Result, '%'], EmptyStr));
          fcLikeLeft,
          fcNotLikeLeft:  Result := QuotedStr(TUtils.Concat(['%', Result], EmptyStr));
          fcLikeRight,
          fcNotLikeRight: Result := QuotedStr(TUtils.Concat([Result, '%'], EmptyStr));
        end;
//        Result := QuotedStr(Result);
      end;
    dftInteger:  Result := VarToStrDef(FValue, EmptyStr);
    dftFloat:    Result := ReplaceStr(FloatToStr(FValue), ',', '.');
    dftDate:     Result := QuotedStr(TUtils.DateToSQLFormat(FDatabase, VarToDateTime(FValue)));
    dftDateTime: Result := QuotedStr(TUtils.DateTimeToSQLFormat(FDatabase, VarToDateTime(FValue)));
    dftGuid:     Result := TUtils.GuidStrToSQLFormat(FDatabase, StringToGUID(FValue));
    dftArray:    Result := _ArrayValueToString;
    dftBoolean:  result := BoolToStr(FValue);
    dftText:     Result := '(' + FValue + ')';
  end;
end;

function TCQLOperator._GetDataType: TCQLDataFieldType;
begin
  Result := FDataType;
end;

function TCQLOperator.GetOperator: string;
begin
  case FCompare of
    fcEqual        : Result := '=';
    fcNotEqual     : Result := '<>';
    fcGreater      : Result := '>';
    fcGreaterEqual : Result := '>=';
    fcLess         : Result := '<';
    fcLessEqual    : Result := '<=';
    fcIn           : Result := 'in';
    fcNotIn        : Result := 'not in';
    fcIsNull       : Result := 'is null';
    fcIsNotNull    : Result := 'is not null';
    fcBetween      : Result := 'between';
    fcNotBetween   : Result := 'not between';
    fcExists       : Result := 'exists';
    fcNotExists    : Result := 'not exists';
    fcLike,
    fcLikeFull,
    fcLikeLeft,
    fcLikeRight    : Result := 'like';
    fcNotLike,
    fcNotLikeFull,
    fcNotLikeLeft,
    fcNotLikeRight : Result := 'not like';
  end;
end;

function TCQLOperator._GetValue: Variant;
begin
  Result := FValue;
end;

class function TCQLOperator.New(const ADatabase: TDBName): ICQLOperator;
begin
  Result := Self.CreatePrivate(ADatabase);
end;

procedure TCQLOperator._SetColumnName(const Value: string);
begin
  FColumnName := Value;
end;

procedure TCQLOperator._SetCompare(const Value: TCQLOperatorCompare);
begin
  FCompare := Value;
end;

procedure TCQLOperator._SetdataType(const Value: TCQLDataFieldType);
begin
  FDataType := Value;
end;

procedure TCQLOperator._SetValue(const Value: Variant);
begin
  FValue := Value;
end;

function TCQLOperator._ArrayValueToString: string;
var
  LFor: Integer;
  LValue: Variant;
  LValues: array of Variant;
begin
  Result := '(';
  LValues:= FValue;
  for LFor := 0 to Length(LValues) -1 do
  begin
    LValue := LValues[LFor];
    Result := Result + IfThen(LFor = 0, EmptyStr, ', ');
    Result := Result + IfThen(VarTypeAsText(VarType(LValue)) = 'OleStr',
                              QuotedStr(VarToStr(LValue)),
                              ReplaceStr(VarToStr(LValue), ',', '.'));
  end;
  Result := Result + ')';
end;

{ TCQLOperators }

function TCQLOperators.CreateOperator(const AColumnName: string;
  const AValue: Variant;
  const ACompare: TCQLOperatorCompare;
  const ADataType: TCQLDataFieldType): ICQLOperator;
begin
  Result := TCQLOperator.New(FDatabase);
  Result.ColumnName := AColumnName;
  Result.Compare := ACompare;
  Result.Value := AValue;
  Result.DataType := ADataType;
end;

function TCQLOperators.IsEqual(const AValue: Integer): string;
begin
  Result := CreateOperator('', AValue, fcEqual, dftInteger).AsString;
end;

function TCQLOperators.IsEqual(const AValue: Extended): string;
begin
  Result := CreateOperator('', AValue, fcEqual, dftFloat).AsString;
end;

constructor TCQLOperators.CreatePrivate(const ADatabase: TDBName);
begin
  FDatabase := ADatabase;
end;

function TCQLOperators.IsEqual(const AValue: string): string;
begin
  Result := CreateOperator('', AValue, fcEqual, dftString).AsString;
end;

function TCQLOperators.IsExists(const AValue: string): string;
begin
  Result := CreateOperator('', AValue, fcExists, dftText).AsString;
end;

function TCQLOperators.IsGreaterEqThan(const AValue: Extended): string;
begin
  Result := CreateOperator('', AValue, fcGreaterEqual, dftFloat).AsString;
end;

function TCQLOperators.IsGreaterEqThan(const AValue: Integer): string;
begin
  Result := CreateOperator('', AValue, fcGreaterEqual, dftInteger).AsString;
end;

function TCQLOperators.IsGreaterThan(const AValue: Integer): string;
begin
  Result := CreateOperator('', AValue, fcGreater, dftInteger).AsString;
end;

function TCQLOperators.IsIn(const AValue: string): string;
begin
  Result := CreateOperator('', AValue, fcIn, dftText).AsString;
end;

function TCQLOperators.IsIn(const AValue: TArray<String>): string;
begin
  Result := CreateOperator('', AValue, fcIn, dftArray).AsString;
end;

function TCQLOperators.IsIn(const AValue: TArray<Double>): string;
begin
  Result := CreateOperator('', AValue, fcIn, dftArray).AsString;
end;

function TCQLOperators.IsGreaterThan(const AValue: Extended): string;
begin
  Result := CreateOperator('', AValue, fcGreater, dftFloat).AsString;
end;

function TCQLOperators.IsLessEqThan(const AValue: Extended): string;
begin
  Result := CreateOperator('', AValue, fcLessEqual, dftFloat).AsString;
end;

function TCQLOperators.IsLessEqThan(const AValue: Integer): string;
begin
  Result := CreateOperator('', AValue, fcLessEqual, dftInteger).AsString;
end;

function TCQLOperators.IsLessThan(const AValue: Extended): string;
begin
  Result := CreateOperator('', AValue, fcLess, dftFloat).AsString;
end;

function TCQLOperators.IsLessThan(const AValue: Integer): string;
begin
  Result := CreateOperator('', AValue, fcLess, dftInteger).AsString;
end;

function TCQLOperators.IsLike(const AValue: string): string;
begin
  Result := CreateOperator('', AValue, fcLike, dftString).AsString;
end;

function TCQLOperators.IsLikeFull(const AValue: string): string;
begin
  Result := CreateOperator('', AValue, fcLikeFull, dftString).AsString;
end;

function TCQLOperators.IsLikeLeft(const AValue: string): string;
begin
  Result := CreateOperator('', AValue, fcLikeLeft, dftString).AsString;
end;

function TCQLOperators.IsLikeRight(const AValue: string): string;
begin
  Result := CreateOperator('', AValue, fcLikeRight, dftString).AsString;
end;

function TCQLOperators.IsNotEqual(const AValue: Extended): string;
begin
  Result := CreateOperator('', AValue, fcNotEqual, dftFloat).AsString;
end;

function TCQLOperators.IsNotEqual(const AValue: string): string;
begin
  Result := CreateOperator('', AValue, fcNotEqual, dftString).AsString;
end;

function TCQLOperators.IsNotEqual(const AValue: TDate): string;
begin
  Result := CreateOperator('', AValue, fcNotEqual, dftDate).AsString;
end;

function TCQLOperators.IsNotEqual(const AValue: TDateTime): string;
begin
  Result := CreateOperator('', AValue, fcNotEqual, dftDateTime).AsString;
end;

function TCQLOperators.IsNotExists(const AValue: string): string;
begin
  Result := CreateOperator('', AValue, fcNotExists, dftText).AsString;
end;

function TCQLOperators.IsNotEqual(const AValue: Integer): string;
begin
  Result := CreateOperator('', AValue, fcNotEqual, dftInteger).AsString;
end;

function TCQLOperators.IsNotLike(const AValue: string): string;
begin
  Result := CreateOperator('', AValue, fcNotLike, dftString).AsString;
end;

function TCQLOperators.IsNotLikeFull(const AValue: string): string;
begin
  Result := CreateOperator('', AValue, fcNotLikeFull, dftString).AsString;
end;

function TCQLOperators.IsNotLikeLeft(const AValue: string): string;
begin
  Result := CreateOperator('', AValue, fcNotLikeLeft, dftString).AsString;
end;

function TCQLOperators.IsNotLikeRight(const AValue: string): string;
begin
  Result := CreateOperator('', AValue, fcNotLikeRight, dftString).AsString;
end;

function TCQLOperators.IsNotNull: string;
begin
  Result := CreateOperator('', Null, fcIsNotNull, dftUnknown).AsString;
end;

function TCQLOperators.IsNull: string;
begin
  Result := CreateOperator('', Null, fcIsNull, dftUnknown).AsString;
end;

class function TCQLOperators.New(const ADatabase: TDBName): ICQLOperators;
begin
  Result := Self.CreatePrivate(ADatabase);
end;

function TCQLOperators.IsNotIn(const AValue: TArray<String>): string;
begin
  Result := CreateOperator('', AValue, fcNotIn, dftArray).AsString;
end;

function TCQLOperators.IsNotIn(const AValue: TArray<Double>): string;
begin
  Result := CreateOperator('', AValue, fcNotIn, dftArray).AsString;
end;

function TCQLOperators.IsNotIn(const AValue: string): string;
begin
  Result := CreateOperator('', AValue, fcNotIn, dftText).AsString;
end;

function TCQLOperators.IsEqual(const AValue: TDateTime): string;
begin
  Result := CreateOperator('', AValue, fcEqual, dftDateTime).AsString;
end;

function TCQLOperators.IsEqual(const AValue: TDate): string;
begin
  Result := CreateOperator('', AValue, fcEqual, dftDate).AsString;
end;

function TCQLOperators.IsGreaterEqThan(const AValue: TDateTime): string;
begin
  Result := CreateOperator('', AValue, fcGreaterEqual, dftDateTime).AsString;
end;

function TCQLOperators.IsGreaterEqThan(const AValue: TDate): string;
begin
  Result := CreateOperator('', AValue, fcGreaterEqual, dftDate).AsString;
end;

function TCQLOperators.IsGreaterThan(const AValue: TDate): string;
begin
  Result := CreateOperator('', AValue, fcGreater, dftDate).AsString;
end;

function TCQLOperators.IsGreaterThan(const AValue: TDateTime): string;
begin
  Result := CreateOperator('', AValue, fcGreater, dftDateTime).AsString;
end;

function TCQLOperators.IsLessEqThan(const AValue: TDateTime): string;
begin
  Result := CreateOperator('', AValue, fcLessEqual, dftDateTime).AsString;
end;

function TCQLOperators.IsLessEqThan(const AValue: TDate): string;
begin
  Result := CreateOperator('', AValue, fcLessEqual, dftDate).AsString;
end;

function TCQLOperators.IsLessThan(const AValue: TDateTime): string;
begin
  Result := CreateOperator('', AValue, fcLess, dftDateTime).AsString;
end;

function TCQLOperators.IsLessThan(const AValue: TDate): string;
begin
  Result := CreateOperator('', AValue, fcLess, dftDate).AsString;
end;

function TCQLOperators.IsEqual(const AValue: TGUID): string;
begin
  Result := CreateOperator('', AValue.ToString, fcEqual, dftGuid).AsString;
end;

function TCQLOperators.IsNotEqual(const AValue: TGUID): string;
begin
  Result := CreateOperator('', AValue.ToString, fcNotEqual, dftGuid).AsString;
end;

end.
