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

unit cqlbr.having;

{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  cqlbr.section,
  cqlbr.interfaces;

type
  TCQLHaving = class(TCQLSection, ICQLHaving)
  strict private
    FExpression: ICQLExpression;
    function _GetExpression: ICQLExpression;
    procedure _SetExpression(const Value: ICQLExpression);
  public
    constructor Create;
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    function Serialize: string;
    property Expression: ICQLExpression read _GetExpression write _SetExpression;
  end;


implementation

uses
  cqlbr.expression,
  cqlbr.utils;

{ TCQLHaving }

constructor TCQLHaving.Create;
begin
  inherited Create('Having');
  FExpression := TCQLExpression.Create;
end;

procedure TCQLHaving.Clear;
begin
  FExpression.Clear;
end;

function TCQLHaving._GetExpression: ICQLExpression;
begin
  Result := FExpression;
end;

function TCQLHaving.IsEmpty: Boolean;
begin
  Result := FExpression.IsEmpty;
end;

function TCQLHaving.Serialize: string;
begin
  if IsEmpty then
    Result := ''
  else
    Result := TUtils.Concat(['HAVING', FExpression.Serialize]);
end;

procedure TCQLHaving._SetExpression(const Value: ICQLExpression);
begin
  FExpression := Value;
end;

end.
