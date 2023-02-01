#Requires -Version 5.0
<# 
.SYNOPSIS
    Delete. \bin. \obj.folders.from- .C#. projects
#>

[Cmdletbinding()]
param(
    [String[]]$arg = 
    @('-File'
        , "Clean-VSBin.ps1"
        , '-PathToSolutionFolder'
        , 'D:\ANT\Repo\cSharp'
    )   
)
Write-Host "Starting Clean-VSBin: $arg" -BackgroundColor DarkGreen -ForegroundColor White
Start-Process powershell -ArgumentList $arg -Verbose -NoNewWindow -Wait
pause