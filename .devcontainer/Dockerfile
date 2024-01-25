FROM --platform=amd64 mcr.microsoft.com/devcontainers/dotnet:1-6.0-jammy

ENV ASPNETCORE_URLS http://localhost:8000

COPY mssql/installSQLtools.sh installSQLtools.sh

RUN bash ./installSQLtools.sh \
     && apt-get clean -y \
     && rm -rf /var/lib/apt/lists/* /tmp/library-scripts

