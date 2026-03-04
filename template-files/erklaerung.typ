

#let erklaerung(
  Autor: [Autor],
  FirmenStadt: [FirmenStadt],
  Sperrvermerk: bool,
  SperrvermerkText: none,
  Erklaerung: bool,
  ErklaerungText: none,
  ErklaerungTitel: none,
) = {
  if Erklaerung or Sperrvermerk {
    pagebreak()
  }
  if Erklaerung {
    set text(lang: "de")
    // Heutiges Datum:
    let Heute = datetime.today().display("[day].[month].[year]") //repr:long im Monat ist momentan noch auf Englisch


    box(
      stroke: 1pt + luma(30),
      inset: 12pt,
    )[
      #align(center)[
        #text(size: 18pt, weight: "bold")[
          #if ErklaerungTitel == none {
            [Ehrenwörtliche Erklärung]
          } else {
            ErklärungTitel
          }]
      ]
      #v(8pt)

      #if ErklaerungText == none {
        [Ich versichere hiermit, dass ich die vorliegende Arbeit selbstständig verfasst und keine anderen
          als die angegebenen Quellen und Hilfsmittel verwendet habe und diese Arbeit bei keiner
          anderen Prüfung mit gleichem oder vergleichbarem Inhalt vorgelegt habe und diese bislang
          nicht veröffentlicht wurde. Des Weiteren versichere ich, dass die eingereichte elektronische
          Fassung mit der gedruckten Ausfertigung übereinstimmt.]
      } else {
        ErklaerungText
      }

      #v(3cm)


      #table(
        columns: (1fr, 1fr, 1.4fr),
        align: (center, center, center),
        inset: (x: 0pt, y: 4pt),
        stroke: (x: none, y: none),
        [#FirmenStadt], [#Heute], [gez. #Autor],
        [#line(length: 100%, stroke: 0.8pt + luma(40))],
        [#line(length: 100%, stroke: 0.8pt + luma(40))],
        [#line(length: 100%, stroke: 0.8pt + luma(40))],

        [Ort], [Datum], [Unterschrift],
      )
    ]


    v(12pt)
  }

  if Sperrvermerk {
    align(bottom)[

      #box(
        stroke: 1pt + luma(30),
        width: 100%,
        inset: 12pt,
      )[
        #align(center)[
          #text(size: 18pt, weight: "bold")[Sperrvermerk]
        ]
        #v(8pt)
        #if SperrvermerkText == none {
          [Der Inhalt dieser Arbeit darf weder als Ganzes noch in Auszügen Personen
            außerhalb des Prüfungsprozesses und des Evaluationsverfahrens zugänglich gemacht
            werden, sofern keine anderslautende Genehmigung vom Dualen Partner vorliegt.]
        } else {
          SperrvermerkText
        }
      ]
    ]
  }
}
