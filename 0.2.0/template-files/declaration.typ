#import "i18n.typ": strings

#let declaration(
  author: [author],
  company-city: [company-city],
  confidential: bool,
  confidential-text: none,
  show-declaration: bool,
  declaration-text: none,
  declaration-title: none,
  lang: "de",
) = {
  let translations = strings(lang)
  if show-declaration or confidential {
    pagebreak()
  }
  if show-declaration {
    set text(lang: lang)
    let today = datetime.today().display(translations.date-format)


    box(
      stroke: 1pt + luma(30),
      inset: 12pt,
    )[
      #align(center)[
        #text(size: 18pt, weight: "bold")[
          #if declaration-title == none {
            translations.declaration-title
          } else {
            declaration-title
          }]
      ]
      #v(8pt)

      #if declaration-text == none {
        translations.declaration-body
      } else {
        declaration-text
      }

      #v(3cm)


      #table(
        columns: (1fr, 1fr, 1.4fr),
        align: (center, center, center),
        inset: (x: 0pt, y: 4pt),
        stroke: (x: none, y: none),
        [#company-city], [#today], [#translations.signed #author],
        [#line(length: 100%, stroke: 0.8pt + luma(40))],
        [#line(length: 100%, stroke: 0.8pt + luma(40))],
        [#line(length: 100%, stroke: 0.8pt + luma(40))],

        [#translations.place], [#translations.date], [#translations.signature],
      )
    ]


    v(12pt)
  }

  if confidential {
    align(bottom)[

      #box(
        stroke: 1pt + luma(30),
        width: 100%,
        inset: 12pt,
      )[
        #align(center)[
          #text(size: 18pt, weight: "bold")[#translations.confidential-title]
        ]
        #v(8pt)
        #if confidential-text == none {
          translations.confidential-body
        } else {
          confidential-text
        }
      ]
    ]
  }
}
