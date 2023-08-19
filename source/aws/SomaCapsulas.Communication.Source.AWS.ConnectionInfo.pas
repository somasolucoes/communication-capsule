unit SomaCapsulas.Communication.Source.AWS.ConnectionInfo;

interface

uses
  System.Classes, System.SysUtils, Data.Cloud.AmazonAPI, SomaCapsulas.Communication.Interfaces;

type
  TAWSConnectionInfo = class(TInterfacedObject, IAWSConnectionInfo)
  private
    FAccessKeyID: string;
    FSecretAccessKey: string;
    FDefaultRegion: TAmazonRegion;
    function GetAccessKeyID: string;
    function GetDefaultRegion: TAmazonRegion;
    function GetSecretAccessKey: string;
    procedure SetAccessKeyID(const Value: string);
    procedure SetDefaultRegion(const Value: TAmazonRegion);
    procedure SetSecretAccessKey(const Value: string);
  public
    property AccessKeyID: string read GetAccessKeyID write SetAccessKeyID;
    property SecretAccessKey: string read GetSecretAccessKey write SetSecretAccessKey;
    property DefaultRegion: TAmazonRegion read GetDefaultRegion write SetDefaultRegion;
    constructor Create(AAccessKeyID, ASecretAccessKey: string; ADefaultRegion: TAmazonRegion);
  end;

implementation

{ TAWSConnectionInfo }

constructor TAWSConnectionInfo.Create(AAccessKeyID, ASecretAccessKey: string;
  ADefaultRegion: TAmazonRegion);
begin
  Self.FAccessKeyID := AAccessKeyID;
  Self.FSecretAccessKey := ASecretAccessKey;
  Self.FDefaultRegion := ADefaultRegion;
end;

function TAWSConnectionInfo.GetAccessKeyID: string;
begin
  Result := Self.FAccessKeyID;
end;

function TAWSConnectionInfo.GetDefaultRegion: TAmazonRegion;
begin
  Result := Self.FDefaultRegion;
end;

function TAWSConnectionInfo.GetSecretAccessKey: string;
begin
  Result := Self.FSecretAccessKey;
end;

procedure TAWSConnectionInfo.SetAccessKeyID(const Value: string);
begin
  FAccessKeyID := Value;
end;

procedure TAWSConnectionInfo.SetDefaultRegion(const Value: TAmazonRegion);
begin
  FDefaultRegion := Value;
end;

procedure TAWSConnectionInfo.SetSecretAccessKey(const Value: string);
begin
  FSecretAccessKey := Value;
end;

end.
