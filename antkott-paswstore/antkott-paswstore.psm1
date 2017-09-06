# Модуль PowerShell SMUA - шифрование пароля в файл и обратная функция
# Положить в C:\Program Files\WindowsPowerShell\Modules\antkott-paswstore\
##############################
$moduleVer="1.0 #01.08.17 by Anton V. Kotlyarenko"
$moduleNameShort="antkott-paswstore"
$moduleName="Модуль PowerShell antkott - работа с паролями"



############## PASSW #######################################

Write-LogService ""
Write-LogService "UsingModule [$ModuleNameShort] $moduleVer"
Write-LogService "            [$moduleName] "
Write-LogService "   from     [$((Get-Module -ListAvailable $moduleNameShort).path)] "

function Export-SecureKey ($path){    
    [System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
    $pathSecKey = [Microsoft.VisualBasic.Interaction]::InputBox("Enter path to new key", $moduleNameShor, $path)
    #Generate encryption key.
    $key = New-Object byte[](32)
    $rng = [System.Security.Cryptography.RNGCryptoServiceProvider]::Create()
    $rng.GetBytes($key)
    set-content -path $path -value $key -encoding byte
}


# https://powertoe.wordpress.com/2011/06/05/storing-passwords-to-disk-in-powershell-with-machine-based-encryption/
# Get the password using the -AsSecureString parameter of Read-Host
# Convert the securestring to a string using ConvertFrom-SecureString using a 32 byte key
# Convert the string returned from step 2 into an array of bytes
# Create an RSA machine key in the cryptographic service provider (CSP)
# Encrypt the bytes in step 3 using RSA
# Serialize the encrypted bytes to disk as clixml using Export-Clixml

function Export-SecureString ($pathSec, $pathSecKey){
    [System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
    $pathSecKey = [Microsoft.VisualBasic.Interaction]::InputBox("Enter path to key", $moduleNameShor, $pathSecKey)    
    $Key = New-Object byte[] 32  
    $key=Get-Content -Encoding Byte -Path $pathSecKey      
    [string]$pasw = [Microsoft.VisualBasic.Interaction]::InputBox("Enter passw", $moduleNameShor, "12345")
    $path = [Microsoft.VisualBasic.Interaction]::InputBox("Enter path", $moduleNameShor, $pathSec)      
    $securepass =$pasw |ConvertTo-SecureString -AsPlainText -Force| ConvertFrom-SecureString  -Key $key
    $bytes = [byte[]][char[]]$securepass
    $csp = New-Object System.Security.Cryptography.CspParameters
    $csp.KeyContainerName = "SuperSecretProcessOnMachine"
    $csp.Flags = $csp.Flags -bor [System.Security.Cryptography.CspProviderFlags]::UseMachineKeyStore
    $rsa = New-Object System.Security.Cryptography.RSACryptoServiceProvider -ArgumentList 5120,$csp
    $rsa.PersistKeyInCsp = $true
    $encrypted = $rsa.Encrypt($bytes,$true)
    $encrypted |Export-Clixml $path
}

function Import-SecureString($pathSec, $pathSecKey){
    $encrypted = Import-Clixml $pathSec
    $key=Get-Content -Encoding Byte -Path $pathSecKey
    $csp = New-Object System.Security.Cryptography.CspParameters
    $csp.KeyContainerName = "SuperSecretProcessOnMachine"
    $csp.Flags = $csp.Flags -bor [System.Security.Cryptography.CspProviderFlags]::UseMachineKeyStore
    $rsa = New-Object System.Security.Cryptography.RSACryptoServiceProvider -ArgumentList 5120,$csp
    $rsa.PersistKeyInCsp = $true
    $script:pass = [char[]]$rsa.Decrypt($encrypted, $true) -join "" |ConvertTo-SecureString -Key $key
    return $script:pass
}

function ConvertFrom-SecureToPlain {    
    param( [Parameter(Mandatory=$true)][System.Security.SecureString] $SecurePassword)    
    # Create a "password pointer"
    $PasswordPointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)    
    # Get the plain text version of the password
    $PlainTextPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($PasswordPointer)    
    # Free the pointer
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($PasswordPointer)    
    # Return the plain text password
    $PlainTextPassword   
}



