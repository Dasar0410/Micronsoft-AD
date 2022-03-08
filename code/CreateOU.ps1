# User OUs
New-ADOrganizationalUnit 'AllUsers' -Description 'Containing OUs and users'
New-ADOrganizationalUnit 'IT' -Description 'IT staff'
    -Path 'OU=AllUsers,DC=sec,DC=core'
New-ADOrganizationalUnit 'Cons' -Description 'Consultants'
    -Path 'OU=AllUsers,DC=sec,DC=core'
New-ADOrganizationalUnit 'Adm' -Description 'Administration'
    -Path 'OU=AllUsers,DC=sec,DC=core'
New-ADOrganizationalUnit 'HR' -Description 'Human resources'
    -Path 'OU=AllUsers,DC=sec,DC=core'
New-ADOrganizationalUnit 'Web' -Description 'Web-design'
    -Path 'OU=Cons,OU=AllUsers,DC=sec,DC=core'
New-ADOrganizationalUnit 'Prog' -Description 'Programutvikling'
    -Path 'OU=Cons,OU=AllUsers,DC=sec,DC=core'
New-ADOrganizationalUnit 'Supp' -Description 'Tech support'
    -Path 'OU=IT,OU=AllUsers,DC=sec,DC=core'
New-ADOrganizationalUnit 'ITAdmin' -Description 'IT AD Administrators'
    -Path 'OU=IT,OU=ALLUsers,DC=sec,DC=core'
# Computer OUs
New-ADOrganizationalUnit 'Clients' -Description 'Containing OUs and users laptops'
New-ADOrganizationalUnit 'Servers' -Description 'Containing OUs and servers'
New-ADOrganizationalUnit 'Adm' -Description 'Adm laptops'
    -Path 'OU=Clients,DC=sec,DC=core'
New-ADOrganizationalUnit 'Cons' -Description 'Consultants laptops'
    -Path 'OU=Clients,DC=sec,DC=core'
New-ADOrganizationalUnit 'IT' -Description 'IT computers'
    -Path 'OU=Clients,DC=sec,DC=core'



#Add the computers to the AD.
Get-ADComputer "MGR" | 
  Move-ADObject -TargetPath "OU=Adm,OU=Clients,DC=sec,DC=core"

# Join cl1 and srv1 directly to their correct OU
#
# Manual for Add-Computer states it is smart to use -PassThru:
# "Returns an object representing the item with which you are working. 
# By default, this cmdlet does not generate any output."
#
# CL1
Add-Computer -Credential $cred -DomainName sec.core `
  -OUPath 'OU=Cons,OU=Clients,DC=sec,DC=core' -PassThru -Verbose
# SRV1
Add-Computer -Credential $cred -DomainName sec.core `
  -OUPath 'OU=Servers,DC=sec,DC=core' -PassThru -Verbose
  
# Let's check status, query via dedicated Cmdlet
Get-ADComputer -Filter * |
  Select-Object -Property DNSHostName,DistinguishedName

# Same query via generic LDAP Cmdlet
Get-ADObject -LDAPfilter "(ObjectClass=Computer)" |
  Select-Object -Property DNSHostName,DistinguishedName
# notice missing DNSHostName ! Cmdlet returns a different object  
