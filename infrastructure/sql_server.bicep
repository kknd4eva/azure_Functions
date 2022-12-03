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

// Let me into my own server
resource SQLAllConnectionsAllowed 'Microsoft.Sql/servers/firewallRules@2020-11-01-preview' = {
  name: 'AllowMyPublicIp'
  parent: sqlServer
  properties: {
    startIpAddress: '121.200.21.94'
    endIpAddress: '121.200.21.94'
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


