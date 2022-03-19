$OrgUnits = @("ou = Supp, ou = IT, ou = AllUsers","ou = ITadmin, ou = IT, ou = AllUsers","ou = Web, ou=Cons, ou=AllUsers",
            "ou = Prog, ou=Cons, ou=AllUsers","ou = Adm, ou = AllUsers", "ou = HR, ou = AllUsers")
Write-Output "UserName;GivenName;SurName;UserPrincipalName;DisplayName;Password;Department;Path" > micronsoftusers.csv
do{ # Denne løkken kjører så lenge brukeren vil legge til en ny bruker
    $firstName = Read-Host "Skriv inn fornavn"
    $lastName = Read-Host "Skriv inn etternavn"
do{ # så lenge OUvalg er en lovlig verdi
    $OUvalg = Read-Host "Velg OU(0-5): IT-Support[0], IT-Admin[1], Web-konsulent[2], Progutvikler[3], Administrasjon[4], HR[5]"
    Write-Output $OUvalg
}while($OUvalg -gt 5 || $OUvalg -lt 0)

Write-Output "Legger til valgt bruker..."
$UserName          = $firstName.ToLower()
$GivenName         = $firstName
$SurName           = $lastName
$UserPrincipalName = $UserName + $Surname + '@' + 'micron.soft' 
$DisplayName       = $GivenName + ' ' + $SurName
$Password          = (-join ('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPRSTUVWXYZ0123456789!"#$%&()*+,-./:<=>?@[\]_{|}'.ToCharArray() | Get-Random -Count 30)) + 'A$' + $uniktTall
$Department        = ($OrgUnits[$OUvalg] -split '[=,]')[1] 
$Path              = $OrgUnits[$OUvalg] + ',' + "dc=micron,dc=soft" #Legger bruker til i valgt OU ved hjelp av i variabelen i loop ovenfor
Write-Output "$UserName;$GivenName;$SurName;$UserPrincipalName;$DisplayName;$Password;$Department;$Path" >> micronsoftusers.csv
$Kjoreponytt = Read-Host "Vil du kjøre igjen (j/N)"
}while($Kjoreponytt -eq 'J')
## Når programkjører er ferdig med å legge til brukere så legges alle brukerne til AD nedenfor
$ADUsers = Import-Csv micronsoftusers.csv -Delimiter ";"
foreach ($User in $ADUsers) {
  New-ADUser `
    -SamAccountName        $User.Username `
    -UserPrincipalName     $User.UserPrincipalName `
    -Name                  $User.DisplayName `
    -GivenName             $User.GivenName `
    -Surname               $User.SurName `
    -Enabled               $True `
    -ChangePasswordAtLogon $False `
    -DisplayName           $user.Displayname `
    -Department            $user.Department `
    -Path                  $user.path `
    -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -Force)
}
Write-Output "Bruker(en/ene) er lagt til i AD!"