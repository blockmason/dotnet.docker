FROM debian:stretch

ENV \
  DOTNET_CLI_TELEMETRY_OPTOUT="1" \
  DOTNET_SKIP_FIRST_TIME_EXPERIENCE="1" \
  DOTNET_VERSION="2.2"

RUN set -o nounset -o errexit;\
  apt-get update;\
  apt-get upgrade -y;\
  apt-get install \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    git \
    gnupg \
    gzip \
    python \
    ssh \
    wget \
    xz-utils \
    zlibc \
    zlib1g \
    zlib1g-dev \
  -y;\
  curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg;\
  curl -sSL https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/microsoft.list;\
  chown root:root /etc/apt/trusted.gpg.d/microsoft.gpg /etc/apt/sources.list.d/microsoft.list;\
  chmod 0444 /etc/apt/trusted.gpg.d/microsoft.gpg /etc/apt/sources.list.d/microsoft.list;\
  apt-get update;\
  apt-get install "dotnet-sdk-${DOTNET_VERSION}" -y;\
  apt-get autoremove -y;\
  rm -vfR /var/lib/apt/lists/*;\
  addgroup --system --gid 1337 docker;\
  adduser --system --gid 1337 --uid 1337 --home /docker --gecos '' --shell /bin/bash --disabled-login docker;

USER docker

WORKDIR /docker

RUN dotnet tool install -g trx2junit
