#Change font (kali font)
Install-Module oh-my-posh -Scope CurrentUser -AllowPrerelease
"Import-Module oh-my-posh
Set-PoshPrompt -Theme kali" > $profile
pwsh
