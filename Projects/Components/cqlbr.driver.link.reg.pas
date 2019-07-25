unit cqlbr.driver.link.reg;

interface

uses
  Classes,
  DesignIntf,
  DesignEditors,
  cqlbr.driver.link.firebird,
  cqlbr.driver.link.mongodb,
  cqlbr.driver.link.oracle,
  cqlbr.driver.link.mysql,
  cqlbr.driver.link.mssql;

type
  TCQLBrEditorFirebird = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TCQLBrEditorMSSQL = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TCQLBrEditorMySQL = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TCQLBrEditorOracle = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TCQLBrEditorMongoDB = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

procedure register;

implementation

procedure register;
begin
  RegisterComponents('CQLBr-Links', [TCQLBrDriverLinkFirebird,
                                     TCQLBrDriverLinkMSSQL,
                                     TCQLBrDriverLinkMYSQL,
                                     TCQLBrDriverLinkOracle,
                                     TCQLBrDriverLinkMongoDB
                                    ]);
  RegisterSelectionEditor(TCQLBrDriverLinkFirebird, TCQLBrEditorFirebird);
  RegisterSelectionEditor(TCQLBrDriverLinkMSSQL, TCQLBrEditorMSSQL);
  RegisterSelectionEditor(TCQLBrDriverLinkMYSQL, TCQLBrEditorMYSQL);
  RegisterSelectionEditor(TCQLBrDriverLinkOracle, TCQLBrEditorOracle);
  RegisterSelectionEditor(TCQLBrDriverLinkMongoDB, TCQLBrEditorMongoDB);
end;

{ TCQLBrEditorFirebird }

procedure TCQLBrEditorFirebird.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('cqlbr.qualifier.firebird');
  Proc('cqlbr.select.firebird');
  Proc('cqlbr.serialize.firebird');
end;

{ TCQLBrEditorMSSQL }

procedure TCQLBrEditorMSSQL.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('cqlbr.qualifier.mssql');
  Proc('cqlbr.select.mssql');
  Proc('cqlbr.serialize.mssql');
end;

{ TCQLBrEditorMongoDB }

procedure TCQLBrEditorMongoDB.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('cqlbr.qualifier.mongodb');
  Proc('cqlbr.select.mongodb');
  Proc('cqlbr.serialize.mongodb');
end;

{ TCQLBrEditorOracle }

procedure TCQLBrEditorOracle.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('cqlbr.qualifier.oracle');
  Proc('cqlbr.select.oracle');
  Proc('cqlbr.serialize.oracle');
end;

{ TCQLBrEditorMySQL }

procedure TCQLBrEditorMySQL.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('cqlbr.qualifier.mysql');
  Proc('cqlbr.select.mysql');
  Proc('cqlbr.serialize.mysql');
end;

end.
