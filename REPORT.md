<p align="center">
  <img 
    width="500"
    height="300"
    src="https://i.imgur.com/f6A8rsb.png"
  >
</p>


## Innholdsfortegnelse

- [Introduksjon](#introduksjon)
- [Gruppe Medlemmer](#gruppe-medlemmer)
- [Domene Model](#domene-model)
- [Problemer](#problemer)


## Introduksjon

Målet med oppgaven var å sette opp en Active Directory for en bedrift. Selskapet vi skal sette op AD for er `Micronsoft` som er et ny oppstartet IT/ konsulent firma. De har avdelinger innenfor IT, konsultasjon, og Tech Support. 

## Gruppe-Medlemmer

- Daniel Sarjomaa
- Harald Martin Raanes
- Eskil Lykke Refsgaard

## Domene-model

`Domene modellen vår`

```
MICRON
└── SOFT
    ├── OU = IT
    │   ├── surname = hard
    │   └── name = mrtn
    └── OU = 
        ├── I
        └── D
        └── K
```

## Problemer

- *`PSSession`*  
    - PSSesion brukes for å remote koble seg til andre enheter. Planen vår var å bruke dette for å joine de ulike "computers" sammen i Active Directory. Problemet vi møtte var at vi først måtte på hver enhet vi ønsket å koble sammen, først måtte enable for remote connection. Dette gjorde at det ikke legner var hensiktmessig å bruke denne metode for raskest/ mest effektivt oppsett for Active Directory. Vi endte dermed å ha muligheten for å koble oss til de "computeres" som er lagt til Micronsoft sitt AD, men vil ikke bli brukt til å 
    - Et Annet problem relatert til PSSEssion var å kunne få utførst kommandoer i hosten som var connected til. I noen av tilfelle opplevde vi at noen av kommandoen ikke ble utført på den tilkoblede sin datamaskin, men heller sin egen. Vi har ikke funnet noen god løsning på dette.
- *`OUs`* 
    - Litt problemer med å få slette alle OUene. Fant til slutt komandoen på [Microsoft.docs]()https://docs.microsoft.com/en-us/powershell/module/activedirectory/remove-adorganizationalunit?view=windowsserver2022-ps for å slette OUer samt.

- *`Script Analyzer`*
    - Vi har hatt litt problemer med å forstå flere av error meldingene som har oppstått når vi har pushet kode. Vi kunne se i pipelinen som ble kjørt at det var en god del steder unødvendige whitespaces som vi fjernet relativt fort
    - **PSUseBOMForUnicodeEncodedFile** var en anne error meldingen vi fikk. Dette er en error som omhandler hvordan [Powershell bruker kryptering av tegn](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_character_encoding?view=powershell-7.2) for input og output av string data. Problemet ble løst når vi endret "encodingen" fra *UTF-8* til *UTF-8 with BOM*.
    - I menu scriptet vårt hadde vi en **InvokeExpression** kommando som Script Analyzer ikke ville godta. Vi brukte kommandoen for å laste ned noen applikasjoner fra [Github.gist](https://gist.github.com/Datakriger101/2aeece14caa9bd022a1587b91b73bfa4). Disse vil dermed bare bli lagt til når koden kjøres. Det var dette vi ønsket å laste ned via **InvokeExpression** kommandoen. Løsningen ble bare å kjøre den manuelt. 

- *`GPO`* 
    - Trodde det var mulig å finne GPO som kunne blir edita og lastet ned - vanskelig
    - Scriptene fungerte ikke
    - Matche alle domene navn og OUer
    - Fant en løsning, men var en paid for service
    - Implemenetere Security Baseline fra Microsoft, kan ikke endre GPO som vi ville

- *`UPN - The operation end because UPN value not uniqe`*

## Copyright

[Micronsoft.com](https://www.microsoft.com/nb-no/) :)
