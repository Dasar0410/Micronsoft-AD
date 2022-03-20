#Main menu, where all the scripts are run from
#Different ps1 script found in /code/. folder

function Get-Meny
{
	Write-Output " - Create OUs (1)"
	Write-Output " - Create All Users(2)"
	Write-Output " - Create single user (3)"
	Write-Output " - Move user to other OU (4)"
	Write-Output " - Delete one/all users (5)"
	Write-Output " - Connect to other hosts (6)"
	Write-Output " - Apply GPO(under progress)(7)"
	#Write-Output " - Download Powershell Core, Sys and Git (6)"
}

$svar = 'J'
while($svar -eq 'J')
{
	Get-Meny;
	do{
	$kommando = Read-Host "Hvilken opsjon velger du (1-7):"
	} while($kommando -lt 1 || $kommando -gt 7)
	$result = switch ( $kommando )
	{
    		1 { ./CreateOU.ps1 }
			2 { ./CreateUsers.ps1 }
			3 { ./CreateSingleUser.ps1 }
			4 { ./MoveUserToOtherOU.ps1}
    		5 { ./DeleteUsers.ps1 }
    		6 { ./ConnectPSSession.ps1 }
    		7 { ./ImportGPOs.ps1 }
	}
	$result
	$svar = Read-Host "\nVil du gjore noe mer (J/n):"
	Set-Location 'C:\Users\Administrator\HaraldMR-DCSG1005downloadfork*\code'
}