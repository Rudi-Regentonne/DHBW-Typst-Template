

#let erklaerung(
  Autor: [Autor],
  FirmenStadt: [FirmenStadt],
  Sperrvermerk: bool,
  SperrvermerkText: none,
  Erklaerung: bool,
  ErklaerungText: none,
  ErklaerungTitel: none,
  lang: "de",
) = {
  let i18n = if lang == "en" {(
    ehrenwort-titel: "Statement of Originality",
    ehrenwort-text: [I hereby certify that I have written this work independently and have not used any sources or resources other than those indicated, and that this work has not been submitted for any other examination with the same or similar content, and has not been published. Furthermore, I certify that the submitted electronic version matches the printed version.],
    ort: "Place",
    datum: "Date",
    unterschrift: "Signature",
    gez: "signed",
    sperrvermerk-titel: "Confidentiality Notice",
    sperrvermerk-text: [The content of this work may not be made accessible to persons outside the examination and evaluation process, either in whole or in part, unless otherwise authorized by the Dual Partner.],
  )} else {(
    ehrenwort-titel: "Ehrenwörtliche Erklärung",
    ehrenwort-text: [Ich versichere hiermit, dass ich die vorliegende Arbeit selbstständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel verwendet habe und diese Arbeit bei keiner anderen Prüfung mit gleichem oder vergleichbarem Inhalt vorgelegt habe und diese bislang nicht veröffentlicht wurde. Des Weiteren versichere ich, dass die eingereichte elektronische Fassung mit der gedruckten Ausfertigung übereinstimmt.],
    ort: "Ort",
    datum: "Datum",
    unterschrift: "Unterschrift",
    gez: "gez.",
    sperrvermerk-titel: "Sperrvermerk",
    sperrvermerk-text: [Der Inhalt dieser Arbeit darf weder als Ganzes noch in Auszügen Personen außerhalb des Prüfungsprozesses und des Evaluationsverfahrens zugänglich gemacht werden, sofern keine anderslautende Genehmigung vom Dualen Partner vorliegt.],
  )}

  if Erklaerung or Sperrvermerk {
    pagebreak()
  }
  if Erklaerung {
    set text(lang: lang)
    let Heute = datetime.today().display("[day].[month].[year]")


    box(
      stroke: 1pt + luma(30),
      inset: 12pt,
    )[
      #align(center)[
        #text(size: 18pt, weight: "bold")[
          #if ErklaerungTitel == none {
            [#i18n.ehrenwort-titel]
          } else {
            ErklaerungTitel
          }]
      ]
      #v(8pt)

      #if ErklaerungText == none {
        i18n.ehrenwort-text
      } else {
        ErklaerungText
      }

      #v(3cm)


      #table(
        columns: (1fr, 1fr, 1.4fr),
        align: (center, center, center),
        inset: (x: 0pt, y: 4pt),
        stroke: (x: none, y: none),
        [#FirmenStadt], [#Heute], [#i18n.gez #Autor],
        [#line(length: 100%, stroke: 0.8pt + luma(40))],
        [#line(length: 100%, stroke: 0.8pt + luma(40))],
        [#line(length: 100%, stroke: 0.8pt + luma(40))],

        [#i18n.ort], [#i18n.datum], [#i18n.unterschrift],
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
          #text(size: 18pt, weight: "bold")[#i18n.sperrvermerk-titel]
        ]
        #v(8pt)
        #if SperrvermerkText == none {
          i18n.sperrvermerk-text
        } else {
          SperrvermerkText
        }
      ]
    ]
  }
}
