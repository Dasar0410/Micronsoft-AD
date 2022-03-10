function Get-Version {
    $PSVersionTable.PSVersion
}

function Get-Meny
{
	Write-Output "\n\n"
	Write-Output " - Create OUs (1)"
	Write-Output " - Delete all Users (2)"
	Write-Output " - Font Change (3)"
	Write-Output " - Connect to other hosts (4)"
	Write-Output " - Download Powershell Core, Sys and Git (5)"
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
    		5 { Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Datakriger101/PS_scripts/main/startup.ps1')) }
    		default { write-output "nothing happens"}
	}

	$result 
	$svar = Read-Host "\nVil du gjøre noe mer (J/n):"
}


#https://raw.githubusercontent.com/Datakriger101/PS_scripts/main/startup.ps1

#iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Datakriger101/PS_scripts/main/startup.ps1'))
