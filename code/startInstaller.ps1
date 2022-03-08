#Kjør som administrator

#Går til bruker
cd C:\Users\Admin

#Språk
Get-WinUserLanguageList
Set-WinUserLanguageList -LanguageList nb-NO

#For å kunne kjøre
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install -y powershell-core				#CHOOOOCO

choco install -y sysinternals					#Mr Windows Expert

choco install -y git						#Kan cmt bort

#bginfo vil tydeligvis ikke fungere så legger til det senere	#Check

pwsh.exe							

#iex ((New-Object System.Net.WebClient).DownloadString('https://gist.githubusercontent.com/Datakriger101/2aeece14caa9bd022a1587b91b73bfa4/raw/18447241314c9b4a1cd3b666e98094bc06f62660/PS_startInstaller.ps1'))

