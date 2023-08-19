unit SomaCapsulas.Communication.Constant;
interface
uses
  Data.Cloud.AmazonAPI;
const
  /// <summary>
  ///   FTP connection time out.
  /// </summary>
  FTP_CONNECT_TIME_OUT = 30000;
  /// <summary>
  ///   FTP read time out.
  /// </summary>
  FTP_READ_TIME_OUT = 60000;
  /// <summary>
  ///   Protocol to communicate with S3.
  /// </summary>
  AWS_S3_PROTOCOL = 'https';

implementation end.
