#import "@preview/acrostiche:0.7.0": *
#import "@local/turbocharged-dhbw:0.2.0": code, small-todo


= Konfiguration der Vorlage (Main-Funktion)

Die Vorlage wird über die Funktion `report` in der `main.typ` konfiguriert. Hier ist eine Übersicht aller Parameter, die an die Funktion übergeben werden können:

== Persönliche und formale Daten
- `author`: Der vollständige Name des Verfassers (Content).
- `student-id`: Die Matrikelnummer zur eindeutigen Identifikation (String/Content).
- `course`: Die Kursbezeichnung (z. B. "TINF22B1").
- `program`: Der Name des Studiengangs (z. B. "Informatik").
- `city`: Standort des Betriebs.
  - Wird genutzt für den Betriebsstandort und gegebenenfalls in der Erklärung sonst Optional

== Projektspezifische Daten
- `title`: Das Thema der Arbeit, erscheint groß auf dem Deckblatt.
- `document-type`: Die Art der Arbeit (z. B. "Praxisbericht", "Bachelorarbeit").
- `module`: Die Modulbezeichnung oder Prüfungsnummer (Optional).
- `submission-date`: Das Datum der Einreichung (Optional).
- `duration`: Der Bearbeitungszeitraum (Optional).

== Unternehmensdaten
- `company-name`: Name des Ausbildungsbetriebs (Optional).
- `company-logo`: Das Logo der Firma. Einbindung via `image("pfad/zu/logo.png")` (Optional).
- `company-supervisor`: Name des Ansprechpartners im Betrieb (Optional).
- `university-supervisor`: Name des betreuenden Dozenten oder Gutachters (Optional).

== Hochschuldaten
- `university`: Name der Hochschule. Falls nicht gesetzt, wird "Duale Hochschule Baden-Württemberg Karlsruhe" verwendet.
- `university-logo`: Das Logo der Hochschule. Einbindung via `image("pfad/zu/logo.png")`. Falls nicht gesetzt, wird das Standard-DHBW-Logo verwendet.

== Dokumentensteuerung
- `confidential`: Soll ein Sperrvermerk eingefügt werden (Optional).
- `confidential-text`: Eigener Text für den Sperrvermerk (Optional).
- `show-declaration`: Soll eine Erklärung eingefügt werden (Optional).
- `declaration-title`: Eigener Titel für die Erklärung (Optional).
- `declaration-text`: Eigener Text für die Erklärung (Optional).
- `abstract-content`: Der Inhalt des Abstracts. Am besten via `include "content/abstract.typ"` einbinden (Optional).
- `acronyms`: Ein Dictionary oder eine YAML-Datei (`yaml("abk.yml")`) mit Abkürzungen für das automatische Verzeichnis (Optional).
- `bibliography-content`: Die Literaturquelle, eingebunden über die `bibliography()`-Funktion (Optional).
- `cover-page`: Überschreibt das Deckblatt mit eigenem Content Am besten via `include "filename.typ"` (Optional).
- `lang`: Sprache des Dokuments, `"de"` (Standard) oder `"en"` (Optional).

== Beispiel für den Aufruf
Ein typischer Aufruf in der `main.typ` sieht wie folgt aus:

#code(firstnumber: 1, stepnumber: 1, numbers: true, caption: "Beispielaufruf", highlight: (3, 10))[```typst
#show: report.with(
author: "Rudi Regentonne",
title: "Analyse des Kaffeeverbrauchs im Homeoffice",
program: "Angewandte Informatik",
company-logo: image("assets/firma-logo.png"),
confidential: true,
abstract-content: include "content/abstract.typ",
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

== Offene Punkte markieren

- ```typst #small-todo(..args)```: Zeigt eine Markierung für offene/zu klärende Stellen im Text an. Nimmt dieselben Argumente wie `todo` aus dem Paket `@preview/dashy-todo` entgegen, rendert sie aber kleiner (0.8em).

Beispiel: #small-todo[Quelle für diese Aussage ergänzen]

