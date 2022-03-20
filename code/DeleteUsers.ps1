do{
$valg = Read-Host "Slett en valgt bruker(1) / Slett ALLE brukere(2)"
}while($valg -lt 1 || $valg -gt 2)

if ($valg -eq 1){ # Hvis en bruker skal slettes
    $firstName = Read-Host "Fornavn paa bruker som skal slettes"
    $lastName = Read-Host "Etternavn paa bruker som skal slettes"
    $fullName = $firstName + ' ' + $lastName
    Get-ADUser -Filter "Name -like '$fullName'" | Remove-ADUser -Confirm:$false #spor ikke om konfirmasjon
    Write-Output "Hvis bruker $fullname eksisterer saa er den naa slettet"
}
else {# Hvis alle brukere skal slettes
    Write-Output "Sletter ALLE brukere..."
    Get-ADUser -SearchBase "OU=AllUsers, DC=micron, DC=soft" -Filter * | Remove-ADUser -Confirm #spor om konfirmasjon
    Write-Output "ALLE brukerne er slettet!"
}