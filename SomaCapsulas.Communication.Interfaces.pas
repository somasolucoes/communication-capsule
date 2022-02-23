unit SomaCapsulas.Communication.Interfaces;

interface

uses
  System.Classes, System.SysUtils, Data.Cloud.AmazonAPI;

type
  IProtocol = interface
  ['{FE996318-48A0-4529-9007-CAF4324815E6}']
    function GetHost: string;
    function GetPort: Word;
    procedure SetHost(const Value: string);
    procedure SetPort(const Value: Word);
    property Host: string read GetHost write SetHost;
    property Port: Word read GetPort write SetPort;
  end;

  IProtocolAutenticated = interface(IProtocol)
  ['{B953AB0D-2C13-4F0E-AAD1-F3B9F66DB143}']
    function GetPassword: string;
    function GetUser: string;
    procedure SetPassword(const Value: string);
    procedure SetUser(const Value: string);
    property User: string read GetUser write SetUser;
    property Password: string read GetPassword write SetPassword;
  end;

  IFTP = interface(IProtocolAutenticated)
  ['{06210FD6-6E57-4D1D-9CCE-29E02E09757B}']
    function GetDirectory: string;
    function GetIsPassive: Boolean;
    function GetSubDomain: string;
    procedure SetDirectory(const Value: string);
    procedure SetIsPassive(const Value: Boolean);
    procedure SetSubDomain(const Value: string);
    property IsPassive: Boolean read GetIsPassive write SetIsPassive;
    property Directory: string read GetDirectory write SetDirectory;
    property SubDomain: string read GetSubDomain write SetSubDomain;
    function Connect: Boolean;
    function Connected: Boolean;
    procedure Disconnect;
    procedure ChangeDir; overload;
    procedure ChangeDir(APath: string); overload;
    procedure RetrieveFilesName(var AStringList: TStringList; AMask: string; ADetailed: Boolean); overload;
    procedure RetrieveFilesName(var AStringList: TStringList; ADetailed: Boolean); overload;
    procedure RetrieveFilesName(var AStringList: TStringList); overload;
    procedure UploadFile(APath: string);
    procedure DownloadFile(AServerFile, ALocalFile: string); overload;
    procedure DownloadFile(AServerFile: string; var AMemoryStream: TMemoryStream); overload;
    procedure DeleteFile(AFileName: string);
  end;

  IFTPBuilder = interface
  ['{8429424F-C3E6-479E-A8B6-424999CE0249}']
    function UsingUser(AUser: string): IFTPBuilder;
    function WithPassword(APassword: string): IFTPBuilder;
    function OnHost(AHost: string): IFTPBuilder;
    function AtPort(APort: Word): IFTPBuilder;
    function ChangeToDir(ADir: string): IFTPBuilder;
    function IsPassive(AIsPassive: Boolean): IFTPBuilder;
    function AvaliableOn(ASubDomain: string): IFTPBuilder;
    function Build: IFTP;
  end;

  ISFTP = interface(IFTP)
  ['{901B160E-57EE-4929-A380-204538355795}']
  end;

  ISFTPBuilder = interface
  ['{C89386F6-01AD-4744-A10A-B45248EF713E}']
    function UsingUser(AUser: string): ISFTPBuilder;
    function WithPassword(APassword: string): ISFTPBuilder;
    function OnHost(AHost: string): ISFTPBuilder;
    function AtPort(APort: Word): ISFTPBuilder;
    function ChangeToDir(ADir: string): ISFTPBuilder;
    function AvaliableOn(ASubDomain: string): ISFTPBuilder;
    function Build: ISFTP;
  end;

implementation end.