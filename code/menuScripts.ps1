#Main menu, where all the scripts are run from
#Different ps1 script found in /code/. folder

function Get-Meny
{
	Write-Output "\n\n"
	Write-Output " - Create OUs (1)"
	Write-Output " - Create  All Users(2)"
	Write-Output " - Delete All Users (3)"
	Write-Output " - Connect to other hosts (4)"
	Write-Output " - Apply GPO(under progress)(5)"
	Write-Output " - Download Powershell Core, Sys and Git (6)"
}

$svar = 'J'

while($svar -eq 'J')
{

	Get-Meny;
	do{
	$kommando = Read-Host "Hvilken opsjon velger du (1-6):"
	} while($kommando -lt 0 || $kommando -gt 6)
	$result = switch ( $kommando )
	{
    		1 { ./CreateOU.ps1 }
			2 { ./CreateUsers.ps1 }
			3 { ./CreateSingleUser.ps1 }
    		4 { ./deleteAllUsers.ps1 }
    		5 { ./ConnectPSSession.ps1 }
    		6 { ./ImportGPOs.ps1 }
    		default { write-output "nothing happens"}
	}

	$result
	$svar = Read-Host "\nVil du gjøre noe mer (J/n):"
}