unit SomaCapsulas.Communication.Source.Protocol.Core;

interface

uses
  System.Classes, System.SysUtils, SomaCapsulas.Communication.Interfaces;

type
  TProtocol = class abstract(TInterfacedObject, IProtocol)
  private
    FPort: Word;
    FHost: string;
    function GetHost: string;
    function GetPort: Word;
    procedure SetHost(const Value: string);
    procedure SetPort(const Value: Word);
  public
    property Host: string read GetHost write SetHost;
    property Port: Word read GetPort write SetPort;
  end;

  TProtocolAutenticated = class abstract(TProtocol, IProtocolAutenticated)
  private
    FPassword: string;
    FUser: string;
    function GetPassword: string;
    function GetUser: string;
    procedure SetPassword(const Value: string);
    procedure SetUser(const Value: string);
  public
    property User: string read GetUser write SetUser;
    property Password: string read GetPassword write SetPassword;
  end;

implementation

{ TProtocol }

function TProtocol.GetHost: string;
begin
  Result := Self.FHost;
end;

function TProtocol.GetPort: Word;
begin
  Result := Self.FPort;
end;

procedure TProtocol.SetHost(const Value: string);
begin
  FHost := Value;
end;

procedure TProtocol.SetPort(const Value: Word);
begin
  FPort := Value;
end;

{ TProtocolAutenticated }

function TProtocolAutenticated.GetPassword: string;
begin
  Result := Self.FPassword;
end;

function TProtocolAutenticated.GetUser: string;
begin
  Result := Self.FUser;
end;

procedure TProtocolAutenticated.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

procedure TProtocolAutenticated.SetUser(const Value: string);
begin
  FUser := Value;
end;

end.
