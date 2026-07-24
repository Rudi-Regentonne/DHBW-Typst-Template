#import "@local/turbocharged-dhbw:0.2.0": report
#show: report.with(
  submission-date: "32. Nozember 2000",
  module: "T4_2000",
  author: "Rudi Regentonne",
  //university-supervisor: "Prof. Dr. Jürgen R.",
  company-supervisor: "Andi Mauer",
  duration: "560 Stunden",
  company-name: "Saftladen GmbH",
  city: "Bielefeld",
  company-logo: image("assets/dhbw-logo.png"),
  student-id: "123456789",
  program: "Informatik / Angewandte Informatik",
  title: "Arbeitszeitbetrug",
  course: "TINF2XXBX",
  confidential: false,
  abstract-content: include "content/abstract.typ",
  //document-type: "Projekt-/Studien-/Bachelorarbeit",
  //document-type: "Projektarbeit",
  //document-type: "Studienarbeit",
  //document-type: "Bachelorarbeit",
  document-type: "Praxisbericht",
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

#include "content/anhang.typ"
