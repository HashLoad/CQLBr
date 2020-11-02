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

{ @abstract(CQLBr Framework)
  @created(18 Jul 2019)
  @author(Isaque Pinheiro <isaquesp@gmail.com>)
  @author(Site : https://www.isaquepinheiro.com.br)
}

unit cqlbr.functions.firebird;

interface

uses
  SysUtils,
  cqlbr.functions.abstract;

type
  TCQLFunctionsFirebird = class(TCQLFunctionAbstract)
  public
    constructor Create;
    function Substring(const AVAlue: String; const AStart, ALength: Integer): String; override;
    function Date(const AVAlue: String; const AFormat: String): String; override;
  end;

implementation

uses
  cqlbr.db.register,
  cqlbr.interfaces;

{ TCQLFunctionsFirebird }

constructor TCQLFunctionsFirebird.Create;
begin
  inherited;
end;

function TCQLFunctionsFirebird.Date(const AVAlue: String; const AFormat: String): String;
begin
  Result := FormatDateTime(AFormat, StrToDateTime(AValue));
end;

function TCQLFunctionsFirebird.Substring(const AVAlue: String; const AStart,
  ALength: Integer): String;
begin
  Result := 'Substring(' + AValue + ' FROM ' + IntToStr(AStart) + ' FOR ' + IntToStr(ALength) + ')';
end;

initialization
  TDBRegister.RegisterFunctions(dbnFirebird, TCQLFunctionsFirebird.Create);

end.
