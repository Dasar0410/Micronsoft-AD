# Adds the computers to the AD.




# !! This script is not yet complete !!



# MGR
Get-ADComputer "MGR" | 
    Move-ADObject -TargetPath "OU=Adm,OU=Clients,DC=sec,DC=core"

# Get-ADComputer "CL1" | 
#    Move-ADObject -TargetPath "OU=Cons,OU=Clients,DC=sec,DC=core"

# CL1
# Add-Computer -Credential $cred -DomainName sec.core `
#    -OUPath 'OU=Cons,OU=Clients,DC=sec,DC=core' -PassThru -Verbose
# SRV1
# Add-Computer -Credential $cred -DomainName sec.core `
#    -OUPath 'OU=Servers,DC=sec,DC=core' -PassThru -Verbose
