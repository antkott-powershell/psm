# Module PowerShell SMUA - common functions
# Put in C:\Program Files\WindowsPowerShell\Modules\smua-common\
##############################
$moduleVer="1.6 #01.06.17 by Anton V. Kotlyarenko"
$moduleNameShort="antkott-common"
$moduleName="Module PowerShell antkott - common functions"



############## LOGGING #######################################

function loggingMainten{
    if (!(Test-path $LogPath)) {
        New-Item -Path $LogPath -ItemType "directory"
    }
}

function Write-Log
{param([string]$msg)	
    if($logfilename){ 
        Out-File -FilePath $logfilename -InputObject $msg -Append -encoding unicode        
    }
    write-host $msg -ForegroundColor White    
}

function Write-LogService
{param([string]$msg)
    if($logfilename){	
        Out-File -FilePath $logfilename -InputObject $msg -Append -encoding unicode         
    } 
    write-host $msg -ForegroundColor Gray
}

Write-LogService ""
Write-LogService "UsingModule [$ModuleNameShort] $moduleVer"
Write-LogService "            [$moduleName] "
Write-LogService "   from     [$((Get-Module -ListAvailable $moduleNameShort).path)] "

function Set-DetailedLogON {
    $ErrorActionPreference="SilentlyContinue"
    Stop-Transcript | out-null
    $ErrorActionPreference = "Continue"
    Start-Transcript -path $logFileNameDetailed -append -Force
}

function Set-DetailedLogOFF {
    Stop-Transcript
}


function Write-LogGood
{param([string]$msg)	
    Out-File -FilePath $logfilename -InputObject $msg -Append -encoding unicode
    write-host $msg -ForegroundColor Green   
}

 function Write-LogWarning
{param([string]$msg)	
    Out-File -FilePath $logfilename -InputObject $msg -Append -encoding unicode
    write-host $msg -ForegroundColor Yellow    
}


 function Write-LogBad
{param([string]$msg)
    $msg=$msg.ToUpper()	
    Out-File -FilePath $logfilename -InputObject $msg -Append -encoding unicode
    write-host $msg -ForegroundColor DarkYellow  
}

function Write-LogError
{param([string]$msg)
    Out-File -FilePath $logErrorFileName -InputObject $msg -Append -encoding unicode
    write-host $msg.ToUpper() -ForegroundColor DarkYellow  
}

function Get-TimeForLog {
    return, [string](Get-Date -Format "yyyy.MM.dd HH:mm:ss")
}


