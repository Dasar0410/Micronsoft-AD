<p align="center">
  <img 
    width="1000"
    height="300"
    src="img/MicronsoftLogo.png"
  >
</p>


## Innholdsfortegnelse

- [Introduksjon](#introduksjon)
- [Gruppe Medlemmer](#gruppe-medlemmer)
- [Domene Model](#domene-model)
- [Problemer](#problemer)
- [Organisasjonskart](#organisasjons-kart)


## Introduksjon

Målet med oppgaven var å sette opp en Active Directory for en bedrift. Selskapet vi skal sette op AD for er `Micronsoft` som er et ny oppstartet IT/ konsulent firma. De har avdelinger innenfor IT, konsultasjon, administrasjon og HR. 

## Gruppe-Medlemmer

- Daniel Sarjomaa
- Harald Martin Raanes
- Eskil Lykke Refsgaard

## Domene-modell

**`Modellen for OU`**

![](img/ModelAllusers.png "Modellen for AllUsers")

```
micron.soft
└── AllUsers
    ├── Adm
    |── Cons
    │   ├── Prog
    │   └── Web
    └── HR
    └── IT
        └── ITAdmin
        └── Supp
```

## Organisasjons-kart
![](img/OrganizationChart.png "Dette er organisasjonskartet vårt")

## Utfordringer

- *`PSSession`*  
    - PSSession brukes for å remote koble seg til andre enheter. Planen vår var å bruke dette for å joine de ulike enhetene sammen i Active Directory remotely. Problemet vi møtte på, var at vi først måtte enable remote connection via et script på hver enhet vi ønsket å koble sammen først.

    >> New-ItemProperty -Name LocalAccountTokenFilterPolicy `
    >> -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System `
    >> -PropertyType DWord -Value 1
    >> Enable-PsRemoting -Force

    -  Dette gjorde at det ikke lenger var hensiktmessig å bruke denne metoden for raskest/mest effektivt oppsett for Active Directory. Dermed så valgte vi at det ikke var nødvendig å bruke PSSession for dette prosjektet
    - Et annet problem vi støtte på som var relatert til PSsession var å kunne utføre kommandoer i computeren som hosten var kobla til. I noen av tilfellene opplevde vi at noen av kommandoene ikke ble utført på den tilkoblede sin datamaskin, men heller ens egen. Vi har ikke funnet noen god løsning på dette og valgte derfor ikke å kjøre scripts remotely på andre enheter. 
- *`OUs`* 
    - Litt problemer med å få slette alle OUene. Fant til slutt komandoen på [Microsoft.docs](https://docs.microsoft.com/en-us/powershell/module/activedirectory/remove-adorganizationalunit?view=windowsserver2022-ps) for å slette OUer sammen med brukerne som befant seg i disse

- *`Installer av pwsh, git, sysinternals`*
    - Planen var å ha et script liggende i [Github.gist](https://gist.github.com/Datakriger101/2aeece14caa9bd022a1587b91b73bfa4) og kjøre dette fra vårt [menuscript.ps1](menuScript.ps1)
    bruke dette aktivt for å laste ned de ulike applikasjonen/ programmene samt repoet som er nødvendige for å sette opp Active Directory for *Micronsoft*. Første problem ble at når et repo skal clones ned på dc1 via scriptet, blir man spurt om en "access token". Vi bestemte oss derfor å clone repoet manuelt.
    - Et annet problem vi hadde med dette var aliaset [iex](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-expression?view=powershell-7.2), eller InvokeExpression kommandoen. Dette fikk vi problemer med i script analyzer. 
    - Vi løste begge problemene ved å heller laste ned repoet som en zip fil og starte *menuScriptet.ps1* hvor alle scriptene kjøres fra. Da er det ikke bruk for access token og InvokeExpression blir heller ikke noe problem gjennom Pipelinen. 

- *`Script Analyzer`*
    - Vi har hatt litt problemer med å forstå flere av error meldingene som har oppstått når vi har pushet kode. Vi kunne se i pipelinen som ble kjørt at det var en god del unødvendige whitespaces som vi fjernet relativt fort.
    - **PSUseBOMForUnicodeEncodedFile** var et annet script analyzer problem vi fikk. Dette er et problem som omhandler hvordan [Powershell bruker kryptering av tegn](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_character_encoding?view=powershell-7.2) for input og output av string data. Problemet ble løst når vi endret "encodingen" fra *UTF-8* til *UTF-8 with BOM*. Problemet kunne også løses ved å fjerne alle ÆØÅ tegn siden disse bokstavene var årsaken til problemet. Da endret vi mye av kommenteringa i koden vår til å heller bruke "o for ø", "a for å" og "ae for æ"

    - I menu scriptet vårt hadde vi en **InvokeExpression** kommando som Script Analyzer ikke ville godta. Vi brukte kommandoen for å laste ned noen applikasjoner fra [Github.gist](https://gist.github.com/Datakriger101/2aeece14caa9bd022a1587b91b73bfa4). Disse vil dermed bare bli lagt til når koden kjøres. Det var dette vi ønsket å laste ned via **InvokeExpression** kommandoen. Løsningen ble bare å kjøre den manuelt.
    - PSAvoidUsingConvertToSecureStringWithPlainText er en error som vi bare eksluderer i pipelinen. Finnes under [Editor](https://gitlab.stud.idi.ntnu.no/daniepsa/dcsg-1005-prosjekt/-/ci/editor?branch_name=main) i Pipeline fanen.

- *`GPO`* 
    - GPO var noe gruppen var litt usikker på når vi startet på prosjektet, så vi bestemte oss for å finne en god løsning når vi hadde fått det andre grunnleggende på plass. Da vi først startet hadde vi planlagt å bare laste ned noen (grunnleggende/ standard) GPOer og editere de slik at de passer våre OUer. Dette fungerte ikke. Løsnigen ble her å manuelt lage egene GPOer som skulle lastes ned for domenet.
    - Microsoft sin Security Baseline var en løsning vi vurderte. Problemet var at vi her ikke hadde muligheten til å endre GPOene slik vi ville, spcripps som fulgte med i baseline toolkitet ble brukt, ettersom disse hjalp mye med å få importert en stor mengde GPOer fra en backup. Vi fikk hjelp av faren til Harald Martin med å få en bedre forståelse for hvordan oppsettet med GPOer fungerer, ettersom at han erfaring innenfor dette temaet 
    - Til slutt ble det laget omtrent 20 ulike gpoer som endret en policy per object. F.eks vil Adm. Bakgrunnen bare sette bakgrunnen for administrasjons brukere, ikke noe mer. Alle disse ble det gjort en backup av og lastet opp i git repoet slik at man kunne enkelt hente de ved hjelp av GPO scripts.
    - Et siste problem her var at det var problematisk å sjekke om ulike GPOer overskrev hverandre, feks hadde vi flere GPOer som var satt til alle brukerene som feks hindret brukeren i å bruke kontrollpanelet. Dette ville vært upopulært for IT brukere, så vi har en IT GPO som skrur av denne funksjonen. Om IT brukerene fikk all users GPOen eller ikke var vanskelig å se. Men ved å flytte brukere litt rundt så var det mulig å logge inn på feks admin brukeren på CL1 etter å ha flyttet brukeren til IT gruppen, og sjekke om den hadde tilgang til kontroll panelet.

- *`UPN - The operation failed because UPN value provided for addition/modification is not unique forest-wide.`*
    - [UPN](https://www.codetwo.com/kb/upn/) står for "User Principal Name" og error meldingen vi fikk angående denne variabelen var i forhold til [CreateUsers.ps1](https://gitlab.stud.idi.ntnu.no/daniepsa/dcsg-1005-prosjekt/-/blob/main/code/CreateUsers.ps1) scriptet. Når vi prøvde å lage en bruker så var det flere bruker som fikk samme fornavn og dette førte til UPN-en til flere brukere var helt like og det førte til at brukeren ikke ble lagd som var et stort problem og førte til stor forskjell fra antall brukere som egentlig skulle bli lagd, spesielt hvis programkjorer lager store bedrifter på f.eks 500 brukere. Grunnen til at ikke-unike UPN verdier var så høy var hovedsakelig fordi formatet på UPN verdien var Fornavn@micron.soft.
    - Løsningen vi kom med var å endre formatet på UPN verdien til "FornavnEtternavn(unikt tall)@micron.soft". Det å legge til etternavn i jobb mailen(UPN) ville redusere så og si alt av ikke-unike UPN verdier men hvis to folk skulle ha akkurat samme fornavn og etternavn så måtte vi innføre en til variabel. Da kom vi fram til at et unikt tall som er unikt for hver eneste bruker var den beste løsningen. Dette unike tallet blir økt med en per bruker som legges til så derfor vil f.eks første brukeren lagret i [micronsoftusers.csv](https://gitlab.stud.idi.ntnu.no/daniepsa/dcsg-1005-prosjekt/-/blob/main/code/micronsoftusers.CSV) ha 1 som unik verdi mens bruker nr.50 på lista vil ha det unike nummeret 50.

- *`Password - The password does not meet the length, complexity, or history requirement of the domain.`*
    - Erroren ovenfor er en error som virker ganske simpel å løse pga. at erroren er veldig beskrivende men løsningen var ikke så simpel som en skulle tro. Denne erroren oppsto når [CreateUsers.ps1](https://gitlab.stud.idi.ntnu.no/daniepsa/dcsg-1005-prosjekt/-/blob/main/code/CreateUsers.ps1) skulle legge til brukerne med hver deres personlige passord til Active directorien. Det som gjorde det veldig vanskelig å feilsøke denne erroren er at den bare skjedde omtrent 1/3 av gangene man opprettet brukere litt avhengende av hvor mange man lagde. 
    - Passordet består av 30 tilfeldige tegn plukket ut fra ett array av tegn med alle lower case og upper case bokstaver, tall og spesielle tegn. Problemet tror vi da oppsto når disse tilfeldige trukket tegna ikke oppfylte alle minimums krava til passord. Dette kunne f.eks skje hvis alle tegna i ett passord bare var tall og bokstaver men ingen spesialtegn fordi ett passord må ha minst 1 spesialtegn, 1 upper case bokstav og minst 1 tall. Derfor hvis en av disse kriteriene ikke ble oppfylt så ville passordet være ugyldig
    - Løsningen for dette problemet var å legge til en sluttdel på hvert passord som besto av ett spesialtegn, en stor bokstav og ett tall. passord formatet ble da slik: (generert passord + stor bokstav + spesialtegn + unikt tall)

## Copyright

[Micronsoft.com](https://www.microsoft.com/nb-no/) :)
