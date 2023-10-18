{
         CQL Brasil - Criteria Query Language for Delphi/Lazarus


                   Copyright (c) 2019, Isaque Pinheiro
                          All rights reserved.

                    GNU Lesser General Public License
                      Vers�o 3, 29 de junho de 2007

       Copyright (C) 2007 Free Software Foundation, Inc. <http://fsf.org/>
       A todos � permitido copiar e distribuir c�pias deste documento de
       licen�a, mas mud�-lo n�o � permitido.

       Esta vers�o da GNU Lesser General Public License incorpora
       os termos e condi��es da vers�o 3 da GNU General Public License
       Licen�a, complementado pelas permiss�es adicionais listadas no
       arquivo LICENSE na pasta principal.
}

{
  @abstract(CQLBr Framework)
  @created(18 Jul 2019)
  @source(Inspired by and based on "GpSQLBuilder" project - https://github.com/gabr42/GpSQLBuilder)
  @source(Author of CQLBr Framework: Isaque Pinheiro <isaquesp@gmail.com>)
  @source(Author's Website: https://www.isaquepinheiro.com.br)
}

unit cqlbr.qualifier;

{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  SysUtils,
  Generics.Collections,
  cqlbr.interfaces;

type
  TCQLSelectQualifier = class(TInterfacedObject, ICQLSelectQualifier)
  strict private
    FQualifier: TSelectQualifierType;
    FValue: Integer;
    function _GetQualifier: TSelectQualifierType;
    function _GetValue: Integer;
    procedure _SetQualifier(const Value: TSelectQualifierType);
    procedure _SetValue(const Value: Integer);
  public
    property Qualifier: TSelectQualifierType read _GetQualifier write _SetQualifier;
    property Value: Integer read _GetValue write _SetValue;
  end;

  TCQLSelectQualifiers = class(TInterfacedObject, ICQLSelectQualifiers)
  protected
    FExecutingPagination: Boolean;
    FQualifiers: TList<ICQLSelectQualifier>;
    function _GetQualifier(AIdx: Integer): ICQLSelectQualifier;
    constructor Create;
  public
    destructor Destroy; override;
    function Add: ICQLSelectQualifier; overload;
    procedure Add(AQualifier: ICQLSelectQualifier); overload;
    procedure Clear;
    function ExecutingPagination: Boolean;
    function Count: Integer;
    function IsEmpty: Boolean;
    function SerializePagination: string; virtual; abstract;
    function SerializeDistinct: string;
    property Qualifiers[AIdx: Integer]: ICQLSelectQualifier read _GetQualifier; default;
  end;

implementation

uses
  cqlbr.utils;

{ TCQLSelectQualifiers }

function TCQLSelectQualifiers.Add: ICQLSelectQualifier;
begin
  Result := TCQLSelectQualifier.Create;
end;

procedure TCQLSelectQualifiers.Add(AQualifier: ICQLSelectQualifier);
begin
  FQualifiers.Add(AQualifier);
  if AQualifier.Qualifier in [sqFirst, sqSkip] then
    FExecutingPagination := True;
end;

procedure TCQLSelectQualifiers.Clear;
begin
  FExecutingPagination := False;
  FQualifiers.Clear;
end;

function TCQLSelectQualifiers.Count: Integer;
begin
  Result := FQualifiers.Count;
end;

constructor TCQLSelectQualifiers.Create;
begin
  FExecutingPagination := False;
  FQualifiers := TList<ICQLSelectQualifier>.Create;
end;

destructor TCQLSelectQualifiers.Destroy;
begin
  FQualifiers.Free;
  inherited;
end;

function TCQLSelectQualifiers.ExecutingPagination: Boolean;
begin
  Result := FExecutingPagination;
end;

function TCQLSelectQualifiers._GetQualifier(AIdx: Integer): ICQLSelectQualifier;
begin
  Result := FQualifiers[AIdx];
end;

function TCQLSelectQualifiers.IsEmpty: Boolean;
begin
  Result := (Count = 0);
end;

function TCQLSelectQualifiers.SerializeDistinct: string;
var
  LFor: Integer;
begin
  inherited;
  Result := '';
  for LFor := 0 to Count -1 do
  begin
    if FQualifiers[LFor].Qualifier = sqDistinct then
    begin
      Result := TUtils.Concat([Result, 'DISTINCT']);
      Exit;
    end;
  end;
end;

{ TCQLSelectQualifier }

function TCQLSelectQualifier._GetQualifier: TSelectQualifierType;
begin
  Result := FQualifier;
end;

function TCQLSelectQualifier._GetValue: Integer;
begin
  Result := FValue;
end;

procedure TCQLSelectQualifier._SetQualifier(const Value: TSelectQualifierType);
begin
  FQualifier := Value;
end;

procedure TCQLSelectQualifier._SetValue(const Value: Integer);
begin
  FValue := Value;
end;

end.
