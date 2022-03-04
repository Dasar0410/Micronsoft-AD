#Kjør som administrator

#Link til git
#	iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mats-s/quick-setup/main/win-srv-setup.ps1'))


#Går til bruker
cd C:\Users\Admin

Get-WinUserLanguageList
Set-WinUserLanguageList -LanguageList nb-NO

Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install -y powershell-core

choco install -y sysinternals

# - choco install -y git

#bginfo vil tydeligvis ikke fungere så legger til det senere

#Gå inn i pwsh // eksempelvil pwsh.exe

pwsh
