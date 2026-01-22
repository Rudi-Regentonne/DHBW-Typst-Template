#import "template-files/template.typ": bericht
#show: bericht.with(
  AbgabeDatum: "32. Nozember 2000",
  Pruefung: "T4_2000",
  Autor: "Rudi Regentonne",
  BetreuerDHBW: "Prof. Dr. Jürgen R.",
  BetreuerFirma: "Andi Mauer",
  Dauer: "560 Stunden",
  FirmenName: "Saftladen GmbH",
  FirmenStadt: "Bielefeld",
  Firmenlogo: image("assets/dhbw-logo.png"),
  MatrikelNummer: "123456789",
  Studiengang: "Informatik / Angewandte Informatik",
  Titel: "Arbeitszeitbetrug",
  Kurs: "TINF2XXBX",
  Sperrvermerk: false,
  Zusammenfassung: include "content/abstract.typ",
  //Was: "Projekt-/Studien-/Bachleorarbeit",
  //Was: "Projektarbeit",
  //Was: "Studienarbeit",
  //Was: "Bachelorarbeit",
  Was: "Praxisbericht",
  acronyms: yaml("abk.yml"),
  bibliography-content: bibliography("bericht.bib"),
)

// Main content
#pagebreak()
= Einleitung
#include "content/einleitung.typ"
#pagebreak()
= Hauptteil
#include "content/hauptteil.typ"
#pagebreak()
= Schluss
#include "content/schluss.typ"

// Appendix

#pagebreak()





= Anhang
//counter(appendix).update(0)
//show: appsec.with(it => counter(appendix).step(it))
#show heading.where(level: 1): set block(above: 1em, below: 1em)
#show heading.where(level: 1): it => [
  #set text(dhbw-blue)
  //counter(appendix).display("A.1")
  #it.body
]

//include "appendixA.typ"

