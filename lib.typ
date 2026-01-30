#import "template-files/listings-lib.typ": code
#let bericht(
  Autor: [Autor],
  Pruefung: [Pruefung],
  Titel: [Titel],
  Studiengang: [Studiengang],
  AbgabeDatum: none,
  Dauer: none,
  MatrikelNummer: none,
  Kurs: none,
  FirmenName: none,
  FirmenStadt: none,
  BetreuerFirma: none,
  BetreuerDHBW: none,
  Was: [Was],
  Sperrvermerk: true,
  Zusammenfassung: none,
  Firmenlogo: none,
  acronyms: (),
  bibliography-content: none,
  body,
) = {
  import "@preview/hydra:0.6.2": hydra
  import "@preview/acrostiche:0.7.0": *


  if acronyms.len() > 0 {
    init-acronyms(acronyms)
  }


  let shrink_to_fit(content, max-width, base: 12pt, min-size: 8pt) = {
    let natural = measure(text(size: base, content)).width
    layout(size => {
      let limit = if type(max-width) == length { max-width } else { size.width }
      let scale = if natural > 0pt { calc.min(1.0, limit / natural) } else { 1.0 }

      let new-size = calc.max(min-size, base * scale)

      text(size: new-size, weight: "regular")[#content]
    })
  }
  set page(
    paper: "a4",
    margin: (x: 1.8cm, y: 1.5cm),
    header: context {
      let headings = query(selector(heading).after(here()))
      if (counter(page).get().first() > 2 and headings.len() > 0) {
        if headings.first().level >= 2 or headings.first().location().page() != here().page() {
          grid(
            columns: (auto, 1fr),
            gutter: 1em,
            context (align(left, [#hydra(1) ])), context (align(right, shrink_to_fit(hydra(2), 1fr))),
          )
          line(length: 100%)
        }
      }
    },
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

  set math.equation(numbering: "(1)")
  set figure(numbering: "1")
  // Title page

  grid(
    columns: (1fr, 1fr),

    [
      #align(left)[
        #if Firmenlogo != none {
          Firmenlogo
        }
      ]
    ],
    [
      #align(right)[
        #image("template/assets/dhbw-logo.png", width: 4cm)
      ]
    ],
  )

  align(center, [
    #text(24pt, weight: "bold", Titel)
    #v(1cm)
    #smallcaps(text(24pt, Was))
    #v(1cm)

    #text(16pt)[
      für das Modul
      #v(0.5cm)
      #Pruefung
      #v(0.5cm)
      des Studienganges #Studiengang
      #v(0.5cm)
      an der
      #v(0.5cm)
      Dualen Hochschule Baden-Württemberg Karlsruhe
    ]
    #v(0.5cm)
    #text(16pt)[von]
    #v(0.5cm)
    #text(16pt, weight: "bold")[#Autor]
    #v(1cm)
    #if AbgabeDatum != none {
      text(14pt)[Abgabedatum #AbgabeDatum]
    }
  ])
  v(1fr)


  let rows = (
    ("Bearbeitungszeitraum", Dauer),
    ("Matrikelnummer", MatrikelNummer),
    ("Kurs", Kurs),
    ("Ausbildungsfirma", FirmenName),
    ("", FirmenStadt),
    ("Betreuer der Ausbildungsfirma", BetreuerFirma),
    ("Gutachter der Studienakademie", BetreuerDHBW),
  ).filter(it => it.at(1) != none)
  table(
    columns: (50%, 50%),

    align: (left, left),

    stroke: 0pt + gray,

    inset: 6pt,
    // Zellinnenabstand
    ..rows.flatten().map(it => [#it]),
  )

  // Declaration
  pagebreak()
  import "template-files/erklaerung.typ": erklaerung
  erklaerung(Autor: Autor, FirmenStadt: FirmenStadt, Sperrvermerk: Sperrvermerk)


  set page(numbering: "I")
  // Abstract
  if Zusammenfassung != none {
    pagebreak()
    Zusammenfassung
  }


  // Table of Contents
  pagebreak()
  set heading(numbering: "1.1")
  //Headings level
  show heading.where(
    level: 1,
  ): it => {
    set align(left)
    set text(20pt)
    set par(justify: true, leading: 1em, spacing: 1.5em)
    let chapter_prefix_content = ""
    if it.numbering != none {
      v(1em)
      text(20pt)[Kapitel #counter(heading).get().first()]
      v(1em)
    } else {
      v(0.5em)
    }


    it.body

    v(0.8em)
  }
  // Headings level 2
  show heading.where(
    level: 2,
  ): it => block(width: 100%)[
    #set align(left)
    #set text(16pt)
    #set par(justify: true, leading: 1em, spacing: 1.5em)
    #v(0.5em)
    #it
    #v(0.8em)
  ]
  // Headings level 3
  show heading.where(
    level: 3,
  ): it => block(width: 100%)[
    #set align(left)
    #set text(14pt)
    #set par(justify: true, leading: 1em, spacing: 1.5em)
    #v(0.5em)
    #it
    #v(0.8em)
  ]

  show outline.entry.where(level: 1): it => {
    v(1.2em, weak: true)


    text(stroke: 0.25pt, link(it.element.location(), it.indented(
      it.prefix(),
      {
        it.body()
        h(1fr)
        it.page()
      },
    )))
  }
  outline()
  // reset styles
  show outline.entry: it => link(
    it.element.location(),
    it.indented(it.prefix(), it.inner()),
  )


  context {
    // List of figures
    show outline.entry.where(
      level: 1,
    ): set text(weight: "regular")
    let figures = query(figure.where(kind: image))
    if figures.len() > 0 {
      pagebreak()
      outline(
        title: text()[Abbildungsverzeichnis],
        target: figure.where(kind: image),
      )
    }
    // List of acronyms


    if (acronyms != none and acronyms.len() > 0) {
      pagebreak()


      print-index(
        row-gutter: 1em,
        title: heading(level: 1, numbering: none, outlined: true)[Abkürzungsverzeichnis],
        delimiter: "",
        clickable: true,
      )
    }

    // List of tables
    let tables = query(figure.where(kind: table))
    if tables.len() > 0 {
      pagebreak()
      outline(
        title: heading(level: 1, numbering: none, outlined: true)[Tabellenverzeichnis],
        target: figure.where(kind: table),
      )
    }

    // List of Listings
    let listings = query(figure.where(kind: "listing"))
    if listings.len() > 0 {
      outline(
        title: heading(level: 1, numbering: none, outlined: true)[Quellcodeverzeichnis],
        target: figure.where(kind: "listing"),
      )
    }


    // List of formulas

    // Anzahl der blockartigen Gleichungen ermitteln
    let eqs = query(math.equation.where(block: true))
    // Nur anzeigen, wenn mindestens eine Gleichung existiert

    if eqs.len() > 0 {
      pagebreak()
      outline(
        title: heading(level: 1, numbering: none, outlined: true)[Formelverzeichnis],
        target: math.equation.where(block: true),
      )
    }
  }


  set page(numbering: "1")

  body
  set page(numbering: "I")
  // Bibliography
  show bibliography: set bibliography(title: heading(level: 1, numbering: none, outlined: true)[Literaturverzeichnis])
  if bibliography-content != none {
    pagebreak()
    set page(numbering: "I")
    set bibliography(style: "ieee")
    heading(level: 1, numbering: none, outlined: true)[Literaturverzeichnis]

    show bibliography: set bibliography(title: none)

    bibliography-content
  }
}
