﻿$wkids = "WK1N60TK1","WKMJAMWZ5","WKMJAMWZ9","WKMJAMXC1","WKMJBFEE9","WKMJBFET1","WKMJBFEX4","WKMJBNXR2","WKMJBRAY0","WKMJCCAZ8","WKMJCCBA3","WKMJCCBB0","WKMJCRKZ0","WKMJCRLA3","WKMJCRLC2","WKMJCRLC7","WKMJCRMR0","WKMJCRRD1","WKMJCRRL1","WKMJCRTT6","WKMJCRVA3","WKMJCRVA6","WKMJCRVA9","WKMJCRVE1","WKMJCRVE7","WKMJENPVD","WKMJEWFM2","WKMJFEEW3","WKMJFEEX4","WKMJFEFA9","WKMJFFGH0","WKMJFFGL1","WKMJFVG36","WKMJFVG47","WKMJFVG62","WKMJFVG68","WKMJFWB63","WKMJFWB72","WKMJFWB74","WKMJFWB75","WKMJFWB81","WKMJFWB83","WKMJFWB84","WKMJFWB87","WKMJFWB88","WKMJFWB89","WKMJFWB94","WKMJFWB96","WKMJFWB97","WKMJFWB98","WKMJFWC01","WKMJFWLRC","WKMJFYA88","WKMJFYA95","WKMJFYB12","WKMJFYB44","WKMJFYB62","WKMJFYC00","WKMJFYC93","WKMJFYD04","WKMJFYD09","WKMJFYD25","WKMJFYTRP","WKMJFZKMY","WKMJHDEB9","WKMJHDFV5","WKMJKNR69","WKMJKNY96","WKMJKNZ05","WKMJKNZ30","WKMJKNZ51","WKMJKNZ64","WKMJKPT18","WKMJNFX34","WKMJNFX53","WKMJNFX84","WKMJNGD43","WKMJNGD80","WKMJWGB02","WKMJWNR36","WKMJWNR49","WKMJYNY58","WKMJYNZ18","WKMJYPC28","WKMJYZG40","WKPB52L8F","WKPB5L71C","WKPB5L71H","WKPBDNEAH","WKPBP0028","WKR80BP3P","WKR80TN6H","WKR80TW9A","WKR80VF1F","WKR86KHXF","WKR8D2Z10","WKR8FL29V","WKR8PGA1V","WKR8PV54H"

foreach ($wkid in $wkids) {
    if (test-connection $wkid -count 1 -quiet) {
        write-host $wkid": " -NoNewline
        (([wmiclass]"\\$wkid\root\default:stdregprov").GetDWORDValue("2147483650", "SOFTWARE\1E\NomadBranch\NMDS", "MaximumMegaByte")).uvalue
    } else {
        write-host $wkid": Not Online"
    }
}