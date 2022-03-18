# Adds the computers to the AD.
# CL1 and SRV1 must currently be added to the AD from respective computers.

# MGR
Get-ADComputer "MGR" | Move-ADObject -TargetPath "OU=Adm,OU=Clients,DC=micron,DC=soft"

# CL1
Add-Computer -Credential $cred -DomainName micron.soft -OUPath "OU=Cons,OU=Clients,DC=micron,DC=soft" -PassThru -Verbose
# SRV1
Add-Computer -Credential $cred -DomainName micron.soft -OUPath 'OU=Servers,DC=micron,DC=soft' -PassThru -Verbose