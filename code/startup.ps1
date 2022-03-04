#cd:
cd C:\Users\Admin

#Språk:
Get-WinUserLanguageList
Set-WinUserLanguageList -LanguageList nb-NO

#Choco install og pwsh-core:
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install -y powershell-core

#Sysinternals install:	//Tar veldig lang tid
choco install -y sysinternals

#Fjernet BG info, fra discord "setup"

#pwsh.exe theme:
#For å se de forskjellige themesa man kan velge mellom > https://github.com/lukesampson/concfg/tree/master/preset_examples 
cd C:\Users\Admin
Invoke-WebRequest "https://codeload.github.com/lukesampson/concfg/zip/refs/heads/master" -OutFile ".\master.zip"
Expand-Archive .\master.zip -DestinationPath concfg
.\concfg\concfg-master\bin\concfg.ps1 import atelier-lakeside -y
pwsh.exe
