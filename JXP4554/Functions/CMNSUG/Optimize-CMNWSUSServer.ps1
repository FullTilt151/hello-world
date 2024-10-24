Function Optimize-CMNWSUSServer {
    <# 
    ===============================================
    Script to decline superseeded updates in WSUS.
    ===============================================
    It's recommended to run the script with the -SkipDecline Switch to see how many superseded updates are in WSUS and to TAKE A BACKUP OF THE SUSDB before declining the updates.
    Parameters:

    $updateServer             = Specify WSUS Server Name
    $useSSL                   = Specify whether WSUS Server is configured to use SSL
    $Port                     = Specify WSUS Server Port
    $skipDecline       d      = Specify this to do a test run and get a summary of how many superseded updates we have
    $DeclineLastLevelOnly     = Specify whether to decline all superseded updates or only last level superseded updates

    Supersedence chain could have multiple updates. 
    For example, Update1 supersedes Update2. Update2 supersedes Update3. In this scenario, the Last Level in the supersedence chain is Update3. 
    To decline only the last level updates in the supersedence chain, specify the DeclineLastLevelOnly Switch

    Usage:
    =======

    To do a test run against WSUS Server without SSL
    Decline-SupersededUpdates.ps1 -UpdateServer SERVERNAME -Port 8530 -SkipDecline

    To do a test run against WSUS Server using SSL
    Decline-SupersededUpdates.ps1 -UpdateServer SERVERNAME -UseSSL -Port 8531 -SkipDecline

    To decline all superseded updates on the WSUS Server using SSL
    Decline-SupersededUpdates.ps1 -UpdateServer SERVERNAME -UseSSL -Port 8531

    To decline only Last Level superseded updates on the WSUS Server using SSL
    Decline-SupersededUpdates.ps1 -UpdateServer SERVERNAME -UseSSL -Port 8531 -DeclineLastLevelOnly


 #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    Param(
        [Parameter(Mandatory = $false)]
        [string] $updateServer = $env:COMPUTERNAME,
	
        [Parameter(Mandatory = $false)]
        [Switch] $useSSL,
	
        [Parameter(Mandatory = $false)]
        [Int]$port = 8530,

        [Parameter(Mandatory = $false)]
        [Switch] $skipDecline,

        [Parameter(Mandatory = $false)]
        [Switch] $declineLastLevelOnly,

        [Parameter(Mandatory = $false, HelpMessage = 'Maximum age of update, all older will be declined. Default is 36 months.')]
        [Int]$maxAge = 99,

        [Parameter(Mandatory = $false, HelpMessage = 'Exception bulletin ID''s, these will always be set to not approved.')]
        [String[]]$exceptionBulletinIDs = ('08-052', '09-062', '10-036', '10-087', '11-022', '11-023', '11-025', '11-036', '11-045', '11-053', '11-072', '11-073', '11-090', '12-013', '12-016', '12-020', '12-036', '12-039', '12-043', '12-045', '12-046', '12-057', '12-059', '12-060', '12-066', '12-074', '13-002', '13-004', '13-009', '13-022', '13-023', '13-025', '13-027', '13-035', '13-041', '13-044', '13-052', '13-054', '13-068', '13-074', '13-082', '13-085', '13-087', '13-090', '13-094', '13-095', '13-097', '13-098', '13-099', '13-104', '13-105', '13-106', '14-001', '14-007', '14-009', '14-010', '14-011', '14-012', '14-014', '14-018', '14-021', '14-023', '14-024', '14-025', '14-026', '14-031', '14-036', '14-037', '14-044', '14-046', '14-051', '14-052', '14-053', '14-056', '14-065', '14-072', '14-075', '14-080', '14-081', '14-083', '15-004', '15-009', '15-011', '15-012', '15-013', '15-022', '15-028', '15-032', '15-033', '15-034', '15-041', '15-044', '15-045', '15-046', '15-048', '15-056', '15-065', '15-067', '15-069', '15-076', '15-079', '15-080', '15-081', '15-093', '15-094', '15-098', '15-106', '15-109', '15-112', '15-116', '15-118', '15-124', '15-128', '15-129', '16-001', '16-004', '16-006', '16-017', '16-029', '16-035', '16-039', '16-041', '16-051', '16-054', '16-061', '16-063', '16-065', '16-070', '16-075', '16-079', '16-084', '16-087', '16-090', '16-095', '16-104', '16-106', '16-107', '16-109', '16-118', '16-120', '16-132', '16-133', '16-136', '16-139', '16-142', '16-144', '16-146', '16-154', '16-155', '17-001', '17-003', '17-004', '17-005', '17-006', '17-013', '17-014', '17-023'),

        [Parameter(Mandatory = $false, HelpMessage = 'Exception article ID''s, these will always be set to not approved.')]
        [String[]]$exceptionArticleIDs = ('971089', '971090', '971091', '971092', '973544', '973551', '973552', '973830', '982158', '982312', '2264072', '2264107', '2289158', '2460011', '2464594', '2465373', '2467173', '2509488', '2523021', '2532531', '2535818', '2538218', '2538241', '2538242', '2538243', '2542054', '2548826', '2553070', '2553428', '2565057', '2565063', '2579115', '2584063', '2584066', '2597974', '2598243', '2598244', '2618451', '2621440', '2633873', '2654428', '2667402', '2685939', '2687417', '2687423', '2687499', '2687505', '2687510', '2698023', '2698365', '2721691', '2726929', '2742597', '2750841', '2760406', '2760600', '2794707', '2807986', '2810048', '2810062', '2810073', '2814124', '2817330', '2817478', '2832414', '2833946', '2837597', '2837610', '2847559', '2862152', '2863240', '2868626', '2871997', '2878230', '2878284', '2890788', '2892074', '2893294', '2898850', '2898857', '2898868', '2900986', '2901125', '2905616', '2909210', '2912390', '2928120', '2931358', '2931366', '2932677', '2937610', '2956073', '2960358', '2961858', '2963983', '2965161', '2965242', '2965310', '2973112', '2975808', '2977326', '2978128', '2986475', '2999412', '3000483', '3023224', '3032655', '3033929', '3037581', '3042553', '3045308', '3048070', '3054834', '3054848', '3054978', '3054984', '3056819', '3067505', '3067904', '3070738', '3080333', '3080446', '3097996', '3098781', '3099862', '3101520', '3101526', '3101544', '3106614', '3114402', '3114511', '3114518', '3114862', '3115467', '3115487', '3118378', '3126036', '3126446', '3135983', '3135988', '3135996', '3136000', '3142033', '3142042', '3143693', '3151058', '3151097', '3153704', '3154070', '3160005', '3161561', '3168965', '3170106', '3170455', '371021', '3174644', '3175443', '3182373', '3185319', '3185330', '3185911', '3188730', '3188740', '3193713', '3194716', '3194725', '3197868', '3205383', '3206632', '3207752', '3209498', '4011264', '4015549', '4016871', '4017094', '4018381', '4019263', '4019264', '4019473', '4019474', '4021558', '4056893', '4078130', '4284833', '4284860', '2837599', '2956078', '3118304', '3127894', '3127945', '3141537', '3172531', '3178687', '3178688', '3178702', '3178729', '3191828', '3191837', '3191843', '3191844', '3191847', '3191848', '3191858', '3191863', '3191865', '3191881', '3191882', '3191907', '3191932', '3191937', '3191938', '3191939', '3191943', '3191944', '3191945', '3203382', '3203383', '3203386', '3203392', '3203393', '3203436', '3203438', '3203460', '3203461', '3203464', '3203467', '3203474', '3203477', '3205402', '3212646', '3213537', '3213545', '3213555', '3213624', '3213630', '3213640', '3213647', '3213648', '3213986', '3214628', '4010250', '4011038', '4011040', '4011050', '4011052', '4011055', '4011061', '4011062', '4011063', '4011064', '4011078', '4011089', '4011090', '4011091', '4011095', '4011103', '4011107', '4011108', '4011110', '4011159', '4011162', '4011178', '4011179', '4011196', '4011197', '4011199', '4011201', '4011205', '4011213', '4011220', '4011222', '4011232', '4011233', '4011234', '4011242', '4011250', '4011265', '4011266', '4011270', '4011273', '4011277', '4011575', '4011590', '4011602', '4011604', '4011605', '4011607', '4011608', '4011611', '4011614', '4011618', '4011626', '4011627', '4011632', '4011636', '4011637', '4011639', '4011643', '4011651', '4011657', '4011659', '4011660', '4011665', '4011674', '4011675', '4011682', '4011686', '4011690', '4011695', '4011697', '4011707', '4011711', '4011714', '4011720', '4011721', '4011727', '4011730', '4012204', '4012215', '4012216', '4013429', '4013867', '4014329', '4014661', '4014981', '4015217', '4015549', '4017094', '4018271', '4018291', '4018483', '4018588', '4019088', '4019089', '4019090', '4019092', '4019093', '4019112', '4019115', '4019264', '4019472', '4020821', '4021558', '4022715', '4022719', '4022730', '4025252', '4025339', '4025341', '4025376', '4034658', '4034662', '4034664', '4034674', '4034733', '4036586', '4036996', '4038777', '4038782', '4038783', '4038788', '4038792', '4038806', '4040685', '4041083', '4041676', '4041681', '4041689', '4041691', '4041693', '4047206', '4048951', '4048952', '4048953', '4048954', '4048957', '4048958', '4049179', '4052725', '4052978', '4053577', '4053578', '4053579', '4053580', '4054517', '4054518', '4054519', '4055266', '4055532', '4056568', '4056887', '4056888', '4056890', '4056891', '4056892', '4056894', '4056895', '4073537', '4074588', '4074590', '4074591', '4074592', '4074594', '4074595', '4074598', '4074736', '4088776', '4088779', '4088782', '4088785', '4088787', '4088875', '4089187', '4096040'),

        [Parameter(Mandatory = $false, HelpMessage = 'LogFile Name')]
        [String]$logFile = 'C:\Temp\Error.log',

        [Parameter(Mandatory = $false, HelpMessage = 'Log entries')]
        [Switch]$logEntries,

        [Parameter(Mandatory = $false, HelpMessage = 'Max Log size')]
        [Int]$maxLogSize = 5242880,

        [Parameter(Mandatory = $false, HelpMessage = 'Max number of history logs')]
        [Int]$maxLogHistory = 5
    )

    begin {
        #Build splat for log entries
        $NewLogEntry = @{
            LogFile       = $logFile;
            Component     = 'Optimize-CMNWSUSServer';
            maxLogSize    = $maxLogSize;
            maxLogHistory = $maxLogHistory;
        }

        # Assign a value to logEntries
        if ($PSBoundParameters['logEntries']) {$logEntries = $true}
        else {$logEntries = $false}
        if ($PSBoundParameters['useSSL']) {$useSSL = $true}
        else {$useSSL = $false}
        if ($PSBoundParameters['skipDecline']) {$skipDecline = $true}
        else {$skipDecline = $false}
        if ($PSBoundParameters['declineLastLevelOnly']) {$declineLastLevelOnly = $true}
        else {$declineLastLevelOnly = $false}

        # Create a hashtable with your output info
        $returnHashTable = @{}

        if ($logEntries) {
            New-CMNLogEntry -entry 'Starting Function' -type 1 @NewLogEntry
            New-CMNLogEntry -entry "updateServer = $updateServer" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "useSSL = $useSSL" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "port = $port" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "skipDecline = $skipDecline" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "declineLastLevelOnly = $declineLastLevelOnly" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "maxAge = $maxAge" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "exceptionBulletinIDs = $exceptionBulletinIDs" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "exceptionArticleIDs = $exceptionArticleIDs" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "logFile = $logFile" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "logEntries = $logEntries" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "maxLogSize = $maxLogSize" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "maxLogHistory = $maxLogHistory" -type 1 @NewLogEntry
        }

        if ($skipDecline -and $declineLastLevelOnly) {
            if ($logEntries) {New-CMNLogEntry -entry 'Using SkipDecline and DeclineLastLevelOnly Switches together is not allowed.' -type 3 @NewLogEntry}
            throw 'Using SkipDecline and DeclineLastLevelOnly Switches together is not allowed.'
        }

        $outPath = 'C:\Temp\'
        $outSupersededList = Join-Path $outPath "$updateServer - SupersededUpdates.csv"
    
        try {
            if ($useSSL) {
                if ($logEntries) {New-CMNLogEntry -entry "Connecting to WSUS server $updateServer on Port $Port using SSL... " -type 1 @NewLogEntry }
                $useSSL = $true
            }
            Else {
                if ($logEntries) {New-CMNLogEntry -entry "Connecting to WSUS server $updateServer on Port $Port... " -type 1 @NewLogEntry}
                $useSSL = $false
            }
    
            [reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration") | out-null
            $wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer($updateServer, $useSSL, $Port);
        }
        catch [System.Exception] {
            $message = "Failed to connect.`r`nError: $($_.Exception.Message)`r`nPlease make sure that WSUS Admin Console is installed on this machine"
            if ($logEntries) {New-CMNLogEntry -entry $message -type 3 @NewLogEntry}
            throw $message
        }
    }

    process {
        if ($logEntries) {
            New-CMNLogEntry -entry "Beggining process loop." -type 1 @NewLogEntry
            New-CMNLogEntry -entry "Getting a list of all updates... " -type 1 @NewLogEntry
        }
        $countAllUpdates = 0
        $countSupersededAll = 0
        $countSupersededLastLevel = 0
        $countDeclined = 0

        try {
            $allUpdates = $wsus.GetUpdates()
            $allGroups = $wsus.GetComputerTargetGroups()
            $approval = [Microsoft.UpdateServices.Administration.UpdateApprovalAction]::NotApproved
        }

        catch [System.Exception] {
            $message = "Failed to get updates.`r`nError: $($_.Exception.Message)`r`nIf this operation timed out, please decline the superseded updates from the WSUS Console manually."
            if ($logEntries) {New-CMNLogEntry -entry $message -type 3 @NewLogEntry}
            throw $message
        }

        if ($logEntries) {
            New-CMNLogEntry -entry "Done" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "Parsing the list of updates... " -type 1 @NewLogEntry
        }
        foreach ($update in $allUpdates) {
            $countAllUpdates++
            if ($update.IsDeclined) {$countDeclined++}
            if (!$update.IsDeclined -and $update.IsSuperseded) {
                $countSupersededAll++
                if (!$update.HasSupersededUpdates) {$countSupersededLastLevel++}
                #Do I want CSV or return or both?
                $result = New-Object -TypeName psobject
                Add-Member -InputObject $result -MemberType NoteProperty -Name 'UpdateID' -Value $update.Id.UpdateId.Guid
                Add-Member -InputObject $result -MemberType NoteProperty -Name 'RevisionNumber' -Value $update.Id.RevisionNumber
                Add-Member -InputObject $result -MemberType NoteProperty -Name 'Title' -Value $update.Title
                if ($update.KnowledgeBaseArticles.Count -ne 0) {
                    $message = ''
                    foreach ($article in $update.KnowledgeBaseArticles) {$message = "$message $article"}
                    $message = $message.Substring(0, $message.Length - 1)
                    Add-Member -InputObject $result -MemberType NoteProperty -Name 'KBArticle' -Value $message
                }
                else {Add-Member -InputObject $result -MemberType NoteProperty -Name 'KBArticle' -Value ''}
                if ($update.SecurityBulletins.Count -ne 0) { 
                    $message = ''               
                    foreach ($bulletin in $update.SecurityBulletins) {$message = "$message $bulletin"}
                    $message = $message.Substring(0, $message.Length - 1)
                    Add-Member -InputObject $result -MemberType NoteProperty -Name 'SecurityBulletin' -Value $message
                }
                else {Add-Member -InputObject $result -MemberType NoteProperty -Name 'SecurityBulletin' -Value ''}
                Add-Member -InputObject $result -MemberType NoteProperty -Name 'LastLevel' -Value $update.HasSupersededUpdates
                Export-Csv -InputObject $result -Path $outSupersededList -NoTypeInformation -Append -Encoding ASCII
            }
        }

        if ($logEntries) {
            New-CMNLogEntry -entry "Done." -type 1 @NewLogEntry
            New-CMNLogEntry -entry "List of superseded updates: $outSupersededList" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "========" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "Summary:" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "========" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "All Updates = $countAllUpdates" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "Any except Declined = $($countAllUpdates - $countDeclined)" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "All Superseded Updates = $countSupersededAll" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "`t`tSuperseded Updates (Intermediate) = $($countSupersededAll - $countSupersededLastLevel)" -type 1 @NewLogEntry
            New-CMNLogEntry -entry "`t`tSuperseded Updates (Last Level) = $countSupersededLastLevel" -type 1 @NewLogEntry
        }

        if (!$skipDecline) {
            $updatesDeclined = 0
            $updatesApproved = 0
            foreach ($update in $allUpdates) {
                if (!$update.IsDeclined) {
                    #we want to defaulting to not declining
                    $declineUpdate = $false
                    #is it a last level only?
                    if ($update.IsSuperseded -and !$update.HasSupersededUpdates -and $declineLastLevelOnly) {$declineUpdate = $true}
                    #Decline superseded
                    elseif ($update.IsSuperseded -and !$declineLastLevelOnly) {$declineUpdate = $true}
                    #is it too old?
                    if (((New-TimeSpan -Start $update.CreationDate -End (Get-Date)).days / 30.42) -gt $maxAge) {$declineUpdate = $true}
                    #is it an exception articleID?
                    foreach ($updateArticleID in $update.KnowledgebaseArticles) {
                        if ($exceptionArticleIDs.Contains($updateArticleID)) {$declineUpdate = $false}
                    }
                    #is it an exception BulletinID?
                    foreach ($updateBulletinID in $update.SecurityBulletins) {
                        if ($exceptionBulletinIDs.Contains($update.BulletinID)) {$declineUpdate = $false}
                    }
                    if ($update.Title -match 'itanium') {$declineUpdate = $true}
                    if ($declineUpdate) {
                        try {
                            $update.Decline()
                            $update.Refresh()
                            if ($logEntries) {New-CMNLogEntry -entry "Declined update $($update.Id.UpdateId.Guid) - $($update.Title)" -type 1 @NewLogEntry}
                            $returnHashTable['DeclinedUpdates'] += [Array]"$($update.ID.UpdateId.Guid) - $($update.Title)"
                            #Write-Progress -Activity 'Declining Updates' -Status "Declining update $($update.Id.UpdateId.Guid)" -PercentComplete (($updatesDeclined / $countSupersededLastLevel) * 100)
                            $updatesDeclined++
                        }
                        catch [System.Exception] {
                            if ($logEntries) {New-CMNLogEntry -entry "Failed to decline update $($update.Id.UpdateId.Guid). Error: $($_.Exception.Message)" -type 1 @NewLogEntry}
                            $returnHashTable['FailedDecline'] += [Array]"$($update.ID.UpdateId.Guid) - $($update.Title)"
                        }            
                    }
                }
                else {
                    $approveUpdate = $false
                    foreach ($updateArticleID in $update.KnowledgebaseArticles) {
                        if ($exceptionArticleIDs.Contains($updateArticleID)) {$approveUpdate = $true}
                    }
                    #is it an exception BulletinID?
                    foreach ($updateBulletinID in $update.SecurityBulletins) {
                        if ($exceptionBulletinIDs.Contains($update.BulletinID)) {$approveUpdate = $true}
                    }
                    if ($approveUpdate) {
                        try {
                            $update.Approve($approval, $allGroups[0])
                            $update.Refresh()
                            if ($logEntries) {New-CMNLogEntry -entry "Approved update $($update.Id.UpdateId.Guid) - $($update.Title)" -type 1 @NewLogEntry}
                            $returnHashTable['ApprovedUpdates'] += [Array]"$($update.ID.UpdateId.Guid) - $($update.Title)"
                            $updatesApproved++
                        }
                        catch [System.Exception] {
                            if ($logEntries) {New-CMNLogEntry -entry "Failed to decline update $($update.Id.UpdateId.Guid). Error: $($_.Exception.Message)" -type 1 @NewLogEntry}
                            $returnHashTable['FailedApproved'] += [Array]"$($update.ID.UpdateId.Guid) - $($update.Title)"
                        }            
                    }
                }
            }
            #Write-Progress -Activity 'Declining Updates' -Completed
        }
        else {
            if ($logEntries) {New-CMNLogEntry -entry "SkipDecline flag is set to $skipDecline. Skipped declining updates" -type 1 @NewLogEntry}
        }
    }

    end {
        if ($PSBoundParameters['logEntries']) {
            New-CMNLogEntry -entry "$updatesDeclined updates decliend." -type 1 @NewLogEntry
            New-CMNLogEntry -entry "$updatesApproved updates approved." -type 1 @NewLogEntry
            New-CMNLogEntry -entry 'Completing Function' -Type 1 @NewLogEntry
        }
        $returnHashTable.Add('UpdatesApproved', $updatesApproved)
        $returnHashTable.Add('UpdatesDeclined', $updatesDeclined)
        $obj = New-Object -TypeName PSObject -Property $returnHashTable
        $obj.PSObject.TypeNames.Insert(0, 'CMN.WSUSServer')
        Return $obj
    }
}