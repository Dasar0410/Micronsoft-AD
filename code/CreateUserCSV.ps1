# 100 unike fornavn
$FirstName = @("Josefine","Emma","Ella","Maja","Olivia","Emilie","Sofie","Leah",
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

# 100 unike etternavn
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
    # Alle OU-ene lagret i array format for a lett plukke ut riktig OU a sette brukere i.
    $OrgUnits = @("ou = Supp, ou = IT, ou = AllUsers","ou = ITadmin, ou = IT, ou = AllUsers","ou = Web, ou=Cons, ou=AllUsers",
    "ou = Prog, ou=Cons, ou=AllUsers","ou = Adm, ou = AllUsers", "ou = HR, ou = AllUsers")
    # OU-navn i array som outputtes til brukeren
    $AnsattStillinger = @("IT-Support","IT-Adminer", "Web-konsulent", "Programutvikling-konsulent", "Adminstrasjon", "HR")
    $lagdeBrukere = 0 # Brukes for a outputta brukere som forlopig er lagd etter hver OU
    $uniktTall = 0 # Unikt tall som brukes for a sikre at alle brukere har unike brukernavn og UPN
    #Skriver forst formatet til csv filen
	Write-Output "UserName;GivenName;SurName;UserPrincipalName;DisplayName;Password;Department;Path" > micronsoftusers.csv
    foreach ($i in 0..5) { # Gar gjennom alle OU-er i firmaet
            $AntallIStilling = Read-Host "Hvor mange personer i" $AnsattStillinger[$i] #Spor hvor mange brukere som skal lages i navaerende OU
            $lagdeBrukere += $AntallIStilling
            $string = "Du har forelopig tildelt "
            $string += write-Output $lagdeBrukere
            $string += " personer en OU"
            Write-Output $string
            foreach ($j in 1..$AntallIStilling) { # Lager x antall randomiza brukere ettersom hva programkjorer valgte
                $uniktTall++ #plusser pa unike tallet for hver bruker som blir lagd
                $fn = Get-Random -Minimum -0 -Maximum 100 #firstname
                $ln = Get-Random -Minimum -0 -Maximum 100 #lastname
                $UserName          = $FirstName[$fn].ToLower() + $uniktTall
                $GivenName         = $FirstName[$fn]
                $SurName           = $LastName[$ln]
                $UserPrincipalName = $UserName + $Surname + '@' + 'micron.soft'
                $DisplayName       = $GivenName + ' ' + $SurName
                $Password          = (-join ('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPRSTUVWXYZ0123456789!"#$%&()*+,-./:<=>?@[\]_{|}'.ToCharArray() | Get-Random -Count 30)) + 'A$' + $uniktTall
                $Department        = ($OrgUnits[$i] -split '[=,]')[1]
                $Path              = $OrgUnits[$i] + ',' + "dc=micron,dc=soft" #Legger bruker til i valgt OU ved hjelp av i variabelen i loop ovenfor
                #Skriver ut brukeren med all dems data til micronsoftusers.csv
                Write-Output "$UserName;$GivenName;$SurName;$UserPrincipalName;$DisplayName;$Password;$Department;$Path" >> micronsoftusers.csv
            }
    }