﻿$RegKey = "HKLM:\SOFTWARE\1E\NomadBranch\"
$RestartService = $false
if (Test-Path $RegKey){
    $NomadCache = Get-ItemProperty HKLM:\SOFTWARE\1E\NomadBranch\ -Name LocalCachePath
    $FileName = $NomadCache.LocalCachePath + "SKPSWI.DAT"
    if (-not (Test-Path $FileName)){
        $File = New-Item $FileName -type File
        $File.Attributes = $File.Attributes -bor ([System.IO.FileAttributes]::Hidden)
        $RestartService = $true
    }
}
$UIResourceMgr = New-Object -ComObject UIResource.UIResourceMgr
$FileName = $UIResourceMgr.GetCacheInfo().Location + "\SKPSWI.DAT"
if (-Not (Test-Path $FileName)){
    $File = New-Item $FileName -type File
    $File.Attributes = $File.Attributes -bor ([System.IO.FileAttributes]::Hidden)
    $RestartService = $true
}


if ($RestartService){
    Restart-Service -Name CcmExec
}
# SIG # Begin signature block
# MIISKgYJKoZIhvcNAQcCoIISGzCCEhcCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQULEMj++KFxcik8yVrdoDT7ugk
# Fzyggg+hMIIHdTCCBV2gAwIBAgIKVJ0IygABAAAFhzANBgkqhkiG9w0BAQUFADBE
# MRQwEgYDVQQKEwtIdW1hbmEgSW5jLjEsMCoGA1UEAxMjSHVtYW5hIEdlbmVyYWwg
# UHVycG9zZSBJc3N1aW5nIENBIDIwHhcNMTQwMTEzMTQxMzQxWhcNMTYwMTEzMTQx
# MzQxWjBvMQswCQYDVQQGEwJVUzELMAkGA1UECBMCS1kxEzARBgNVBAcTCkxvdWlz
# dmlsbGUxFDASBgNVBAoTC0h1bWFuYSBJbmMuMQwwCgYDVQQLEwNIVU0xGjAYBgNV
# BAMMEVRTQU1TX0FsbF9Qcm9kX0NTMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
# CgKCAQEAmYn6XyKH6oK/LE87P0TFBV69pI6cI+h05hOrjDHa5ife+hZ0fXXYPNbr
# PTMkEQK+h6ko3yQUNDyuYgUgp/HBMoyAkjQPrt/tb5VyrKM4e/xfineakkkAkHD4
# QFehLc11K8s4vcL16W++V31/3LLBYCtFxFL+LWUxZcIZHmt5VC5xtqBZGagNLSuF
# QyytUpMvUXndZv/LWTedF+Dn52zaLIxYlyfDf5LzCv/yhdms5cYRvv22b1JI+cGU
# kCBy4pbQryG/LZ+fj7Vib+RSnZepGngAn+2UjtuaS/o0ykQUUhMBnGiCBwqlenzl
# LB2aUaMmp+cRAjEXl7S3iKkZrOp5QQIDAQABo4IDPDCCAzgwHQYDVR0OBBYEFGSg
# AFKAxifTFTwqwU+hSESvmq/+MB8GA1UdIwQYMBaAFIJDe10gi/8kEiY3FCeIn6yq
# qlrPMIIBOwYDVR0fBIIBMjCCAS4wggEqoIIBJqCCASKGgdZsZGFwOi8vL2NuPUh1
# bWFuYSUyMEdlbmVyYWwlMjBQdXJwb3NlJTIwSXNzdWluZyUyMENBJTIwMixDTj1M
# T1VQS0lXUFMwMDcsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENO
# PVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9YWRlYSxEQz1odW0/Y2VydGlm
# aWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1
# dGlvblBvaW50hkdodHRwOi8vY3JsLmh1bWFuYS5jb20vSHVtYW5hJTIwR2VuZXJh
# bCUyMFB1cnBvc2UlMjBJc3N1aW5nJTIwQ0ElMjAyLmNybDCCATYGCCsGAQUFBwEB
# BIIBKDCCASQwgckGCCsGAQUFBzAChoG8bGRhcDovLy9jbj1IdW1hbmElMjBHZW5l
# cmFsJTIwUHVycG9zZSUyMElzc3VpbmclMjBDQSUyMDIsQ049QUlBLENOPVB1Ymxp
# YyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24s
# REM9YWRlYSxEQz1odW0/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNl
# cnRpZmljYXRpb25BdXRob3JpdHkwVgYIKwYBBQUHMAKGSmh0dHA6Ly9haWEuaHVt
# YW5hLmNvbS9IdW1hbmElMjBHZW5lcmFsJTIwUHVycG9zZSUyMElzc3VpbmclMjBD
# QSUyMDIoMSkuY3J0MAsGA1UdDwQEAwIHgDA+BgkrBgEEAYI3FQcEMTAvBicrBgEE
# AYI3FQiB0K0Wg+HiNYXRkwCBzLVbgretGYENhISsSYPSyw4CAWQCAQMwEwYDVR0l
# BAwwCgYIKwYBBQUHAwMwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDAzANBgkq
# hkiG9w0BAQUFAAOCAgEAHiGmT2WrKAbcvft//fjzMM3nLXoTLg6L5YldK2ABDg0O
# NFfwtgMf96PP63O9jmsN22YoMHdEYztVRtb1dLFROJdyxwy85STT1aqvv2GvUFxz
# /2fOODeJPLugv1Bl3vK82kmvcyNIw8IeRlqWeSKiBwx16PQaYihBaNEG+eQZjN4o
# BuxilPoerBRJOiu0mm8sBbcOaocPK+W027oUgxC3r3MqJ2uTbidFPixiN9Ofgnlb
# N8fT6zOFWuXrTnCwXsC+oTgjww6JvABW+9f49kHe+VYvegyS9bZfoPHoDLjcqltS
# m1xJkEgAksmFbRCrDYNt6cnjmgMRXs/1ngNj+LkyMPwOPZMCO1vLtp0v5ZHuTmE/
# GmImT6eDhXj2sqRqONRfw7+tO10qwfVJnblwjfMZOsBGlne0FELP8ZCYh82c4fVZ
# 7ir5Op9EfZ51umNvtSuHAPXbd0GEm3wVxovrsTiMR/yoib6kB6N3xTwoHUvmZdKb
# /L2UAPKIeaX2p6WJUnVC1pJeDsFTlTH6PBDxJOyEYtM1CEBrdZzms3+4xyLXZaj6
# OsVqE2lsArE7pEBrgzUnisiD/MwmNSO6puj27B7SR8VskgP8dnImbr7+opGD3Bp0
# YS7O4Ja8cUUsVmZ+T64JTZqMMx3hXtBQpMePYQ34/xsCyQOZJ84zbk7/Ile0yWMw
# gggkMIIGDKADAgECAgphP2YjAAAAAAADMA0GCSqGSIb3DQEBBQUAMDwxFDASBgNV
# BAoTC0h1bWFuYSBJbmMuMSQwIgYDVQQDExtIdW1hbmEgRW50ZXJwcmlzZSBSb290
# IENBIDIwHhcNMTIxMDEyMjA0ODA4WhcNMjIxMDEyMjA1ODA4WjBEMRQwEgYDVQQK
# EwtIdW1hbmEgSW5jLjEsMCoGA1UEAxMjSHVtYW5hIEdlbmVyYWwgUHVycG9zZSBJ
# c3N1aW5nIENBIDIwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQC2YDWH
# dRTh7+9q8hinm9W0AVIZKPCdqnD3aKTvFCHgZfhtRhPOi0E5STVE1qUWjnMMhvpT
# 3swDbkcHJUwTzu18WAIU9bFwEx3MDgHtSkr5Ek45hfUubxpuDXFEHkaYYbYpBIjF
# BouBgky3D7oGY/TtR/SoFgVOfPJ+cSzbBa3MFHZhc2iCpYBovwc77h4kKOCw5k/I
# 1/T12P409SI+wPG+gnCp+MiJZgFImK74F+b3lCetlnT6fU4bbgijb1reYO/byB1E
# tzc657SqErADObWRueReFgMBBFC8mHJkBQ67VY/zczokXeU+RCFRZwlcA3hQ3rJQ
# B7T21gEJljij43iFNSp8k/D/5SflkYqABrrxtuTpQNtEbAX+B2o/NcGZ7B0AxziD
# mZrus5HLTpa/H5o+4URQug6w+sRdG0A65erpAf+t4ke9q72Xq18Vx3mvUAo+aDZW
# vskJPXrnTVDwR2hb72bHcWOuXjJa0oiLTtTonSRFg9B3OAoLQ3dmyMmFXgu3ywjw
# 8G9F3EYDyZrvnou8PYvFcrthayHejxo//Sue+BIAUpUBj5ShLFAq1B3hdhpwGDme
# X7xZ3vVCmOCda4a/LKiku868mHokRxRyEJ/H7f4KJI9Y6ffM3CZjo4gbQ9WAz6d1
# NoZ9mpBG6sXjR8QMNzZmxxRdpFzk9D8MYHdMrQIDAQABo4IDHjCCAxowCwYDVR0P
# BAQDAgGGMBAGCSsGAQQBgjcVAQQDAgEBMCMGCSsGAQQBgjcVAgQWBBQPkKm0+zK9
# YlwM52itvgkBKjwstzAdBgNVHQ4EFgQUgkN7XSCL/yQSJjcUJ4ifrKqqWs8wGAYD
# VR0gBBEwDzANBgsrBgEEAYH7GwECBDAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMA
# QTASBgNVHRMBAf8ECDAGAQH/AgEBMB8GA1UdIwQYMBaAFC8qgJVnMKPCRE04/JRS
# QznAE3deMIIBJgYDVR0fBIIBHTCCARkwggEVoIIBEaCCAQ2GgctsZGFwOi8vL2Nu
# PUh1bWFuYSUyMEVudGVycHJpc2UlMjBSb290JTIwQ0ElMjAyLENOPUxPVVBLSVdQ
# UzA1LENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNl
# cyxDTj1Db25maWd1cmF0aW9uLERDPWFkZWEsREM9aHVtP2NlcnRpZmljYXRlUmV2
# b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2lu
# dIY9aHR0cDovL2NybC5odW1hbmEuY29tL0h1bWFuYSUyMEVudGVycHJpc2UlMjBS
# b290JTIwQ0ElMjAyLmNybDCCAR8GCCsGAQUFBwEBBIIBETCCAQ0wgb8GCCsGAQUF
# BzAChoGybGRhcDovLy9jbj1IdW1hbmElMjBFbnRlcnByaXNlJTIwUm9vdCUyMENB
# JTIwMixDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2Vydmlj
# ZXMsQ049Q29uZmlndXJhdGlvbixEQz1hZGVhLERDPWh1bT9jQUNlcnRpZmljYXRl
# P2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTBJBggrBgEF
# BQcwAoY9aHR0cDovL2FpYS5odW1hbmEuY29tL0h1bWFuYSUyMEVudGVycHJpc2Ul
# MjBSb290JTIwQ0ElMjAyLmNydDANBgkqhkiG9w0BAQUFAAOCAgEAp03h1t1tLPQn
# DwsIHvYh3mguw4sKNTwvJd/I1RTDq3PWAHDhtI9PYICtDW+RJeisqlZ5GO/mV3bP
# GkA1ZnDq0Povdm7DKeTZnKDoRuY5b3CAaFfK5ce7J1fGqWsTEj6kYkOx7tNdJ/oM
# zUbQLGDTCuxX5a7opt7E5tn6JCSt9YbEMdz3tjgkQRQB4An2gqW5KVG7xz2IcWtQ
# QgFlt6ryl1YRDR2FQGBHlGsELyjHSDzaBhDWOLcWjTILsm1TuwxeQ/QUAIL3g4jo
# yaGbRqmpyS+qRVhmD0OL2ho/pGKYQJyqqktgDau3YcaDyuuGWeolHMLvS2tpDCek
# 2tQrioB1BhcD82a3ZZniPtUse1riXm4A7M3apa5NykrZEK9Nt/rsk4kd1nMKLg+x
# P8/g5GbMN4oDTfWUvRAmgqGimWIDT3pK3fW8RPBUYOVRJHiB/sxKlhCJCYm9zhIA
# 23QuSrzynwJsBGBAzau0fhgdNxNNgNTWuSWX55dEVzkmQQpPsneUsPaYavsp9Lwz
# /rpkv2kCfnWJh74cO/2/E0KbIMf6HJabd5Zc9Bjv4EWyi4Fr/MxNcGsoo1He9ueV
# +znQavCmJMjgPKcdjB8OFRrVWiKJCxJtmlHB14eKQJr9WdlKwl1C/7XwnmUA9Mel
# GCIqY8StEMB8go0NP/dlICQiHxeAGC0xggHzMIIB7wIBATBSMEQxFDASBgNVBAoT
# C0h1bWFuYSBJbmMuMSwwKgYDVQQDEyNIdW1hbmEgR2VuZXJhbCBQdXJwb3NlIElz
# c3VpbmcgQ0EgMgIKVJ0IygABAAAFhzAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIB
# DDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEE
# AYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQU7NsWkPKv3+zp
# qYkwN0iTNCzaruwwDQYJKoZIhvcNAQEBBQAEggEAd2CHHduQGulZiUXD8/yY9IFt
# APOr2mRZnCpgwsO6iGluDraejU7psfUuoL2aULPuQ6tXksRwDIcf7bOlyo0RVK7F
# yVS6Ss4EAFxl7OvMr+td3ltiuzXg39eKIcfiYhr3CoZm7bGMN9nwKHuwfaz+tkrY
# L3TjVOvgQvRuzW/NWLFik5VwBQXBO0nasKkQ978/ahYpr50200wFgCg6ef4Ku5jp
# E882V9PmSInNdg2T0pJSnjX4kTkwXRvFPI22lBFcqSl2XxzwEIFtWG/eCC8G8Cy4
# pBpK7LJZuG6gyzr1eqE1AN9hjEXXxjXf48cMq9Xwyp2Hopu0AQZkKhv8H9Apsg==
# SIG # End signature block