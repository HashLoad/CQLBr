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

unit cqlbr.update;

{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  cqlbr.section,
  cqlbr.namevalue,
  cqlbr.interfaces;

type
  TCQLUpdate = class(TCQLSection, ICQLUpdate)
  strict private
    FTableName: string;
    FValues: ICQLNameValuePairs;
    function _SerializeNameValuePairsForUpdate(const APairs: ICQLNameValuePairs): string;
    function  _GetTableName: string;
    procedure _SetTableName(const value: string);
  public
    constructor Create;
    procedure Clear; override;
    function IsEmpty: boolean; override;
    function Values: ICQLNameValuePairs;
    function Serialize: string;
    property TableName: string read _GetTableName write _SetTableName;
  end;

implementation

uses
  cqlbr.utils;

{ TCQLUpdate }

procedure TCQLUpdate.Clear;
begin
  FTableName := '';
  FValues.Clear;
end;

constructor TCQLUpdate.Create;
begin
  inherited Create('Update');
  FValues := TCQLNameValuePairs.New;
end;

function TCQLUpdate._GetTableName: string;
begin
  Result := FTableName;
end;

function TCQLUpdate.IsEmpty: boolean;
begin
  Result := (TableName = '');
end;

function TCQLUpdate.Serialize: string;
begin
  if IsEmpty then
    Result := ''
  else
    Result := TUtils.Concat(['UPDATE', FTableName, 'SET',
      _SerializeNameValuePairsForUpdate(FValues)]);
end;

function TCQLUpdate._SerializeNameValuePairsForUpdate(const APairs: ICQLNameValuePairs): string;
var
  LFor: Integer;
begin
  Result := '';
  for LFor := 0 to APairs.Count -1 do
    Result := TUtils.Concat([Result, TUtils.Concat([APairs[LFor].Name, '=', APairs[LFor].Value])], ', ');
end;

procedure TCQLUpdate._SetTableName(const value: string);
begin
  FTableName := Value;
end;

function TCQLUpdate.Values: ICQLNameValuePairs;
begin
  Result := FValues;
end;

end.
