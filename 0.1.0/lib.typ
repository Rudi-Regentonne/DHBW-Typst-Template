#import "template-files/listings-lib.typ": code
#import "template-files/header.typ": running-header
#import "template-files/titlepage.typ": titlepage
#import "template-files/verzeichnisse.typ": verzeichnisse
#let bericht(
  Autor: [Autor],
  Pruefung: none,
  Titel: [Titel],
  Studiengang: [Studiengang],
  AbgabeDatum: none,
  Dauer: none,
  MatrikelNummer: none,
  Kurs: none,
  FirmenName: none,
  Stadt: none,
  BetreuerFirma: none,
  BetreuerDHBW: none,
  Was: [Was],
  Sperrvermerk: true,
  SperrvermerkText: none,
  Zusammenfassung: none,
  Firmenlogo: none,
  acronyms: (),
  Hochschullogo: none,
  Hochschule: none,
  Erklaerung: true,
  ErklaerungText: none,
  ErklaerungTitel: none,
  bibliography-content: none,
  Deckblatt: none,
  body,
) = {
  import "@preview/acrostiche:0.7.0": *

  if acronyms.len() > 0 {
    init-acronyms(acronyms)
  }

  set page(
    paper: "a4",
    margin: (x: 1.8cm, top: 2.5cm, bottom: 2cm),
    header: running-header(),
  )
  set text(
    font: "New Computer Modern",
    size: 12pt,
  )
  set par(
    justify: true,
    spacing: 1em,
    leading: 0.8em,
  )
  set text(lang: "de")

  // Gender-inclusive language: No line break at gender sign
  show ":innen": ":\u{2060}innen"
  show ":in": ":\u{2060}in"
  show "*innen": "*\u{2060}innen"
  show "*in": "*\u{2060}in"
  show "_innen": "_\u{2060}innen"
  show "_in": "_\u{2060}in"
  show "/-innen": "\u{2060}/-\u{2060}innen"
  show "/-in": "\u{2060}/-\u{2060}in"

  set math.equation(numbering: "(1)")
  set figure(numbering: "1")

  titlepage(
    Titel: Titel,
    Was: Was,
    Studiengang: Studiengang,
    Pruefung: Pruefung,
    Hochschule: Hochschule,
    Autor: Autor,
    AbgabeDatum: AbgabeDatum,
    Dauer: Dauer,
    MatrikelNummer: MatrikelNummer,
    Kurs: Kurs,
    FirmenName: FirmenName,
    Stadt: Stadt,
    BetreuerFirma: BetreuerFirma,
    BetreuerDHBW: BetreuerDHBW,
    Firmenlogo: Firmenlogo,
    Hochschullogo: Hochschullogo,
    Deckblatt: Deckblatt,
  )

  // Declaration
  import "template-files/erklaerung.typ": erklaerung

  erklaerung(
    Autor: Autor,
    FirmenStadt: Stadt,
    Sperrvermerk: Sperrvermerk,
    SperrvermerkText: SperrvermerkText,
    ErklaerungText: ErklaerungText,
    ErklaerungTitel: ErklaerungTitel,
    Erklaerung: Erklaerung,
  )

  verzeichnisse(
    body,
    Zusammenfassung: Zusammenfassung,
    bibliography-content: bibliography-content,
    acronyms: acronyms,
  )
}

#let small-todo = (..args) => {
  import "@preview/dashy-todo:0.1.3": todo
  text(size: 0.8em)[#todo(..args)]
}
