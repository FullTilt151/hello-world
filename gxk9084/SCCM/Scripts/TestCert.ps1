﻿get-childitem cert:\localmachine\sms | where-object {$_.thumbprint -eq '$GUIDfromsmscfgini'}