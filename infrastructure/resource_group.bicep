targetScope = 'subscription'

@description('The administrator password of the SQL logical server.')
@secure()
param administratorLoginPassword string

resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'rg-sqlfunctions'
  location: 'eastus'
}

// delpoy sql server in resource group scope
module sqlServer './sql_server.bicep' = {
  name: 'sqlServerDeployment'
  scope: rg    // Deployed in the scope of resource group we created above
  params: {
    adminPassword: administratorLoginPassword
  }
}

// deploy function app in resource group scope
module functionApp './function_app.bicep' = {
  name: 'functionAppDeployment'
  scope: rg    // Deployed in the scope of resource group we created above
  params: {
    appInsightsLocation: 'eastus'
  }
}
