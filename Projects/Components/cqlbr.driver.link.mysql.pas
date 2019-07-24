unit cqlbr.driver.link.mysql;

interface

uses
  Classes,
  SysUtils,
  cqlbr.select.mysql,
  cqlbr.serialize.mysql,
  cqlbr.qualifier.mysql;

type
  [ComponentPlatformsAttribute(pfidWindows or pfidOSX or pfidLinux)]
  TCQLDriverLinkMySQL = class(TComponent)
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
