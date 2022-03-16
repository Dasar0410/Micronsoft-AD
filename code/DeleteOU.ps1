# Delete all OUS
get-ADOrganizationalUnit -Identity "OU=AllUsers,DC=sec,DC=core" |
set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion $false
Remove-ADOrganizationalUnit -Identity "OU=AllUsers,DC=sec,DC=core" -Recursive

get-ADOrganizationalUnit -Identity "OU=Clients,DC=sec,DC=core" |
set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion $false
Remove-ADOrganizationalUnit -Identity "OU=Clients,DC=sec,DC=core" -Recursive

get-ADOrganizationalUnit -Identity "OU=Servers,DC=sec,DC=core" |
set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion $false
Remove-ADOrganizationalUnit -Identity "OU=Servers,DC=sec,DC=core" -Recursive