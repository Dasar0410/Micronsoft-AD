#Main menu, where all the scripts are run from
#Different ps1 script found in /code/. folder

function Get-Meny
{
	Write-Output " - Create OUs [1]"
	Write-Output " - Import GPO [2]"
	Write-Output " - Create All Users [3]"
	Write-Output " - Create single user [4]"
	Write-Output " - Move user to other OU [5]"
	Write-Output " - Delete one/all users [6]"
}

$svar = 'J'
while($svar -eq 'J')
{
	Get-Meny;
	do{
	$kommando = Read-Host "\nVelg kommando fra meny [1-7]:"
	} while($kommando -lt 1 && $kommando -gt 7)
		$result = switch ( $kommando )
		{
			1 { ./CreateOU.ps1 }
			2 { ./ImportGPOs.ps1 }
			3 { ./CreateUsers.ps1 }
			4 { ./CreateSingleUser.ps1 }
			5 { ./MoveUserToOtherOU.ps1 }
			6 { ./DeleteUsers.ps1 }
		}
	$result
	$svar = Read-Host "\nVil du gjore noe mer [J/N]:"
	Set-Location 'C:\Users\Administrator\HaraldMR-DCSG1005downloadfork*\code'
}