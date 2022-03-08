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