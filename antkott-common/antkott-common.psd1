#
# Манифест модуля для модуля "antkott-common".
#
# Создано: Anton V. Kotlyarenko
#
# Дата создания: 07.08.2017
#
# Файл модуля сценария или двоичного модуля, связанный с этим манифестом.
RootModule = '.\antkott-common.psm1'

# Номер версии данного модуля.
ModuleVersion = '1.0.0.6'

# Уникальный идентификатор данного модуля
GUID = '5d9269a6-aade-48d3-961f-6f8c154d665r'

# Автор данного модуля
Author = 'Anton V. Kotlyarenko'

# Компания, создавшая данный модуль, или его поставщик
CompanyName = 'AntKott'

# Заявление об авторских правах на модуль
Copyright = '(c) 2016 Anton V. Kotlyarenko. Все права защищены.'

# Описание функций данного модуля
# Description = ''

# Минимальный номер версии обработчика Windows PowerShell, необходимой для работы данного модуля
# PowerShellVersion = ''

# Имя узла Windows PowerShell, необходимого для работы данного модуля
# PowerShellHostName = ''

# Минимальный номер версии узла Windows PowerShell, необходимой для работы данного модуля
# PowerShellHostVersion = ''

# Минимальный номер версии Microsoft .NET Framework, необходимой для данного модуля
# DotNetFrameworkVersion = ''

# Минимальный номер версии среды CLR (общеязыковой среды выполнения), необходимой для работы данного модуля
# CLRVersion = ''

# Архитектура процессора (нет, X86, AMD64), необходимая для этого модуля
# ProcessorArchitecture = ''

# Модули, которые необходимо импортировать в глобальную среду перед импортированием данного модуля
# RequiredModules = @()

# Сборки, которые должны быть загружены перед импортированием данного модуля
# RequiredAssemblies = @()

# Файлы сценария (PS1), которые запускаются в среде вызывающей стороны перед импортом данного модуля.
# ScriptsToProcess = @()

# Файлы типа (.ps1xml), которые загружаются при импорте данного модуля
# TypesToProcess = @()

# Файлы формата (PS1XML-файлы), которые загружаются при импорте данного модуля
# FormatsToProcess = @()

# Модули для импорта в качестве вложенных модулей модуля, указанного в параметре RootModule/ModuleToProcess
# NestedModules = @()

# Функции для экспорта из данного модуля
FunctionsToExport = @(
       'Set-DetailedLogON',
       'Set-DetailedLogOFF',
       'Write-Log',
       'Write-LogService',
       'Write-LogGood',
       'Write-LogBad',
       'Write-LogWarning',
       'Write-LogError',
       'Write-LogStaging',
       'Write-LogCatchingErrorReport',
       'Write-OneRowCSV',
       'Set-Pause',
       'Get-TimeForLog',
       'Get-DateCurrent',
       'Get-TimeCurrent',
       'Get-IniContent',
       'New-Archive',
       'Export-Archive',
       'Copy-File',
       'WidenWindow',
       'Start-CommonHeaderForScript',
       'Exit-CommonHeaderForScript',
       'Enable-ScriptTranscript',
       'Disable-ScriptTranscript',
       'Clear-Folder',
       'Clear-BeforeExit',
       'Get-DatePastDay',
       'Send-Mail'
       )

# Командлеты для экспорта из данного модуля
CmdletsToExport = '*'

# Переменные для экспорта из данного модуля
VariablesToExport = '*'

# Псевдонимы для экспорта из данного модуля
AliasesToExport = '*'

# Список всех модулей, входящих в пакет данного модуля
# ModuleList = @()

# Список всех файлов, входящих в пакет данного модуля
# FileList = @()

# Личные данные для передачи в модуль, указанный в параметре RootModule/ModuleToProcess
# PrivateData = ''

# Код URI для HelpInfo данного модуля
# HelpInfoURI = ''

# Префикс по умолчанию для команд, экспортированных из этого модуля. Переопределите префикс по умолчанию с помощью команды Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

