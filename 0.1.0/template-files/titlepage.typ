#let titlepage(
  Titel: [Titel],
  Was: [Was],
  Studiengang: [Studiengang],
  Pruefung: none,
  Hochschule: none,
  Autor: [Autor],
  AbgabeDatum: none,
  Dauer: none,
  MatrikelNummer: none,
  Kurs: none,
  FirmenName: none,
  Stadt: none,
  BetreuerFirma: none,
  BetreuerDHBW: none,
  Firmenlogo: none,
  Hochschullogo: none,
  Deckblatt: none,
) = {
  if Deckblatt == none {
    // Title page
    let logo-box = box(
      height: 2cm,
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
            #if Hochschullogo == none {
              image("dhbw-logo.png")
            } else {
              Hochschullogo
            }
          ]
        ],
      ),
    )

    set par(justify: false)

    let rows = (
      ("Bearbeitungszeitraum", Dauer),
      ("Matrikelnummer", MatrikelNummer),
      ("Kurs", Kurs),
      ("Ausbildungsfirma", FirmenName),
      ("", if FirmenName != none { Stadt }),
      ("Betreuer der Ausbildungsfirma", BetreuerFirma),
      ("Gutachter der Studienakademie", BetreuerDHBW),
    ).filter(it => it.at(1) != none)
    let info-table = table(
      columns: (50%, 50%),
      align: (left, left),
      stroke: 0pt + gray,
      inset: 6pt,
      // Zellinnenabstand
      ..rows.flatten().map(it => [#it]),
    )

    // Vertical spacing scales down for long titles so the info table
    // still fits on the same page.
    let title-block(scale: 1.0) = align(center, [

      #text(24pt, weight: "bold", Titel)
      #v(1cm * scale)
      #smallcaps(text(24pt, Was))
      #v(1cm * scale)

      #text(16pt)[
        #if Pruefung != none {
          [für das Modul]
          v(0.5cm * scale)
          Pruefung
          v(0.5cm * scale)
        }
        des Studienganges #Studiengang
        #v(0.5cm * scale)
        an der
        #v(0.5cm * scale)
        #if Hochschule == none {
          [Dualen Hochschule Baden-Württemberg Karlsruhe]
        } else {
          Hochschule
        }
      ]
      #v(0.5cm * scale)
      #text(16pt)[von]
      #v(0.5cm * scale)
      #text(16pt, weight: "bold")[#Autor]
      #v(1cm * scale)
      #if AbgabeDatum != none {
        text(14pt)[Abgabedatum #AbgabeDatum]

        v(1cm * scale)
      }
    ])

    let content-width = 21cm - 2 * 1.8cm
    let content-height = 29.7cm - 2.5cm - 2cm
    let logo-gap = 1cm
    let logo-height = 2cm
    let table-gap = 1.5cm

    context {
      let min-scale = 0.5
      let table-height = measure(info-table, width: content-width).height
      let natural = measure(title-block(scale: 1.0), width: content-width).height
      let available = calc.max(
        0pt,
        content-height - logo-height - logo-gap - table-height - table-gap,
      )
      let scale = if natural > 0pt {
        calc.max(min-scale, calc.min(1.0, available / natural))
      } else {
        1.0
      }

      box(
        height: content-height,
        width: 100%,
        stack(
          dir: ttb,
          spacing: 0pt,
          logo-box,
          v(logo-gap),
          title-block(scale: scale),
          v(1fr),
          info-table,
        ),
      )
    }
  } else {
    Deckblatt
  }
}
