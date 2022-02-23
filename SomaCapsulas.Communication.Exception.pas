unit SomaCapsulas.Communication.Exception;

interface

uses
  SomaCapsulas.Exception;

type
  ESomaCapsulasCommunication = class(ESomaCapsulas);
  ESomaCapsulasCommunicationFTP = class(ESomaCapsulasCommunication);
  ESomaCapsulasCommunicationSFTP = class(ESomaCapsulasCommunicationFTP);

implementation end.
