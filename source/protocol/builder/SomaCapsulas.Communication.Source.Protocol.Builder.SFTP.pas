unit SomaCapsulas.Communication.Source.Protocol.Builder.SFTP;

interface

uses
  System.Classes, System.SysUtils, SomaCapsulas.Communication.Interfaces;

type
  TSFTPBuilder = class abstract(TInterfacedObject, ISFTPBuilder)
  private
    FSFTP: ISFTP;
  public
    function UsingUser(AUser: string): ISFTPBuilder;
    function WithPassword(APassword: string): ISFTPBuilder;
    function OnHost(AHost: string): ISFTPBuilder;
    function AtPort(APort: Word): ISFTPBuilder;
    function ChangeToDir(ADir: string): ISFTPBuilder;
    function AvaliableOn(ASubDomain: string): ISFTPBuilder;
    function Build: ISFTP;
    constructor Create; virtual; abstract;
  end;

  TSFTPPuttyBuilder = class(TSFTPBuilder)
  public
    constructor Create; override;
  end;

implementation

uses
  SomaCapsulas.Communication.Source.Protocol.SFTP;

{ TSFTPBuilder }

function TSFTPBuilder.Build: ISFTP;
begin
  Result := Self.FSFTP;
end;

function TSFTPBuilder.AvaliableOn(ASubDomain: string): ISFTPBuilder;
begin
  Self.FSFTP.SubDomain := ASubDomain;
  Result := Self;
end;

function TSFTPBuilder.AtPort(APort: Word): ISFTPBuilder;
begin
  Self.FSFTP.Port := APort;
  Result := Self;
end;

function TSFTPBuilder.ChangeToDir(ADir: string): ISFTPBuilder;
begin
  Self.FSFTP.Directory := ADir;
  Result := Self;
end;

function TSFTPBuilder.OnHost(AHost: string): ISFTPBuilder;
begin
  Self.FSFTP.Host := AHost;
  Result := Self;
end;

function TSFTPBuilder.UsingUser(AUser: string): ISFTPBuilder;
begin
  Self.FSFTP.User := AUser;
  Result := Self;
end;

function TSFTPBuilder.WithPassword(APassword: string): ISFTPBuilder;
begin
  Self.FSFTP.Password := APassword;
  Result := Self;
end;

{ TSFTPPuttyBuilder }

constructor TSFTPPuttyBuilder.Create;
begin
  Self.FSFTP := TSFTPPutty.Create;
end;

end.
