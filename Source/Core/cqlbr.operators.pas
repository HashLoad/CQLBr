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

  @colaborador(Gabriel Baltazar - Autor da classe)
}

unit cqlbr.operators;

interface

uses
  SysUtils,
  Variants,
  cqlbr.interfaces,
  cqlbr.utils;

type
  TCQLOperator = class(TInterfacedObject, ICQLOperator)
  protected
    FColumnName: String;
    FCompare: TCQLOperatorCompare;
    FValue: Variant;
    FDataType: TCQLDataFieldType;
    function GetOperator: String;
    function GetCompareValue: String; virtual;
    function GetColumnName: String;
    function GetCompare: TCQLOperatorCompare;
    function GetValue: Variant;
    function GetDataType: TCQLDataFieldType;
    procedure SetColumnName(const Value: String);
    procedure SetCompare(const Value: TCQLOperatorCompare);
    procedure SetValue(const Value: Variant);
    procedure SetdataType(const Value: TCQLDataFieldType);
    constructor Create;
  public
    class function New: ICQLOperator;
    destructor Destroy; override;
    property ColumnName:String read GetcolumnName write SetcolumnName;
    property Compare: TCQLOperatorCompare read Getcompare    write Setcompare;
    property Value: Variant read Getvalue write Setvalue;
    property DataType: TCQLDataFieldType read GetdataType   write SetdataType;
    function AsString: String;
end;

implementation

{ TCQLOperator }

function TCQLOperator.AsString: String;
begin
  Result := TUtils.Concat([FColumnName, GetOperator, GetCompareValue] );
end;

constructor TCQLOperator.Create;
begin
end;

destructor TCQLOperator.Destroy;
begin

  inherited;
end;

function TCQLOperator.GetcolumnName: String;
begin
  Result := FColumnName;
end;

function TCQLOperator.Getcompare: TCQLOperatorCompare;
begin
  Result := FCompare;
end;

function TCQLOperator.GetCompareValue: String;
begin
  if VarIsNull(FValue) then
    Exit;
  case FDataType of
    dftString:
      begin
        Result := VarToStrDef(FValue, EmptyStr);
        case FCompare of
          fcLikeFull,
          fcNotLikeFull:  Result := TUtils.Concat(['%', Result, '%'], EmptyStr);
          fcLikeLeft,
          fcNotLikeLeft:  Result := TUtils.Concat(['%', Result], EmptyStr);
          fcLikeRight,
          fcNotLikeRight: Result := TUtils.Concat([Result, '%'], EmptyStr);
        end;
        Result := QuotedStr(Result);
      end;
    dftInteger:
      Result := VarToStrDef(FValue, EmptyStr);
    dftFloat:
      Result := FloatToStr(FValue).Replace(',', '.');
    dftDate:
      Result := VarToWideStrDef(FValue, EmptyStr);
  end;
end;

function TCQLOperator.GetdataType: TCQLDataFieldType;
begin
  Result := FDataType;
end;

function TCQLOperator.getOperator: String;
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
    fcLikeFull,
    fcLikeLeft,
    fcLikeRight    : Result := 'like';
    fcNotLikeFull,
    fcNotLikeLeft,
    fcNotLikeRight : Result := 'not like';
  end;
end;

function TCQLOperator.Getvalue: Variant;
begin
  Result := FValue;
end;

class function TCQLOperator.New: ICQLOperator;
begin
  Result := Self.Create;
end;

procedure TCQLOperator.SetcolumnName(const Value: String);
begin
  FColumnName := Value;
end;

procedure TCQLOperator.Setcompare(const Value: TCQLOperatorCompare);
begin
  FCompare := Value;
end;

procedure TCQLOperator.SetdataType(const Value: TCQLDataFieldType);
begin
  FDataType := Value;
end;

procedure TCQLOperator.Setvalue(const Value: Variant);
begin
  FValue := Value;
end;

end.
