﻿param(
$ComputerName
)
Get-Counter -ComputerName $ComputerName '\Process(*)\% Processor Time' | Select-Object -ExpandProperty countersamples | Select-Object -Property instancename, cookedvalue| Sort-Object -Property cookedvalue -Descending| Select-Object -First 20| ft InstanceName,@{L='CPU';E={($_.Cookedvalue/100).toString('P')}} -AutoSize