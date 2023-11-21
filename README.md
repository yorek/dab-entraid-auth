# Cloud Day 2023 Demo

Demo used at [Cloud Day 2023](https://www.cloudday.it/)

The demo shows how to us Data API builder and a plain vanilla Javascript client to integrate authentication with Microsoft Entra ID


## Prerequisites

Data API builder CLI installed and a SQL Server or Azure SQL database available.

If you want to use SQL Server locally (for free), it is recommended to use go-sqlcmd to install and run SQL Server Developer Edition in a container.

If you want to use Azure SQL, read here how to quickly create a new Azure SQL database (remember that you can use the free tier for this sample).


## Deploy the database



## Configure Microsoft Entra ID

https://github.com/AzureAD/microsoft-authentication-library-for-js
https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/samples/msal-browser-samples/VanillaJSTestApp2.0/app/default
https://github.com/Azure-Samples/ms-identity-javascript-v2
https://github.com/Azure-Samples/ms-identity-javascript-tutorial


## Run Data API builder locally

Create an `.env` file starting from the `.env.example` file and fill in the missing values and add the connection string, then run Data API builder: 

```bash
dab start
```

## Run the client locally

Using VS Code and the Live Server extension, open the `index.html` file.




