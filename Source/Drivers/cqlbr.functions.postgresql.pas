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

unit cqlbr.functions.postgresql;

{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  SysUtils,
  cqlbr.functions.abstract;

type
  TCQLFunctionsPostgreSQL = class(TCQLFunctionAbstract)
  public
    constructor Create;
    function Substring(const AVAlue: String; const AStart, ALength: Integer): String; override;
    function Date(const AVAlue: String; const AFormat: String): String; overload; override;
    function Date(const AVAlue: String): String; overload; override;
    function Day(const AValue: String): String; override;
    function Month(const AValue: String): String; override;
    function Year(const AValue: String): String; override;
    function Concat(const AValue: array of string): string; override;
  end;

implementation

uses
  cqlbr.register,
  cqlbr.interfaces;

{ TCQLFunctionsPostgreSQL }

function TCQLFunctionsPostgreSQL.Concat(const AValue: array of string): string;
var
  LFor: Integer;
  LIni: Integer;
  LFin: Integer;
begin
  Result := '';
  LIni := Low(AValue);
  LFin := High(AValue);

  for LFor := LIni to LFin do
  begin
    Result := Result + AValue[LFor];
    if LFor < LFin then
      Result := Result + ' || ';
  end;
end;

constructor TCQLFunctionsPostgreSQL.Create;
begin
  inherited;
end;

function TCQLFunctionsPostgreSQL.Date(const AVAlue, AFormat: String): String;
begin
  Result := 'TO_DATE(' + AValue + ', ' + AFormat + ')';
end;

function TCQLFunctionsPostgreSQL.Date(const AVAlue: String): String;
begin
  Result := 'TO_DATE(' + AValue + ', ''dd/MM/yyyy'')';
end;

function TCQLFunctionsPostgreSQL.Day(const AValue: String): String;
begin
  Result := 'EXTRACT(DAY FROM ' + AValue + ')';
end;

function TCQLFunctionsPostgreSQL.Month(const AValue: String): String;
begin
  Result := 'EXTRACT(MONTH FROM ' + AValue + ')';
end;

function TCQLFunctionsPostgreSQL.Substring(const AVAlue: String; const AStart,
  ALength: Integer): String;
begin
  Result := 'SUBSTRING(' + AValue + ' FROM ' + IntToStr(AStart) + ' FOR ' + IntToStr(ALength) + ')';
end;

function TCQLFunctionsPostgreSQL.Year(const AValue: String): String;
begin
  Result := 'EXTRACT(YEAR FROM ' + AValue + ')';
end;

initialization
  TCQLBrRegister.RegisterFunctions(dbnDB2, TCQLFunctionsPostgreSQL.Create);

end.