== Codeblöcke
Inline kann mit einfachen Backticks eingebunden werden ``` `Inlinecode` ```.
#box[

  Für Codeblöcke kann entweder ````typst ```Sprache code``` ```` oder ````typst
    #import "../template-files/listings-lib.typ": code
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
#code(caption: "Formel im Formelverzeichnis")[```typst
#figure(
  $ y = m dot x + c $,
  kind: math.equation,
)
```]
Das Ergebnis:
#figure(
  $ y = m dot x + c $,
  kind: math.equation,
)

== Abbildungen

Bilder werden so eingefügt:
#code(caption: "Bild einfügen")[```typst
#figure(
  image("../assets/dhbw-logo.png", width: 40%),
  caption: [
    Hilfe was sehe ich hier
  ],
)
```]

#figure(
  image("../assets/dhbw-logo.png", width: 40%),
  caption: [
    Hilfe was sehe ich hier
  ],
)
#box[

  == Tabellen

  Alle Tabellen im Fließtext (`body`) werden automatisch im Booktabs-Stil formatiert: die erste Zeile wird fett gesetzt, seitliche/innere Linien entfernt, und nur eine Linie über der ersten sowie unter der letzten Zeile gezeichnet. Eigene `stroke`- oder `align`-Angaben in der eigenen `table()`-Definition werden dadurch überschrieben; nur `columns` und `fill` bleiben wirksam. Das Deckblatt und die Erklärung sind von dieser automatischen Formatierung ausgenommen.

  Tabellen, die auch im Tabellenverzeichnis landen sollen, werden so erstellt:
  #code(caption: "Tabelle im Tabellenverzeichnis")[```typst
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
  ```]
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

#pagebreak()

= Template Configuration (Main Function)

The template is configured via the `report` function in `main.typ`. Here is an overview of all parameters that can be passed to the function:

== Personal and Formal Data
- `author`: The full name of the author (content).
- `student-id`: The student ID for unique identification (string/content).
- `course`: The course designation (e.g. "TINF22B1").
- `program`: The name of the degree program (e.g. "Computer Science").
- `city`: Location of the company.
  - Used for the company location and, where applicable, in the declaration; otherwise optional.

== Project-Specific Data
- `title`: The topic of the thesis, displayed prominently on the title page.
- `document-type`: The type of thesis (e.g. "Project Report", "Bachelor's Thesis").
- `module`: The module designation or exam number (optional).
- `submission-date`: The submission date (optional).
- `duration`: The processing period (optional).

== Company Data
- `company-name`: Name of the training company (optional).
- `company-logo`: The company logo. Included via `image("path/to/logo.png")` (optional).
- `company-supervisor`: Name of the contact person at the company (optional).
- `university-supervisor`: Name of the supervising professor or reviewer (optional).

== University Data
- `university`: Name of the university. If not set, "Duale Hochschule Baden-Württemberg Karlsruhe" is used.
- `university-logo`: The university logo. Included via `image("path/to/logo.png")`. If not set, the default DHBW logo is used.

== Document Control
- `confidential`: Whether a confidentiality notice should be inserted (optional).
- `confidential-text`: Custom text for the confidentiality notice (optional).
- `show-declaration`: Whether a declaration of authorship should be inserted (optional).
- `declaration-title`: Custom title for the declaration (optional).
- `declaration-text`: Custom text for the declaration (optional).
- `abstract-content`: The content of the abstract. Best included via `include "content/abstract.typ"` (optional).
- `acronyms`: A dictionary or a YAML file (`yaml("abk.yml")`) with acronyms for the automatic list of abbreviations (optional).
- `bibliography-content`: The bibliography source, included via the `bibliography()` function (optional).
- `cover-page`: Overrides the title page with custom content, best included via `include "filename.typ"` (optional).
- `lang`: Document language, `"de"` (default) or `"en"` (optional).

== Example Call
A typical call in `main.typ` looks like this:

#code(firstnumber: 1, stepnumber: 1, numbers: true, caption: "Example call", highlight: (3, 10))[```typst
#show: report.with(
lang: "en",
author: "Rudi Regentonne",
title: "Coffee Consumption Analysis in the Home Office",
program: "Applied Computer Science",
company-logo: image("assets/company-logo.png"),
confidential: true,
abstract-content: include "content/abstract.typ",
acronyms: yaml("abk.yml"),
)
```]

= Using Other Commands

== Acronyms

- ```typst #init-acronyms(dict)```: Initializes the acronyms.
- ```typst #acr(key)``` (or ```typst #ac```): Displays the acronym (full on first use, short afterwards).
- ```typst #acrpl(key)``` (or ```typst #acp```): Plural version of ```typst #acr```.
- ```typst #acrcap(key)```: Like ```typst #acr```, but the definition is capitalized.
- ```typst #acrfull(key)``` (or ```typst #acf```): Always shows the long form.
- ```typst #acs(key)```: Always shows only the short form.
- ```typst #acl(key)```: Shows only the definition (long form).
- ```typst #print-index()```: Generates the list of abbreviations.
- ```typst #reset-all-acronyms()```: Resets all acronyms.
- ```typst #acused(key)```: Marks the acronym as "used" without printing any text.

