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

unit cqlbr.serialize.mongodb;

{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  SysUtils,
  cqlbr.register,
  cqlbr.interfaces,
  cqlbr.serialize;

type
  TCQLSerializerMongoDB = class(TCQLSerialize)
  public
    function AsString(const AAST: ICQLAST): String; override;
  end;

implementation

{ TCQLSerializer }

function TCQLSerializerMongoDB.AsString(const AAST: ICQLAST): String;
begin
  Result := inherited AsString(AAST);
end;

initialization
  TCQLBrRegister.RegisterSerialize(dbnMongoDB, TCQLSerializerMongoDB.Create);

end.
