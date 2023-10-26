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

unit cqlbr.ast;

{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  cqlbr.interfaces;

type
  TCQLAST = class(TInterfacedObject, ICQLAST)
  strict private
    FASTColumns: ICQLNames;
    FASTSection: ICQLSection;
    FASTName: ICQLName;
    FASTTableNames: ICQLNames;
    FSelect: ICQLSelect;
    FInsert: ICQLInsert;
    FUpdate: ICQLUpdate;
    FDelete : ICQLDelete;
    FGroupBy: ICQLGroupBy;
    FHaving: ICQLHaving;
    FJoins: ICQLJoins;
    FOrderBy: ICQLOrderBy;
    FWhere: ICQLWhere;
    function _GetASTColumns: ICQLNames;
    procedure _SetASTColumns(const Value: ICQLNames);
    function _GetASTSection: ICQLSection;
    procedure _SetASTSection(const Value: ICQLSection);
    function _GetASTName: ICQLName;
    procedure _SetASTName(const Value: ICQLName);
    function _GetASTTableNames: ICQLNames;
    procedure _SetASTTableNames(const Value: ICQLNames);
  public
    constructor Create(const ADatabase: TDBName);
    destructor Destroy; override;
    class function New(const ADatabase: TDBName): ICQLAST;
    procedure Clear;
    function IsEmpty: Boolean;
    function Select: ICQLSelect;
    function Delete: ICQLDelete;
    function Insert: ICQLInsert;
    function Update: ICQLUpdate;
    function Joins: ICQLJoins;
    function Where: ICQLWhere;
    function GroupBy: ICQLGroupBy;
    function Having: ICQLHaving;
    function OrderBy: ICQLOrderBy;
    property ASTColumns: ICQLNames read _GetASTColumns write _SetASTColumns;
    property ASTSection: ICQLSection read _GetASTSection write _SetASTSection;
    property ASTName: ICQLName read _GetASTName write _SetASTName;
    property ASTTableNames: ICQLNames read _GetASTTableNames write _SetASTTableNames;
  end;

implementation

uses
  cqlbr.register,
  cqlbr.select,
  cqlbr.orderby,
  cqlbr.where,
  cqlbr.delete,
  cqlbr.joins,
  cqlbr.groupby,
  cqlbr.having,
  cqlbr.insert,
  cqlbr.update;

{ TCQLAST }

procedure TCQLAST.Clear;
begin
  FSelect.Clear;
  FDelete.Clear;
  FInsert.Clear;
  FUpdate.Clear;
  FJoins.Clear;
  FWhere.Clear;
  FGroupBy.Clear;
  FHaving.Clear;
  FOrderBy.Clear;
end;

constructor TCQLAST.Create(const ADatabase: TDBName);
begin
  FSelect := TCQLBrRegister.Select(ADatabase);
  FDelete := TCQLDelete.Create;
  FInsert := TCQLInsert.Create;
  FUpdate := TCQLUpdate.Create;
  FJoins := TCQLJoins.Create;
  FWhere := TCQLBrRegister.Where(ADatabase);
  if FWhere = nil then
    FWhere := TCQLWhere.Create;
  FGroupBy := TCQLGroupBy.Create;
  FHaving := TCQLHaving.Create;
  FOrderBy := TCQLOrderBy.Create;
end;

function TCQLAST.Delete: ICQLDelete;
begin
  Result := FDelete;
end;

destructor TCQLAST.Destroy;
begin
  inherited;
end;

function TCQLAST._GetASTColumns: ICQLNames;
begin
  Result := FASTColumns;
end;

function TCQLAST._GetASTName: ICQLName;
begin
  Result := FASTName;
end;

function TCQLAST._GetASTSection: ICQLSection;
begin
  Result := FASTSection;
end;

function TCQLAST._GetASTTableNames: ICQLNames;
begin
  Result := FASTTableNames;
end;

function TCQLAST.GroupBy: ICQLGroupBy;
begin
  Result := FGroupBy;
end;

function TCQLAST.Having: ICQLHaving;
begin
  Result := FHaving;
end;

function TCQLAST.Insert: ICQLInsert;
begin
  Result := FInsert;
end;

function TCQLAST.IsEmpty: Boolean;
begin
  Result := FSelect.IsEmpty and
            FJoins.IsEmpty and
            FWhere.IsEmpty and
            FGroupBy.IsEmpty and
            FHaving.IsEmpty and
            FOrderBy.IsEmpty;
end;

function TCQLAST.Joins: ICQLJoins;
begin
  Result := FJoins;
end;

class function TCQLAST.New(const ADatabase: TDBName): ICQLAST;
begin
  Result := Self.Create(ADatabase);
end;

function TCQLAST.OrderBy: ICQLOrderBy;
begin
  Result := FOrderBy;
end;

function TCQLAST.Select: ICQLSelect;
begin
  Result := FSelect;
end;

procedure TCQLAST._SetASTColumns(const Value: ICQLNames);
begin
  FASTColumns := Value;
end;

procedure TCQLAST._SetASTName(const Value: ICQLName);
begin
  FASTName := Value;
end;

procedure TCQLAST._SetASTSection(const Value: ICQLSection);
begin
  FASTSection := Value;
end;

procedure TCQLAST._SetASTTableNames(const Value: ICQLNames);
begin
  FASTTableNames := Value;
end;

function TCQLAST.Update: ICQLUpdate;
begin
  Result := FUpdate;
end;

function TCQLAST.Where: ICQLWhere;
begin
  Result := FWhere;
end;

end.
