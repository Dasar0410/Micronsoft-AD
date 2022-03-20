$OrgUnits = @("ou = Supp, ou = IT, ou = AllUsers, dc=micron, dc=soft","ou = ITadmin, ou = IT, ou = AllUsers, dc=micron, dc=soft","ou = Web, ou=Cons, ou=AllUsers, dc=micron, dc=soft",
        "ou = Prog, ou=Cons, ou=AllUsers, dc=micron, dc=soft","ou = Adm, ou = AllUsers, dc=micron, dc=soft", "ou = HR, ou = AllUsers, dc=micron, dc=soft")
$firstName = Read-Host "Skriv inn fornavn pa bruker du vil flytte"
$lastName = Read-Host "Skriv inn etternavn"
$fullName = $firstName + ' ' + $lastName #legger til mellomrom sa den vil funke med -Filter "Name"
do{ # saa lenge OUvalg er en lovlig verdi
    $OUvalg = Read-Host "Velg OU(0-5): IT-Support[0], IT-Admin[1], Web-konsulent[2], Progutvikler[3], Administrasjon[4], HR[5]"
}while($OUvalg -gt 5 || $OUvalg -lt 0)
#hvis programkjorer har valgt en eksisterende bruker sa blir den flyttet over til valgt OU
Get-ADObject -Filter "Name -like '$fullName'" | Move-ADObject -TargetPath "$OrgUnits[$OUvalg]"
Write-Output "Hvis $fullname eksisterer sa er den flyttet"