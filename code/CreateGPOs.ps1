$gpoName = Read-Host -Prompt 'GPO name'

Get-GPO -Name $gpoName

$gpoGuid = (Get-GPO -Name $gpoName).Id.ToString()

$domainController = 'DC1'
$domainName = 'sec.core'
$registryPolPath = "\\$domainController\sysvol\$domainName\Policies\{$gpoGuid}\User"
Get-ChildItem -Path $registryPolPath
$regPolPath = Join-Path -Path $registryPolPath -ChildPath 'registry.pol'

Install-Module -Name GPRegistryPolicy

Parse-PolFile -Path $regPolPath #I VANLIG POWERSHELL

# Keypath -->
$regKeyInfo = Parse-PolFile -Path $regPolPath

$comment = Read-Host -Prompt 'Comment for GPO'
New-GPO -Name $gpoName -Comment $comment

$gpRegParams = @{
    Name  = $gpoName
    Key   = "HKCU$($regKeyInfo.KeyName)"
    ValueName = $regKeyInfo.ValueName
    Type  = $regKeyInfo.ValueType
    Value = $regKeyInfo.ValueData
}
Set-GPRegistryValue @gpRegParams


Get-GPRegistryValue -Name $gpoName -Key "HKCU$($regKeyInfo.KeyName)"
#Linker til OU
$ou = 'ALLUSERS'
$domainDn = (Get-ADDomain).DistinguishedName

$ouDN = "OU=$ou,$domainDN"
New-GPLink -Name $gpoName -Target $ouDn -LinkEnabled 'Yes'