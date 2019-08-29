# Private Gallery Creator Docker Image

This repository contains `Dockerfile` definitions for
[lambda3/vs-extensions-gallery](https://github.com/lambda3/docker-vs-extensions-gallery).

This is the Windows Docker image for the
[Private VS Gallery Creator](https://github.com/madskristensen/PrivateGalleryCreator/).

[![Downloads from Docker Hub](https://img.shields.io/docker/pulls/lambda3/vs-extensions-gallery.svg)](https://registry.hub.docker.com/u/lambda3/vs-extensions-gallery)
[![Stars on Docker Hub](https://img.shields.io/docker/stars/lambda3/vs-extensions-gallery.svg)](https://registry.hub.docker.com/u/lambda3/vs-extensions-gallery) [![](https://images.microbadger.com/badges/image/lambda3/vs-extensions-gallery.svg)](https://microbadger.com/images/lambda3/vs-extensions-gallery "Get your own image badge on microbadger.com")


## Supported tags

* [`latest` (*Dockerfile*)](https://github.com/lambda3/docker-vs-extensions-gallery/blob/master/Dockerfile)

This is based on the
[IIS Server image for Windows Server 2019](https://hub.docker.com/_/microsoft-windows-servercore-iis).

## Running

On Windows, use Docker for Windows and run, on PowerShell:

````powershell
docker run --rm -ti -v "c:\path\to\vsixs\:c:\vsix\" -p 5000:80 lambda3/vs-extensions-gallery
````

And navigate to [http://localhost:5000/feed.xml](http://localhost:5000/feed.xml).

## Maintainers

* [Giovanni Bassi](http://blog.lambda3.com.br/L3/giovannibassi/), aka Giggio, [Lambda3](http://www.lambda3.com.br), [@giovannibassi](https://twitter.com/giovannibassi)

## License

This software is open source, licensed under the Apache License, Version 2.0.
See [LICENSE.txt](https://github.com/lambda3/docker-vs-extensions-gallery/blob/master/LICENSE.txt) for details.
Check out the terms of the license before you contribute, fork, copy or do anything
with the code. If you decide to contribute you agree to grant copyright of all your contribution to this project, and agree to
mention clearly if do not agree to these terms. Your work will be licensed with the project at Apache V2, along the rest of the code.
