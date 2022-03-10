$font = Read-Host "Hvilket theme vil du ha "


Install-Module oh-my-posh -Scope CurrentUser
"Import-Module oh-my-posh
Set-PoshPrompt -Theme " + $font  > $profile
pwsh



