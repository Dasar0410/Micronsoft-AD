choco install -y 7zip

curl -O 'https://download.microsoft.com/download/8/5/C/85C25433-A1B0-4FFA-9429-7E023E7DA8D8/Windows%20Server%202022%20Security%20Baseline.zip'

7z x '.\Windows%20Server%202022%20Security%20Baseline.zip'
Set-Location '.\Windows Server-2022-Security-Baseline-FINAL\Scripts'
Get-GPO -All | Format-Table -Property displayname
.\Baseline-ADImport.ps1
Get-GPO -All | Format-Table -Property displayname

Set-Location ..

curl -O 'https://download.microsoft.com/download/8/5/C/85C25433-A1B0-4FFA-9429-7E023E7DA8D8/Windows%2010%20version%2021H2%20Security%20Baseline.zip'
7z x '.\Windows%2010%20version%2021H2%20Security%20Baseline.zip'
Set-Location '.\Windows-10-v21H2-Security-Baseline\Scripts'
Get-GPO -All | Format-Table -Property displayname
.\Baseline-ADImport.ps1
Get-GPO -All | Format-Table -Property displayname


Get-GPO -Name "MSFT Windows Server 2022 - Domain Controller" | New-GPLink -Target "OU=Domain Controllers,DC=micron,DC=soft"
Get-GPO -Name "MSFT Windows 10 21H2 - Computer" | New-GPLink -Target "OU=Computers,DC=micron,DC=soft"
Get-GPO -Name "MSFT Windows 10 21H2 - User" | New-GPLink -Target "OU=AllUsers,DC=micron,DC=soft"

Set-Location ..