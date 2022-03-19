choco install -y 7zip

curl 'https://codeload.github.com/HaraldMR/DCSG1005downloadfork/legacy.zip/main' --output main.zip

7z x '.\main.zip'
Set-Location '.\HaraldMR-DCSG1005downloadfork-b80d563\GPOs'
Get-GPO -All | Format-Table -Property displayname 
.\Baseline-ADImport.ps1
Get-GPO -All | Format-Table -Property displayname

Set-Location ..



Get-GPO -Name "MSFT Windows Server 2022 - Domain Controller" | New-GPLink -Target "OU=Domain Controllers,DC=micron,DC=soft"
Get-GPO -Name "MSFT Windows 10 21H2 - Computer" | New-GPLink -Target "OU=Computers,DC=micron,DC=soft"
Get-GPO -Name "MSFT Windows 10 21H2 - User" | New-GPLink -Target "OU=AllUsers,DC=micron,DC=soft"

Set-Location ..