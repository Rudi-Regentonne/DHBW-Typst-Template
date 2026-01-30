#import "@preview/acrostiche:0.7.0": *
#import "@local/turbocharged-dhbw:0.1.0": code


= Konfiguration der Vorlage (Main-Funktion)

Die Vorlage wird über die Funktion `bericht` konfiguriert. Hier ist eine Übersicht aller Parameter, die an die Funktion übergeben werden können:

== Persönliche und formale Daten
- `Autor`: Der vollständige Name des Verfassers (Content).
- `MatrikelNummer`: Die Matrikelnummer zur eindeutigen Identifikation (String/Content).
- `Kurs`: Die Kursbezeichnung (z. B. "TINF22B1").
- `Studiengang`: Der Name des Studiengangs (z. B. "Informatik").

== Projektspezifische Daten
- `Titel`: Das Thema der Arbeit, erscheint groß auf dem Deckblatt.
- `Was`: Die Art der Arbeit (z. B. "Praxisbericht", "Bachelorarbeit").
- `Pruefung`: Die Modulbezeichnung oder Prüfungsnummer (z. B. "T3_2000").
- `AbgabeDatum`: Das Datum der Einreichung.
- `Dauer`: Der Bearbeitungszeitraum (z. B. "12 Wochen" oder "560 Stunden").

== Unternehmensdaten
- `FirmenName`: Name des Ausbildungsbetriebs.
- `FirmenStadt`: Standort des Betriebs (wird für die Erklärung benötigt).
- `Firmenlogo`: Das Logo der Firma. Einbindung via `image("pfad/zu/logo.png")`.
- `BetreuerFirma`: Name des Ansprechpartners im Betrieb.
- `BetreuerDHBW`: Name des betreuenden Dozenten oder Gutachters der DHBW.

== Dokumentensteuerung
- `Sperrvermerk`: Ein boolescher Wert (`true` oder `false`). Bei `true` wird automatisch ein Sperrvermerk in die Erklärung eingefügt.
- `Zusammenfassung`: Der Inhalt des Abstracts. Am besten via `include "content/abstract.typ"` einbinden.
- `acronyms`: Ein Dictionary oder eine YAML-Datei (`yaml("abk.yml")`) mit Abkürzungen für das automatische Verzeichnis.
- `bibliography-content`: Die Literaturquelle, eingebunden über die `bibliography()`-Funktion.

== Beispiel für den Aufruf
Ein typischer Aufruf in der `main.typ` sieht wie folgt aus:

#code(firstnumber: 1, stepnumber: 1, numbers: true, caption: "Beispielaufruf")[```typst
#import "@local/turbocharged-dhbw:0.1.0" : bericht

#show: bericht.with(
  Autor: "Rudi Regentonne",
  Titel: "Analyse des Kaffeeverbrauchs im Homeoffice",
  Studiengang: "Angewandte Praktikantenwissenschaften",
  Firmenlogo: image("assets/firma-logo.png"),
  Sperrvermerk: true,
  Zusammenfassung: include "content/abstract.typ",
  acronyms: yaml("abk.yml"),
)
```]

= Nutzung der sonstigen Befehle

== Abkürzungen

- ```typst #init-acronyms(dict)```: Initialisiert die Abkürzungen.
- ```typst #acr(key)``` (oder ```typst #ac```): Zeigt Abkürzung an (beim ersten Mal voll, danach kurz).
- ```typst #acrpl(key)``` (oder ```typst #acp```): Plural-Version von ```typst #acr```.
- ```typst #acrcap(key)```: Wie ```typst #acr```, aber Definition wird großgeschrieben.
- ```typst #acrfull(key)``` (oder ```typst #acf```): Zeigt immer die Langform.
- ```typst #acs(key)```: Zeigt immer nur die Kurzform.
- ```typst #acl(key)```: Zeigt nur die Definition (Langform) an.
- ```typst #print-index()```: Erzeugt das Abkürzungsverzeichnis.
- ```typst #reset-all-acronyms()```: Setzt alle Abkürzungen zurück.
- ```typst #acused(key)```: Markiert Abkürzung als "verwendet", ohne Text zu drucken.

== Zitieren
Geht mit ```typst @bibname``` oder mit ```typst #cite(<bibname>)```@


== Codeblöcke
Inline kann mit einfachen Backticks eingebunden werden ``` `Inlinecode` ```.
#box[

  Für Codeblöcke kann entweder ````typst ```Sprache code``` ```` oder ````typst
    #import "@local/turbocharged-dhbw:0.1.0": code
    #code(
      firstnumber: 1,
      stepnumber: 1,
      numbers: true,
      caption: "lustiger Rust code",
      highlight: ( 2, 4),
    )[```rust
    fn main() {
      let semester_planung = vec![None; 3]; // Drei Jahre voller Leere
      let klausur_status = "abgegeben".repeat(100);
      let korrektur_dauer = std::time::Duration::from_secs(u64::MAX);
    }
    ```]
  ````

]

#box[

  Heraus kommt dann:
  #code(
    firstnumber: 1,
    stepnumber: 1,
    numbers: true,
    caption: "lustiger Rust code",
    highlight: (2, 4),
  )[```rust
  fn main() {
    let semester_planung = vec![None; 3]; // Drei Jahre voller Leere
    let klausur_status = "abgegeben".repeat(100);
    let korrektur_dauer = std::time::Duration::from_secs(u64::MAX);
  }
  ```]
]


== Formeln
```typst $1 + 1$ ```gibt eine inline Formel: $1 + 1$.
Um eine Formel zu schreiben, die auch im Formelverzeichnis auftaucht wird dieser Syntax verwendet:
̀```typst
#figure(
  $ y = m dot x + c $,
  kind: math.equation,
)
```
Das Ergebnis:
#figure(
  $ y = m dot x + c $,
  kind: math.equation,
)

== Abbildungen

Bilder werden so eingefügt:
```typst
#figure(
  image("../assets/dhbw-logo.png", width: 40%),
  caption: [
    Hilfe was sehe ich hier
  ],
)
```

#figure(
  image("../assets/dhbw-logo.png", width: 40%),
  caption: [
    Hilfe was sehe ich hier
  ],
)
#box[

  == Tabellen
  Tabellen, die auch im Tabellenverzeichnis landen sollen, werden so erstellt:
  ```typst
  #figure(
    table(
      columns: (1fr, 1fr),
      fill: (col, row) => if row == 0 { maroon.lighten(80%) },
      [*Vorgang*], [*Status*],
      [Korrektur], [Wie bitte?],
      [Moodle], [Wartungsarbeiten],
      [Dualis-Server], [Glasfaser angebaggert],
      [Digitaltechnik Klausur], [geschrieben (1998)],
      [Exmatrikulation], [ausgefüllt],
    ),
    caption: [DHBW-Betriebszustände],
  )
  ```
]
#figure(
  table(
    columns: (1fr, 1fr),
    fill: (col, row) => if row == 0 { maroon.lighten(80%) },
    [*Vorgang*], [*Status*],
    [Korrektur], [Wie bitte?],
    [Moodle], [Wartungsarbeiten],
    [Dualis-Server], [Glasfaser angebaggert],
    [Digitaltechnik Klausur], [geschrieben (1998)],
    [Exmatrikulation], [ausgefüllt],
  ),
  caption: [DHBW-Betriebszustände],
)




