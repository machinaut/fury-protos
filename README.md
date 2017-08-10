# fury-protos

Example shared protobuf repository, which builds debian (C++) and python packages.

## Why?

[GRPC](https://grpc.io/) and [Protobufs](https://developers.google.com/protocol-buffers/)
are great but they're a headache to sync between different repositories.

This is an example of a way to fix that: a standalone repository, which
builds packages that can be included directly in downstream projects.

[Gemfury](https://gemfury.com) takes care of hosting the repositories,
so you can just include them in downstream repos.

## Building Packages

To build the debian and python packages and upload new versions to gemfury:

    make upload

See [Makefile](Makefile) for more.

## Using Packages

To use the debian package:

    apt-get update && apt-get install -y apt-transport-https
    echo "deb [trusted=yes] https://repo.fury.io/machinaut/ /" >> /etc/apt/sources.list.d/fury.list
    apt-get update && apt-get -y install fury-protos && ldconfig

To use the python package in a requirements.txt:

    pip install fury-protos --extra-index-url https://pypi.fury.io/machinaut/

## Caveat: Prerequisites

The debian package requires `grpc` and `protobuf` packages,
which aren't up to date in the standard ubuntu repositories.

I solved this by building and uploading my own, also on Gemfury:
https://gemfury.com/machinaut

I'll upload the code for building these soon.
(Though my packages are public, I'm not making promises to maintain them!)
