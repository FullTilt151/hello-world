﻿$timestamp = get-date -UFormat %m%d%y-%H%M%S
Get-ADComputer -filter * -properties * | where {$_.DistinguishedName -like "*AdminAccess*"} | Select-Object Name, Enabled, DistinguishedName, LastLogonDate, lastlogontimestamp, Modified, PasswordLastSet, whenchanged | Export-Csv c:\temp\AdminAccessWKIDs_$timestamp.csv -NoTypeInformation -Append