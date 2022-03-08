#Install Posh-module
Install-Module oh-my-posh -Scope CurrentUser -AllowPrerelease
Get-PoshThemes

"Import-Module oh-my-posh
Set-PoshPrompt -Theme kali" > $profile

pwsh
