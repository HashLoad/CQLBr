unit cqlbr.driver.link.oracle;

interface

uses
  Classes,
  SysUtils,
  cqlbr.select.oracle,
  cqlbr.serialize.oracle,
  cqlbr.qualifier.oracle;

type
  [ComponentPlatformsAttribute(pfidWindows or pfidOSX or pfidLinux)]
  TCQLBrDriverLinkOracle = class(TComponent)
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
