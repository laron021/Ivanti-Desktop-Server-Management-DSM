# ----------------------------
# Module: DSMScript.psm1
# Author: laron021
#----------------------------
<#
#>
#
# This module can be used to execute software rollouts in DSM according to the given parameters.
# --------Pay attention to the follofing parameters! Modify them first according to your environment--------
# -Core module needed: https://www.powershellgallery.com/packages/msgDSM7Module/your_preferred_version
# -Server names must be addressed manually! --> line 87
# -Use custom group object IDs --> line 197
# -For some functions, higher DSM module needed: msgDSM7Module.1.0.3.9.psm1 --> line 446
# -Before creating new group objects, modify  the -LDAPPath parameter according to your current environment
# Import and enjoy. Remember to modify the parameters
# Destination folder for the log file: C:\location
# ------------------------------------------------------
# Import-Module "C:\location\DSMScript.psm1" -Force
# -------------------------------------------------------
# pilot -currentgroup XXX -targetgroup XXX -exc $exc -start $activtionstartdate
# cleanup -getpolicy XXX -basisgroup XXX 
# totalcleanup -exc $exc
# welle -currentwelle XXX -targetwelle XXX -exc $exc -start $activtionstartdate
# qsa -targetgroup XXX -start $activtionstartdate -deny $deny -revupdate $revupdate -standard $standard
# prod -revupdate_basis @() -erweiterung_basis @() -uninstall_basis @() -erweiterung_welle @() -deny_welle @() -revupdate_welle @() -welle XXX -basis XXX -start $activtionstartdate
# deny -target XX -SwID XXX -start $activtionstartdate
# standard -target XXX -SwID XXX -start $activtionstartdate
# lastuser -username 'STRING'
# checkmembership -groups @()
# indipilot
# 
# ------------------------------------------------------------------------------------------------
Write-Host "
██████╗ ███████╗███╗   ███╗███████╗ ██████╗██████╗ ██╗██████╗ ████████╗
██╔══██╗██╔════╝████╗ ████║██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝
██║  ██║███████╗██╔████╔██║███████╗██║     ██████╔╝██║██████╔╝   ██║   
██║  ██║╚════██║██║╚██╔╝██║╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   
██████╔╝███████║██║ ╚═╝ ██║███████║╚██████╗██║  ██║██║██║        ██║   
╚═════╝ ╚══════╝╚═╝     ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   
                                                                       
██████╗ ██╗   ██╗    ██╗      █████╗ ██████╗  ██████╗ ███╗   ██╗       
██╔══██╗╚██╗ ██╔╝    ██║     ██╔══██╗██╔══██╗██╔═══██╗████╗  ██║       
██████╔╝ ╚████╔╝     ██║     ███████║██████╔╝██║   ██║██╔██╗ ██║       
██╔══██╗  ╚██╔╝      ██║     ██╔══██║██╔══██╗██║   ██║██║╚██╗██║       
██████╔╝   ██║       ███████╗██║  ██║██║  ██║╚██████╔╝██║ ╚████║       
╚═════╝    ╚═╝       ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝       
                                                                         

Hello Friend, check my github for readme.  
https://github.com/laron021/Ivanti-Desktop-Server-Management-DSM" -ForegroundColor Green  -BackgroundColor Black 


