# Azure Functions with SQL extensions

A small starter project showing the use of the following technologies
* Bicep for the deployment of Infrastructure-as-code
* Azure Functions with SQL extensions to provide seamless integration for serverless querying of databases

## Getting Started

### To deploy the Bicep
(The resource group bicep file is deployed at the subscription level, then it triggers the creation of the SQL server and the Azure Function App in the scope of the created resource group)

```
KKnD@LAPTOP-M1FLIIDM MINGW64 /d/repos/azure_Functions (master)
$ az deployment sub create --location eastus --template-file ./infrastructure/resource_group.bicep
```

### Use sqlcmd to bootstrap the created database with a table and some rows of data
```
KKnD@LAPTOP-M1FLIIDM MINGW64 /d/repos/azure_Functions (master)
$ sqlcmd -S tcp:xxxxxxxxx.database.windows.net -d azurefunctiondb -U dbmaster -P xxxxxxxx -i ./sql_script/setup.sql
```

### To deploy the function

#### Build the function dlls
```
dotnet build
```

#### Deploy to Azure 
```

```