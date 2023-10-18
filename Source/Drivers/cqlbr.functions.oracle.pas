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

unit cqlbr.functions.oracle;

{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  SysUtils,
  cqlbr.functions.abstract;

type
  TCQLFunctionsOracle = class(TCQLFunctionAbstract)
  public
    constructor Create;
    function Substring(const AVAlue: string; const AStart, ALength: Integer): string; override;
    function Date(const AVAlue: string; const AFormat: string): string; overload; override;
    function Date(const AVAlue: string): string; overload; override;
    function Day(const AValue: string): string; override;
    function Month(const AValue: string): string; override;
    function Year(const AValue: string): string; override;
    function Concat(const AValue: array of string): string; override;
  end;

implementation

uses
  cqlbr.register,
  cqlbr.interfaces;

{ TCQLFunctionsOracle }

function TCQLFunctionsOracle.Concat(const AValue: array of string): string;
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

constructor TCQLFunctionsOracle.Create;
begin
  inherited;
end;

function TCQLFunctionsOracle.Date(const AVAlue, AFormat: string): string;
begin
  Result := 'TO_DATE(' + AValue + ', ' + AFormat + ')';
end;

function TCQLFunctionsOracle.Date(const AVAlue: string): string;
begin
  Result := 'TO_DATE(' + AValue + ', ''dd/MM/yyyy'')';
end;

function TCQLFunctionsOracle.Day(const AValue: string): string;
begin
  Result := 'EXTRACT(DAY FROM ' + AVAlue + ')';
end;

function TCQLFunctionsOracle.Month(const AValue: string): string;
begin
  Result := 'EXTRACT(MONTH FROM ' + AVAlue + ')';
end;

function TCQLFunctionsOracle.Substring(const AVAlue: string; const AStart,
  ALength: Integer): string;
begin
  Result := 'SUBSTR(' + AValue + ', ' + IntToStr(AStart) + ', ' + IntToStr(ALength) + ')';
end;

function TCQLFunctionsOracle.Year(const AValue: string): string;
begin
  Result := 'EXTRACT(YEAR FROM ' + AVAlue + ')';
end;

initialization
  TCQLBrRegister.RegisterFunctions(dbnOracle, TCQLFunctionsOracle.Create);

end.
