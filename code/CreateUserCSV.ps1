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
              "Jacobsen","Dahl","Jorgensen","Henriksen","Lund","Halvorsen",
              "Sorensen","Jakobsen","Moen","Gundersen","Iversen","Strand",
              "Solberg","Svendsen","Eide","Knutsen","Martinsen","Paulsen",
              "Bakken","Kristoffersen","Mathisen","Lie","Amundsen","Nguyen",
              "Rasmussen","Ali","Lunde","Solheim","Berge","Moe","Nygaard",
              "Bakke","Kristensen","Fredriksen","Holm","Lien","Hauge",
              "Christensen","Andresen","Nielsen","Knudsen","Evensen","Saather",
              "Aas","Myhre","Hanssen","Ahmed","Haugland","Thomassen",
              "Sivertsen","Simonsen","Danielsen","Berntsen","Sandvik",
              "Ronning","Arnesen","Antonsen","Nass","Vik","Haug","Ellingsen",
              "Thorsen","Edvardsen","Birkeland","Isaksen","Gulbrandsen","Ruud",
              "Aasen","Strom","Myklebust","Tangen","Odegaard","Eliassen",
              "Helland","Boe","Jenssen","Aune","Mikkelsen","Tveit","Brekke",
              "Abrahamsen","Madsen"
             )

    $OrgUnits = @("ou = Supp, ou = IT, ou = AllUsers","ou = ITadmin, ou = IT, ou = AllUsers","ou = Web, ou=Cons, ou=AllUsers",
    "ou = Prog, ou=Cons, ou=AllUsers","ou = Adm, ou = AllUsers", "ou = HR, ou = AllUsers")
    $AnsattStillinger = @("IT-Support","IT-Adminer", "Web-konsulent", "Programutvikling-konsulent", "Adminstrasjon", "HR")
    $antallAnsatte = Read-Host "Hvor mange personer i IT bedriften?"
    $lagdeAnsatte = 0
    $uniktTall = 0
	Write-Output "UserName;GivenName;SurName;UserPrincipalName;DisplayName;Password;Department;Path" > micronsoftusers.csv
    foreach ($i in 0..5) { # Gar gjennom alle stillinger i firmaet og leser inn antall ansatte
        if ($lagdeAnsatte -lt $antallAnsatte ){
            $AntallIStilling = Read-Host "Hvor mange personer i" $AnsattStillinger[$i] #Spor hvor mange det skal vare i en stilling
            $lagdeAnsatte += $AntallIStilling
            $string = "Du har forelopig tildelt "
            $string += write-Output $lagdeAnsatte
            $string += " personer en OU"
            write-Output $string
            foreach ($j in 1..$AntallIStilling) { # Lager random ansatte for sa mange brukeren har inputtet
                $uniktTall++
                $fn = Get-Random -Minimum -0 -Maximum 100
                $ln = Get-Random -Minimum -0 -Maximum 100
                $UserName          = $FirstName[$fn].ToLower() + $uniktTall
                $GivenName         = $FirstName[$fn]
                $SurName           = $LastName[$ln]
                $UserPrincipalName = $UserName + $Surname + $uniktTall + '@' + 'micron.soft'
                $DisplayName       = $GivenName + ' ' + $SurName
                $Password          = -join ('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPRSTUVWXYZ0123456789!"#$%&()*+,-./:<=>?@[\]_{|}'.ToCharArray() | Get-Random -Count 20)
                $Department        = ($OrgUnits[$i] -split '[=,]')[1]
                $Path              = $OrgUnits[$i] + ',' + "dc=micron,dc=soft"
                # Legger til brukerinformasjon i new bruker

                Write-Output "$UserName;$GivenName;$SurName;$UserPrincipalName;$DisplayName;$Password;$Department;$Path" >> micronsoftusers.csv
            }
        }
    } # Problem:: Det blir lagt en ekstra bruker inn i hver OU. dett skal ikke skje. fisk daniel


