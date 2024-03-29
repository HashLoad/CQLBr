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

{
  @abstract(CQLBr Framework)
  @created(18 Jul 2019)
  @source(Inspired by and based on "GpSQLBuilder" project - https://github.com/gabr42/GpSQLBuilder)
  @source(Author of CQLBr Framework: Isaque Pinheiro <isaquesp@gmail.com>)
  @source(Author's Website: https://www.isaquepinheiro.com.br)
}

unit cqlbr.name;

{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  SysUtils,
  Generics.Collections,
  cqlbr.interfaces;

type
  TCQLName = class(TInterfacedObject, ICQLName)
  strict private
    FAlias: string;
    FCase: ICQLCase;
    FName: string;
    function _GetAlias: string;
    function _GetCase: ICQLCase;
    function _GetName: string;
    procedure _SetAlias(const Value: string);
    procedure _SetCase(const Value: ICQLCase);
    procedure _SetName(const Value: string);
  public
    class function New: ICQLName;
    procedure Clear;
    function IsEmpty: Boolean;
    function Serialize: string;
    property Name: string read _GetName write _SetName;
    property Alias: string read _GetAlias write _SetAlias;
    property &Case: ICQLCase read _GetCase write _SetCase;
  end;

  TCQLNames = class(TInterfacedObject, ICQLNames)
  private
    FColumns: TList<ICQLName>;
    function SerializeName(const AName: ICQLName): string;
    function SerializeDirection(ADirection: TOrderByDirection): string;
  protected
    function GetColumns(AIdx: Integer): ICQLName;
    constructor Create;
  public
    class function New: ICQLNames;
    destructor Destroy; override;
    function Add: ICQLName; overload; virtual;
    procedure Add(const Value: ICQLName); overload; virtual;
    procedure Clear;
    function Count: Integer;
    function IsEmpty: Boolean;
    function Serialize: string;
    property Columns[AIdx: Integer]: ICQLName read GetColumns; default;
  end;

implementation

uses
  cqlbr.utils;

{ TCQLName }

procedure TCQLName.Clear;
begin
  FName := '';
  FAlias := '';
end;

function TCQLName._GetAlias: string;
begin
  Result := FAlias;
end;

function TCQLName._GetCase: ICQLCase;
begin
  Result := FCase;
end;

function TCQLName._GetName: string;
begin
  Result := FName;
end;

function TCQLName.IsEmpty: Boolean;
begin
  Result := (FName = '') and (FAlias = '');
end;

class function TCQLName.New: ICQLName;
begin
  Result := Self.Create;
end;

function TCQLName.Serialize: string;
begin
  if Assigned(FCase) then
    Result := '(' + FCase.Serialize + ')'
  else
    Result := FName;
  if FAlias <> '' then
    Result := TUtils.Concat([Result, 'AS', FAlias]);
end;

procedure TCQLName._SetAlias(const Value: string);
begin
  FAlias := Value;
end;

procedure TCQLName._SetCase(const Value: ICQLCase);
begin
  FCase := Value;
end;

procedure TCQLName._SetName(const Value: string);
begin
  FName := Value;
end;

{ TCQLNames }

function TCQLNames.Add: ICQLName;
begin
  Result := TCQLName.Create;
  Add(Result);
end;

procedure TCQLNames.Add(const Value: ICQLName);
begin
  FColumns.Add(Value);
end;

procedure TCQLNames.Clear;
begin
  FColumns.Clear;
end;

function TCQLNames.Count: Integer;
begin
  Result := FColumns.Count;
end;

constructor TCQLNames.Create;
begin
  FColumns := TList<ICQLName>.Create;
end;

destructor TCQLNames.Destroy;
begin
  FColumns.Free;
  inherited;
end;

function TCQLNames.GetColumns(AIdx: Integer): ICQLName;
begin
  Result := FColumns[AIdx];
end;

function TCQLNames.IsEmpty: Boolean;
begin
  Result := (Count = 0);
end;

class function TCQLNames.New: ICQLNames;
begin
  Result := Self.Create;
end;

function TCQLNames.Serialize: string;
var
  LFor: Integer;
  LOrderByCol: ICQLOrderByColumn;
begin
  Result := '';
  for LFor := 0 to FColumns.Count -1 do
  begin
    Result := TUtils.Concat([Result, SerializeName(FColumns[LFor])], ', ');
    if Supports(FColumns[LFor], ICQLOrderByColumn, LOrderByCol) then
      Result := TUtils.Concat([Result, SerializeDirection(LOrderByCol.Direction)]);
  end;
end;

function TCQLNames.SerializeDirection(ADirection: TOrderByDirection): string;
begin
  case ADirection of
    dirAscending:  Result := '';
    dirDescending: Result := 'DESC';
  else
    raise Exception.Create('TCQLNames.SerializeDirection: Unknown direction');
  end;
end;

function TCQLNames.SerializeName(const AName: ICQLName): string;
begin
  Result := AName.Serialize;
end;

end.
