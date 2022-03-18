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




Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses 192.168.111.102
$cred = Get-Credential -UserName 'MICRON\Administrator' -Message 'Cred'
Add-Computer -Credential $cred -DomainName micron.soft -PassThru -Verbose
Restart-Computer