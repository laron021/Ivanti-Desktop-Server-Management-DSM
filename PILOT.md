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
    Connect-DSM7Web -WebServer enteoorg -UseDefaultCredential
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