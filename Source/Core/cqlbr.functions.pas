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

unit cqlbr.functions;

{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  SysUtils,
  cqlbr.interfaces,
  cqlbr.functions.abstract;

type
  TCQLFunctions = class(TCQLFunctionAbstract, ICQLFunctions)
  strict private
    FDatabase: TDBName;
    constructor CreatePrivate(const ADatabase: TDBName);
  public
    class function New(const ADatabase: TDBName): ICQLFunctions;
    class function Q(const AValue: string): string;
    function Count(const AValue: string): string; override;
    function Upper(const AValue: string): string; override;
    function Lower(const AValue: string): string; override;
    function Min(const AValue: string): string; override;
    function Max(const AValue: string): string; override;
    function Sum(const AValue: string): string; override;
    function Coalesce(const AValues: array of String): string; override;
    function Substring(const AVAlue: string; const AStart, ALength: Integer): string; override;
    function Cast(const AExpression: string; const ADataType: string): string; override;
    function Convert(const ADataType: string; const AExpression: string;
      const AStyle: string): string; override;
    function Date(const AVAlue: string; const AFormat: string): string; overload; override;
    function Date(const AVAlue: string): string; overload; override;
    function Day(const AValue: string): string; override;
    function Month(const AValue: string): string; override;
    function Year(const AValue: string): string; override;
    function Concat(const AValue: array of string): string; override;
  end;
implementation

uses
  cqlbr.register;

{ TCQLFunctions }

class function TCQLFunctions.New(const ADatabase: TDBName): ICQLFunctions;
begin
  Result := Self.CreatePrivate(ADatabase);
end;

class function TCQLFunctions.Q(const AValue: string): string;
begin
  Result := '''' + AValue + '''';
end;

function TCQLFunctions.Substring(const AVAlue: string;
  const AStart, ALength: Integer): string;
begin
  Result := TCQLBrRegister.Functions(FDatabase).Substring(AValue, AStart, ALength);
end;

function TCQLFunctions.Sum(const AValue: string): string;
begin
  Result := 'SUM(' + AValue + ')';
end;

function TCQLFunctions.Date(const AVAlue: string): string;
begin
  Result := TCQLBrRegister.Functions(FDatabase).Date(AVAlue);
end;

function TCQLFunctions.Date(const AVAlue, AFormat: string): string;
begin
  Result := TCQLBrRegister.Functions(FDatabase).Date(AVAlue, AFormat);
end;

function TCQLFunctions.Day(const AValue: string): string;
begin
  Result := TCQLBrRegister.Functions(FDatabase).Day(AVAlue);
end;

function TCQLFunctions.Cast(const AExpression: string;
  const ADataType: string): string;
begin
  Result := 'CAST(' + AExpression + ' AS ' + ADataType + ')';
end;

function TCQLFunctions.Coalesce(const AValues: array of String): string;
begin
  Result := '';
end;

function TCQLFunctions.Concat(const AValue: array of string): string;
begin
  Result := TCQLBrRegister.Functions(FDatabase).Concat(AVAlue);
end;

function TCQLFunctions.Convert(const ADataType: string;
  const AExpression: string; const AStyle: string): string;
begin
  Result := '';
end;

function TCQLFunctions.Count(const AValue: string): string;
begin
  Result := 'COUNT(' + AValue + ')';
end;

constructor TCQLFunctions.CreatePrivate(const ADatabase: TDBName);
begin
  FDatabase := ADatabase;
end;

function TCQLFunctions.Lower(const AValue: string): string;
begin
  Result := 'LOWER(' + AValue + ')';
end;

function TCQLFunctions.Max(const AValue: string): string;
begin
  Result := 'MAX(' + AValue + ')';
end;

function TCQLFunctions.Min(const AValue: string): string;
begin
  Result := 'MIN(' + AValue + ')';
end;

function TCQLFunctions.Month(const AValue: string): string;
begin
  Result := TCQLBrRegister.Functions(FDatabase).Month(AVAlue);
end;

function TCQLFunctions.Upper(const AValue: string): string;
begin
  Result := 'UPPER(' + AValue + ')';
end;

function TCQLFunctions.Year(const AValue: string): string;
begin
  Result := TCQLBrRegister.Functions(FDatabase).Year(AVAlue);
end;

end.
