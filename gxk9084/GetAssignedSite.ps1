﻿$([WmiClass]"\\$($ComputerName)\Root\ccm:SMS_Client").getassignedsite() | Select sSiteCode