function regex {
	[CmdletBinding()]
	param(
        
        [Parameter(Mandatory)]
		[String]$m
	)

    $regex = $m -match '[0-2][\d][:][\d][\d][\s][0-2][\d][.][0-3][0-9][.][2][0][2][4]'
    if (!$regex){
        [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
        [System.Windows.Forms.MessageBox]::Show('Incorrect date format!','WARNING')
    }
}


function DSMWeb {
    param (
        [string]$primaryServer = "BLS",
        [string]$secondaryServer = "Secondary BLS"
    )

    $connection = Connect-DSM7Web -WebServer $primaryServer -UseDefaultCredential
    if ($null -ne $connection) {
        Write-Output "Connected to $primaryServer"
    }
    else {
        Write-Warning "Could not connect to $primaryServer. Attempting to connect to $secondaryServer." 

        $connection = Connect-DSM7Web -WebServer $secondaryServer -UseDefaultCredential
        if ($null -ne $connection) {
            Write-Output "Connected to $secondaryServer" 
        }
        else {
            Write-Error "Could not connect to $secondaryServer"
        }
    }
}
DSMWeb -primaryServer "enteoorg" -secondaryServer "SERVERNAME"


function pilot {
	[CmdletBinding()]
	param(
		[Parameter()]
		[System.Collections.ArrayList]$exc, #exception policy ID
        
        [Parameter(Mandatory)]
		[int32]$currentgroup, #QS group ID
    
        [Parameter(Mandatory)]
		[int32]$targetgroup,  #Pilot group ID

        [Parameter(Mandatory)]
		[String]$start

	)
    #Connect-DSM7Web -WebServer enteoorg -UseDefaultCredential
    filter timestamp {"$(Get-Date -Format G): $_"}
    $transcript = 'D:\Work\Scripts\zuweisung-transcript.log'

	#---ERWEITERUNG--DENY--REWUPDATE---#
    Start-Transcript -Path $transcript  -NoClobber -Append

    $policy = Get-DSM7PolicyListByTarget -ID $currentgroup | select ID,AssignedObjectName,SchemaTag,PolicyState,SwInstallationParameters | where {$_.ID -notin $exc -and $_.PolicyState -notlike "Deleting"} 
    foreach($i in $policy){

        if ($i.Schematag -eq "DenyPolicy"){

            if ($i.SwInstallationParameters.Tag -match "Umgebung"){
                Copy-DSM7Policy -ID $i.ID -TargetID $targetgroup -ActivationStartDate $start |timestamp
                Write-Host $i.AssignedObjectName "Configuration found" -ForegroundColor Green -BackgroundColor Black
            }
            else{
                Copy-DSM7Policy -ID $i.ID -TargetID $targetgroup -IsActiv -ActivationStartDate $start |timestamp
            }
        
        }
        else{
            if ($i.SwInstallationParameters.Tag -match "Umgebung"){
                Copy-DSM7Policy -ID $i.ID -TargetID $targetgroup -ActivationStartDate $start |timestamp
                Write-Host $i.AssignedObjectName "Configuration found" -ForegroundColor Green -BackgroundColor Black
            }
            else{
                Update-DSM7Policy -ID $i.ID -IsActiv -ActivationStartDate $start |timestamp
                Add-DSM7PolicyToTarget -ID $i.ID -TargetID $targetgroup |timestamp

            }
        }
    }


Get-DSM7PolicyListByTarget -ID $targetgroup | select SchemaTag,ActivationStartDate,AssignedObjectName | Format-Table -AutoSize

Stop-Transcript
}


function cleanup {
	[CmdletBinding()]
	param(
		[Parameter()]
		[System.Collections.ArrayList]$exc, #exception policy ID
                                            #JobPolicy should be included
        
        [Parameter(Mandatory)]
		[int32]$getpolicy, # group ID,mostly pilot
    
        [Parameter(Mandatory)]
		[int32]$basisgroup  #basis group ID
                            #policy remains here, all of the target groups will be removed

	)
    
    Clear-Host
    #Connect-DSM7Web -WebServer enteoorg -UseDefaultCredential
    filter timestamp {"$(Get-Date -Format G): $_"}
    $transcript = 'D:\Work\Scripts\zuweisung-transcript.log'

    #ERWEITERUNG
    Start-Transcript -Path $transcript  -NoClobber -Append
 
    $policy = Get-DSM7PolicyListByTarget -ID $getpolicy | select ID,AssignedObjectName,SchemaTag,TargetObjectList | where { ($_.TargetObjectList.TargetObjectID -contains $basisgroup) -and ($_.ID -notin $exc)}

    foreach ($k in $policy) { 
        Move-DSM7PolicyToTarget -ID $k.ID -TargetID $basisgroup -ForceRemove |timestamp
    } #delete policy without uninstall

    Write-Host  "Policies with ERWEITERUNG claned up succesfully" -ForegroundColor Green -BackgroundColor Black
    Stop-Transcript
}


function totalcleanup {
	[CmdletBinding()]
	param(
		[Parameter()]
		[System.Collections.ArrayList]$exc #exception policy ID
                                            #JobPolicy should be included
	)
    Clear-Host
    #Connect-DSM7Web -WebServer enteoorg -UseDefaultCredential
    $transcript = 'D:\Work\Scripts\zuweisung-transcript.log'
    Start-Transcript -Path $transcript  -NoClobber -Append

    #DENY,STANDARD
    $remove_from = @(440274,440275,440276,440271,440272,440273,440792,440796,440797,440793,440798,440799,440794,440800,440801) #RG1-RG2-RG3-QSA-PILOT

    foreach ($x in $remove_from){
       $list = Get-DSM7PolicyListByTarget -ID $x | select ID,SchemaTag,PolicyState | where { ($_.ID -notin $exc)} 
        foreach($i in $list){
            if($i.PolicyState -notlike "Deleting"){
                 Remove-DSM7Policy -ID $i.ID -ForceDelete
                 }
        }    
    }
    

    #CHECK REMAINED POLICIES
    foreach($q in $remove_from){Get-DSM7PolicyListByTarget  -ID $q | select ID,AssignedObjectName}
    Stop-Transcript
}


function welle {
	[CmdletBinding()]
	param(
		[Parameter()]
		[System.Collections.ArrayList]$exc, #exception policy ID
        
        [Parameter(Mandatory)]
		[int32]$currentwelle, #QS group ID
    
        [Parameter(Mandatory)]
		[int32]$targetwelle,  #Pilot group ID

        [Parameter(Mandatory)]
		[String]$start,

        [Parameter()]
		[int32]$final

	)
    #WELLE 160659-basis
    #Connect-DSM7Web -WebServer enteoorg -UseDefaultCredential
    filter timestamp {"$(Get-Date -Format G): $_"}

    $wpolicy = Get-DSM7PolicyListByTarget -ID $currentwelle | select ID,SchemaTag,AssignedObjectName | where { $_.ID -notin $exc} 
    foreach ($v in $wpolicy ) {  

               if ($v.Schematag -eq "DenyPolicy") {

                $x = $v.AssignedObjectName
                
                    if ($targetwelle -eq $final){

                        
                        $y = Get-DSM7PolicyListByTarget -ID $final | select ID,AssignedObjectName | where { $_.AssignedObjectName -eq $x}  

                        foreach ($j in $y) {
                            Update-DSM7Policy -ID $j.ID -IsActiv -ActivationStartDate $start |timestamp
                            Remove-DSM7Policy -ID $j.ID
                        }
                    }
                    else{
                        Copy-DSM7Policy -ID $v.ID -TargetID $targetwelle -IsActiv -ActivationStartDate $start |timestamp
                    }

               }
           
               else { 
                    Update-DSM7Policy -ID $v.ID -IsActiv -ActivationStartDate $start |timestamp
                    Add-DSM7PolicyToTarget -ID $v.ID -TargetID $targetwelle |timestamp
               }
    }  
}


function qsa {
	[CmdletBinding()]
	param(
		[Parameter()]
		[System.Collections.ArrayList]$standard, #software ID
        
        [Parameter()]
		[System.Collections.ArrayList]$revupdate, #software ID

        [Parameter()]
		[System.Collections.ArrayList]$deny, #software ID
    
        [Parameter(Mandatory)]
		[int32]$targetgroup,  #Pilot group ID

        [Parameter(Mandatory)]
		[String]$start
	)

    Clear-Host
    #Connect-DSM7Web -WebServer enteoorg -UseDefaultCredential
    filter timestamp {"$(Get-Date -Format G): $_"}
    $transcript = 'D:\Work\Scripts\zuweisung-transcript.log'

    #DENY,STANDARD,REVUPDATE
    Start-Transcript -Path $transcript  -NoClobber -Append

    foreach ($i in $standard ) {
            New-DSM7Policy -IsActiv -TargetID $targetgroup -SwID $i -ActivationStartDate $start |timestamp}

    foreach ($i in $revupdate ) {
            New-DSM7Policy -IsActiv -TargetID $targetgroup -SwID $i -ActivationStartDate $start -Priority 800|timestamp}

    foreach ($i in $deny ) {
            New-DSM7Policy -IsActiv -TargetID $targetgroup -SwID $i -ActivationStartDate $start -DenyPolicy |timestamp}


    Get-DSM7PolicyListByTarget -ID $targetgroup | select ID,SchemaTag,AssignedObjectName
    Stop-Transcript
}


function prod {
	[CmdletBinding()]
	param(
		[Parameter()]
		[System.Collections.ArrayList]$deny_welle, #policy ID
        
        [Parameter()]
		[System.Collections.ArrayList]$revupdate_welle, #policy ID

        [Parameter()]
		[System.Collections.ArrayList]$erweiterung_welle, #policy ID

        [Parameter()]
		[System.Collections.ArrayList]$revupdate_basis, #basis policy ID!!!
                                                        #don't use it if there is newer version available in DSM!

        [Parameter()]
		[System.Collections.ArrayList]$erweiterung_basis, #policy ID

        [Parameter()]
		[System.Collections.ArrayList]$uninstall_basis, #basis policy ID!!!
    
        [Parameter()]
		[int32]$welle,  #welle group ID

        [Parameter()]
		[int32]$basis,  #basis group ID

        [Parameter(Mandatory)]
		[String]$start
	)

    Clear-Host
    #Connect-DSM7Web -WebServer enteoorg -UseDefaultCredential
    filter timestamp {"$(Get-Date -Format G): $_"}
    $transcript = 'D:\Work\scripts\zuweisung_prod-transcript.log'
    Start-Transcript -Path $transcript  -NoClobber -Append
    
    #PROD
    $copy = $revupdate_welle+$deny_welle

    $policy = $uninstall_basis+$erweiterung_basis+$revupdate_basis+$erweiterung_welle+$revupdate_welle+$deny_welle

    foreach($i in $policy){

        if($i -in $copy){
            Copy-DSM7Policy -ID $i -TargetID $welle -IsActiv -ActivationStartDate $start |timestamp
        }

        elseif($i -in $erweiterung_welle){
            Update-DSM7Policy -ID $i -IsActiv -ActivationStartDate $start |timestamp
            Add-DSM7PolicyToTarget -ID $i -TargetID $welle |timestamp
        }

        elseif($i -in $revupdate_basis ){
            Update-DSM7Policy -ID $i -IsActiv -ActivationStartDate $start -UpdatePackage -CriticalUpdate |timestamp
        }

        elseif($i -in $erweiterung_basis){
            Update-DSM7Policy -ID $i -IsActiv -ActivationStartDate $start |timestamp
            Add-DSM7PolicyToTarget -ID $i -TargetID $basis |timestamp
        }

        elseif($i -in $uninstall_basis){
            Update-DSM7Policy -ID $i -IsActiv -ActivationStartDate $start |timestamp
            Remove-DSM7Policy -ID $i |timestamp               
        }
    }


Stop-Transcript
}


function standard {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory)]
		[int32]$target, #Target ID
        
        [Parameter(Mandatory)]
		[int32]$SwID,  #Software ID
        
        [Parameter(Mandatory)]
		[String]$start
	)
    Clear-Host
    #Connect-DSM7Web -WebServer enteoorg -UseDefaultCredential
	New-DSM7Policy -IsActiv -TargetID $target -SwID $SwID -ActivationStartDate $start
}


