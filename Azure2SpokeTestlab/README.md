Builds azure test lab if run with:
```
pwsh
 import-module az 
 Connect-AzAccount
 Enable-AzureRmAlias
 
New-AzResourceGroup -Name testRG -Location westeurope
New-AzResourceGroupDeployment -ResourceGroupName "testRG" -TemplateFile https://raw.githubusercontent.com/unixhead/misc/master/Azure2SpokeTestlab/2-spoke-testlab-network.json
New-AzResourceGroupDeployment -ResourceGroupName "testRG" -password "<PASSWORDHERE>" -adminip "<MY-IP-Address>" -TemplateFile https://raw.githubusercontent.com/unixhead/misc/master/Azure2SpokeTestlab/2-spoke-testlab-VMs.json
```

Builds this (minus load balancer):

![testnet](https://github.com/unixhead/misc/raw/master/Azure2SpokeTestlab/testnet1.png)
