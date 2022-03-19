do{
$valg = Read-Host "Slett en valgt bruker(1) / Slett ALLE brukere(2)"
}while($valg -ne 1 && $valg -ne 2)

if ($valg -eq 1){
$firstName = Read-Host "Fornavn på bruker som skal slettes"
$lastName = Read-Host "Etternavn på bruker som skal slettes"
}
else if($valg -eq 2){
    Write-Host "Sletter ALLE brukere..."
    Get-ADUser -SearchBase "OU=AllUsers, DC=micron, DC=soft" -Filter * | Remove-ADUser -Confirm:$false
    Write-Host "ALLE brukerne er slettet!"
}