function deny {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory)]
		[int32]$target, #Target ID
        
        [Parameter(Mandatory)]
		[int32]$SwID,  #Software ID
        
        [Parameter(Mandatory)]
		[String]$start

	)
    Clear-Host
    #Connect-DSM7Web -WebServer enteoorg -UseDefaultCredential
	New-DSM7Policy -IsActiv -TargetID $target -SwID $SwID -ActivationStartDate $start -DenyPolicy
}


function lastuser {
	[CmdletBinding()]
	param(
		
        [Parameter(Mandatory)]
		[String]$username

	)
    Clear-Host
    #Connect-DSM7Web -WebServer enteoorg -UseDefaultCredential
	$userid = Get-DSM7User -Name $username 
    $c= ($userid.ID)
    Get-DSM7ComputerList -Filter "(&(BasicInventory.LastLoggedOnUser=$c)(objectCategory=Computer))" | select name | Format-Table -AutoSize
}


function checkmembership {
	[CmdletBinding()]
	param(
		
        [Parameter(Mandatory)]
		[System.Collections.ArrayList]$groups #group IDs
    )
    Clear-Host
    Import-Module "D:\Work\arlakato\msgDSM7Module.1.0.3.9.psm1"
    #Connect-DSM7Web -WebServer enteoorg -UseDefaultCredential
    $transcript = 'D:\work\Scripts\zuweisung-transcript.log'
    Start-Transcript -Path $transcript  -NoClobber -Append

    foreach ($k in $groups){ 

        $policy = Get-DSM7PolicyListByTarget -ID $k |select ID,AssignedObjectName,SchemaTag | where {$_.Schematag -ne "DenyPolicy"} 
        $policy2 = $policy[0].AssignedObjectName 

    
        $g = Get-DSM7PolicyListByAssignedSoftware -Name $policy2 |select TargetObjectList | Where {($_.TargetObjectList.TargetObjectName -cmatch "DL-SWD")  }
        $getname = $g.TargetObjectList.TargetObjectName


        $member = Get-DSM7GroupMembers -ID $k | select Name
        foreach($j in $member){

            $z = Get-DSM7Computer -Name $j.Name | select BasicInventory.LastLoggedOnUser  
            $LastLoggedOnuser = Get-DSM7User -ID $z.'BasicInventory.LastLoggedOnUser' | select Name

            $a = Get-DSM7ListOfMemberships -ID $z.'BasicInventory.LastLoggedOnUser' | select Name 
            #MEMBER
            if ($a.Name -contains $getname){

                Write-Host $j.Name,$LastLoggedOnuser.Name,"Has membership in:",$getname -ForegroundColor Green -BackgroundColor Black
                Write-Host "Policy going to be removed without uninstall-->forceremove" -ForegroundColor Yellow -BackgroundColor Black
            }
            #NOT MEMBER
            else{

                Write-Host $j.Name,$LastLoggedOnuser.Name,"Has NO membership in:",$getname -ForegroundColor Red -BackgroundColor Black
                Write-Host "Software going ot be uninstalled" -ForegroundColor Yellow -BackgroundColor Black

                #$policybycomputer = Get-DSM7PolicyInstanceListByNode -Name $j.Name | where {$_.PolicyID -in $policy.ID} |select ID
                #$policybycomputer | ForEach-Object {Remove-DSM7PolicyInstance -ID $_.ID} 
            }
        
        }
    }

    Stop-Transcript
}

