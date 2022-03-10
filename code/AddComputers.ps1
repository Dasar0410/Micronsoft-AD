# Adds the computers to the AD.
# CL1 and SRV1 must currently be added to the AD from respective computers.

# MGR
Get-ADComputer "MGR" | Move-ADObject -TargetPath "OU=Adm,OU=Clients,DC=sec,DC=core"

# CL1
Add-Computer -Credential $cred -DomainName sec.core -OUPath 'OU=Cons,OU=Clients,DC=sec,DC=core' -PassThru -Verbose
# SRV1
Add-Computer -Credential $cred -DomainName sec.core -OUPath 'OU=Servers,DC=sec,DC=core' -PassThru -Verbose