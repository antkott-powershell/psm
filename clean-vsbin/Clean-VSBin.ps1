#Requires -Version 5.0
<# 
.SYNOPSIS
    Delete. \bin. \obj.folders.from- .C#. projects
#>

[Cmdletbinding()]
param(
    [Parameter(Mandatory = $true)]
    [String]$PathToSolutionFolder
)

Clear-Host
$ErrorActionPreference = 'Stop'
#$ExecutionContext.SessionState.LanguageMode = "FullLanguage"

#[string]$Script:ScriptName = ([IO.FileInfo]$MyInvocation.MyCommand.Definition).BaseName
$scriptInputParams = $PSCmdlet.MyInvocation.BoundParameters
trap {
    $errorMessage = $_.Exception.Message
    [string]$trappedMessage = "Couldn't execute the $Script:ScriptName:'$errorMessage'"
    Write-Warning $trappedMessage
    Write-Host "INPUT PARAMS:"
    Write-Host ($scriptInputParams | Out-String)
    Write-Host "ERROR:"
    $_ | Out-String | Write-Error
    exit -1
}

#region internal functions
function Get-Timestamp {
    return Get-Date -Format "dd-MMM-yyyy HH:mm:ss"
}
function Write-Log($message) {
    Write-Host "$(Get-Timestamp) $message"
}
function Exit-Fromscript {
    [cmdletbinding()]
    param(
        [string]
        $ExitCode = 0
    )
    Write-Log "Script FINISHED `n"
    Exit $ExitCode
}
#endregion

#START
Write-Log "`n START '$scriptName' script"
Write-Log "Get-VS folders from '$PathToSolutionFolder'"
$folders = Get-ChildItem $PathToSolutionFolder -include bin, obj, Teststore -Recurse -Force  -Depth:10
[int]$itemscount = $folders.Count
[int]$counter = 0
Write-Log "Deleting $itemsCount items"
Write-Host
Write-Host
foreach ($folder in $folders) {
    $counter++
    [string]$path = $folder.FullName
    $percentage = (100 * $counter) / $itemsCount
    Write-Progress -Activity "Deleting" -Status "$path" -PercentComplete $percentage
    Remove-Item $path -Force -Recurse
}
Exit-Fromscript    