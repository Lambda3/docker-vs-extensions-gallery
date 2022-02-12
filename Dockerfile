# escape=`
FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019

LABEL maintainer="giggio@giggio.net"
ENV PGC_GALLERY_NAME "My Gallery"
ENV PGC_VSIX_LOCATION c:\vsix\
RUN powershell -NoProfile -Command Remove-Item -Recurse -Force C:\inetpub\wwwroot\*; mkdir c:\pgc\; mkdir c:\vsix\;

#dotnet, see https://github.com/dotnet/dotnet-docker/blob/a414b0c27dd50282292c6656b1ea3f9d3347e1d7/src/runtime/3.1/nanoserver-1809/amd64/Dockerfile
ENV `
    # Enable detection of running in a container
    DOTNET_RUNNING_IN_CONTAINER=true `
    # .NET Runtime version
    DOTNET_VERSION=3.1.22

# Install .NET Runtime
RUN powershell -Command `
    $ErrorActionPreference = 'Stop'; `
    $ProgressPreference = 'SilentlyContinue'; `
    Invoke-WebRequest -OutFile dotnet.zip https://dotnetcli.azureedge.net/dotnet/Runtime/${Env:DOTNET_VERSION}/dotnet-runtime-${Env:DOTNET_VERSION}-win-x64.zip; `
    $dotnet_sha512 = '302ebd2348ca893646f1574ff38b8db31dde91c52ec60f23019a5f28cb72ad268facf2c0ee23d201ff0187ba5ee4317f01eb9c6681f88356f3da7d5d2f3452f7'; `
    if ((Get-FileHash dotnet.zip -Algorithm sha512).Hash -ne $dotnet_sha512) { `
    Write-Host 'CHECKSUM VERIFICATION FAILED!'; `
    exit 1; `
    }; `
    mkdir 'C:\Program Files\dotnet'; `
    tar -oxzf dotnet.zip -C 'C:\Program Files\dotnet'; `
    Remove-Item -Force dotnet.zip
#end dotnet
RUN setx /M PATH "%PATH%;C:\Program Files\dotnet"

ADD https://github.com/winsw/winsw/releases/download/v2.11.0/WinSW-x64.exe c:\pgc\pgc.exe
ADD https://github.com/madskristensen/PrivateGalleryCreator/releases/download/1.0.49/PrivateGalleryCreator.zip c:\pgc\
RUN powershell -Command `
    Expand-Archive c:\pgc\PrivateGalleryCreator.zip -DestinationPath c:\pgc\ ; `
    rm c:\pgc\PrivateGalleryCreator.zip
COPY pgc.xml c:\pgc\
RUN powershell -Command `
    cd c:\pgc\; `
    .\pgc.exe install
ENTRYPOINT powershell -Command [Environment]::SetEnvironmentVariable(\"PGC_VSIX_LOCATION\", $env:PGC_VSIX_LOCATION, \"Machine\"); `
    [Environment]::SetEnvironmentVariable(\"PGC_GALLERY_NAME\", $env:PGC_GALLERY_NAME, \"Machine\"); `
    net start pgc; `
    . C:\ServiceMonitor.exe w3svc