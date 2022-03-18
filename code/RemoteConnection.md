#### `Run these command sets when after joining MGR and CL1 to the AD. Dette gjør at det er mulig å connecte fra DC1 via PSSession prokollen. `
>
>   New-ItemProperty -Name LocalAccountTokenFilterPolicy `
>  -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System `
>  -PropertyType DWord -Value 1

>Enable-PsRemoting -Force

>Set-Item WSMan:\localhost\Client\TrustedHosts -Value "*" >-Force
## Connect from DC1

### DC1 -> SRV

### DC1 -> CL1


#### `Connecte hosts utenfra domenet - først på srv`

>New-ItemProperty -Name LocalAccountTokenFilterPolicy `  
>  -Path   HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System `
  -PropertyType DWord -Value 1  

  `Deretter på cl1`


>$curValue = (Get-Item wsman:\localhost\Client\TrustedHosts).value  
>if ($curValue -eq '') {   
>Set-Item wsman:\localhost\Client\TrustedHosts -Value "192.168.111.151"#IP_ADDRESS_OF_SRV1  
>} else {  
>  Set-Item wsman:\localhost\Client\TrustedHosts -Value   "$curValue, 192.168.111.151"#IP_ADDRESS_OF_SRV1
>}  
>$cred = Get-Credential -Username Admin -Message 'Cred'  
>Enter-PSSession -Credential $cred #IP_ADDRESS_OF_SRV1   

#### `run as administrator`
>Install-WindowsFeature AD-Domain-Services, DNS -IncludeManagementTools  
>$Password = Read-Host -Prompt 'Enter Password' -AsSecureString  
>Set-LocalUser -Password $Password Administrator  
>$Params = @{  
>    DomainMode                    = 'WinThreshold'  
>    DomainName                    = 'micron.soft'  
>    DomainNetbiosName             = 'MICRON'  
>    ForestMode                    = 'WinThreshold'  
>    InstallDns                    = $true  
>    NoRebootOnCompletion          = $true  
>    SafeModeAdministratorPassword = $Password  
>    Force                         = $true  
>}  
>Install-ADDSForest @Params  

>Restart-Computer  

#### `Teste om domenet er satt opp`
>Get-ADRootDSE  
>Get-ADForest  
>Get-ADDomain  
  
>Get-ADComputer -Filter *  

## run as administrator, på mgr og cl1 for å joine domenet
>Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses IP_ADDRESS_OF_DC1  
>$cred = Get-Credential -UserName 'MICRON\Administrator' -Message 'Cred'  
>Add-Computer -Credential $cred -DomainName micron.soft -PassThru -Verbose  
>Restart-Computer  
