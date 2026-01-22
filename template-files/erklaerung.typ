
// ===============================

// Falls du Kopf-/Fußzeilen nutzt und diese hier leer sein sollen, aktiviere:
// #set page(header: none, footer: none)

// ===============================
// (Optionale) Variablen – hier kannst du deine eigenen einsetzen
#let erklaerung(Autor: [Autor], FirmenStadt: [FirmenStadt], Sperrvermerk: bool) = {
  set text(lang: "de")
  // Heutiges Datum:
  let Heute = datetime.today().display("[day].[month].[year]") //repr:long im Monat ist momentan noch auf Englisch


  // ===============================
  // Ehrenwörtliche Erklärung (gerahmt)
  box(
    stroke: 1pt + luma(30), // Rahmen
    inset: 12pt, // Innenabstand
  )[
    #align(center)[
      #text(size: 18pt, weight: "bold")[Ehrenwörtliche Erklärung]
    ]
    #v(8pt)

    // Fließtext (wie im LaTeX-Original)
    Ich versichere hiermit, dass ich die vorliegende Arbeit selbstständig verfasst und keine anderen
    als die angegebenen Quellen und Hilfsmittel verwendet habe und diese Arbeit bei keiner
    anderen Prüfung mit gleichem oder vergleichbarem Inhalt vorgelegt habe und diese bislang
    nicht veröffentlicht wurde. Des Weiteren versichere ich, dass die eingereichte elektronische
    Fassung mit der gedruckten Ausfertigung übereinstimmt.

    #v(3cm)

    // Unterschriftenbereich (Ort / Datum / Unterschrift)
    #table(
      columns: (1fr, 1fr, 1.4fr),
      align: (center, center, center),
      inset: (x: 0pt, y: 4pt),
      stroke: (x: none, y: none),
      // Zeile 1: Werte
      [#FirmenStadt], [#Heute], [gez. #Autor],
      // Zeile 2: Linien
      [#line(length: 100%, stroke: 0.8pt + luma(40))],
      [#line(length: 100%, stroke: 0.8pt + luma(40))],
      [#line(length: 100%, stroke: 0.8pt + luma(40))],
      // Zeile 3: Beschriftungen
      [Ort], [Datum], [Unterschrift],
    )
  ]

  // Platz bis Seitenende füllen (wie \vfill), optional
  v(12pt)

  // ===============================
  // Sperrvermerk (gerahmt)
  if Sperrvermerk {
    align(bottom)[

      #box(
        stroke: 1pt + luma(30),
        inset: 12pt,
      )[
        #align(center)[
          #text(size: 18pt, weight: "bold")[Sperrvermerk]
        ]
        #v(8pt)

        Der Inhalt dieser Arbeit darf weder als Ganzes noch in Auszügen Personen
        außerhalb des Prüfungsprozesses und des Evaluationsverfahrens zugänglich gemacht
        werden, sofern keine anderslautende Genehmigung vom Dualen Partner vorliegt.
      ]
    ]
  }
}
