.\CreateUserCSV.ps1
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
