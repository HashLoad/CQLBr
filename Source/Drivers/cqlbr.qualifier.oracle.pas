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

unit cqlbr.qualifier.oracle;

{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  SysUtils,
  cqlbr.interfaces,
  cqlbr.qualifier;

type
  TCQLSelectQualifiersOracle = class(TCQLSelectQualifiers)
  public
    function SerializePagination: String; override;
    class function New: TCQLSelectQualifiersOracle;
  end;

implementation

uses
  cqlbr.utils;

{ TCQLSelectQualifiersOracle }

class function TCQLSelectQualifiersOracle.New: TCQLSelectQualifiersOracle;
begin
  Result := Self.Create;
end;

function TCQLSelectQualifiersOracle.SerializePagination: String;
var
  LFor: Integer;
  LFirst: String;
  LSkip: String;
begin
  LFirst := '';
  LSkip := '';
  Result := '';
  for LFor := 0 to Count -1 do
  begin
    case FQualifiers[LFor].Qualifier of
      sqFirst: LFirst := TUtils.Concat(['WHERE ROWNUM <=', IntToStr(FQualifiers[LFor].Value)]);
      sqSkip:  LSkip  := TUtils.Concat(['AND ROWINI >', IntToStr(FQualifiers[LFor].Value)]);
    else
      raise Exception.Create('TCQLSelectQualifiersOracle.SerializeSelectQualifiers: Unknown qualifier');
    end;
  end;
  if (LFirst <> '') or (LSkip <> '') then
  begin
    Result := 'SELECT * FROM (SELECT T.*, ROWNUM AS ROWINI FROM (%s) T)';
    Result := TUtils.Concat([Result, LFirst, LSkip]);
  end;
end;

end.
