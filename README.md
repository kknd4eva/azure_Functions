# Azure Functions with SQL extensions

A small starter project showing the use of the following technologies
* Bicep for the deployment of Infrastructure-as-code
* Azure Functions with SQL extensions to provide seamless integration for serverless querying of databases

## Getting Started

### To deploy the Bicep
(The resource group bicep file is deployed at the subscription level, then it triggers the creation of the SQL server and the Azure Function App in the scope of the created resource group). Here's a visualised structure overview of the infrastructure we'll deploy

<img src="https://i.ibb.co/NW88yqB/2022-12-04-14-16-43-Window.png">

```
KKnD@LAPTOP-M1FLIIDM MINGW64 /d/repos/azure_Functions (master)
$ az deployment sub create --location eastus --template-file ./infrastructure/resource_group.bicep
```

### Use sqlcmd to bootstrap the created database with a table and some rows of data
```
KKnD@LAPTOP-M1FLIIDM MINGW64 /d/repos/azure_Functions (master)
$ sqlcmd -S tcp:xxxxxxxxx.database.windows.net -d azurefunctiondb -U dbmaster -P xxxxxxxx -i ./sql_script/setup.sql
```
### To test the function locally

Make sure you have installed Azure Functions Core Tools. create a local.settings.json file and populate it as per the below

```
{
    "IsEncrypted": false,
    "Values": {
        "FUNCTIONS_WORKER_RUNTIME": "dotnet"
    },
    "Host": {
        "LocalHttpPort": 7071,
        "CORS": "*",
        "CORSCredentials": false
    },
    "ConnectionStrings": {
        "SQLConnectionString": "<your deployed sql connection string>"
    }
}
```

Start the function locally
```
API+JMatson@API440525936366 MINGW64 ~/source/repos/azure_Functions (master)
$ func start
```

Make a call
```
API+JMatson@API440525936366 MINGW64 ~/source/repos/azure_Functions (master)
$ curl -X GET http://localhost:7071/api/transactions
```

Profit!
```
[
  {
    "id": 1,
    "sale_date": "2022-12-04T02:06:10.763Z",
    "customer_id": "1",
    "product_id": "1",
    "quantity": 1,
    "price": 10.00
  },
  {
    "id": 2,
    "sale_date": "2022-12-04T02:06:10.763Z",
    "customer_id": "1",
    "product_id": "2",
    "quantity": 1,
    "price": 20.00
  },
  {
    "id": 3,
    "sale_date": "2022-12-04T02:06:10.763Z",
    "customer_id": "1",
    "product_id": "3",
    "quantity": 1,
    "price": 30.00
  },
  {
    "id": 4,
    "sale_date": "2022-12-04T02:06:10.763Z",
    "customer_id": "2",
    "product_id": "1",
    "quantity": 1,
    "price": 10.00
  },
  {
    "id": 5,
    "sale_date": "2022-12-04T02:06:10.763Z",
    "customer_id": "2",
    "product_id": "2",
    "quantity": 1,
    "price": 20.00
  },
  {
    "id": 6,
    "sale_date": "2022-12-04T02:06:10.763Z",
    "customer_id": "2",
    "product_id": "3",
    "quantity": 1,
    "price": 30.00
  },
  {
    "id": 7,
    "sale_date": "2022-12-04T02:06:10.763Z",
    "customer_id": "3",
    "product_id": "1",
    "quantity": 1,
    "price": 10.00
  },
  {
    "id": 8,
    "sale_date": "2022-12-04T02:06:10.763Z",
    "customer_id": "3",
    "product_id": "2",
    "quantity": 1,
    "price": 20.00
  },
  {
    "id": 9,
    "sale_date": "2022-12-04T02:06:10.763Z",
    "customer_id": "3",
    "product_id": "3",
    "quantity": 1,
    "price": 30.00
  }
]
```

### To deploy the function

#### Build the function
```
dotnet publish -c release
```
#### Deploy to Azure 
```
az functionapp deployment source config-zip -g rg-sqlfunctions -n <function app> --src publish.zip
```