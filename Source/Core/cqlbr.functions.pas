{
         TCQLFunctions Brasil - Criteria Query Language for Delphi/Lazarus


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

unit cqlbr.functions;

interface

uses
  SysUtils,
  cqlbr.interfaces,
  cqlbr.functions.abstract;

type
  TCQLFunctions = class(TCQLFunctionAbstract, ICQLFunctions)
  private
    FDatabase: TDBName;
    constructor CreatePrivate(const ADatabase: TDBName);
  public
    class function New(const ADatabase: TDBName): ICQLFunctions;
    class function Q(const AValue: String): String;
    function Count(const AValue: String): String; override;
    function Upper(const AValue: String): String; override;
    function Lower(const AValue: String): String; override;
    function Min(const AValue: String): String; override;
    function Max(const AValue: String): String; override;
    function Sum(const AValue: String): String; override;
    function Coalesce(const AValues: array of String): String; override;
    function Substring(const AVAlue: String; const AStart, ALength: Integer): String; override;
    function Cast(const AExpression: String; ADataType: String): String; override;
    function Convert(const ADataType: String; AExpression: String; AStyle: String): String; override;
    function Date(const AVAlue: String; const AFormat: String): String; override;
  end;

implementation

uses
  cqlbr.db.register;

{ TCQLFunctions }

class function TCQLFunctions.New(const ADatabase: TDBName): ICQLFunctions;
begin
  Result := Self.CreatePrivate(ADatabase);
end;

class function TCQLFunctions.Q(const AValue: String): String;
begin
  Result := '''' + AValue + '''';
end;

function TCQLFunctions.Substring(const AVAlue: String; const AStart, ALength: Integer): String;
begin
  Result := TDBRegister.Functions(FDatabase).Substring(AValue, AStart, ALength);
end;

function TCQLFunctions.Sum(const AValue: String): String;
begin
  Result := 'Sum(' + AValue + ')';
end;

function TCQLFunctions.Date(const AVAlue: String; const AFormat: String): String;
begin
  Result := TDBRegister.Functions(FDatabase).Date(AVAlue, AFormat);
end;

function TCQLFunctions.Cast(const AExpression: String; ADataType: String): String;
begin
  Result := 'Cast(' + AExpression + ' AS ' + ADataType + ')';
end;

function TCQLFunctions.Coalesce(const AValues: array of String): String;
begin
  Result := '';
end;

function TCQLFunctions.Convert(const ADataType: String; AExpression: String; AStyle: String): String;
begin
  Result := '';
end;

function TCQLFunctions.Count(const AValue: String): String;
begin
  Result := 'Count(' + AValue + ')';
end;

constructor TCQLFunctions.CreatePrivate(const ADatabase: TDBName);
begin
  FDatabase := ADatabase;
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
