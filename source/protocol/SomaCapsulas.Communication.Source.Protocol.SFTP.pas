unit SomaCapsulas.Communication.Source.Protocol.SFTP;

interface

uses
  System.Classes, System.SysUtils, tgputtylib, tgputtysftp, SomaCapsulas.Communication.Source.Protocol.FTP,
  SomaCapsulas.Communication.Source.Protocol.Core, SomaCapsulas.Communication.Interfaces,
  SomaCapsulas.Communication.Source.Protocol.Builder.SFTP;

type
  TSFTP = class abstract(TFTP);

  TSFTPPutty = class(TSFTP, ISFTP)
  private
    FComponent: TTGPuttySFTP;
    [weak]
    FFiles: TStringList;
    FMask: string;
    procedure SetComponent(const Value: TTGPuttySFTP);
    procedure ClenRefs;
  protected
    function VerifyHostKey(const AHost: PAnsiChar;
                           const APort: Integer;
                           const AFingerprint: PAnsiChar;
                           const AVerifyStatus: Integer;
                           var AStoreHostKey: Boolean): Boolean;
    function Listing(const ANames: Pfxp_names): Boolean;
  public
    type
      Builder = TSFTPPuttyBuilder;
    property Component: TTGPuttySFTP read FComponent write SetComponent;
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
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  System.RegularExpressions, SomaCapsulas.Communication.Exception,
  SomaCapsulas.Communication.Message, Math;

{ TSFTPPutty }

constructor TSFTPPutty.Create;
begin
  Self.Component := TTGPuttySFTP.Create(False);
end;

function TSFTPPutty.Connect: Boolean;
begin
  try
    with Self.Component do
    begin
      if Connected then
        Disconnect;
      HostName        := Self.Host;
      UserName        := Self.User;
      Password        := Self.Password;
      Port            := Self.Port;
      OnVerifyHostKey := VerifyHostKey;
      OnListing       := Listing;
      Connect;
    end;
  finally
    Result := Self.Connected;
  end;
end;

function TSFTPPutty.Connected: Boolean;
begin
  Result := Self.Component.Connected;
end;

procedure TSFTPPutty.Disconnect;
begin
  Self.Component.Disconnect;
end;

procedure TSFTPPutty.ClenRefs;
begin
  Self.FFiles := nil;
  Self.FMask := EmptyStr
end;

function TSFTPPutty.Listing(const ANames: Pfxp_names): Boolean;
var
  I: Integer;
  LRegexp: string;
  LMathWithRegex: Boolean;
  LFileName: string;
begin
  LRegexp := StringReplace(Self.FMask, '.', '\.', [rfIgnoreCase, rfReplaceAll]);
  LRegexp := StringReplace(LRegexp, '*', '.*', [rfIgnoreCase, rfReplaceAll]);
  for I := ZeroValue to Pred(ANames^.nnames) do
  begin
    LFileName := Pfxp_name_array(ANames^.names)^[I].filename;
    LMathWithRegex := True;
    if not LRegexp.IsEmpty then
      LMathWithRegex := TRegEx.IsMatch(LFileName, LRegexp);
    if (Assigned(Self.FFiles) and LMathWithRegex) then
      Self.FFiles.Add(Utf8ToString(LFileName));
  end;
  Result := True;
end;

procedure TSFTPPutty.ChangeDir(APath: string);
begin
  Self.Component.ChangeDir(APath);
end;

procedure TSFTPPutty.ChangeDir;
begin
  if (Self.Component.WorkDir <> Self.Directory) and
    (not Self.Directory.IsEmpty) then
    Self.Component.ChangeDir(Self.Directory);
end;

procedure TSFTPPutty.DeleteFile(AFileName: string);
begin
  Initialize;
  Self.Component.DeleteFile(AFileName);
end;

procedure TSFTPPutty.DownloadFile(AServerFile: string;
  var AMemoryStream: TMemoryStream);
begin
  Initialize;
  Self.Component.DownloadStream(AServerFile, AMemoryStream, False);
end;

procedure TSFTPPutty.DownloadFile(AServerFile, ALocalFile: string);
begin
  Initialize;
  Self.Component.DownloadFile(AServerFile, ALocalFile, False);
end;

procedure TSFTPPutty.RetrieveFilesName(var AStringList: TStringList;
  ADetailed: Boolean);
begin
  Initialize;
  Self.FFiles := AStringList;
  Self.Component.ListDir(EmptyAnsiStr);
  ClenRefs;
end;

procedure TSFTPPutty.RetrieveFilesName(var AStringList: TStringList;
  AMask: string; ADetailed: Boolean);
begin
  Initialize;
  Self.FFiles := AStringList;
  Self.FMask := AMask;
  Self.Component.ListDir(EmptyAnsiStr);
  ClenRefs;
end;

procedure TSFTPPutty.RetrieveFilesName(var AStringList: TStringList);
begin
  Initialize;
  Self.FFiles := AStringList;
  Self.Component.ListDir(EmptyAnsiStr);
  ClenRefs;
end;

procedure TSFTPPutty.UploadFile(ALocalFile: string);
var
  LDateTime: TDateTimeInfoRec;
  LServerFile: string;
begin
  if not FileExists(ALocalFile) then
    raise ESomaCapsulasCommunicationSFTP.Create(Format(E_SCC_0002, [ALocalFile]));
  Initialize;
  LServerFile := ExtractFileName(ALocalFile);
  FileGetDateTimeInfo(ALocalFile, LDateTime);
  Self.Component.UploadFile(ALocalFile, LServerFile, False);
  Self.Component.SetModifiedDate(LServerFile, LDateTime.TimeStamp, False);
end;

function TSFTPPutty.VerifyHostKey(const AHost: PAnsiChar;
  const APort: Integer; const AFingerprint: PAnsiChar;
  const AVerifyStatus: Integer; var AStoreHostKey: Boolean): Boolean;
begin
  Result := True;
  AStoreHostKey := Result;
end;

destructor TSFTPPutty.Destroy;
begin
  if Self.Connected then
    Self.Disconnect;
  if Assigned(Self.Component) then
    Self.Component.Free;
  inherited;
end;

{$REGION ' Setters '}
procedure TSFTPPutty.SetComponent(const Value: TTGPuttySFTP);
begin
  FComponent := Value;
end;
{$ENDREGION}

end.
