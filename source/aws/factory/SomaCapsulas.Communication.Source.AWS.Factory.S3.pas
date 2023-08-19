unit SomaCapsulas.Communication.Source.AWS.Factory.S3;

interface

uses
  System.Classes, System.SysUtils, SomaCapsulas.Communication.Interfaces,
  SomaCapsulas.Communication.Types;

type
  TAWSS3Factory = class sealed
    class function Assemble(AAWSType: TAWSType; AAWSConnectionInfo: IAWSConnectionInfo): IAWSS3; static;
  end;

implementation

uses
  SomaCapsulas.Communication.Source.AWS.S3, SomaCapsulas.Exception, SomaCapsulas.Communication.Message;

{ TAWSS3Factory }

class function TAWSS3Factory.Assemble(
  AAWSType: TAWSType; AAWSConnectionInfo: IAWSConnectionInfo): IAWSS3;
begin
  case AAWSType of
    awstWrapper:
      Result := TAWSS3Wrapper.Create(AAWSConnectionInfo);
  end;
end;

end.
