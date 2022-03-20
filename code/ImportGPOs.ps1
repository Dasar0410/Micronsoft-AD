# Scriptet henter alle gpo backuper som ligger i git repositoriet og linker de til
# sine respektive OUer.
# @see .\Baseline-ADImport.ps1


Set-Location 'C:\Users\Administrator\HaraldMR-DCSG1005downloadfork*\GPOs\Scripts'
.\Baseline-ADImport.ps1

Get-GPO -Name "[Adm] Bakgrunn" | New-GPLink -Target "OU=Adm,OU=AllUsers,DC=micron,DC=soft"
Get-GPO -Name "[All Users] CMD off" | New-GPLink -Target "OU=AllUsers,DC=micron,DC=soft"
Get-GPO -Name "[All Users] Firewall" | New-GPLink -Target "OU=AllUsers,DC=micron,DC=soft"
Get-GPO -Name "[All Users] Forced system restarts off" | New-GPLink -Target "OU=AllUsers,DC=micron,DC=soft"
Get-GPO -Name "[All Users] Password settings" | New-GPLink -Target "OU=AllUsers,DC=micron,DC=soft"
Get-GPO -Name "[All Users] PIN Complexity" | New-GPLink -Target "OU=AllUsers,DC=micron,DC=soft"
Get-GPO -Name "[All Users] Prohibit software installation" | New-GPLink -Target "OU=AllUsers,DC=micron,DC=soft"
Get-GPO -Name "[All Users] Restrict access to settings" | New-GPLink -Target "OU=AllUsers,DC=micron,DC=soft"
Get-GPO -Name "[Cons] Bakgrunn" | New-GPLink -Target "OU=Cons,OU=AllUsers,DC=micron,DC=soft"
Get-GPO -Name "[Cons] Removable storage access off" | New-GPLink -Target "OU=Cons,OU=AllUsers,DC=micron,DC=soft"
Get-GPO -Name "[Domain Policy] Anonymous SID enumeration disabled" | New-GPLink -Target "OU=Domain Controllers,DC=micron,DC=soft"
Get-GPO -Name "[Domain Policy] Guest account access off" | New-GPLink -Target "OU=Domain Controllers,DC=micron,DC=soft"
Get-GPO -Name "[HR] Bakgrunn" | New-GPLink -Target "OU=HR,OU=AllUsers,DC=micron,DC=soft"
Get-GPO -Name "[IT] Access to settings" | New-GPLink -Target "OU=IT,OU=AllUsers,DC=micron,DC=soft"
Get-GPO -Name "[IT] Allow software installations" | New-GPLink -Target "OU=IT,OU=AllUsers,DC=micron,DC=soft"
Get-GPO -Name "[IT] Bakgrunn" | New-GPLink -Target "OU=IT,OU=AllUsers,DC=micron,DC=soft"
Get-GPO -Name "[IT] CMD on" | New-GPLink -Target "OU=IT,OU=AllUsers,DC=micron,DC=soft"
Get-GPO -Name "[IT] Forced system restarts on" | New-GPLink -Target "OU=IT,OU=AllUsers,DC=micron,DC=soft"