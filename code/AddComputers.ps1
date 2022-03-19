# Adds the computers to the AD.

Get-ADComputer "MGR" | Move-ADObject -TargetPath "OU=Adm,OU=Clients,DC=micron,DC=soft"
Get-ADComputer "CL1" | Move-ADObject -TargetPath "OU=Cons,OU=Clients,DC=micron,DC=soft"
Get-ADComputer "SRV1" | Move-ADObject -TargetPath "OU=Servers,DC=micron,DC=soft"