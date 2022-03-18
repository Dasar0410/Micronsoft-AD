#Funksjon som lar en logge seg inn på en annen host som har joinet AD
#De 2 hostene må først enable for PSremoting, (gjøes når cl1 og mgr jointer AD)
#Follow guide in RemoteConnection.md

$svar = Read-Host "Vil du joine cl1(1) eller mgr(2)"

if($svar -eq 1){ Enter-PSSession cl1 }
elseif ($svar -eq 2){ Enter-PSSession mgr }
else{Write-Output "Tilkoblingen fungerte ikke"}