# Deletes all users from AD structure.
get-ADOrganizationalUnit -Identity "OU=AllUsers,DC=sec,DC=core" |
  set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion $false
  Remove-ADOrganizationalUnit -Identity "OU=AllUsers,DC=sec,DC=core" -Recursive