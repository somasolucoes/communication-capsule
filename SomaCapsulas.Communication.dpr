program SomaCapsulas.Communication;
{$APPTYPE CONSOLE}
{$R *.res}
uses
  System.SysUtils,
  SomaCapsulas.Communication.Constant in 'SomaCapsulas.Communication.Constant.pas',
  SomaCapsulas.Communication.Exception in 'SomaCapsulas.Communication.Exception.pas',
  SomaCapsulas.Communication.Interfaces in 'SomaCapsulas.Communication.Interfaces.pas',
  SomaCapsulas.Communication.Message in 'SomaCapsulas.Communication.Message.pas',
  SomaCapsulas.Communication.Types in 'SomaCapsulas.Communication.Types.pas',
  SomaCapsulas.Communication.Source.Protocol.Core in 'source\protocol\SomaCapsulas.Communication.Source.Protocol.Core.pas',
  SomaCapsulas.Communication.Source.Protocol.FTP in 'source\protocol\SomaCapsulas.Communication.Source.Protocol.FTP.pas',
  SomaCapsulas.Communication.Source.Protocol.SFTP in 'source\protocol\SomaCapsulas.Communication.Source.Protocol.SFTP.pas',
  SomaCapsulas.Communication.Source.Protocol.Builder.FTP in 'source\protocol\builder\SomaCapsulas.Communication.Source.Protocol.Builder.FTP.pas',
  SomaCapsulas.Communication.Source.Protocol.Builder.SFTP in 'source\protocol\builder\SomaCapsulas.Communication.Source.Protocol.Builder.SFTP.pas',
  SomaCapsulas.Communication.Source.AWS.ConnectionInfo in 'source\aws\SomaCapsulas.Communication.Source.AWS.ConnectionInfo.pas',
  SomaCapsulas.Communication.Source.AWS.Core in 'source\aws\SomaCapsulas.Communication.Source.AWS.Core.pas',
  SomaCapsulas.Communication.Source.AWS.Response in 'source\aws\SomaCapsulas.Communication.Source.AWS.Response.pas',
  SomaCapsulas.Communication.Source.AWS.S3 in 'source\aws\SomaCapsulas.Communication.Source.AWS.S3.pas',
  SomaCapsulas.Communication.Source.AWS.Factory.S3 in 'source\aws\factory\SomaCapsulas.Communication.Source.AWS.Factory.S3.pas';

var
  LReadLnToWait: string;
begin
  try
    Writeln('SOMA Cápsulas - Communication');
    Writeln(EmptyStr);
    Writeln('           _..---...,""-._     ,/}/)      ');
    Writeln('        .''        ,      ``..''(/-<      ');
    Writeln('       /   _      {      )         \      ');
    Writeln('      ;   _ `.     `.   <         a(      ');
    Writeln('    ,''   ( \  )      `.  \ __.._ .: y    ');
    Writeln('   (  <\_-) )''-.____...\  `._   //-''    ');
    Writeln('    `. `-'' /-._)))      `-._)))          ');
    Writeln('      `...''         hjw                  ');
    Read(LReadLnToWait);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
