<p align="center">
  <img 
    width="1000"
    height="300"
    src="https://i.imgur.com/cJRUMM3.png"
  >
</p>


## Innholdsfortegnelse

- [Introduksjon](#introduksjon)
- [Gruppe Medlemmer](#gruppe-medlemmer)
- [Domene Model](#domene-model)
- [Problemer](#problemer)
- [Organisasjonskart](#organisasjons-kart)


## Introduksjon

Målet med oppgaven var å sette opp en Active Directory for en bedrift. Selskapet vi skal sette op AD for er `Micronsoft` som er et ny oppstartet IT/ konsulent firma. De har avdelinger innenfor IT, konsultasjon, og Tech Support. 

## Gruppe-Medlemmer

- Daniel Sarjomaa
- Harald Martin Raanes
- Eskil Lykke Refsgaard

## Domene-modell

**`Modellen for OU`**

![Imgur](https://i.imgur.com/syYaqh0.png)

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
![Imgur](https://i.imgur.com/MQnpXEX.png)

## Utfordringer

- *`PSSession`*  
    - PSSesion brukes for å remote koble seg til andre enheter. Planen vår var å bruke dette for å joine de ulike enhetene sammen i Active Directory remote. Problemet vi møtte var at vi først måtte på hver enhet vi ønsket å koble sammen først måtte enable for remote connection via et script.

    >> New-ItemProperty -Name LocalAccountTokenFilterPolicy `
    >> -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System `
    >> -PropertyType DWord -Value 1
    >> Enable-PsRemoting -Force

    -  Dette gjorde at det ikke legner var hensiktmessig å bruke denne metode for raskest/ mest effektivt oppsett for Active Directory. Vi endte dermed å ha muligheten for å koble oss til de enhetene som er lagt til Micronsoft sitt AD, men vil ikke bli brukt til å.
    - Et Annet problem relatert til PSSEssion var å kunne få utførst kommandoer i hosten som var connected til. I noen av tilfelle opplevde vi at noen av kommandoen ikke ble utført på den tilkoblede sin datamaskin, men heller ens egen. Vi har ikke funnet noen god løsning på dette og valgte derfor ikke å gjøre noe remote via script på andre enheter. 
- *`OUs`* 
    - Litt problemer med å få slette alle OUene. Fant til slutt komandoen på [Microsoft.docs](https://docs.microsoft.com/en-us/powershell/module/activedirectory/remove-adorganizationalunit?view=windowsserver2022-ps) for å slette OUer sammen med brukerne som befant seg i disse

- *`Installer av pwsh, git, sysinternals`*
    - Planen var å ha et script liggende i [Github.gist](https://gist.github.com/Datakriger101/2aeece14caa9bd022a1587b91b73bfa4) og kjøre dette fra vårt [menuscript.ps1](menuScript.ps1)
    bruke dette aktivt for å laste ned de ulike applikasjonen/ programmene samt repoet som er nødvendige for å sette opp Active Directory for *Micronsoft*. Første problem ble at når et repo skal clones ned på dc1 via scriptet, blir man spurt om en "access token". Vi bestemte oss derfor å clone repoet manuelt.
    - Et annet problem vi hadde med dette var alieset [iex](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-expression?view=powershell-7.2), eller InvokeExpression kommandoen. Dette vi fikk vi problemer med i script analyzer. 
    - Via løste begge problemene ved å heller laste ned repoet som en zip fil og starte *menuScriptet.ps1* hvor alle scriptene kjøres fra. Da er det ikke bruk for noen access token og InvokeExpression vil ikke bli noe problem gjennom Pipelinen. 

- *`Script Analyzer`*
    - Vi har hatt litt problemer med å forstå flere av error meldingene som har oppstått når vi har pushet kode. Vi kunne se i pipelinen som ble kjørt at det var en god del steder unødvendige whitespaces som vi fjernet relativt fort.
    - **PSUseBOMForUnicodeEncodedFile** var en anne error meldingen vi fikk. Dette er en error som omhandler hvordan [Powershell bruker kryptering av tegn](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_character_encoding?view=powershell-7.2) for input og output av string data. Problemet ble løst når vi endret "encodingen" fra *UTF-8* til *UTF-8 with BOM*.
    - I menu scriptet vårt hadde vi en **InvokeExpression** kommando som Script Analyzer ikke ville godta. Vi brukte kommandoen for å laste ned noen applikasjoner fra [Github.gist](https://gist.github.com/Datakriger101/2aeece14caa9bd022a1587b91b73bfa4). Disse vil dermed bare bli lagt til når koden kjøres. Det var dette vi ønsket å laste ned via **InvokeExpression** kommandoen. Løsningen ble bare å kjøre den manuelt.
    - PSAvoidUsingConvertToSecureStringWithPlainText er en error som vi bare eksluderer i pipelinen. Finnes under [Editor](https://gitlab.stud.idi.ntnu.no/daniepsa/dcsg-1005-prosjekt/-/ci/editor?branch_name=main) i Pipeline fanen.

- *`GPO`* 
    - GPO var noe gruppen var litt usikker på når vi startet på prosjektet, så vi bestemte oss for å finne en god løsning når vi hadde fått det andre grunnleggende på plass. Da vi først startet hadde vi planlagt å bare laste ned noen (grunnleggende/ standard) GPOer og editere de slik at de passer våre OUer. Dette fungerte ikke. Løsnigen ble her å manuelt lage egene GPOer som skulle lastes ned for domenet.
    - Microsoft sin Security Baseline var en vi vurdert. Problemet var at vi her ikke hadde muligheten til å endre GPOene slik vi ville, spcritps som fulgte med i baseline toolkitet ble brukt, ettersom disse hjalp mye med å få importert en stor mengde GPOer fra en backup. Vi fikk her help av faren til Harald Martin med å få en bedre forståelse for hvordan oppsettet med GPOer fungerer. 
    - Til slutt ble det laget omtrent 20 ulike gpoer som gjorde en ting per object. Feks vil Adm Bakrunn bare sette bakrunn for administrasjons brukere, ikke noe mer. Alle disse ble det gjort en backup av og lastet opp i git repoet slik at man kunne enkelt hente de ved hjelp av GPO scripts.
    - Et siste problem her var at det var problematisk å sjekke om ulike GPOer overskrev hverandre, feks hadde vi flere GPOer som var satt til alle brukerene som feks hindret brukeren i å bruke controllpanelet. Dette ville vært upopulært for IT brukere, så vi har en IT GPO som skruv av denne funksjonen. Om IT brukerene fikk all users GPOen eller ikke var vanskelig å se. Men ved å flytte brukere litt rundt så var det mulig å logge inn på feks admin brukeren på CL1 etter å ha flyttet brukeren til IT gruppen, og sjekke om den hadde tilgang til controll panelet.

- *`UPN - The operation end because UPN value not uniqe`*
    - [UPN](https://www.codetwo.com/kb/upn/) står for "User Principal Name" og er en error melding som oppstår når brukernavnene i systemet ikke er unike. I vår sammenheng er det mailen som er problemet. Det er ikke alltid slik. 
    - Løsningen vi kom med var å legge hver mail på formatet "FornvavnEtternavn(et tall)@micron.soft". Tallet på slutten er med for å gjøre det mulig å skille den fra hverandre. Scriptet vi har gjør det mulig å opprette så mange brukere vi ønsker og legge dem inn for det allerede eksiterende OUene. VI bestemmer også antall for hvor mange som skal inn i hver OU. 


## Copyright

[Micronsoft.com](https://www.microsoft.com/nb-no/) :)
