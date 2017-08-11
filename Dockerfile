FROM ubuntu:16.04
# reference: https://xan-manning.co.uk/making-deb-packages-using-docker/

VOLUME /build
VOLUME /release

# Install build dependencies
RUN apt-get update && apt-get -y install \
    apt-transport-https \
    build-essential \
    devscripts \
    fakeroot \
    debhelper \
    automake \
    autotools-dev \
    pkg-config \
    ca-certificates \
    --no-install-recommends

# Install application dependencies
RUN echo "deb [trusted=yes] https://repo.fury.io/machinaut/ /" >> /etc/apt/sources.list.d/fury.list
RUN apt-get update && apt-get -y install \
    grpc \
    protobuf \
    --no-install-recommends && ldconfig

COPY deb /src
COPY fury_protos/ /src/fury_protos
COPY VERSION /src/VERSION
WORKDIR /src

ENTRYPOINT ["/src/entrypoint.sh"]
