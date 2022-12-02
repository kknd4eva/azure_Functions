// Passed to us from the parent bicep file
param adminPassword string

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: uniqueString('sql', resourceGroup().id)
  location: resourceGroup().location
  properties: {
    administratorLogin: 'dbmaster'
    administratorLoginPassword: adminPassword
  }
}

resource sqlDB 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  parent: sqlServer
  name: 'azurefunctiondb'
  location: resourceGroup().location
  sku: {
    name: 'Free'
    tier: 'Free'
  }
}


