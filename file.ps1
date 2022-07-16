Set-Location c:\
Install-Module -Name AzureAD -AllowClobber -Verbose -Force

Connect-AzureAD -AccountId "kenson@v8t8l.onmicrosoft.com"

Get-AzureADUser

Get-AzureADUser -ObjectID LidiaH@v8t8l.onmicrosoft.com | Select DisplayName, UsageLocation

Get-AzureADSubscribedSku | Select SkuPartNumber

Get-AzureADUser -SearchString "manager" | select DisplayName,UserPrincipalName,jobtitle,department

Install-Module MSOnline -AllowClobber -Force -Verbose

Connect-MsolService

Get-MsolUser -All -UnlicensedUsersOnly

Get-MsolUser -All | where {$_.UsageLocation -eq $null}