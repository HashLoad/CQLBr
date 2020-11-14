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

unit cqlbr.select.interbase;

interface

uses
  SysUtils,
  cqlbr.select;

type
  TCQLSelectInterbase = class(TCQLSelect)
  public
    constructor Create; override;
    function Serialize: String; override;
  end;

implementation


uses
  cqlbr.utils,
  cqlbr.register,
  cqlbr.interfaces,
  cqlbr.qualifier.interbase;

{ TCQLSelectInterbase }

constructor TCQLSelectInterbase.Create;
begin
  inherited;
  FQualifiers := TCQLSelectQualifiersInterbase.New;
end;

function TCQLSelectInterbase.Serialize: String;
begin
  Result := inherited Serialize;
end;

initialization
  TCQLBrRegister.RegisterSelect(dbnInterbase, TCQLSelectInterbase.Create);

end.