Function Get-IniContent {  
    <#  
    .Synopsis  
        Gets the content of an INI file  
          
    .Description  
        Gets the content of an INI file and returns it as a hashtable  
          
    .Notes  
        Author        : Oliver Lipkau <oliver@lipkau.net>  
        Blog        : http://oliver.lipkau.net/blog/  
        Source        : https://github.com/lipkau/PsIni 
                      http://gallery.technet.microsoft.com/scriptcenter/ea40c1ef-c856-434b-b8fb-ebd7a76e8d91 
        Version        : 1.0 - 2010/03/12 - Initial release  
                      1.1 - 2014/12/11 - Typo (Thx SLDR) 
                                         Typo (Thx Dave Stiff) 
          
        #Requires -Version 2.0  
          
    .Inputs  
        System.String  
          
    .Outputs  
        System.Collections.Hashtable  
          
    .Parameter FilePath  
        Specifies the path to the input file.  
          
    .Example  
        $FileContent = Get-IniContent "C:\myinifile.ini"  
        -----------  
        Description  
        Saves the content of the c:\myinifile.ini in a hashtable called $FileContent  
      
    .Example  
        $inifilepath | $FileContent = Get-IniContent  
        -----------  
        Description  
        Gets the content of the ini file passed through the pipe into a hashtable called $FileContent  
      
    .Example  
        C:\PS>$FileContent = Get-IniContent "c:\settings.ini"  
        C:\PS>$FileContent["Section"]["Key"]  
        -----------  
        Description  
        Returns the key "Key" of the section "Section" from the C:\settings.ini file  
          
    .Link  
        Out-IniFile
        https://gallery.technet.microsoft.com/scriptcenter/ea40c1ef-c856-434b-b8fb-ebd7a76e8d91#content 
        https://gallery.technet.microsoft.com/ea40c1ef-c856-434b-b8fb-ebd7a76e8d91 
    #>  
      
    [CmdletBinding()]  
    Param(  
        [ValidateNotNullOrEmpty()]  
        [ValidateScript({(Test-Path $_) -and ((Get-Item $_).Extension -eq ".ini")})]  
        [Parameter(ValueFromPipeline=$True,Mandatory=$True)]  
        [string]$FilePath  
    )  
      
    Begin  
        {Write-Verbose "$($MyInvocation.MyCommand.Name):: Function started"}  
          
    Process  
    {  
        Write-Verbose "$($MyInvocation.MyCommand.Name):: Processing file: $Filepath"  
              
        $ini = @{}  
        switch -regex -file $FilePath  
        {  
            "^\[(.+)\]$" # Section  
            {  
                $section = $matches[1]  
                $ini[$section] = @{}  
                $CommentCount = 0  
            }  
            "^(;.*)$" # Comment  
            {  
                if (!($section))  
                {  
                    $section = "No-Section"  
                    $ini[$section] = @{}  
                }  
                $value = $matches[1]  
                $CommentCount = $CommentCount + 1  
                $name = "Comment" + $CommentCount  
                $ini[$section][$name] = $value  
            }   
            "(.+?)\s*=\s*(.*)" # Key  
            {  
                if (!($section))  
                {  
                    $section = "No-Section"  
                    $ini[$section] = @{}  
                }  
                $name,$value = $matches[1..2]  
                $ini[$section][$name] = $value  
            }  
        }  
        Write-Verbose "$($MyInvocation.MyCommand.Name):: Finished Processing file: $FilePath"  
        Return $ini  
    }  
          
    End  
        {Write-Verbose "$($MyInvocation.MyCommand.Name):: Function ended"}  
} 


function Write-LogStaging
{param([string]$msg)
    $msg="...................................`n"+"<STAGE "+$msg+"> `n...................................`n"
    write-host $(Get-TimeForLog).ToUpper() -ForegroundColor Cyan 
    Out-File -FilePath  $logfilename -InputObject $(Get-TimeForLog) -Append -encoding unicode
    Out-File -FilePath  $logfilename -InputObject $msg -Append -encoding unicode
    write-host $msg.ToUpper() -ForegroundColor Cyan 
}

function Write-LogCatchingErrorReport
{param(
[Parameter(mandatory=$true)]
[string]$stage,
[Parameter(mandatory=$true)]
[string]$ErrorExceptionType,
[string]$ErrorMessage,
[string]$FailedItem,
[string]$AdditionaLInfo)    
   Write-LogError "--------------------------------"
   Write-LogError "(FAIL) unfortunately we caught error: [$ErrorExceptionType]"
   Write-LogError "  at stage: [$stage]"
   Write-LogError $ErrorMessage
   Write-LogError $FailedItem
   Write-LogError $AdditionaLInfo
    Write-LogError "--------------------------------"
}

function Write-OneRowCSV
{param([string[]]$arrayOfRowNames,[string[]]$arrayOfRowValue)
    write-host "toCSV=[$([string]$arrayOfRowValue)]";
    $numColstoExport=$arrayOfRowNames.Count
    $holdarr=@()    
    $obj = new-object PSObject
    for ($i=0;$i -lt $numColstoExport; $i++){                  
        $obj | add-member -membertype NoteProperty -name $arrayOfRowNames[$i] -value $arrayOfRowValue[$i]
    }
    $holdarr+=$obj
    $obj=$null    
    $holdarr| Export-Csv  -LiteralPath $csvFileName -Append -Encoding:UTF8 -Force -NoTypeInformation   
}

function Set-Pause
    {param([int] $sec, [string]$msg)
    Write-host " pause for $($sec)sec" -ForegroundColor Gray 
    for($i=1
     $i -le $sec
     $i++){       
       $percent=[int](($i*100)/$sec)
       if ($i -ne $sec ){
            write-progress -activity "($msg): wait for [$($sec-$i)] sec" -status "$percent%" -percentcomplete $percent;
       } else {
            write-progress -activity "($msg): wait for [$($sec-$i)] sec" -status "$percent%" -percentcomplete $percent -Completed
       }       
       sleep -Seconds 1
     }  
}

