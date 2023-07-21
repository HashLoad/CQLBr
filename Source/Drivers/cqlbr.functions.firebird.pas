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

unit cqlbr.functions.firebird;

{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  SysUtils,
  cqlbr.functions.abstract;

type
  TCQLFunctionsFirebird = class(TCQLFunctionAbstract)
  public
    constructor Create;
    function Substring(const AValue: String; const AStart, ALength: Integer): String; override;
    function Date(const AValue: String; const AFormat: String): String; overload; override;
    function Date(const AValue: String): String; overload; override;
    function Day(const AValue: String): String; override;
    function Month(const AValue: String): String; override;
    function Year(const AValue: String): String; override;
    function Concat(const AValue: array of string): string; override;
  end;

implementation

uses
  cqlbr.register,
  cqlbr.interfaces;

{ TCQLFunctionsFirebird }

function TCQLFunctionsFirebird.Concat(const AValue: array of string): string;
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

constructor TCQLFunctionsFirebird.Create;
begin
  inherited;
end;

function TCQLFunctionsFirebird.Date(const AValue: String; const AFormat: String): String;
begin
  Result := FormatDateTime(AFormat, StrToDateTime(AValue));
end;

function TCQLFunctionsFirebird.Date(const AValue: String): String;
begin
  Result := AValue;
end;

function TCQLFunctionsFirebird.Day(const AValue: String): String;
begin
  Result := 'EXTRACT(DAY FROM ' + AValue + ')';
end;

function TCQLFunctionsFirebird.Month(const AValue: String): String;
begin
  Result := 'EXTRACT(MONTH FROM ' + AValue + ')';
end;

function TCQLFunctionsFirebird.Substring(const AValue: String; const AStart,
  ALength: Integer): String;
begin
  Result := 'SUBSTRING(' + AValue + ' FROM ' + IntToStr(AStart) + ' FOR ' + IntToStr(ALength) + ')';
end;

function TCQLFunctionsFirebird.Year(const AValue: String): String;
begin
  Result := 'EXTRACT(YEAR FROM ' + AValue + ')';
end;

initialization
  TCQLBrRegister.RegisterFunctions(dbnFirebird, TCQLFunctionsFirebird.Create);

end.
