unit SomaCapsulas.Communication.Source.Protocol.Builder.FTP;

interface

uses
  System.Classes, System.SysUtils, SomaCapsulas.Communication.Interfaces;

type
  TFTPBuilder = class abstract(TInterfacedObject, IFTPBuilder)
  private
    FFTP: IFTP;
  public
    function UsingUser(AUser: string): IFTPBuilder;
    function WithPassword(APassword: string): IFTPBuilder;
    function OnHost(AHost: string): IFTPBuilder;
    function AtPort(APort: Word): IFTPBuilder;
    function ChangeToDir(ADir: string): IFTPBuilder;
    function AvaliableOn(AAccessDomain: string): IFTPBuilder;
    function IsPassive(AIsPassive: Boolean): IFTPBuilder;
    function Build: IFTP;
    constructor Create; virtual; abstract;
  end;

  TFTPIndyBuilder = class(TFTPBuilder)
  public
    constructor Create; override;
  end;

implementation

uses
  SomaCapsulas.Communication.Source.Protocol.FTP;

{ TFTPIndyBuilder }

function TFTPBuilder.Build: IFTP;
begin
  Result := Self.FFTP;
end;

function TFTPBuilder.IsPassive(AIsPassive: Boolean): IFTPBuilder;
begin
  Self.FFTP.IsPassive := AIsPassive;
  Result := Self;
end;

function TFTPBuilder.AvaliableOn(AAccessDomain: string): IFTPBuilder;
begin
  Self.FFTP.AccessDomain := AAccessDomain;
  Result := Self;
end;

function TFTPBuilder.AtPort(APort: Word): IFTPBuilder;
begin
  Self.FFTP.Port := APort;
  Result := Self;
end;

function TFTPBuilder.ChangeToDir(ADir: string): IFTPBuilder;
begin
  Self.FFTP.Directory := ADir;
  Result := Self;
end;

function TFTPBuilder.OnHost(AHost: string): IFTPBuilder;
begin
  Self.FFTP.Host := AHost;
  Result := Self;
end;

function TFTPBuilder.UsingUser(AUser: string): IFTPBuilder;
begin
  Self.FFTP.User := AUser;
  Result := Self;
end;

function TFTPBuilder.WithPassword(APassword: string): IFTPBuilder;
begin
  Self.FFTP.Password := APassword;
  Result := Self;
end;

{ TFTPIndyBuilder }

constructor TFTPIndyBuilder.Create;
begin
  Self.FFTP := TFTPClientIndy.Create;
end;

end.
