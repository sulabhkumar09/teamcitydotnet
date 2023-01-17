FROM mcr.microsoft.com/dotnet/core/sdk:7.0
LABEL maintainer="sulabh kumar"

ENV PLANTUML_VERSION=1.2018.5
ENV LANG en_US.UTF-8

RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y default-jdk && \
    apt-get install -y ant && \
    apt-get install -y libc6-dev && \
    apt-get install -y libgdiplus && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean;

# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# Remove cache to reduce docker size
RUN rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/lib/libgdiplus.so /usr/lib/gdiplus.dll
RUN ln -s /usr/lib/libc6-dev.so /usr/lib/c6-dev.dll

RUN export PATH="$PATH:~/.dotnet/tools:/root/.dotnet/tools"
RUN dotnet tool install --global dotnet-sonarscanner
