unit cql.core;

interface

uses
  SysUtils,
  Generics.Collections,
  cqlbr.interfaces;

type
  TCQLSection = class(TInterfacedObject, ICQLSection)
  private
    FName: String;
  protected
    function GetName: String;
  public
    constructor Create(ASectionName: String);
    procedure Clear; virtual; abstract;
    function IsEmpty: Boolean; virtual; abstract;
    property Name: String read GetName;
  end;

  TCQLName = class(TInterfacedObject, ICQLName)
  strict private
    FAlias: String;
    FCase: ISQLCase;
    FName: String;
  strict protected
    function GetAlias: String;
    function GetCase: ISQLCase;
    function GetName: String;
    procedure SetAlias(const Value: String);
    procedure SetCase(const Value: ISQLCase);
    procedure SetName(const Value: String);
  public
    class function New: ICQLName;
    procedure Clear;
    function IsEmpty: Boolean;
    function Serialize: String;
    property Name: String read GetName write SetName;
    property Alias: String read GetAlias write SetAlias;
    property &Case: ISQLCase read GetCase write SetCase;
  end;

  TSQLNames = class(TInterfacedObject, ICQLNames)
  private
    FColumns: TList<ICQLName>;
    function SerializeName(const AName: ICQLName): String;
    function SerializeDirection(ADirection: TSQLOrderByDirection): String;
  protected
    function  GetColumns(AIdx: Integer): ICQLName;
  public
    constructor Create;
    destructor Destroy; override;
    function Add: ICQLName; overload; virtual;
    procedure Add(const Value: ICQLName); overload; virtual;
    procedure Clear;
    function Count: Integer;
    function IsEmpty: Boolean;
    function Serialize: String;
    property Columns[AIdx: Integer]: ICQLName read GetColumns; default;
  end;

  TCQLNameValue  = class(TInterfacedObject, ICQLNameValue)
  strict private
    FName : String;
    FValue: String;
  protected
    function GetName: String;
    function GetValue: String;
    procedure SetName(const Value: String);
    procedure SetValue(const Value: String);
  public
    procedure Clear;
    function IsEmpty: Boolean;
    property Name: String read GetName write SetName;
    property Value: String read GetValue write SetValue;
  end;

  TCQLNameValuePairs = class(TInterfacedObject, ICQLNameValuePairs)
  strict private
    FList: TList<ICQLNameValue>;
  protected
    function GetItem(AIdx: Integer): ICQLNameValue;
  public
    constructor Create;
    destructor Destroy; override;
    function Add: ICQLNameValue; overload;
    procedure Add(const ANameValue: ICQLNameValue); overload;
    procedure Clear;
    function Count: Integer;
    function IsEmpty: Boolean;
    property Item[AIdx: Integer]: ICQLNameValue read GetItem; default;
  end;

implementation

uses
  cqlbr.serialize;

{ TCQLName }

procedure TCQLName.Clear;
begin
  FName := '';
  FAlias := '';
end;

function TCQLName.GetAlias: String;
begin
  Result := FAlias;
end;

function TCQLName.GetCase: ISQLCase;
begin
  Result := FCase;
end;

function TCQLName.GetName: String;
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

function TCQLName.Serialize: String;
begin
  if Assigned(FCase) then
    Result := '(' + FCase.Serialize + ')'
  else
    Result := FName;
  if FAlias <> '' then
    Result := Result + ' AS ' + FAlias;
end;

procedure TCQLName.SetAlias(const Value: String);
begin
  FAlias := Value;
end;

procedure TCQLName.SetCase(const Value: ISQLCase);
begin
  FCase := Value;
end;

procedure TCQLName.SetName(const Value: String);
begin
  FName := Value;
end;

{ TSQLNames }

function TSQLNames.Add: ICQLName;
begin
  Result := TCQLName.Create;
  Add(Result);
end;

procedure TSQLNames.Add(const Value: ICQLName);
begin
  FColumns.Add(Value);
end;

procedure TSQLNames.Clear;
begin
  FColumns.Clear;
end;

function TSQLNames.Count: Integer;
begin
  Result := FColumns.Count;
end;

constructor TSQLNames.Create;
begin
  FColumns := TList<ICQLName>.Create;
end;

destructor TSQLNames.Destroy;
begin
  FColumns.Free;
  inherited;
end;

function TSQLNames.GetColumns(AIdx: Integer): ICQLName;
begin
  Result := FColumns[AIdx];
end;

function TSQLNames.IsEmpty: Boolean;
begin
  Result := (Count = 0);
end;

function TSQLNames.Serialize: String;
var
  LFor: Integer;
  LOrderByCol: ISQLOrderByColumn;
begin
  Result := '';
  for LFor := 0 to FColumns.Count -1 do
  begin
    Result := TSQLSerializer.Concat([Result, SerializeName(FColumns[LFor])], ', ');
    if Supports(FColumns[LFor], ISQLOrderByColumn, LOrderByCol) then
      Result := TSQLSerializer.Concat([Result, SerializeDirection(LOrderByCol.Direction)]);
  end;
end;

function TSQLNames.SerializeDirection(ADirection: TSQLOrderByDirection): String;
begin
  case ADirection of
    dirAscending:  Result := '';
    dirDescending: Result := 'DESC';
  else
    raise Exception.Create('TSQLNames.SerializeDirection: Unknown direction');
  end;
end;

function TSQLNames.SerializeName(const AName: ICQLName): String;
begin
  Result := AName.Serialize;
end;

{ TCQLSection }

constructor TCQLSection.Create(ASectionName: String);
begin
  FName := ASectionName;
end;

function TCQLSection.GetName: String;
begin
  Result := FName;
end;

{ TCQLNameValue }

procedure TCQLNameValue.Clear;
begin
  FName := '';
  FValue := '';
end;

function TCQLNameValue.GetName: String;
begin
  Result := FName;
end;

function TCQLNameValue.GetValue: String;
begin
  Result := FValue;
end;

function TCQLNameValue.IsEmpty: Boolean;
begin
  Result := (FName <> '');
end;

procedure TCQLNameValue.SetName(const Value: String);
begin
  FName := Value;
end;

procedure TCQLNameValue.SetValue(const Value: String);
begin
  FValue := Value;
end;

{ TCQLNameValuePairs }

function TCQLNameValuePairs.Add: ICQLNameValue;
begin
  Result := TCQLNameValue.Create;
  Add(Result);
end;

procedure TCQLNameValuePairs.Add(const ANameValue: ICQLNameValue);
begin
  FList.Add(ANameValue);
end;

procedure TCQLNameValuePairs.Clear;
begin
  FList.Clear;
end;

function TCQLNameValuePairs.Count: Integer;
begin
  Result := FList.Count;
end;

constructor TCQLNameValuePairs.Create;
begin
  FList := TList<ICQLNameValue>.Create;
end;

destructor TCQLNameValuePairs.Destroy;
begin
  FList.Free;
  inherited;
end;

function TCQLNameValuePairs.GetItem(AIdx: Integer): ICQLNameValue;
begin
  Result := FList[AIdx];
end;

function TCQLNameValuePairs.IsEmpty: Boolean;
begin
  Result := (Count = 0);
end;

end.