function indiprod {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory)]
		[System.Collections.Hashtable]$dict, # @{current = target}
        
        [Parameter(Mandatory)]
		[String]$start,

        [Parameter()]
		[System.Collections.ArrayList]$exc, #exception policy ID

        [Parameter()]
		[System.Collections.ArrayList]$revupdate #revupdate policy ID
        
	)

    Clear-Host
    #Connect-DSM7Web -WebServer enteoorg -UseDefaultCredential
    filter timestamp {"$(Get-Date -Format G): $_"}
    $transcript = 'D:\work\Scripts\zuweisung-transcript.log'
    Start-Transcript -Path $transcript  -NoClobber -Append

    #$dict.getEnumerator() | ForEach-Object { ($_.key, $_.value)} 
    $dict.GetEnumerator() | ForEach-Object {
    $key = $_.key    #current
    $value = $_.value #DL-SWD

     
        $list = Get-DSM7PolicyListByTarget -ID $key | select ID,SchemaTag,AssignedObjectName,SwInstallationParameters | where { $_.ID -notin $exc }
        foreach ($x in $list) {
        
                if ($x.SchemaTag -eq "DenyPolicy"){

                    $name = $x.AssignedObjectName
                    $list2 = Get-DSM7PolicyListByTarget -ID $value | select ID,SchemaTag,AssignedObjectName | where {$_.AssignedObjectName -match $name }

                    foreach($y in $list2){
                            Update-DSM7Policy -ID $y.ID -IsActiv -ActivationStartDate $start |timestamp
                            Remove-DSM7Policy -ID $y.ID |timestamp
                    }
                }

                elseif($x.ID -in $revupdate){

                    $name3 = $x.AssignedObjectName

                    $list3 = Get-DSM7PolicyListByTarget -ID $value | select ID,SchemaTag,AssignedObjectName | where {$_.AssignedObjectName -match $name3 }

                    foreach($q in $list3){
                            Update-DSM7Policy -ID $q.ID -IsActiv -ActivationStartDate $start -UpdatePackage -CriticalUpdate |timestamp
                    }
                }
                else{
                    #CURRENTLY SET FOR DL-SWD!!
                    if ($x.SwInstallationParameters.Tag -match "Umgebung"){
                        Copy-DSM7Policy -ID $x.ID -TargetID $value -ActivationStartDate $start |timestamp
                        Write-Host $x.AssignedObjectName "  ---> Configuration found" -ForegroundColor Green -BackgroundColor Black
                    }
                    else{
                    Copy-DSM7Policy -ID $x.ID -TargetID $value -IsActiv -ActivationStartDate $start -IsUserPolicyAllassociatedComputer |timestamp #-IsUserPolicyAllassociatedComputer
                    }
        
                }
        }
    }
    Stop-Transcript
}

