# escape=`
FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019

LABEL maintainer="giggio@giggio.net"
ENV gallery_name "My Gallery"
RUN powershell -NoProfile -Command Remove-Item -Recurse -Force C:\inetpub\wwwroot\*; mkdir c:\pgc\
ADD https://github.com/kohsuke/winsw/releases/download/winsw-v2.2.0/WinSW.NET4.exe c:\pgc\pgc.exe
ADD https://github.com/madskristensen/PrivateGalleryCreator/releases/download/1.0.34/PrivateGalleryCreator.exe c:\pgc\PrivateGalleryCreator.exe
COPY pgc.xml c:\pgc\
RUN c:\pgc\pgc.exe install
VOLUME c:\vsix\
ENTRYPOINT net start pgc & C:\ServiceMonitor.exe w3svc