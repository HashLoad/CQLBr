{
         TCQLFunc Brasil - Criteria Query Language for Delphi/Lazarus


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

  @colaborador(Gabriel Baltazar)
}

unit cqlbr.functions;

interface

uses
  Variants,
  cqlbr.interfaces,
  cqlbr.operators;

type
  TCQLFunc = class(TInterfacedObject, ICQLFunc)
  private
    function CreateOperator(const AColumnName: String;
      const AValue: Variant;
      const ACompare: TCQLOperatorCompare;
      const ADataType: TCQLDataFieldType): ICQLOperator;
  public
    class function New: ICQLFunc;
    class function Count(const Value: String): String;
    class function Exists(const Value: String): String;
    class function Lower(const Value: String): String;
    class function Min(const Value: String): String;
    class function Max(const Value: String): String;
    class function &Not(const Value: String): String;
    class function Upper(const Value: String): String;
    class function Q(const Value: String): String;
    function IsEqual(const AValue: Extended) : String; overload;
    function IsEqual(const AValue: Integer): String; overload;
    function IsEqual(const AValue: String): String; overload;
    function IsNotEqual(const AValue: Extended): String; overload;
    function IsNotEqual(const AValue: Integer): String; overload;
    function IsNotEqual(const AValue: String): String; overload;
    function IsGreaterThan(const AValue: Extended): String; overload;
    function IsGreaterThan(const AValue: Integer): String; overload;
    function IsGreaterEqThan(const AValue: Extended): String; overload;
    function IsGreaterEqThan(const AValue: Integer): String; overload;
    function IsLessThan(const AValue: Extended): String; overload;
    function IsLessThan(const AValue: Integer): String; overload;
    function IsLessEqThan(const AValue: Extended): String; overload;
    function IsLessEqThan(const AValue: Integer) : String; overload;
    function IsNull: String;
    function IsNotNull: String;
    function IsLikeFull(const AValue: String): String;
    function IsLikeLeft(const AValue: String): String;
    function IsLikeRight(const AValue: String): String;
    function IsNotLikeFull(const AValue: String): String;
    function IsNotLikeLeft(const AValue: String): String;
    function IsNotLikeRight(const AValue: String): String;
  end;

implementation

uses
  cqlbr.utils;

{ TCQLFunc }

function TCQLFunc.CreateOperator(const AColumnName: String;
  const AValue: Variant;
  const ACompare: TCQLOperatorCompare;
  const ADataType: TCQLDataFieldType): ICQLOperator;
begin
  Result := TCQLOperator.New;
  Result.ColumnName := AColumnName;
  Result.Compare := ACompare;
  Result.Value := AValue;
  Result.DataType := ADataType;
end;

class function TCQLFunc.Count(const Value: String): String;
begin
  Result := 'Count(' + Value + ')';
end;

class function TCQLFunc.Exists(const Value: String): String;
begin
  Result := 'exists(' + Value + ')';
end;

function TCQLFunc.IsEqual(const AValue: Integer): String;
begin
  Result := CreateOperator('', AValue, fcEqual, dftInteger).AsString;
end;

function TCQLFunc.IsEqual(const AValue: Extended): String;
begin
  Result := CreateOperator('', AValue, fcEqual, dftFloat).AsString;
end;

function TCQLFunc.IsEqual(const AValue: String): String;
begin
  Result := CreateOperator('', AValue, fcEqual, dftString).AsString;
end;

function TCQLFunc.IsGreaterEqThan(const AValue: Extended): String;
begin
  Result := CreateOperator('', AValue, fcGreaterEqual, dftFloat).AsString;
end;

function TCQLFunc.IsGreaterEqThan(const AValue: Integer): String;
begin
  Result := CreateOperator('', AValue, fcGreaterEqual, dftInteger).AsString;
end;

function TCQLFunc.IsGreaterThan(const AValue: Integer): String;
begin
  Result := CreateOperator('', AValue, fcGreater, dftInteger).AsString;
end;

function TCQLFunc.IsGreaterThan(const AValue: Extended): String;
begin
  Result := CreateOperator('', AValue, fcGreater, dftFloat).AsString;
end;

function TCQLFunc.IsLessEqThan(const AValue: Extended): String;
begin
  Result := CreateOperator('', AValue, fcLessEqual, dftFloat).AsString;
end;

function TCQLFunc.IsLessEqThan(const AValue: Integer): String;
begin
  Result := CreateOperator('', AValue, fcLessEqual, dftInteger).AsString;
end;

function TCQLFunc.IsLessThan(const AValue: Extended): String;
begin
  Result := CreateOperator('', AValue, fcLess, dftFloat).AsString;
end;

function TCQLFunc.IsLessThan(const AValue: Integer): String;
begin
  Result := CreateOperator('', AValue, fcLess, dftInteger).AsString;
end;

function TCQLFunc.IsLikeFull(const AValue: String): String;
begin
  Result := CreateOperator('', AValue, fcLikeFull, dftString).AsString;
end;

function TCQLFunc.IsLikeLeft(const AValue: String): String;
begin
  Result := CreateOperator('', AValue, fcLikeLeft, dftString).AsString;
end;

function TCQLFunc.IsLikeRight(const AValue: String): String;
begin
  Result := CreateOperator('', AValue, fcLikeRight, dftString).AsString;
end;

function TCQLFunc.IsNotEqual(const AValue: Extended): String;
begin
  Result := CreateOperator('', AValue, fcNotEqual, dftFloat).AsString;
end;

function TCQLFunc.IsNotEqual(const AValue: String): String;
begin
  Result := CreateOperator('', AValue, fcNotEqual, dftString).AsString;
end;

function TCQLFunc.IsNotEqual(const AValue: Integer): String;
begin
  Result := CreateOperator('', AValue, fcNotEqual, dftInteger).AsString;
end;

function TCQLFunc.IsNotLikeFull(const AValue: String): String;
begin
  Result := CreateOperator('', AValue, fcNotLikeFull, dftString).AsString;
end;

function TCQLFunc.IsNotLikeLeft(const AValue: String): String;
begin
  Result := CreateOperator('', AValue, fcNotLikeLeft, dftString).AsString;
end;

function TCQLFunc.IsNotLikeRight(const AValue: String): String;
begin
  Result := CreateOperator('', AValue, fcNotLikeRight, dftString).AsString;
end;

function TCQLFunc.IsNotNull: String;
begin
  Result := CreateOperator('', Null, fcIsNotNull, dftUnknown).AsString;
end;

function TCQLFunc.IsNull: String;
begin
  Result := CreateOperator('', Null, fcIsNull, dftUnknown).AsString;
end;

class function TCQLFunc.Lower(const Value: String): String;
begin
  Result := 'Lower(' + Value + ')';
end;

class function TCQLFunc.Max(const Value: String): String;
begin
  Result := 'Max(' + Value + ')';
end;

class function TCQLFunc.Min(const Value: String): String;
begin
  Result := 'Min(' + Value + ')';
end;

class function TCQLFunc.New: ICQLFunc;
begin
  Result := Self.Create;
end;

class function TCQLFunc.&Not(const Value: String): String;
begin
  Result := 'not ' + Value;
end;

class function TCQLFunc.Q(const Value: String): String;
begin
  Result := '''' + Value + '''';
end;

class function TCQLFunc.Upper(const Value: String): String;
begin
  Result := 'Upper(' + Value + ')';
end;

end.
