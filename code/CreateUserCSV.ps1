# 100 unique firstnames
$FirstName = @("Eskil","Emma","Ella","Maja","Olivia","Emilie","Sofie","Leah",
               "Sofia","Ingrid","Frida","Sara","Tiril","Selma","Ada","Hedda",
               "Dani","Anna","Alma","Eva","Mia","Thea","Live","Ida","Astrid",
               "Ellinor","Vilde","Linnea","Iben","Aurora","Mathilde","Jenny",
               "Tuva","Julie","Oda","Sigrid","Amanda","Lilly","Hedvig",
               "Victoria","Amelia","Josefine","Agnes","Solveig","Saga","Marie",
               "Eline","Oline","Maria","Hege","Jakob","Emil","Noah","Oliver",
               "Daniel","Eskil","Harald","Liam","Henrik","Oskar","Aksel",
               "Theodor","Elias","Kasper","Magnus","Johannes","Isak","Mathias",
               "Tobias","Olav","Sander","Haakon","Jonas","Ludvig","Benjamin",
               "Matheo","Alfred","Alexander","Victor","Markus","Theo",
               "Mohammad","Herman","Adam","Ulrik","Iver","Sebastian","Johan",
               "Odin","Leon","Nikolai","Even","Leo","Kristian","Mikkel",
               "Gustav","Felix","Sverre","Adrian","Lars"
              )

# 100 unique lastnames
$LastName = @("Pietrzykowski","Sarjomaa","Refsgaard","Raanes","Abu-bakhr","Al-Ani",
              "Nilsen","Kristiansen","Jensen","Karlsen","Johnsen","Pettersen",
              "Eriksen","Berg","Haugen","Hagen","Johannessen","Andreassen",
              "Jacobsen","Dahl","Jørgensen","Henriksen","Lund","Halvorsen",
              "Sørensen","Jakobsen","Moen","Gundersen","Iversen","Strand",
              "Solberg","Svendsen","Eide","Knutsen","Martinsen","Paulsen",
              "Bakken","Kristoffersen","Mathisen","Lie","Amundsen","Nguyen",
              "Rasmussen","Ali","Lunde","Solheim","Berge","Moe","Nygård",
              "Bakke","Kristensen","Fredriksen","Holm","Lien","Hauge",
              "Christensen","Andresen","Nielsen","Knudsen","Evensen","Sæther",
              "Aas","Myhre","Hanssen","Ahmed","Haugland","Thomassen",
              "Sivertsen","Simonsen","Danielsen","Berntsen","Sandvik",
              "Rønning","Arnesen","Antonsen","Næss","Vik","Haug","Ellingsen",
              "Thorsen","Edvardsen","Birkeland","Isaksen","Gulbrandsen","Ruud",
              "Aasen","Strøm","Myklebust","Tangen","Ødegård","Eliassen",
              "Helland","Bøe","Jenssen","Aune","Mikkelsen","Tveit","Brekke",
              "Abrahamsen","Madsen"
             )

    $OrgUnits = @("ou = Supp, ou = IT, ou = AllUsers","ou = ITadmin, ou = IT, ou = AllUsers","ou = Web, ou=Cons, ou=AllUsers",
    "ou = Prog, ou=Cons, ou=AllUsers","ou = Adm, ou = AllUsers", "ou = HR, ou = AllUsers")
    $AnsattStillinger = @("IT-Support","IT-Adminer", "Web-konsulent", "Programutvikling-konsulent", "Adminstrasjon", "HR")
    $antallAnsatte = Read-Host "Hvor mange personer i IT bedriften?"
    $lagdeAnsatte = 0
	Write-Output "UserName;GivenName;SurName;UserPrincipalName;DisplayName;Password;Department;Path" > seccoreusers.csv
while($lagdeAnsatte -lt $antallAnsatte ){
    foreach ($i in 0..5) { # Går gjennom alle stillinger i firmaet og leser inn antall ansatte
        $AntallIStilling = Read-Host "Hvor mange ansatte i" $AnsattStillinger[$i] #Spør hvor mange det skal være i en stilling
        $lagdeAnsatte += $AntallIStilling
    foreach ($j in 0..$AntallIStilling) { # Lager random ansatte for så mange brukeren har inputtet 
        $fn = Get-Random -Minimum -0 -Maximum 100
        $ln = Get-Random -Minimum -0 -Maximum 100 
        $UserName          = $FirstName[$fn].ToLower()
        $GivenName         = $FirstName[$fn]
        $SurName           = $LastName[$ln]
        $UserPrincipalName = $UserName + '@' + 'sec.core'
        $DisplayName       = $GivenName + ' ' + $SurName
        $Password          = -join ('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPRSTUVWXYZ0123456789!"#$%&()*+,-./:<=>?@[\]_{|}'.ToCharArray() | Get-Random -Count 16)
        $Department        = ($OrgUnits[$i] -split '[=,]')[1]
        $Path              = $OrgUnits[$i] + ',' + "dc=SEC,dc=CORE"
        # Legger til brukerinformasjon i new bruker
         Write-Output "$UserName;$GivenName;$SurName;$UserPrincipalName;$DisplayName;$Password;$Department;$Path" >> seccoreusers.csv
        



        }
    }
}

