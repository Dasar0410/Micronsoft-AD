function Get-Version {
    $PSVersionTable.PSVersion
}

function Get-Meny
{
	echo "\n\n"
	echo " - Lage OUer (1)"
	echo " - Slette OUer (2)"
	echo " - Connecte til andre hosts (3)"
}

$svar = 'J'

while($svar -eq 'J')
{

	Get-Meny;	
	$kommando = Read-Host "Hvilket nummer vil du gjøre:"
	
	$result = switch ( $kommando )
	{
    		1 { 'Sunday'    }
    		2 { 'Monday'    }
    		3 { ./another.ps1   }
    		default { echo "nothing happens"}
	}

	$result 
	$svar = Read-Host "\nVil du gjøre noe mer (J/n):"
}
