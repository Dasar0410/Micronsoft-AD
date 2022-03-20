# Kjøres som administrator i powershell på DC1
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install -y powershell-core


# Kjøres som admin i powershell på DC1
Install-WindowsFeature AD-Domain-Services, DNS -IncludeManagementTools
$Password = Read-Host -Prompt 'Enter Password' -AsSecureString
Set-LocalUser -Password $Password Administrator
$Params = @{
    DomainMode                    = 'WinThreshold'
    DomainName                    = 'micron.soft'
    DomainNetbiosName             = 'MICRON'
    ForestMode                    = 'WinThreshold'
    InstallDns                    = $true
    NoRebootOnCompletion          = $true
    SafeModeAdministratorPassword = $Password
    Force                         = $true
}
Install-ADDSForest @Params
Restart-Computer


# Kjøres som admin i powershell på CL1, MGR og SRV1
Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses 192.168.111.102
$cred = Get-Credential -UserName 'MICRON\Administrator' -Message 'Cred'
Add-Computer -Credential $cred -DomainName micron.soft -PassThru -Verbose
Restart-Computer