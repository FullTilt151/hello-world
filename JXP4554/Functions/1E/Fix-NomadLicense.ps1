$computers = ('WKMJ04AU64', 'WKMJ04CMAW', 'WKMJ04CMAX', 'WKMJ04LSM5', 'WKMJ04LZ4G', 'WKMJ04SWG6', 'WKMJ04SWKK', 'WKMJ04SWKZ', 'WKMJ05J42V', 'WKMJ05RN82', 'WKMJ05RN8T', 'WKMJ05RPND', 'WKMJ05TTHS', 'WKMJ05XAKV', 'WKMJ0648R2', 'WKMJ06U665', 'WKMJ06Y1LZ', 'WKMJ07524C', 'WKMJ075DD1', 'WKMJ075DDY', 'WKMJ07AB9S', 'WKMJ07ABDL', 'WKMJ07ADKN', 'WKMJ07ADZW', 'WKMJ07C0NL', 'WKMJ07C0SA', 'WKMJ07C28U', 'WKMJ07C2FF', 'WKMJ07C2NB', 'WKMJ07C36X', 'WKMJ07C387', 'WKMJ07K5B4', 'WKMJ07K5DG', 'WKMP19VX15', 'WKMP1E2NVR', 'WKMPMP185YS4', 'WKMPMP19ULMX', 'WKPC0F0DZ1', 'WKPC0F10QA', 'WKPC0FESC9', 'WKPC0G3PK9', 'WKPC0GCRPF', 'WKPC0GGKQL', 'WKPC0GLC4G', 'WKPC0H69A4', 'WKPC0H6C8D', 'WKPC0J24Z2', 'WKPC0J274Q', 'WKPC0J4RTE', 'WKPC0J4T02', 'WKPC0J4T5B', 'WKPC0J6JWG', 'WKPC0JYT1Q', 'WKPC0JYT35', 'WKPC0JYTEB', 'WKPC0KFT4Q', 'WKPC0KULYW', 'WKPC0RZPLE', 'WKPC0SJSFR', 'WKPC0UEW3N', 'WKPC0UEW4V', 'WKPC0UEXPW', 'WKPC0VT66B', 'WKPC0VT6UM', 'WKPC0VT6WU', 'WKPC0VT79M', 'WKPC0W9LAB', 'WKPC0W9LBH', 'WKPC0W9LBY', 'WKPC0W9LE8', 'WKPC0W9LE9', 'WKPC0W9LEK', 'WKPC0W9MFN', 'WKPC0W9MG4', 'WKPC0W9MHC', 'WKPC0W9MHK', 'WKPC0W9MJ6', 'WKPC0W9MJL', 'WKPC0W9QYN', 'WKPC0W9R08', 'WKPC0W9R0B', 'WKPC0W9R19', 'WKPC0W9R2F', 'WKPC0W9RB7', 'WKPC0W9RC4', 'WKPC0WQLVB', 'WKPC0WQNUZ', 'WKPC0WQQHN', 'WKPC0WQQJP', 'WKPC0WQQKF', 'WKPC0WWBL2', 'WKPC0WWC9P', 'WKPC0WWCAA', 'WKPC0WWD4B', 'WKPC0WWDPU', 'WKPC0WWDQQ', 'WKPC0WWEK7', 'WKPC0WWEKR', 'WKPC0WWFUY', 'WKPC0WWFVH', 'WKPC0WWGHY', 'WKPC0WWGJN', 'WKPC0X88M3', 'WKPC0X88MK', 'WKPC0X88MY', 'WKPC0X88ND', 'WKPC0XPGX9', 'WKPF06KA21', 'WKPF08ZGM6', 'WKPF09PEZJ', 'WKPF09UYFA', 'WKPF0A9UEG', 'WKPF0AZELP', 'WKPF0C76R6', 'WKPF0DD30J', 'WKPF0EB1CE', 'WKPF0H22SQ', 'WKPF0K2U0V', 'WKR90H14PB', 'WKR90RJ1ZY', 'WKR90RJ20E', 'WKR90S58XQ', 'WKR90SA3LC', 'WKR90SHR7T', 'WKR90SPE88')
foreach ($computer in $computers) {
    if (Test-Connection -count 1 $computer -ErrorAction SilentlyContinue) {
        Write-Output "Fixing $computer"
        PsExec.exe \\$computer -accepteula -s 'C:\Program Files\1E\NomadBranch\nomadbranch.exe' '-relicense=HUMNOM6-64RB-1ILL-9EBL-7UVF'
    }
    else{
        Write-Output "Unable to contact $computer"
    }
}