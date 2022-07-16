#Users in my subscriptions
Get-AzureADUser

#All user without guests)
Get-AzureADUser | Where {$_.UserType -eq "Member"}

#Users in department "Manager"
Get-AzureADUser | Where {$_.Department -eq "Manager"}

#Infos about a user
Get-AzureADUser -ObjectId kenson@v8t8l.onmicrosoft.com | Format-List

#We need a password profile
$PasswordProfile = New-Object `
    -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile

#We need a password
$PasswordProfile.Password = "P@$$w0rd123??"

#The user must change the password at next login
$PasswordProfile.ForceChangePasswordNextLogin = $true

#Lets create a user
New-AzureADUser -GivenName "Richard" `
				-Surname "Rich" `
				-DisplayName "Nazaire Jean Richard" `
				-UserPrincipalName "Nazaire@v8t8l.onmicrosoft.com" `
				-MailNickName "Rich" `
				-AccountEnabled $true `
				-PasswordProfile $PasswordProfile `
				-JobTitle "PDG" `
				-Department "IT"

#Make some changes
Set-AzureADUser `
	-ObjectId Nazaire@v8t8l.onmicrosoft.com `
	-DisplayName “Nazaire Jean-Richard" 

#Set a manager for fred
Set-AzureADUserManager `
    -ObjectId fred.prefect@tomscloud.ch `
     -RefObjectId (Get-AzureADUser -ObjectId jane.ford@tomscloud.ch).ObjectId

#Create a user in a different way
$domain = "tomscloud.ch"
$user = @{
    City = "Oberbuchsiten"
    Country = "Switzerland"
    Department = "Information Technology"
    DisplayName = "Fred Jonas"
    GivenName = "Fred"
    JobTitle = "Azure Administrator"
    UserPrincipalName = "fred.jonas@$domain"
    PasswordProfile = $PasswordProfile
    PostalCode = "4625"
    State = "SO"
    StreetAddress = "Hiltonstrasse"
    Surname = "Jonas"
    TelephoneNumber = "455-233-22"
    MailNickname = "FredJonas"
    AccountEnabled = $true
    UsageLocation = "CH"
}

#Lets create the user
$newUser = New-AzureADUser @user

#Whats in the variable
$newUser | Format-List

#Details about the user
Get-AzureADUser -Filter "Displayname eq 'Nazaire Jean-Richard'" | Select-Object Displayname, State, Department

#Show all groups
Get-AzureADGroup

#Show the group members
Get-AzureADGroupMember `
    -ObjectId (Get-AzureADGroup -SearchString "Manager").ObjectId

#Is there an owner?
Get-AzureADGroupOwner `
    -ObjectId (Get-AzureADGroup -SearchString "Manager").ObjectId

#We add an owner
Add-AzureADGroupOwner `
    -ObjectId (Get-AzureADGroup -SearchString "Manager").ObjectId `
    -RefObjectId (Get-AzureADUser -ObjectId Nazaire@v8t8l.onmicrosoft.com).ObjectId 