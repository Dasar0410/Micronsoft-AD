# Delete all OUS
get-ADOrganizationalUnit -Identity "OU=AllUsers,DC=micron,DC=soft" |
set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion $false
Remove-ADOrganizationalUnit -Identity "OU=AllUsers,DC=micron,DC=soft" -Recursive

get-ADOrganizationalUnit -Identity "OU=Clients,DC=micron,DC=soft" |
set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion $false
Remove-ADOrganizationalUnit -Identity "OU=Clients,DC=micron,DC=soft" -Recursive

get-ADOrganizationalUnit -Identity "OU=Servers,DC=micron,DC=soft" |
set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion $false
Remove-ADOrganizationalUnit -Identity "OU=Servers,DC=micron,DC=soft" -Recursive