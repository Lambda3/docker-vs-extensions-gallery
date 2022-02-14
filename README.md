# Private Gallery Creator Docker Image

This repository contains `Dockerfile` definitions for
[lambda3/vs-extensions-gallery](https://github.com/lambda3/docker-vs-extensions-gallery).

This is the Windows Docker image for the
[Private VS Gallery Creator](https://github.com/madskristensen/PrivateGalleryCreator/).

[![Downloads from Docker Hub](https://img.shields.io/docker/pulls/lambda3/vs-extensions-gallery.svg)](https://hub.docker.com/r/lambda3/vs-extensions-gallery)
[![Stars on Docker Hub](https://img.shields.io/docker/stars/lambda3/vs-extensions-gallery.svg)](https://hub.docker.com/r/lambda3/vs-extensions-gallery) [![](https://images.microbadger.com/badges/image/lambda3/vs-extensions-gallery.svg)](https://microbadger.com/images/lambda3/vs-extensions-gallery "Get your own image badge on microbadger.com")

[![Build Status](https://dev.azure.com/lambda3foss/docker-vs-extensions-gallery/_apis/build/status/Lambda3.docker-vs-extensions-gallery?branchName=master)](https://dev.azure.com/lambda3foss/docker-vs-extensions-gallery/_build/latest?definitionId=4&branchName=master)

## Supported tags

* [`latest` (*Dockerfile*)](https://github.com/lambda3/docker-vs-extensions-gallery/blob/master/Dockerfile)

This is based on the
[ASP.NET Image for Windows Nano Server 2019](https://hub.docker.com/_/microsoft-dotnet-aspnet).

## Running

On Windows, use Docker for Windows and run, on PowerShell:

````powershell
docker run --rm -ti -p 5000:80 -v "c:\path\to\vsixs\:c:\vsix\" lambda3/vs-extensions-gallery
````

You may want to use a file share where the vsix files are stored, if they are
not stored on the container host. It is not possible to mount file shares on
Docker containers, so you will have to to access the share directly from the
container. For that to work, you most likely will need a Group Managed Service
Account, read the
[MS Docs](https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-containers/manage-serviceaccounts)
on how to create one, and then run (replace the json file name):

````powershell
docker run --rm -ti -p 5000:80 --security-opt "credentialspec=file://gsma.json" -e PGC_VSIX_LOCATION=\\myserver\myshare lambda3/vs-extensions-gallery
````

Then navigate to [http://localhost:5000/feed.xml](http://localhost:5000/feed.xml).

## Maintainers

* [Giovanni Bassi](http://blog.lambda3.com.br/L3/giovannibassi/), aka Giggio, [Lambda3](http://www.lambda3.com.br), [@giovannibassi](https://twitter.com/giovannibassi)

## License

This software is open source, licensed under the Apache License, Version 2.0.
See [LICENSE.txt](https://github.com/lambda3/docker-vs-extensions-gallery/blob/master/LICENSE.txt) for details.
Check out the terms of the license before you contribute, fork, copy or do anything
with the code. If you decide to contribute you agree to grant copyright of all your contribution to this project, and agree to
mention clearly if do not agree to these terms. Your work will be licensed with the project at Apache V2, along the rest of the code.
