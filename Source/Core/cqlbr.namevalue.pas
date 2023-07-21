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

unit cqlbr.namevalue;

{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}

interface

uses
  SysUtils,
  Generics.Collections,
  cqlbr.interfaces;

type
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
    constructor Create;
  public
    class function New: ICQLNameValuePairs;
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
  cqlbr.utils;

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

class function TCQLNameValuePairs.New: ICQLNameValuePairs;
begin
  Result := Self.Create;
end;

end.
