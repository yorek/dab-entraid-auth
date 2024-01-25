#!/bin/bash
SApassword="Passw0rd!"

echo ">>> Waiting for SQL Server to start..."
echo "SELECT * FROM SYS.DATABASES" | dd of=testsqlconnection.sql
for i in {1..60};
do
    /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P $SApassword -C -d tempdb -i testsqlconnection.sql > /dev/null
    if [ $? -eq 0 ]
    then
        echo "SQL Server ready."
        break
    else
        echo "Not ready yet..."
        sleep 1
    fi
done
rm testsqlconnection.sql

sqlprojpath="./db/cloud-day-2023-db"
for f in $sqlprojpath/*
do
    if [ $f == $sqlprojpath/*".sqlproj" ]
    then
        echo "Found sqlproj $f, building..."
        dotnet build -c Release $f
        echo "Project sqlproj $f built."
    fi
done

dacpath="$sqlprojpath/bin/Release"
for f in $dacpath/*
do
    if [ $f == $dacpath/*".dacpac" ]
    then
        echo "Found dacpac $f, deploying..."
        dbname=$(basename $f ".dacpac")
        /opt/sqlpackage/sqlpackage /Action:Publish /SourceFile:$f /TargetServerName:localhost /TargetDatabaseName:$dbname /TargetUser:sa /TargetPassword:$SApassword /TargetTrustServerCertificate:True
        echo "Dacpac $f deployed."
    fi
done

echo ">>> Creating .env file...."
echo "MSSQL='Server=localhost;Initial Catalog=cloud-day-2023-db;Persist Security Info=False;User ID=dab_user;Password=P@ssw0rd;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=True;Connection Timeout=30;'" | dd of=.env
echo ">>> .env file created."

echo ">>> Installing Data API builder..."
dotnet tool install Microsoft.DataApiBuilder -g
echo ">>> Data API builder installed."