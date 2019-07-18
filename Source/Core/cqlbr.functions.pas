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

unit cqlbr.functions;

interface

uses
  cqlbr.interfaces;

type
  CQL = class
    class function Count(const s: string): string;
    class function Exists(const s: string): string;
    class function Lower(const s: string): string;
    class function Min(const s: string): string;
    class function Max(const s: string): string;
    class function &Not(const s: string): string;
    class function Upper(const s: string): string;
    class function Q(const s: string): string;
  end;

implementation

{ CQL }

class function CQL.Count(const s: string): string;
begin
  Result := 'Count(' + s + ')';
end;

class function CQL.Exists(const s: string): string;
begin
  Result := 'exists(' + s + ')';
end;

class function CQL.Lower(const s: string): string;
begin
  Result := 'Lower(' + s + ')';
end;

class function CQL.Max(const s: string): string;
begin
  Result := 'Max(' + s + ')';
end;

class function CQL.Min(const s: string): string;
begin
  Result := 'Min(' + s + ')';
end;

class function CQL.&Not(const s: string): string;
begin
  Result := 'not ' + s;
end;

class function CQL.Q(const s: string): string;
begin
  Result := '''' + s + '''';
end;

class function CQL.Upper(const s: string): string;
begin
  Result := 'Upper(' + s + ')';
end;

end.
