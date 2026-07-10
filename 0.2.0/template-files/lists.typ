#import "i18n.typ": strings

#let lists(body, abstract-content: none, bibliography-content: none, acronyms: (), lang: "de") = {
  import "@preview/acrostiche:0.7.0": *

  let translations = strings(lang)

  set page(numbering: "I")

  // Abstract
  if abstract-content != none {
    pagebreak(weak: true)
    abstract-content
  }

  // Table of Contents
  set heading(numbering: "1.1")

  // Headings level 1
  show heading.where(
    level: 1,
  ): it => {
    set align(left)
    set text(20pt)
    set par(justify: true, leading: 1em, spacing: 1.5em)

      if it.numbering != none {
        v(1em)
        text(20pt)[#translations.chapter #counter(heading).get().first()]
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


  // Indent all lists
  set list(indent: 1.5em)
  set enum(indent: 1.5em)

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
        title: heading(level: 1, numbering: none, outlined: true)[#translations.list-of-figures],
        target: figure.where(kind: image),
      )
    }

    // List of acronyms
    if (acronyms != none and acronyms.len() > 0) {
      pagebreak()
      print-index(
        row-gutter: 1em,
        title: heading(level: 1, numbering: none, outlined: true)[#translations.list-of-acronyms],
        delimiter: "",
        clickable: true,
      )
    }

    // List of tables
    let tables = query(figure.where(kind: table))
    if tables.len() > 0 {
      pagebreak()
      outline(
        title: heading(level: 1, numbering: none, outlined: true)[#translations.list-of-tables],
        target: figure.where(kind: table),
      )

    }

    // List of Listings
    let listings = query(figure.where(kind: "listing"))
    if listings.len() > 0 {
      pagebreak()
      outline(
        title: heading(level: 1, numbering: none, outlined: true)[#translations.list-of-listings],
        target: figure.where(kind: "listing"),
      )
    }

    // List of formulas
    let eqs = query(math.equation.where(block: true))
    if eqs.len() > 0 {
      pagebreak()
      outline(
        title: heading(level: 1, numbering: none, outlined: true)[#translations.list-of-equations],
        target: math.equation.where(block: true),
      )

    }
  }

  // ADDED: A weak pagebreak to ensure the main body starts on a new page
  pagebreak(weak: true)
  set page(numbering: "1")
  // First-level headings always start on a new page
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }

  body

  set page(numbering: "I")

  // Bibliography
  show bibliography: set bibliography(title: heading(level: 1, numbering: none, outlined: true)[#translations.bibliography-title])
  if bibliography-content != none {
    pagebreak()
    set page(numbering: "I")
    set bibliography(style: "ieee")
    heading(level: 1, numbering: none, outlined: true)[#translations.bibliography-title]

    show bibliography: set bibliography(title: none)

    bibliography-content
  }
}
