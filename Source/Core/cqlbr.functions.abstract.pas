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
    function Count(const AValue: string): string; virtual; abstract;
    function Upper(const AValue: string): string; virtual; abstract;
    function Lower(const AValue: string): string; virtual; abstract;
    function Min(const AValue: string): string; virtual; abstract;
    function Max(const AValue: string): string; virtual; abstract;
    function Sum(const AValue: string): string; virtual; abstract;
    function Coalesce(const AValues: array of String): string; virtual; abstract;
    function Substring(const AVAlue: string; const AStart, ALength: Integer): string; virtual; abstract;
    function Cast(const AExpression: string; const ADataType: string): string; virtual; abstract;
    function Convert(const ADataType: string; const AExpression: string;
      const AStyle: string): string; virtual; abstract;
    function Year(const AValue: string): string; virtual; abstract;
    function Concat(const AValue: array of string): string; virtual; abstract;
    // Date
    function Date(const AVAlue: string; const AFormat: string): string; overload; virtual; abstract;
    function Date(const AVAlue: string): string; overload; virtual; abstract;
    function Day(const AValue: string): string; virtual; abstract;
    function Month(const AValue: string): string; virtual; abstract;
  end;

implementation

end.
