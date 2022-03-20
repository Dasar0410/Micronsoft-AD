
# DCSG1005-Minutes

### Tittel: Minutes Dokument
### Team: Rånes M, Sarjomaa D, Refsgaard E
---


### Meeting nr. 1 
### Dato: `08.03.2022`, Varighet: `7 timer`, Lokasjon: `Atriet`
### *Agenda:*
- Fordele arbeidsoppgaver
- Roller
- Avtale arbeidsmengde
- Mål for karakter

### `Hva vi gjorde:`
1. Planlegge hvordan infrastrukturen skulle se ut (se vedlegg: domain model)
2. Kontroll på at alle har tilgang til Git repoet
3. Arbeid - scripts
    - Create OUs.
    - Meny
    - Delete OUs
    - Change font (ekstra) 

### `Plan for videre arbeid:`
- *Daniel:* 
    >Script for å legge til brukere - more advanced?
- *Eskil:* 
    >Prøve å finne en god måte i bevege seg mellom hostene i AD via CLI (PSSession).  
    >Jobbe med en installer link for pwsh, sysinterals, git
- *Harald:* 
    >Script for å lage OU  

---
### Meeting nr. 2 
### Dato: `10.03.2022`,  Varighet : `7 timer`, Lokasjon: `Atriet`
#### *Agenda:*
- Fungerer alt som det skal?
- Problemer
    - PSSession vil mest sannsynlig gjøre at programmet tar lengre tid å sette opp.
    - 
- Fordele ut nye arbeidsoppgaver

### `Hva vi gjorde:`
1. Arbeid - scripts
    - Legge comuters til AD - script
    - fix: startup installer
    - Legget til rikitg path for AD structure (OU)
    - Slette alle brukere
2. Snakket om hvordan vi ønsker å implementere GPOer


### *Plan for videre arbeid:*
- *Daniel:* 
    >Jobbe videre med å legge til brukere
- *Eskil:* 
    >Remote Connection  
    >Starte å skrive på REPORT.md
- *Harald:* 
    >Script, Secuity Baseline GPO

---
### Meeting nr. 3 
### Dato: `15.03.2022`,  Varighet : `7 timer`, Lokasjon: `Atriet`
#### *Agenda:*
- Ble arbeidsoppgavene fullført?
- Fordele ut nye arbeidsoppgaver

### `Hva vi gjorde:`
1. Arbeid - scripts
    - Importere MSFT Security Baseline to GPO
    - Velge hvor mange brukere man ønsker å legge til hver OU
    - Skrive på REPORT.md
    - Se på error meldingene vi får via Script Analyzer


### *Plan for videre arbeid:*
- *Daniel:* 
    >Se på script analyzer, rare error meldinger
- *Eskil:* 
    >Slette AllUsers
- *Harald:* 
    >Jobbe videre med GPO, bra oppsett

### Meeting nr. 4 
### Dato: `16.03.2022`,  Varighet : `4 timer`, Lokasjon: `Grupperom Topas`
#### *Agenda:*
- Hva er prioritet før innlevering?
- Ble arbeidsoppgavene fullført?
- Fordele ut nye arbeidsoppgaver

### `Hva vi gjorde:`

1. Planlegge videre arbeid
2. Arbeid - scripts
    - Fix: Opprette alle brukere

### *Plan for videre arbeid:*
- *Daniel:* 
    >Skrive på REPORT.md  
    >Se på script analyzer
- *Eskil:* 
    >Skrive mere på REPORT.md  
    >Se på script analyzer
- *Harald:* 
    >GPO  
    >Skrive på REPORT.md


### Meeting nr. 5 
### Dato: `18.03.2022`,  Varighet : `4 timer`, Lokasjon: `Atriet`
#### *Agenda:*
- Ble arbeidsoppgavene fullført?
- Fordele ut nye arbeidsoppgaver
- Hva trenger å gjøres før innleveringsfristen? 

### `Hva vi gjorde:`

1. Planlegge hva som som gjøres
2. Skrive på REPORT.md
3. Mulighet for å slette GPOer script
4. Feilrettinger ved opprettelse av brukere
5. Fikse alle feil rettet mot script analyzer

### Meeting nr. 6
### Dato: `20.03.2022`,  Varighet : `4 timer`, Lokasjon: `Discord`
#### *Agenda:*
- Siste feilrettinger
- Skrive på rapport
- Spille inn video

### `Hva vi gjorde:`
1. Siste feilrettinger
2. Retter opp i warnings fra pipeline
3. REPORT.md
4. Spille inn video

## Roller
**Daniel:** Leder, programmerer.
**Harald:** Programmerer, research.
**Eskil:** Programmerer. Dokumentasjon.