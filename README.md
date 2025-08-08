# Authenticate using EntraID with Data API builder from any Javascript client

## Pre-Requesites

- [.NET 8](https://dotnet.microsoft.com/en-us/download/dotnet/8.0) 
- [VS Code](https://code.visualstudio.com/)
- [MSSQL](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql) VS Code Extension
- [SQL Database Project](https://marketplace.visualstudio.com/items?itemName=ms-mssql.sql-database-projects-vscode) VS Code extension
- [Live Preview](https://marketplace.visualstudio.com/items?itemName=ms-vscode.live-server)

## Deploy the database

If you need a SQL Server database you can use the free SQL Server Developer Edition or [Azure SQL Free option](https://learn.microsoft.com/en-us/azure/azure-sql/database/free-offer?view=azuresql). 
The easiest way to get started is to use the Docker container for SQL Server. You can find the instructions in the [Local SQL Server container](https://learn.microsoft.com/en-us/sql/tools/visual-studio-code-extensions/mssql/mssql-local-container?view=sql-server-ver17) documentation.

This readme assumes that you are using the local SQL Server container for development.

## Install and test Data API builder

Create a `.env` file in the root of the project with the following content by copying the `.env.sample` file. The sample file is already configured to work with the development environment, so unless you want to change something (for example connect to a differnt server or database, you can leave it as is).

Open the terminal and run 

```bash
dotnet tool install Microsoft.DataApibuilder -g
```

to install Data API builder, then

```
dab start -c config/dab-config-noauth.json --no-https-redirect
```

to run Data API builder. The provided configuration exposes the tables

- `web.speakers`
- `web.sessions`

as REST and GraphQL endpoints, allowing access to anyone, without no need for authentication and authorization.

Right click on the `index.html` file and select "Open with Live Server" to start the application. The simple HTML app, uses GraphQL to query the database via the exposed GraphQL endpoint.

Since there is no authentication nor authorization configured, anyone can access the data. As a result, all the session stored in the database are returned and visualized by the HTML page.

## Add authentication via EntraID

### Register the Data API builder application

Open the Azure Portal and Search for "Entra ID"

(![Entra ID](./_assets/01-entraid.png))

and then open the Entra ID blade. 

![Entra ID Blade](./_assets/02-entraid-blade.png)

Go to App Registrations and click on "New Registration"

![New Registration](./_assets/03-new-registration.png)

Name it "Data API Builder" and select the most appropriate account type for you. For this example we'll use "Accounts in this organization only". 

Click "Register" and then copy the generated "Application (client) ID".

![Application (client) ID](./_assets/04-application-id.png)

into your DAB config, so that the `authentication` section looks like the following (your "Application (client) ID" will be different than the one showed below and in the pictures, which is use just as an example):

```
"authentication": {
    "provider": "AzureAD",
    "jwt": {
        "issuer": "",
        "audience": " 33d3ffac-ed9a-4fbe-b79f-5bc96713e860"
    }
}
```

Now identify the "Directory (tenant) ID" value

![Tenant ID](./_assets/05-tenant-id.png)

And add it in the form of

`https://login.microsoftonline.com/<tenant-id>/v2.0`

to the configuration file

```
"authentication": {
    "provider": "AzureAD",
    "jwt": {
        "issuer": "https://login.microsoftonline.com/36a71206-0015-4845-a10b-02a03ed530bd/v2.0",
        "audience": "33d3ffac-ed9a-4fbe-b79f-5bc96713e860"
    }
},
```

Now click on "Expose an API" and then "Add a Scope":

![Add scope](./_assets/06-add-scope.png)

Accept the provided Application ID Uri and click on "Save and continue".

![Save and continue after adding a scope](./_assets/07-add-scope-save-continue.png)

Create a scope named `Endpoints.Access`. Allow Admins and/or User to consent depending on the security level you want to set.

Get the "Scope ID" as it will be needed later:

![Scope ID](./_assets/08-scope-id.png)

## Configure Data API builder permissions

Now Data API builder is able to authenticate users via Entra ID. A sample of the authorization options that Data API builder allows is available in `./config/dab-config-auth.json` file.

The "Session" entity has been configured to allow only `authenticated` request. The value returned are only those that match the user's identity by comparing the value of the claim `oid` to the value of the column `owner`.

```
"permissions": [
    {
        "role": "authenticated",
        "actions": [{
            "action": "read",
            "policy": {
            "database": "@claims.oid eq @item.owner"
            }
        }]
    }
],
```

## Test Entra ID authorization

```
az login --scope api://1f1bd660-1f6c-4de1-802c-89d95dd59f22/Endpoints.Access --tenant 0d2db678-1e26-4efc-bd68-3fb08199aa9a
```

az account get-access-token --scope "api://1f1bd660-1f6c-4de1-802c-89d95dd59f22/Endpoints.Access" --tenant 0d2db678-1e26-4efc-bd68-3fb08199aa9a