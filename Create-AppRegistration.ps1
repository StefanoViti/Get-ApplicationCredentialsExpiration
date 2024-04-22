Connect-AzAccount -NoTypeInformation

#1 - Create the App Registration

$Domain = (Get-AzDomain).Domains | Where-Object { ($_ -like "*.onmicrosoft.com*") -and ($_ -notlike "*mail.*")} | Select-Object -First 1
$AppRegistrationSplat = @{
    DisplayName    = "App Registration Credential Monitor - Test"
    IdentifierURIs = "http://AppRegistrationMonitorCredentialTest.$Domain"
    ReplyUrls      = "https://www.localhost/"
}
$AzureADApp = New-AzADApplication @AppRegistrationSplat

Write-Host "The application $($AzureADApp.DisplayName) has been created!" -ForegroundColor Green

#2 - Give the necessary permissions to the application

# Application.Read.All
Add-AzADAppPermission -ObjectId $AzureADApp.ID -ApiId '00000003-0000-0000-c000-000000000000' -PermissionId "9a5d68dd-52b0-4cc2-bd40-abcf44ac3a30" -Type Role
# Mail.Send
Add-AzADAppPermission -ObjectId $AzureADApp.ID -ApiId '00000003-0000-0000-c000-000000000000' -PermissionId "b633e1c5-b582-4048-a93e-9f11b44c7e96" -Type Role

Write-Host "The application has been granted the necessary permissions!" -ForegroundColor Green
Write-Host "Go to Microsoft Entra and grant the admin consent for the assigned permissions!" -ForegroundColor Magenta

#3 - Create a Secret and save it for the authentication

[System.DateTime]$startDate = Get-Date
[System.DateTime]$endDate = $startDate.AddYears(1)
$AppSecret = Get-AzADApplication -ApplicationId $AzureADApp.AppID | New-AzADAppCredential -StartDate $startDate -EndDate $endDate

Write-Host "The application has this ID $($AzureADApp.AppID) and this secret $($AppSecret.SecretText). Save them!" -ForegroundColor Green