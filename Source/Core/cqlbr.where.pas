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

unit cqlbr.where;

{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  cqlbr.section,
  cqlbr.expression,
  cqlbr.interfaces;

type
  TCQLWhere = class(TCQLSection, ICQLWhere)
  private
    function GetExpression: ICQLExpression;
    procedure SetExpression(const Value: ICQLExpression);
  protected
    FExpression: ICQLExpression;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Clear; override;
    function Serialize: String; virtual;
    function IsEmpty: Boolean; override;
    property Expression: ICQLExpression read GetExpression write SetExpression;
  end;

implementation

uses
  cqlbr.utils;

{ TCQLWhere }

procedure TCQLWhere.Clear;
begin
  Expression.Clear;
end;

constructor TCQLWhere.Create;
begin
  inherited Create('Where');
  FExpression := TCQLExpression.New;
end;

destructor TCQLWhere.Destroy;
begin
  inherited;
end;

function TCQLWhere.GetExpression: ICQLExpression;
begin
  Result := FExpression;
end;

function TCQLWhere.IsEmpty: Boolean;
begin
  Result := FExpression.IsEmpty;
end;

function TCQLWhere.Serialize: String;
begin
  if IsEmpty then
    Result := ''
  else
    Result := TUtils.Concat(['WHERE', FExpression.Serialize]);
end;

procedure TCQLWhere.SetExpression(const Value: ICQLExpression);
begin
  FExpression := Value;
end;

end.
