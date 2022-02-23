unit SomaCapsulas.Communication.Source.Protocol.FTP;

interface

uses
  System.Classes, System.SysUtils, IdFTP, IdTrivialFTP, IdFTPCommon,
  IdBaseComponent, IdComponent, IdTCPConnection, IdThreadComponent,
  SomaCapsulas.Communication.Interfaces, SomaCapsulas.Communication.Source.Protocol.Core,
  SomaCapsulas.Communication.Source.Protocol.Builder.FTP;

type
  TFTP = class abstract(TProtocolAutenticated, IFTP)
  private
    FDirectory: string;
    FIsPassive: Boolean;
    FSubDomain: string;
    function GetDirectory: string;
    function GetIsPassive: Boolean;
    function GetSubDomain: string;
    procedure SetDirectory(const Value: string);
    procedure SetIsPassive(const Value: Boolean);
    procedure SetSubDomain(const Value: string);
  protected
    procedure Initialize;
  public
    property IsPassive: Boolean read GetIsPassive write SetIsPassive;
    property Directory: string read GetDirectory write SetDirectory;
    property SubDomain: string read GetSubDomain write SetSubDomain;
    function Connect: Boolean; virtual; abstract;
    function Connected: Boolean; virtual; abstract;
    procedure Disconnect; virtual; abstract;
    procedure ChangeDir; overload; virtual; abstract;
    procedure ChangeDir(APath: string); overload; virtual; abstract;
    procedure RetrieveFilesName(var AStringList: TStringList; AMask: string; ADetailed: Boolean); overload; virtual; abstract;
    procedure RetrieveFilesName(var AStringList: TStringList; ADetailed: Boolean); overload; virtual; abstract;
    procedure RetrieveFilesName(var AStringList: TStringList); overload; virtual; abstract;
    procedure UploadFile(ALocalFile: string); virtual; abstract;
    procedure DownloadFile(AServerFile, ALocalFile: string); overload; virtual; abstract;
    procedure DownloadFile(AServerFile: string; var AMemoryStream: TMemoryStream); overload; virtual; abstract;
    procedure DeleteFile(AFileName: string); virtual; abstract;
  end;

  TFTPClientIndy = class(TFTP)
  private
    FComponent: TIdFTP;
    procedure SetComponent(AValue: TIdFTP);
  public
    type
      Builder = TFTPIndyBuilder;
    property Component: TIdFTP read FComponent write SetComponent;
    function Connect: Boolean; override;
    function Connected: Boolean; override;
    procedure Disconnect; override;
    procedure ChangeDir; overload; override;
    procedure ChangeDir(APath: string); overload; override;
    procedure RetrieveFilesName(var AStringList: TStringList; AMask: string; ADetailed: Boolean); overload; override;
    procedure RetrieveFilesName(var AStringList: TStringList; ADetailed: Boolean); overload; override;
    procedure RetrieveFilesName(var AStringList: TStringList); overload; override;
    procedure UploadFile(ALocalFile: string); override;
    procedure DownloadFile(AServerFile, ALocalFile: string); overload; override;
    procedure DownloadFile(AServerFile: string; var AMemoryStream: TMemoryStream); overload; override;
    procedure DeleteFile(AFileName: string); override;
    constructor Create; virtual;
    destructor Destroy; override;
  end;

implementation

uses
  SomaCapsulas.Communication.Constant, SomaCapsulas.Communication.Exception,
  SomaCapsulas.Communication.Message;

{ TFTP }

procedure TFTP.Initialize;
begin
  if not Self.Connected then
  begin
    Self.Connect;
    Self.ChangeDir;
  end;
end;

function TFTP.GetDirectory: string;
begin
  Result := Self.FDirectory;
end;

function TFTP.GetIsPassive: Boolean;
begin
  Result := Self.FIsPassive;
end;

function TFTP.GetSubDomain: string;
begin
  Result := Self.FSubDomain;
end;

procedure TFTP.SetDirectory(const Value: string);
begin
  FDirectory := Value;
end;

procedure TFTP.SetIsPassive(const Value: Boolean);
begin
  FIsPassive := Value;
end;

procedure TFTP.SetSubDomain(const Value: string);
begin
  FSubDomain := Value;
end;

{ TFTPClientIndy }

constructor TFTPClientIndy.Create;
begin
  Self.Component := TIdFTP.Create(nil);
end;

function TFTPClientIndy.Connect: Boolean;
begin
  with Self.Component do
  begin
    if Connected then
      Disconnect;
    Host           := Self.Host;
    Username       := Self.User;
    Password       := Self.Password;
    Port           := Self.Port;
    Passive        := Self.IsPassive;
    TransferType   := ftBinary;
    ConnectTimeout := FTP_CONNECT_TIME_OUT;
    ReadTimeout    := FTP_READ_TIME_OUT;
    Connect;
  end;
  Result := Self.Connected;;
end;

function TFTPClientIndy.Connected;
begin
  Result := Self.Component.Connected;
end;

procedure TFTPClientIndy.Disconnect;
begin
  if Self.Connected then
  begin
    Self.Component.IOHandler.InputBuffer.Clear;
    Self.Component.IOHandler.CloseGracefully;
    Self.Component.Disconnect;
  end;
end;

procedure TFTPClientIndy.ChangeDir(APath: string);
begin
  Self.Component.ChangeDir(APath);
end;

procedure TFTPClientIndy.ChangeDir;
begin
  if (Self.Component.RetrieveCurrentDir <> Self.Directory) and (not Self.Directory.IsEmpty) then
    Self.Component.ChangeDir(Self.Directory);
end;

procedure TFTPClientIndy.RetrieveFilesName(var AStringList: TStringList);
begin
  Initialize;
  Self.Component.List(AStringList);
end;

procedure TFTPClientIndy.RetrieveFilesName(var AStringList: TStringList; AMask: string; ADetailed: Boolean);
begin
  Initialize;
  Self.Component.List(AStringList, AMask, ADetailed);
end;

procedure TFTPClientIndy.RetrieveFilesName(var AStringList: TStringList; ADetailed: Boolean);
begin
  Initialize;
  Self.Component.List(AStringList, EmptyStr, ADetailed);
end;

procedure TFTPClientIndy.UploadFile(ALocalFile: string);
begin
  if not FileExists(ALocalFile) then
    raise ESomaCapsulasCommunicationFTP.Create(Format(E_SCC_0001, [ALocalFile]));
  Initialize;
  Self.Component.Put(ALocalFile);
end;

procedure TFTPClientIndy.DownloadFile(AServerFile: string; var AMemoryStream: TMemoryStream);
begin
  Initialize;
  Self.Component.Get(AServerFile, AMemoryStream, False);
end;

procedure TFTPClientIndy.DownloadFile(AServerFile, ALocalFile: string);
begin
  Initialize;
  Self.Component.Get(AServerFile, ALocalFile, False);
end;

procedure TFTPClientIndy.DeleteFile(AFileName: string);
begin
  Initialize;
  Self.Component.Delete(AFileName);
end;

destructor TFTPClientIndy.Destroy;
begin
  if Self.Connected then
    Self.Disconnect;
  if Assigned(Self.Component) then
    Self.Component.Free;
  inherited;
end;

{$REGION ' Setters '}
procedure TFTPClientIndy.SetComponent(AValue: TIdFTP);
begin
  if FComponent = AValue then
    Exit;
  FComponent := AValue;
end;
{$ENDREGION}

end.

