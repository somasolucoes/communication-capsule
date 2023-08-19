unit SomaCapsulas.Communication.Source.AWS.Core;

interface

uses
  System.Classes, System.SysUtils, SomaCapsulas.Communication.Interfaces;

type
  TAWS = class abstract(TInterfacedObject, IAWS)
  private
    FAWSConnectionInfo: IAWSConnectionInfo;
    function GetAWSConnectionInfo: IAWSConnectionInfo;
    procedure SetAWSConnectionInfo(const Value: IAWSConnectionInfo);
  public
    property AWSConnectionInfo: IAWSConnectionInfo read GetAWSConnectionInfo write SetAWSConnectionInfo;
    constructor Create(AAWSConnectionInfo: IAWSConnectionInfo);
  end;

implementation

{ TAWS }

constructor TAWS.Create(AAWSConnectionInfo: IAWSConnectionInfo);
begin
  Self.FAWSConnectionInfo := AAWSConnectionInfo;
end;

function TAWS.GetAWSConnectionInfo: IAWSConnectionInfo;
begin
  Result := Self.FAWSConnectionInfo;
end;

procedure TAWS.SetAWSConnectionInfo(const Value: IAWSConnectionInfo);
begin
  FAWSConnectionInfo := Value;
end;

end.
