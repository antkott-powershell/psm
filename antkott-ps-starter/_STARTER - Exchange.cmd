@ECHO OFF
::	starter version 1.0 01.08.2017 by Anton V. Kotlyarenko"


	SETLOCAL DisableDelayedExpansion
	FOR /F "tokens=*" %%A IN ('type "settings-script.ini"') DO SET %%A
CLS
ECHO    starter for *.PS1 script with *.INI settings
	SET PRG=%ScriptName%
	SET UNITFLG=%UnitFlag%
	TITLE [%ScriptName% %UnitFlag%]
	ECHO START [%ScriptName% %UnitFlag%]

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Mta -NoProfile -NoLogo -noexit -command ". 'C:\Program Files\Microsoft\Exchange Server\V15\bin\RemoteExchange.ps1'; Connect-ExchangeServer -auto; & '%ScriptPath%\%ScriptName%'"
pause