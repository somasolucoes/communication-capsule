unit SomaCapsulas.Communication.Source.AWS.S3;

interface

uses
  System.Classes, System.SysUtils, SomaCapsulas.Communication.Source.AWS.Core,
  SomaCapsulas.Communication.Interfaces, Data.Cloud.CloudAPI, Data.Cloud.AmazonAPI;

type
  TAWSS3 = class abstract(TAWS, IAWSS3)
  public
    function Upload(ABucketName, AFilePath, AObjectName: string): IAWSResponse; virtual; abstract;
  end;

  TAWSS3Wrapper = class(TAWSS3)
  private
    FComponent: TAmazonStorageService;
    function GetAccessUrl(ABucketName: string; AObjectName: string): string;
    function FullfilWithConnectionInfo(AConnectionInfo: IAWSConnectionInfo): TAmazonConnectionInfo;
    function ResponseToWrapper(AResponse: TCloudResponseInfo; ACloudPath: string): IAWSResponse;
  public
    function Upload(ABucketName, AFilePath, AObjectName: string): IAWSResponse; override;
    constructor Create(AAWSConnectionInfo: IAWSConnectionInfo); reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  Math, SomaCapsulas.Communication.Exception, SomaCapsulas.Communication.Message, SomaCapsulas.Communication.Constant,
  SomaCapsulas.Communication.Source.AWS.Response;

{ TAWSS3Wrapper }

constructor TAWSS3Wrapper.Create(AAWSConnectionInfo: IAWSConnectionInfo);
begin
  inherited;
  Self.FComponent :=
    TAmazonStorageService.Create(FullfilWithConnectionInfo(Self.AWSConnectionInfo));
end;

destructor TAWSS3Wrapper.Destroy;
begin
  if Assigned(Self.FComponent) then
    Self.FComponent.Free;
  inherited;
end;

function TAWSS3Wrapper.Upload(ABucketName, AFilePath, AObjectName: string): IAWSResponse;
var
  LResponse: TCloudResponseInfo;
  LUploadStream: TBytesStream;
  LBytes: TBytes;
  LCloudPath: string;
begin
  Result := nil;
  LUploadStream := TBytesStream.Create;
  LUploadStream.LoadFromFile(AFilePath);
  try
    LUploadStream.Position := ZeroValue;
    SetLength(LBytes, LUploadStream.Size);
    LUploadStream.ReadBuffer(LBytes, LUploadStream.Size);
    LResponse := TCloudResponseInfo.Create;
    try
      Self.FComponent.UploadObject(ABucketName,
                                   AObjectName,
                                   LBytes,
                                   True,
                                   nil,
                                   nil,
                                   amzbaPrivate,
                                   LResponse);
      LCloudPath := GetAccessUrl(ABucketName, AObjectName);
      Result := ResponseToWrapper(LResponse, LCloudPath);
    finally
      if Assigned(LResponse) then
        LResponse.Free;
    end;
  finally
    if Assigned(LUploadStream) then
      LUploadStream.Free;
  end;
end;

function TAWSS3Wrapper.ResponseToWrapper(AResponse: TCloudResponseInfo;
  ACloudPath: string): IAWSResponse;
var
  LStatus: IAWSResponseStatus;
begin
  LStatus := TAWSResponseStatus.Create(AResponse.StatusCode, AResponse.StatusMessage);
  Result := TAWSResponse.Create(LStatus, ACloudPath);
end;

function TAWSS3Wrapper.FullfilWithConnectionInfo(AConnectionInfo: IAWSConnectionInfo): TAmazonConnectionInfo;
begin
  Result := TAmazonConnectionInfo.Create(nil);
  try
    Result.AccountName := AConnectionInfo.AccessKeyID;
    Result.AccountKey  := AConnectionInfo.SecretAccessKey;
    Result.Region      := AConnectionInfo.DefaultRegion;
    Result.Protocol    := AWS_S3_PROTOCOL;
  except
    if Assigned(Result) then
      FreeAndNil(Result);
  end;
end;

function TAWSS3Wrapper.GetAccessUrl(ABucketName, AObjectName: string): string;
begin
  Result := Format('%s://%s.s3.amazonaws.com/%s', [AWS_S3_PROTOCOL,
                                                   ABucketName,
                                                   AObjectName]);
end;

end.