function forceremove {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory)]
		[int32]$ID #policy ID
        
	)
    Clear-Host
    #Connect-DSM7Web -WebServer enteoorg -UseDefaultCredential
	Remove-DSM7Policy -ID $ID -ForceDelete
}

function creategroup {
	[CmdletBinding()]
	param(
		[Parameter()]
		[System.Collections.ArrayList]$testers, #"COMPUTERNAME"

        [Parameter(Mandatory)]
		[String]$groupname
	)

    Clear-Host
    #Connect-DSM7Web -WebServer enteoorg -UseDefaultCredential

    New-DSM7Group -Name $groupname -SchemaTag "Group" -Typ "Computer" -LDAPPath "Managed Users & Computers/FatClient managed/prod.d002.loc"  
    foreach ($j in $testers){
        Add-DSM7ComputerToGroup -Name $j -GroupName $groupname
    }

    Get-DSM7Group -Name $groupname
    Get-DSM7GroupMembers -Name $groupname
}

function remove {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory)]
		[int32]$ID #policy ID
        
	)
    Clear-Host
    Connect-DSM7Web -WebServer enteoorg -UseDefaultCredential
	Remove-DSM7Policy -ID $ID 
}


function creategroup {
	[CmdletBinding()]
	param(
		[Parameter()]
		[System.Collections.ArrayList]$testers, #"COMPUTERNAME"

        [Parameter(Mandatory)]
		[String]$groupname
	)

    Clear-Host
    #Connect-DSM7Web -WebServer enteoorg -UseDefaultCredential

    New-DSM7Group -Name $groupname -SchemaTag "Group" -Typ "Computer" -LDAPPath "Managed Users & Computers/FatClient managed/prod.d002.loc"  
    foreach ($j in $testers){
        Add-DSM7ComputerToGroup -Name $j -GroupName $groupname
    }

    Get-DSM7Group -Name $groupname
    Get-DSM7GroupMembers -Name $groupname
}

