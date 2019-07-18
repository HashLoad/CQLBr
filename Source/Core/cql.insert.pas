unit cql.insert;

interface

uses
  cqlbr.core,
  cqlbr.interfaces;

type
  TCQLInsert = class(TCQLSection, ICQLInsert)
  strict private
    FColumns: ICQLNames;
    FTableName: string;
    FValues: ISQLNameValuePairs;
    function SerializeNameValuePairsForInsert(const APairs: ISQLNameValuePairs): string;
  protected
    function GetTableName: string;
    procedure SetTableName(const Value: string);
  public
    constructor Create;
    procedure Clear; override;
    function Columns: ICQLNames;
    function IsEmpty: Boolean; override;
    function Values: ISQLNameValuePairs;
    function Serialize: String;
    property TableName: string read GetTableName write SetTableName;
  end;

implementation

uses
  cqlbr.serialize;

{ TCQLInsert }

procedure TCQLInsert.Clear;
begin
  TableName := '';
end;

function TCQLInsert.Columns: ICQLNames;
begin
  Result := FColumns;
end;

constructor TCQLInsert.Create;
begin
  inherited Create('Insert');
  FColumns := TSQLNames.Create;
  FValues := TSQLNameValuePairs.Create;
end;

function TCQLInsert.GetTableName: string;
begin
  Result := FTableName;
end;

function TCQLInsert.IsEmpty: Boolean;
begin
  Result := (TableName = '');
end;

function TCQLInsert.Serialize: String;
begin
  if IsEmpty then
    Result := ''
  else
  begin
    Result := TSQLSerializer.Concat(['INSERT INTO', FTableName]);
    if FColumns.Count > 0 then
      Result := TSQLSerializer.Concat([Result, '(', Columns.Serialize, ')'])
    else
      Result := TSQLSerializer.Concat([Result, SerializeNameValuePairsForInsert(FValues)]);
  end;
end;

function TCQLInsert.SerializeNameValuePairsForInsert(const APairs: ISQLNameValuePairs): string;
var
  LFor: integer;
  LColumns: String;
  LValues: String;
begin
  Result := '';
  if APairs.Count = 0 then
    Exit;

  LColumns := '';
  LValues := '';
  for LFor := 0 to APairs.Count - 1 do
  begin
    LColumns := TSQLSerializer.Concat([LColumns, APairs[LFor].Name] , ', ');
    LValues  := TSQLSerializer.Concat([LValues , APairs[LFor].Value], ', ');
  end;
  Result := TSQLSerializer.Concat(['(', LColumns, ') VALUES (', LValues, ')'],'');
end;

procedure TCQLInsert.SetTableName(const Value: string);
begin
  FTableName := Value;
end;

function TCQLInsert.Values: ISQLNameValuePairs;
begin
  Result := FValues;
end;

end.
