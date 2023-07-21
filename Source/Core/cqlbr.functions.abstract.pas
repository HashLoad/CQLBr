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

unit cqlbr.functions.abstract;

{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  cqlbr.interfaces;

type
  TCQLFunctionAbstract = class(TInterfacedObject, ICQLFunctions)
  public
    function Count(const AValue: String): String; virtual; abstract;
    function Upper(const AValue: String): String; virtual; abstract;
    function Lower(const AValue: String): String; virtual; abstract;
    function Min(const AValue: String): String; virtual; abstract;
    function Max(const AValue: String): String; virtual; abstract;
    function Sum(const AValue: String): String; virtual; abstract;
    function Coalesce(const AValues: array of String): String; virtual; abstract;
    function Substring(const AVAlue: String; const AStart, ALength: Integer): String; virtual; abstract;
    function Cast(const AExpression: String; ADataType: String): String; virtual; abstract;
    function Convert(const ADataType: String; AExpression: String; AStyle: String): String; virtual; abstract;
    function Date(const AVAlue: String; const AFormat: String): String; overload; virtual; abstract;
    function Date(const AVAlue: String): String; overload; virtual; abstract;

    function Day(const AValue: String): String; virtual; abstract;

    function Month(const AValue: String): String; virtual; abstract;
    function Year(const AValue: String): String; virtual; abstract;
    function Concat(const AValue: array of string): String; virtual; abstract;
  end;

implementation

end.