== Citing
Works with ```typst @bibname``` or with ```typst #cite(<bibname>)```.

== Marking Open Items

- ```typst #small-todo(..args)```: Displays a marker for open/unclear passages in the text. Takes the same arguments as `todo` from the `@preview/dashy-todo` package, but renders them smaller (0.8em).

Example: #small-todo[Add a source for this claim]

== Code Blocks
Inline code can be included with simple backticks ``` `inline code` ```.
#box[

  For code blocks, either ````typst ```language code``` ```` or ````typst
    #import "../template-files/listings-lib.typ": code
    #code(
      firstnumber: 1,
      stepnumber: 1,
      numbers: true,
      caption: "fun Rust code",
      highlight: ( 2, 4),
    )[```rust
    fn main() {
      let semester_planning = vec![None; 3]; // Three years full of emptiness
      let exam_status = "submitted".repeat(100);
      let grading_duration = std::time::Duration::from_secs(u64::MAX);
    }
    ```]
  ````

]

#box[

  This is what comes out:
  #code(
    firstnumber: 1,
    stepnumber: 1,
    numbers: true,
    caption: "fun Rust code",
    highlight: (2, 4),
  )[```rust
  fn main() {
    let semester_planning = vec![None; 3]; // Three years full of emptiness
    let exam_status = "submitted".repeat(100);
    let grading_duration = std::time::Duration::from_secs(u64::MAX);
  }
  ```]
]


== Formulas
```typst $1 + 1$ ```gives an inline formula: $1 + 1$.
To write a formula that also appears in the list of equations, use this syntax:
#code(caption: "Formula in the list of equations")[```typst
#figure(
  $ y = m dot x + c $,
  kind: math.equation,
)
```]
The result:
#figure(
  $ y = m dot x + c $,
  kind: math.equation,
)

== Figures

Images are inserted like this:
#code(caption: "Inserting an image")[```typst
#figure(
  image("../assets/dhbw-logo.png", width: 40%),
  caption: [
    Help, what am I looking at
  ],
)
```]

#figure(
  image("../assets/dhbw-logo.png", width: 40%),
  caption: [
    Help, what am I looking at
  ],
)
#box[

  == Tables

  All tables in the running text (`body`) are automatically formatted in booktabs style: the first row is set bold, side/inner rules are removed, and only one rule above the first and below the last row is drawn. Custom `stroke` or `align` settings in your own `table()` definition are overridden as a result; only `columns` and `fill` remain effective. The title page and the declaration are exempt from this automatic formatting.

  Tables that should also appear in the list of tables are created like this:
  #code(caption: "Table in the list of tables")[```typst
  #figure(
    table(
      columns: (1fr, 1fr),
      fill: (col, row) => if row == 0 { maroon.lighten(80%) },
      [*Process*], [*Status*],
      [Grading], [Come again?],
      [Moodle], [Under maintenance],
      [Dualis server], [Fiber cable dug up],
      [Digital Electronics exam], [Written (1998)],
      [Deregistration form], [Filled out],
    ),
    caption: [DHBW operating states],
  )
  ```]
]
#figure(
  table(
    columns: (1fr, 1fr),
    fill: (col, row) => if row == 0 { maroon.lighten(80%) },
    [*Process*], [*Status*],
    [Grading], [Come again?],
    [Moodle], [Under maintenance],
    [Dualis server], [Fiber cable dug up],
    [Digital Electronics exam], [Written (1998)],
    [Deregistration form], [Filled out],
  ),
  caption: [DHBW operating states],
)


