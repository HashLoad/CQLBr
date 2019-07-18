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

unit cqlbr.db.register;

interface

uses
  SysUtils,
  Generics.Collections,
  cqlbr.interfaces;

type
  TDBRegister = class
  strict private
    class var FCQLSelect: TDictionary<TDBName, ICQLSelect>;
    class var FCQLSerialize: TDictionary<TDBName, ICQLSerialize>;
  private
    class constructor Create;
    class destructor Destroy;
  public
    /// <summary>
    ///   Select for database
    /// </summary>
    class procedure RegisterSelect(const ADBName: TDBName;
      const ACQLSelect: ICQLSelect);
    class function GetSelect(const ADBName: TDBName): ICQLSelect;
    /// <summary>
    ///   Serialize for database
    /// </summary>
    class procedure RegisterSerialize(const ADBName: TDBName;
      const ACQLSelect: ICQLSerialize);
    class function GetSerialize(const ADBName: TDBName): ICQLSerialize;
  end;

implementation

const
  TStrDBName: array[dbnMSSQL..dbnNexusDB] of
                  string = ('MSSQL','MySQL','Firebird','SQLite','Interbase','DB2',
                            'Oracle','Informix','PostgreSQL','ADS','ASA',
                            'AbsoluteDB','MongoDB','ElevateDB','NexusDB');


class constructor TDBRegister.Create;
begin
  FCQLSelect := TDictionary<TDBName, ICQLSelect>.Create;
  FCQLSerialize := TDictionary<TDBName, ICQLSerialize>.Create;
end;

class destructor TDBRegister.Destroy;
begin
  FCQLSelect.Clear;
  FCQLSelect.Free;
  FCQLSerialize.Clear;
  FCQLSerialize.Free;
  inherited;
end;

class function TDBRegister.GetSelect(const ADBName: TDBName): ICQLSelect;
begin
  if not FCQLSelect.ContainsKey(ADBName) then
    raise Exception
            .Create('O select do banco ' + TStrDBName[ADBName] + ' não está registrado, adicione a unit "cqlbr.select.???.pas" onde ??? nome do banco, na cláusula USES do seu projeto!');

  Result := FCQLSelect[ADBName];
end;

class procedure TDBRegister.RegisterSelect(const ADBName: TDBName;
  const ACQLSelect: ICQLSelect);
begin
  FCQLSelect.AddOrSetValue(ADBName, ACQLSelect);
end;

class function TDBRegister.GetSerialize(const ADBName: TDBName): ICQLSerialize;
begin
  if not FCQLSerialize.ContainsKey(ADBName) then
    raise Exception
            .Create('O serialize do banco ' + TStrDBName[ADBName] + ' não está registrado, adicione a unit "cqlbr.serialize.???.pas" onde ??? nome do banco, na cláusula USES do seu projeto!');

  Result := FCQLSerialize[ADBName];
end;

class procedure TDBRegister.RegisterSerialize(const ADBName: TDBName;
  const ACQLSelect: ICQLSerialize);
begin
  FCQLSerialize.AddOrSetValue(ADBName, ACQLSelect);
end;

end.
