do{
$valg = Read-Host "Slett en valgt bruker(1) / Slett ALLE brukere(2)"
}while($valg -ne 1 && $valg -ne 2)

if ($valg -eq 1){ # Hvis en bruker skal slettes
    $firstName = Read-Host "Fornavn på bruker som skal slettes"
    $lastName = Read-Host "Etternavn på bruker som skal slettes"
    $fullName = $firstName + ' ' + $lastName
    Get-ADUser -Filter "Name -like '$fullName'" | Remove-ADUser -Confirm:$false #spør ikke om konfirmasjon
    Write-Output "Hvis bruker $fullname eksisterer så er den naa slettet"
    
}
else if($valg -eq 2){# Hvis alle brukere skal slettes
    Write-Output "Sletter ALLE brukere..."
    Get-ADUser -SearchBase "OU=AllUsers, DC=micron, DC=soft" -Filter * | Remove-ADUser -Confirm #spør om konfirmasjon
    Write-Output "ALLE brukerne er slettet!"
}