function Get-DateCurrent {
    return, [string](Get-Date -Format "yyyy.MM.dd")
}

function Get-TimeCurrent {
    return, [string](Get-Date -Format "yyyy.MM.dd-HH.mm.ss")
}

function Get-DatePastDay($day) {
    return, [string](get-date).AddDays(-$day).ToString("yyyy.MM.dd")
}

############## ARCHIVE #######################################

function New-Archive([String] $aDirectory, [String] $aZipfile){
    [string]$pathToZipExe = $7ZipPath;
    [Array]$arguments = "a", "-tzip", "$aZipfile", "$aDirectory", "-r";
    & $pathToZipExe $arguments;
}

function Export-Archive ([String] $aZipfile, [String] $aDirectory){
    [string]$pathToZipExe = $7ZipPath;
    [Array]$arguments = "e", "$aZipfile", "-o$aDirectory";
    & $pathToZipExe $arguments;
}

function Copy-File {
    param([string]$from, [string]$to, [string]$siz)    
    $ffile = [io.file]::Open($from, 'Open', 'Read', 'ReadWrite')    
    $tofile = [io.file]::Open($to, 'Create', 'Write', 'Read')
    Write-Progress -Activity "Copying file" -status "$from ==> $to" -PercentComplete 0
    try {
        [byte[]]$buff = new-object byte[] 4096
        [int]$total = [int]$count = 0
        do {
            $count = $ffile.Read($buff, 0, $buff.Length)
            $tofile.Write($buff, 0, $count)
            $total += $count
            if ($total % 1mb -eq 0) {
                Write-Progress -Activity "Copying file [$siz] mb" -status "$from -> $to" `
                   -PercentComplete ([int]($total/$ffile.Length* 100))
            }
        } while ($count -gt 0)
    }
    finally {
        $ffile.Dispose()
        $tofile.Dispose() 
        $ffile.Close()
        $tofile.Close()
        Write-Progress "Done" "Done" -completed
    }
}

############## INCREASE WINDOW WIDTH #####################################################

function WidenWindow([int]$preferredWidth)
{
  [int]$maxAllowedWindowWidth = $host.ui.rawui.MaxPhysicalWindowSize.Width
  if ($preferredWidth -lt $maxAllowedWindowWidth)
  {
    # first, buffer size has to be set to windowsize or more
    # this operation does not usually fail
    $current=$host.ui.rawui.BufferSize
    $bufferWidth = $current.width
    if ($bufferWidth -lt $preferredWidth)
    {
      $current.width=$preferredWidth
      $host.ui.rawui.BufferSize=$current
    }
    # else not setting BufferSize as it is already larger    
    # setting window size. As we are well within max limit, it won't throw exception.
    $current=$host.ui.rawui.WindowSize
    if ($current.width -lt $preferredWidth)
    {
      $current.width=$preferredWidth
      $host.ui.rawui.WindowSize=$current
    }
    #else not setting WindowSize as it is already larger
  }
  $Host.UI.RawUI.BufferSize = New-Object Management.Automation.Host.Size (120, 5000)
}

############## COMMON #######################################

$startTime=$null
$stopTime=$null
$startTimeForLog=$null

function Start-CommonHeaderForScript($ProgrammName,$ver,$scriptPath){

    $script:startTime=Get-Date
    $script:startTimeForLog=$(Get-TimeForLog)
    Write-log ""
    Write-LogGood "############################################################"
    Write-log $script:startTimeForLog
    Write-LogGood "Script [$ProgrammName] `n v.$ver `n from [$scriptPath] `n on PC [$($env:computername)]"
    Write-log ""
    Write-LogGood "############################################################"
    Write-log ""   
}


function Exit-CommonHeaderForScript($exitCode){ 
    $script:stopTime=Get-Date
    $timeScriptWorking=New-TimeSpan –Start $startTime –End $stopTime
       
    Write-log ""
    Write-log ""
    Write-log "---------------------------------------"
    Write-log "Exit with code [$exitCode]"
    Write-log "script worked:[$($timeScriptWorking.Days)]d, [$($timeScriptWorking.Hours)]h, [$($timeScriptWorking.Minutes)]m, [$($timeScriptWorking.Seconds)]s, [$($timeScriptWorking.Milliseconds)]ms"
    Write-log "     Script started  at [$script:startTimeForLog]"
    Write-LogGood "DONE Script finished at [$(Get-TimeForLog)]"
    Write-log "---------------------------------------"    
    Set-DetailedLogOFF
    Get-Variable -Exclude PWD,*Preference | Remove-Variable -EA 0 -Force
    Exit $exitCode
}

function Enable-ScriptTranscript{
    $ErrorActionPreference="SilentlyContinue"
    Stop-Transcript | out-null
    $ErrorActionPreference = "Continue" # or "Stop"
    Start-Transcript -path $global:FullLogFilename -append
}

function Disable-ScriptTranscript{    
    Stop-Transcript | out-null 
}


function Clear-folder ($path, $countDay){ 
    $deleteFiles = Get-ChildItem  -Path $Path | ? {$_.creationtime -lt (Get-Date).AddDays(-$countDay)} 
    Write-Log "starting clear [$path] find [$($deleteFiles.Count)] items older $((Get-Date).AddDays(-$countDay).ToString("dd.MM.yyyy"))"
    foreach($deleteFile in $deleteFiles)  
    {  
        Write-host "Work with $($deleteFile.FullName)"
        Remove-Item -Force -path $deleteFile.FullName
    }
}

function Clear-BeforeExit ($CounterDayScriptGarbageDelete){ 
   if($CounterDayScriptGarbageDelete -ne 0){
        if($LogFolderSyffix){
            Clear-Folder "$ScriptPath\$LogFolderSyffix" $CounterDayScriptGarbageDelete
        }
        if($CSVFolderSyffix){
            Clear-Folder "$ScriptPath\$CSVFolderSyffix" $CounterDayScriptGarbageDelete
        }
    }
}

$global:SmtpServer="10.1.1.76"
$global:SmtpPort=25

function Send-Mail{    
     param(
        $From, 
        $To, 
        $Body, 
        $Subject,
        $attachment 
        )
    Write-Log "doing [Send-Mail] $From ==> $To ($Subject)"
    Write-Log (!$FLAGSendLetter){
        Write-Log "flagSendLetter=[$FLAGSendLetter], so skip sending"  
        return
    }
    Write-Log "SmtpServer [$SmtpServer]"    
    $From = New-Object System.Net.Mail.MailAddress $From
    $To =   New-Object System.Net.Mail.MailAddress $To  
    # invoke SmtpClient 
    $smtpClient = new-object System.Net.Mail.SmtpClient($global:SmtpServer, $global:SmtpPort)  
    # Invoke MailMessage 
    $MailMessage = New-Object system.net.mail.mailmessage 
    # Init Smtp configuration 
    #$SmtpClient.host = $SmtpServer 
    #$SmtpClient.Port = $SmtpPort 
    # Build Mail message 
    $MailMessage.From = $From 
    $MailMessage.To.Add($To) 
    $MailMessage.Subject = $Subject     
    $MailMessage.IsBodyHtml = 1
    $style = "<style>BODY{font-family: Arial; font-size: 11pt;}"  
    $style = $style + "</style>"
    $MailMessage.Body = "<head><pre>$style</pre></head>"
    $MailMessage.Body += $Body 
    $encoding = [System.Text.Encoding]::UTF8 
    $MailMessage.BodyEncoding = $encoding
    $MailMessage.SubjectEncoding = $encoding
    if ($attachment){
        if(Test-Path -Path $attachment -ErrorAction SilentlyContinue){
            Write-Log "find attach ($attachment)"
            $attachmentObject = new-object System.Net.Mail.Attachment($attachment)
            $MailMessage.Attachments.Add($attachmentObject) 
        } else {
            Write-LogBad "not find ($attachment)"
        }   
    } 
    $sendErr=$null  
    try {            
        $SMTPClient.Send($mailMessage)      
    }
    catch { 
        $sendErr=$_.Exception.Message            
        Write-LogError "Error when send mail"
        Write-Log $sendErr            
    } finally{    
        $MailMessage.Dispose()
        $MailMessage=$null
        $Body=$null 
    }
    if(!$sendErr){
        Write-LogGood "message send"
    }
}
