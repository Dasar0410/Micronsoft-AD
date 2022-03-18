# Adds all OUs to AD
# User OUs
New-ADOrganizationalUnit 'AllUsers' -Description 'Containing OUs and users'
New-ADOrganizationalUnit 'IT' -Description 'IT staff' -Path 'OU=AllUsers,DC=micron,DC=soft'
New-ADOrganizationalUnit 'Cons' -Description 'Consultants' -Path 'OU=AllUsers,DC=micron,DC=soft'
New-ADOrganizationalUnit 'Adm' -Description 'Administration' -Path 'OU=AllUsers,DC=micron,DC=soft'
New-ADOrganizationalUnit 'HR' -Description 'Human resources' -Path 'OU=AllUsers,DC=micron,DC=soft'
New-ADOrganizationalUnit 'Web' -Description 'Web-design' -Path 'OU=Cons,OU=AllUsers,DC=micron,DC=soft'
New-ADOrganizationalUnit 'Prog' -Description 'Programutvikling' -Path 'OU=Cons,OU=AllUsers,DC=micron,DC=soft'
New-ADOrganizationalUnit 'Supp' -Description 'Tech support' -Path 'OU=IT,OU=AllUsers,DC=micron,DC=soft'
New-ADOrganizationalUnit 'ITAdmin' -Description 'IT AD Administrators' -Path 'OU=IT,OU=ALLUsers,DC=micron,DC=soft'

# Computer OUs
New-ADOrganizationalUnit 'Clients' -Description 'Containing OUs and users laptops'
New-ADOrganizationalUnit 'Servers' -Description 'Containing OUs and servers'
New-ADOrganizationalUnit 'Adm' -Description 'Adm laptops' -Path 'OU=Clients,DC=micron,DC=soft'
New-ADOrganizationalUnit 'Cons' -Description 'Consultants laptops' -Path 'OU=Clients,DC=micron,DC=soft'
New-ADOrganizationalUnit 'IT' -Description 'IT computers' -Path 'OU=Clients,DC=micron,DC=soft'