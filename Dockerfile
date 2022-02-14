# escape=`
FROM mcr.microsoft.com/powershell:lts-nanoserver-1809 as base

#ADD https://github.com/madskristensen/PrivateGalleryCreator/releases/download/1.0.49/PrivateGalleryCreator.zip c:\pgc\
RUN pwsh -Command `
    mkdir c:\pgc\; `
    Invoke-WebRequest -Uri https://github.com/madskristensen/PrivateGalleryCreator/releases/download/1.0.49/PrivateGalleryCreator.zip -OutFile c:\pgc\PrivateGalleryCreator.zip; `
    Expand-Archive c:\pgc\PrivateGalleryCreator.zip -DestinationPath c:\pgc\ ; `
    rm c:\pgc\PrivateGalleryCreator.zip

# ADD https://github.com/giggio/simpleserver/releases/download/0.2.0/simpleserver.tgz c:\simpleserver\
RUN pwsh -Command `
    mkdir c:\simpleserver\; `
    Invoke-WebRequest -Uri https://github.com/giggio/simpleserver/releases/download/0.2.0/simpleserver.tgz -OutFile c:\simpleserver\simpleserver.tgz; `
    tar -oxzf c:\simpleserver\simpleserver.tgz -C 'C:\simpleserver\' simpleserver.dll simpleserver.deps.json simpleserver.runtimeconfig.json System.CommandLine.dll; `
    Remove-Item -Force c:\simpleserver\simpleserver.tgz

FROM mcr.microsoft.com/dotnet/runtime:3.1-nanoserver-1809 as dotnet31

FROM mcr.microsoft.com/dotnet/aspnet:6.0-nanoserver-1809
LABEL maintainer="giggio@giggio.net"
COPY --from=dotnet31 [ "C:/Program Files/dotnet", "C:/Program Files/dotnet" ]
COPY --from=base 'C:\pgc' 'C:\pgc'
COPY --from=base 'C:\simpleserver' 'C:\simpleserver'
ENV PGC_GALLERY_NAME "My Gallery"
ENV PGC_VSIX_LOCATION c:\vsix\
ENTRYPOINT "c:\start.cmd" < Nul
USER ContainerAdministrator
RUN mkdir c:\gallery\ && mkdir c:\temp && setx /M TEMP "C:\temp" && setx /M TMP "C:\temp"
USER ContainerUser
COPY start.cmd c:\