#
# Манифест модуля для модуля "antkott-paswstore".
#
# Создано: Anton V. Kotlyarenko
#
# Дата создания: 01.18.2016
#

@{

# Файл модуля сценария или двоичного модуля, связанный с этим манифестом.
RootModule = '.\antkott-paswstore.psm1'

# Номер версии данного модуля.
ModuleVersion = '1.0.0.0'

# Уникальный идентификатор данного модуля
GUID = '1dc08ea9-b7d0-4909-bc8a-d2c08f9fe3da'

# Автор данного модуля
Author = 'Anton V. Kotlyarenko'

# Компания, создавшая данный модуль, или его поставщик
CompanyName = 'antkott'

# Заявление об авторских правах на модуль
Copyright = '(c) 2017 Anton V. Kotlyarenko. Все права защищены.'

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
       'Export-SecureString',
       'Import-SecureString',
       'ConvertFrom-SecureToPlain',
       'Export-SecureKey'       
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

