unit cqlbr.driver.link.mssql;

interface

uses
  Classes,
  SysUtils,
  cqlbr.select.mssql,
  cqlbr.serialize.mssql,
  cqlbr.qualifier.mssql;

type
  [ComponentPlatformsAttribute(pfidWindows or pfidOSX or pfidLinux)]
  TCQLBrDriverLinkMSSQL = class(TComponent)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

implementation

end.
