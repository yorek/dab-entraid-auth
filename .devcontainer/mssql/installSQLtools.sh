#!/bin/bash
echo "Installing mssql-tools"
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | (OUT=$(apt-key add - 2>&1) || echo $OUT)
curl -sSL https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list

apt-get update

ACCEPT_EULA=Y apt-get install -y msodbcsql18 mssql-tools18
echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
PATH="$PATH:/opt/mssql-tools18/bin"

apt-get -y install locales 

rm -rf /var/lib/apt/lists/*
locale-gen en_US.UTF-8
localedef -i en_US -f UTF-8 en_US.UTF-8

echo "Installing sqlpackage"
curl -sSL -o sqlpackage.zip "https://aka.ms/sqlpackage-linux"
mkdir /opt/sqlpackage
unzip sqlpackage.zip -d /opt/sqlpackage 
rm sqlpackage.zip
chmod a+x /opt/sqlpackage/sqlpackage
echo 'export PATH="$PATH:/opt/sqlpackage"' >> ~/.bashrc
PATH="$PATH:/opt/sqlpackage"

source ~/.bashrc