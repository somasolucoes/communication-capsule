unit SomaCapsulas.Communication.Source.AWS.Response;

interface

uses
  System.Classes, System.SysUtils, SomaCapsulas.Communication.Interfaces;

type
  TAWSResponseStatus = class(TInterfacedObject, IAWSResponseStatus)
  private
    FCode: Word;
    FText: string;
    function GetCode: Word;
    function GetText: string;
    procedure SetCode(const Value: Word);
    procedure SetText(const Value: string);
  public
    property Code: Word read GetCode write SetCode;
    property Text: string read GetText write SetText;
    constructor Create(ACode: Word; AText: string);
  end;

  TAWSResponse = class(TInterfaceList, IAWSResponse)
  private
    FStatus: IAWSResponseStatus;
    FCloudPath: string;
    function GetStatus: IAWSResponseStatus;
    function GetCloudPath: string;
    procedure SetStatus(const Value: IAWSResponseStatus);
    procedure SetCloudPath(const Value: string);
  public
    property Status: IAWSResponseStatus read GetStatus write SetStatus;
    property CloudPath: string read GetCloudPath write SetCloudPath;
    constructor Create(AStatus: IAWSResponseStatus; ACloudPath: string);
  end;

implementation

{ TAWSResponseStatus }

constructor TAWSResponseStatus.Create(ACode: Word; AText: string);
begin
  Self.FCode := ACode;
  Self.FText := AText;
end;

function TAWSResponseStatus.GetCode: Word;
begin
  Result := Self.FCode;
end;

function TAWSResponseStatus.GetText: string;
begin
  Result := Self.FText;
end;

procedure TAWSResponseStatus.SetCode(const Value: Word);
begin
  FCode := Value;
end;

procedure TAWSResponseStatus.SetText(const Value: string);
begin
  FText := Value;
end;

{ TAWSResponse }

constructor TAWSResponse.Create(AStatus: IAWSResponseStatus; ACloudPath: string);
begin
  Self.FStatus := AStatus;
  Self.FCloudPath := ACloudPath;
end;

function TAWSResponse.GetCloudPath: string;
begin
  Result := Self.FCloudPath;
end;

function TAWSResponse.GetStatus: IAWSResponseStatus;
begin
  Result := Self.FStatus;
end;

procedure TAWSResponse.SetCloudPath(const Value: string);
begin
  FCloudPath := Value;
end;

procedure TAWSResponse.SetStatus(const Value: IAWSResponseStatus);
begin
  FStatus := Value;
end;

end.
