# Get-ApplicationCredentialsExpiration
This PowerShell script monitor the expired (or expiring soon) client secrets and certificates of Azure app registrations. Please read the synopsis of the script for more details.

This script retrieves the expiration date of credentials (secrets or certificates) of Azure app registrations. The script runs as an app registration created ad-hoc (see the file Create-AppRegistration.ps1 in the repository). The script generates a report named .\UsersCalendarEvents.csv in the same folder script and, optionally, can send this report via mail.

Written by: Stefano Viti - stefano.viti1995@gmail.com
Follow me at https://www.linkedin.com/in/stefano-viti/

This script is a follow-up of the work made and presented here:
- https://github.com/bwya77/PSAlerts/tree/main/Azure
- https://www.thelazyadministrator.com/2023/12/16/automated-alerts-on-azure-entra-id-application-secret-expirations/
