﻿Add-PSSnapin citrix.*
Get-BrokerDesktop -AdminAddress 'LOUXDCWPGX1S003.TS.HUMAD.COM:80' –MaxRecordCOunt 10000 | Where-Object {$_.DesktopGroupName -eq "W10_TST_A"} | Select-Object @{l='UserName';e={$_.AssociatedUserNames}} , @{l='FullName';e={$_.AssociatedUserFullNames}} , DNSName, AgentVersion , Broker, LastConnectionTime , LastConnectionUser, RegistrationState , InMaintenanceMode , PowerState | Export-Csv C:\temp\W10SICA.csv