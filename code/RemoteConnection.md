

### Passwords for quick use (Eskil Refsgaard)
- DC1: Sh9im3tawioO29Z1wYKx
- cl1: 3sCfbcftQfNyGJAJTaxP
- mgr: 8lc6nE2dBbpOTbNmKFYz
- srv: 7cuLFehRyr8OPFiRy5Nf 


#### Run these command sets when after joining MGR and CL1 to the AD. Dette gjør at det er mulig å connecte fra DC1 via PSSession prokollen. 
>
>New-ItemProperty -Name LocalAccountTokenFilterPolicy `
>  -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System `
>  -PropertyType DWord -Value 1
>
>Enable-PsRemoting -Force
>
>Set-Item WSMan:\localhost\Client\TrustedHosts -Value "*" >-Force
>
## Connect from DC1

### DC1 -> SRV

### DC1 -> CL1

'
Kjøres på CL1 for å godkjennes


>New-ItemProperty -Name LocalAccountTokenFilterPolicy `
>  -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System `
>  -PropertyType DWord -Value 1


#Kjøres på DC1, bytte ut med CL1 sin IP

>$curValue = (Get-Item wsman:\localhost\Client\TrustedHosts).value
>if ($curValue -eq '') { 
>  Set-Item wsman:\localhost\Client\TrustedHosts -Value "192.168.111.151"#IP_ADDRESS_OF_SRV1
>} else {
>  Set-Item wsman:\localhost\Client\TrustedHosts -Value "$curValue, 192.168.111.151"#IP_ADDRESS_OF_SRV1
>}
>$cred = Get-Credential -Username Admin -Message 'Cred'
>Enter-PSSession -Credential $cred 192.168.111.151#IP_ADDRESS_OF_SRV1 

```
Usage: myvms.ps1 [mgr|cl1|dc1|srv1|mgra|cl1a|dc1a|srv1a]

floating ip's and the Admin-user-password for each host (retrieve from SkyHiGh):
$mgr_ip =""
$mgr_pw =""
$cl1_ip =""
$cl1_pw =""
$dc1_ip ="10.212.136.67"
$dc1_pw ="Sh9im3tawioO29Z1wYKx"
$srv1_ip=""
$srv1_pw=""
# domain administrator password (you set this yourself when creating the domain):
$dc1a_pw=Xx120build

$logintype=$args[0]

function Connect-MyHost {
    param (
        $User,$IP,$Pw
    )
    if (Test-NetConnection -ComputerName "$ip" -Port 3389 -InformationLevel Quiet -WarningAction SilentlyContinue) {
        Write-Output "Logging in $user on $ip"
        cmdkey `/generic:"$ip" `/user:"$user" `/pass:"$pw"
        mstsc `/v:"$ip"
        Start-Sleep 10
        cmdkey `/delete:"$ip"
    } else {
        Write-Output "Not able to reach port 3389 on host $ip"
    }
}

switch ($logintype) {
"mgr" {
    $ip="$mgr_ip"
    $pw="$mgr_pw"
    $user="Admin"
    Connect-MyHost -User $user -IP $ip -Pw $pw
    }
"cl1" {
    $ip="$cl1_ip"
    $pw="$cl1_pw"
    $user="Admin"
    Connect-MyHost -User $user -IP $ip -Pw $pw
    }
"dc1" {
    $ip="$dc1_ip"
    $pw="$dc1_pw"
    $user="Admin"
    Connect-MyHost -User $user -IP $ip -Pw $pw
    }
"srv1" {
    $ip="$srv1_ip"
    $pw="$srv1_pw"
    $user="Admin"
    Connect-MyHost -User $user -IP $ip -Pw $pw
    }
"mgra" {
    $ip=$mgr_ip
    $pw="$dc1a_pw"
    $user='SEC\Administrator'
    Connect-MyHost -User $user -IP $ip -Pw $pw
    }
"cl1a" {
    $ip=$cl1_ip
    $pw="$dc1a_pw"
    $user='SEC\Administrator'
    Connect-MyHost -User $user -IP $ip -Pw $pw
    }
"dc1a" {
    $ip=$dc1_ip
    $pw="$dc1a_pw"
    $user='SEC\Administrator'
    Connect-MyHost -User $user -IP $ip -Pw $pw
    }
"srv1a" {
    $ip=$srv1_ip
    $pw="$dc1a_pw"
    $user='SEC\Administrator'
    Connect-MyHost -User $user -IP $ip -Pw $pw
    }
default {
    Write-Output "Please tell me which login you would like."
    }
}


$SERVER = '10.212.143.15'
$USER   = 'Admin'
Set-ItemProperty 'HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds' ConsolePrompting $true
Invoke-Command -Computer $SERVER -Credential (get-credential "$SERVER\$USER") { ls C:\ }
```

