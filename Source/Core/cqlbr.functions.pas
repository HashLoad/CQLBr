{
         TCQLFunctions Brasil - Criteria Query Language for Delphi/Lazarus


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

unit cqlbr.functions;

interface

uses
  cqlbr.interfaces;

type
  TCQLFunctions = class(TInterfacedObject, ICQLFunctions)
  public
    class function New: ICQLFunctions;
    class function Q(const AValue: String): String;
    function Count(const AValue: String): String;
    function Upper(const AValue: String): String;
    function Lower(const AValue: String): String;
    function Min(const AValue: String): String;
    function Max(const AValue: String): String;
  end;

implementation

{ TCQLFunctions }

class function TCQLFunctions.New: ICQLFunctions;
begin
  Result := Self.Create;
end;

class function TCQLFunctions.Q(const AValue: String): String;
begin
  Result := '''' + AValue + '''';
end;

function TCQLFunctions.Count(const AValue: String): String;
begin
  Result := 'Count(' + AValue + ')';
end;

function TCQLFunctions.Lower(const AValue: String): String;
begin
  Result := 'Lower(' + AValue + ')';
end;

function TCQLFunctions.Max(const AValue: String): String;
begin
  Result := 'Max(' + AValue + ')';
end;

function TCQLFunctions.Min(const AValue: String): String;
begin
  Result := 'Min(' + AValue + ')';
end;

function TCQLFunctions.Upper(const AValue: String): String;
begin
  Result := 'Upper(' + AValue + ')';
end;

end.
