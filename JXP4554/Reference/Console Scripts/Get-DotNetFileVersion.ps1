(Get-ItemProperty C:\windows\Microsoft.NET\Framework\v2.0.50727\System.Management.dll | Select-Object -ExpandProperty VersionInfo | Select-Object FileVersionRaw).FileVersionRaw.tostring()