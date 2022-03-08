function Get-Version {
    $PSVersionTable.PSVersion
}

function Get-Meny
{
	echo "\n\n"
	echo " - Create OUs (1)"
	echo " - Delete all Users (2)"
	echo " - Font Change (3)"
	echo " - Connect to other hosts (4)"
}

$svar = 'J'

while($svar -eq 'J')
{

	Get-Meny;	
	$kommando = Read-Host "Hvilket nummer vil du gjøre:"
	
	$result = switch ( $kommando )
	{
    		1 { ./CreateOU.ps1 }
    		2 { ./deleteAllUsers.ps1 }
    		3 { ./fontChange.ps1 }
    		4 { write-output "Under progress" }
    		default { write-output "nothing happens"}
	}

	$result 
	$svar = Read-Host "\nVil du gjøre noe mer (J/n):"
}