function indipilot {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory)]
		[System.Collections.Hashtable]$dict, # @{current = target}
        
        [Parameter(Mandatory)]
		[String]$start,

        [Parameter()]
		[System.Collections.ArrayList]$exc #exception policy ID

    )
    Clear-Host
    
    filter timestamp {"$(Get-Date -Format G): $_"}

    #$dict.getEnumerator() | ForEach-Object { ($_.key, $_.value)} 
    $dict.GetEnumerator() | ForEach-Object {
    $key = $_.key    #current
    $value = $_.value #target

        $list = Get-DSM7PolicyListByTarget -ID $key | select ID,SchemaTag,AssignedObjectName,SwInstallationParameters | where { $_.ID -notin $exc }
        foreach ($x in $list) {

            if ($x.SwInstallationParameters.Tag -match "Umgebung"){
                Copy-DSM7Policy -ID $x.ID -TargetID $value -ActivationStartDate $start |timestamp
                Write-Host $x.AssignedObjectName "Configuration found" -ForegroundColor Green -BackgroundColor Black
            }
            else{
                Copy-DSM7Policy -ID $x.ID -TargetID $value -IsActiv -ActivationStartDate $start |timestamp
            }   
        }
    }

}

function PreCachingStart {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [int]$groupID,

        [Parameter(Mandatory=$true)]
        [int[]]$policies
    )
    $transcript = 'D:\Work\arlakato\logs\PreCachingStart.log'
    Start-Transcript -Path $transcript  -NoClobber -Append
    # Get the group members' IDs
    $IDs = Get-DSM7GroupMembers -ID $groupID | Select-Object -ExpandProperty ID 

    foreach ($policyID in $policies) {
        $thirdArray = @()
        
        # Get the policy instance list for the current policy
        $instances = Get-DSM7PolicyInstanceListByPolicy -ID $policyID | Select-Object ID, TargetObjectID
        
        # Filter instances where the TargetObjectID matches any ID in the $IDs array
        $thirdArray = $instances | Where-Object { $IDs -contains $_.TargetObjectID } | Select-Object -ExpandProperty ID

        # Update policy instances (assuming this is the desired action)
        Update-DSM7PolicyInstances -ID $thirdArray -active

        # Output the results for the current policy
        Write-Host "Finished unlocking policies for Policy ID: $policyID"
    }
    Stop-Transcript
}

function PreCachingStop {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [int]$groupID,

        [Parameter(Mandatory=$true)]
        [int[]]$policies
    )
    $transcript = 'D:\Work\arlakato\logs\PreCachingStop.log'
    Start-Transcript -Path $transcript  -NoClobber -Append
    # Get the group members' IDs
    $IDs = Get-DSM7GroupMembers -ID $groupID | Select-Object -ExpandProperty ID 

    foreach ($policyID in $policies) {
        $thirdArray = @()
        
        # Get the policy instance list for the current policy
        $instances = Get-DSM7PolicyInstanceListByPolicy -ID $policyID | Select-Object ID, TargetObjectID
        
        # Filter instances where the TargetObjectID matches any ID in the $IDs array
        $thirdArray = $instances | Where-Object { $IDs -contains $_.TargetObjectID } | Select-Object -ExpandProperty ID

        # Update policy instances (assuming this is the desired action)
        Update-DSM7PolicyInstances -ID $thirdArray

        # Output the results for the current policy
        Write-Host "Finished stopping policies for Policy ID: $policyID"
    }
    Stop-Transcript
}