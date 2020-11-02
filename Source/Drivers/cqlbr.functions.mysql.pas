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

{ @abstract(CQLBr Framework)
  @created(18 Jul 2019)
  @author(Isaque Pinheiro <isaquesp@gmail.com>)
  @author(Site : https://www.isaquepinheiro.com.br)
}

unit cqlbr.functions.mysql;

interface

uses
  SysUtils,
  cqlbr.functions.abstract;

type
  TCQLFunctionsMySQL = class(TCQLFunctionAbstract)
  public
    constructor Create;
    function Substring(const AVAlue: String; const AStart, ALength: Integer): String; override;
    function Date(const AVAlue: String; const AFormat: String): String; override;
  end;

implementation

uses
  cqlbr.db.register,
  cqlbr.interfaces;

{ TCQLFunctionsMySQL }

constructor TCQLFunctionsMySQL.Create;
begin
  inherited;
end;

function TCQLFunctionsMySQL.Date(const AVAlue: String; const AFormat: String): String;
begin
  Result := 'DATE_FORMAT(' + AValue + ', ' + AFormat + ')';
end;

function TCQLFunctionsMySQL.Substring(const AVAlue: String; const AStart,
  ALength: Integer): String;
begin
  Result := 'Substring(' + AValue + ', ' + IntToStr(AStart) + ', ' + IntToStr(ALength) + ')';
end;

initialization
  TDBRegister.RegisterFunctions(dbnMySQL, TCQLFunctionsMySQL.Create);

end.
