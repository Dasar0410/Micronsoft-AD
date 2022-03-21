.\CreateUserCSV.ps1 #Lager brukere og setter dem i CSV fil
Write-Output "Importerer CSV-fil og legger brukerne inn i AD..." #Mye av koden her er hentet fra https://gitlab.com/erikhje/dcsg1005/-/blob/master/compendia.md#adding-users
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
Write-Output "Brukerne er lagt til AD!"
