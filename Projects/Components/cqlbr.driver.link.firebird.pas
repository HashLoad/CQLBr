unit cqlbr.driver.link.firebird;

interface

uses
  Classes,
  SysUtils,
  cqlbr.select.firebird,
  cqlbr.serialize.firebird,
  cqlbr.qualifier.firebird;

type
  [ComponentPlatformsAttribute(pfidWindows or pfidOSX or pfidLinux)]
  TCQLBrDriverLinkFirebird = class(TComponent)
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
