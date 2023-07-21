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

unit cqlbr.functions.mssql;

{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  SysUtils,
  cqlbr.functions.abstract;

type
  TCQLFunctionsMSSQL = class(TCQLFunctionAbstract)
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

{ TCQLFunctionsMSSQL }

function TCQLFunctionsMSSQL.Concat(const AValue: array of string): string;
var
  LFor: Integer;
  LIni: Integer;
  LFin: Integer;
const
  cCONCAT = 'CONCAT(%s)';
begin
  Result := '';
  LIni := Low(AValue);
  LFin := High(AValue);

  for LFor := LIni to LFin do
  begin
    Result := Result + AValue[LFor];
    if LFor < LFin then
      Result := Result + ', ';
  end;
  Result := Format(cCONCAT, [Result]);
end;

constructor TCQLFunctionsMSSQL.Create;
begin
  inherited;
end;

function TCQLFunctionsMSSQL.Substring(const AVAlue: String; const AStart,
  ALength: Integer): String;
begin
  Result := 'SUBSTRING(' + AValue + ', ' + IntToStr(AStart) + ', ' + IntToStr(ALength) + ')';
end;

function TCQLFunctionsMSSQL.Year(const AValue: String): String;
begin
  Result := 'YEAR(' + AValue + ')';
end;

function TCQLFunctionsMSSQL.Date(const AVAlue, AFormat: String): String;
begin
  Result := FormatDateTime(AFormat, StrToDateTime(AValue));
end;

function TCQLFunctionsMSSQL.Date(const AVAlue: String): String;
begin
  Result := AValue;
end;

function TCQLFunctionsMSSQL.Day(const AValue: String): String;
begin
  Result := 'DAY(' + AValue + ')';
end;

function TCQLFunctionsMSSQL.Month(const AValue: String): String;
begin
  Result := 'MONTH(' + AValue + ')';
end;

initialization
  TCQLBrRegister.RegisterFunctions(dbnMSSQL, TCQLFunctionsMSSQL.Create);

end.
