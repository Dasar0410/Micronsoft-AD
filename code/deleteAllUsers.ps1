#Script that ONLY removes all the user

Get-ADUser -SearchBase "OU=AllUsers,DC=sec,DC=core" -Filter * | Remove-ADUser -Confirm:$false -Verbose