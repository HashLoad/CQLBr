unit cqlbr.driver.link.mongodb;

interface

uses
  Classes,
  SysUtils,
  cqlbr.select.oracle,
  cqlbr.serialize.oracle,
  cqlbr.qualifier.oracle;

type
  [ComponentPlatformsAttribute(pfidWindows or pfidOSX or pfidLinux)]
  TCQLDriverLinkMongoDB = class(TComponent)
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
