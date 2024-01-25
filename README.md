# Authenticate using EntraID with Data API builder from any Javascript client

WIP - Be patient, in the meantime:

This repo uses Dev Container to provide a development environment with all the tools you need to start developing. Make sure to [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers) extension installed and also have Docker installed and running on your machine.

Create a `.env` file in the root of the project with the following content by copying the `.env.sample` file. The sample file is already configured to work with the development environment, so unless you want to change something (for example connect to a differnt server or database, you can leave it as is).

Open the terminal and run 

```bash
dotnet tool install Microsoft.DataApibuilder -g
```

to install Data API builder, than

```
dab start -c config/dab-config-auth.json --no-https-redirect
```

to run Data API builder. 
