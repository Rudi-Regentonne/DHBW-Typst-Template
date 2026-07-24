#import "i18n.typ": strings

#let titlepage(
  title: [title],
  document-type: [document-type],
  program: [program],
  module: none,
  university: none,
  author: [author],
  submission-date: none,
  duration: none,
  student-id: none,
  course: none,
  company-name: none,
  city: none,
  company-supervisor: none,
  university-supervisor: none,
  company-logo: none,
  university-logo: none,
  cover-page: none,
  lang: "de",
) = {
  let translations = strings(lang)
  if cover-page == none {
    // Title page
    let logo-box = box(
      height: 2cm,
      grid(
        columns: (1fr, 1fr),
        [
          #align(left)[
            #if company-logo != none {
              company-logo
            }
          ]
        ],
        [
          #align(right)[
            #if university-logo == none {
              image("dhbw-logo.png")
            } else {
              university-logo
            }
          ]
        ],
      ),
    )

    set par(justify: false)

    let rows = (
      (translations.processing-period, duration),
      (translations.student-id, student-id),
      (translations.course, course),
      (translations.company-name, company-name),
      ("", if company-name != none { city }),
      (translations.company-supervisor, company-supervisor),
      (translations.university-supervisor, university-supervisor),
    ).filter(it => it.at(1) != none)
    let info-table = table(
      columns: (50%, 50%),
      align: (left, left),
      stroke: 0pt + gray,
      inset: 6pt,
      ..rows.flatten().map(it => [#it]),
    )

    // Vertical spacing scales down for long titles so the info table
    // still fits on the same page.
    let title-block(scale: 1.0) = align(center, [

      #text(24pt, weight: "bold", title)
      #v(1cm * scale)
      #smallcaps(text(24pt, document-type))
      #v(1cm * scale)

      #text(16pt)[
        #if module != none {
          translations.for-the-module
          v(0.5cm * scale)
          module
          v(0.5cm * scale)
        }
        #translations.in-degree-program #program
        #v(0.5cm * scale)
        #translations.at-university
        #v(0.5cm * scale)
        #if university == none {
          translations.default-university
        } else {
          university
        }
      ]
      #v(0.5cm * scale)
      #text(16pt)[#translations.by]
      #v(0.5cm * scale)
      #text(16pt, weight: "bold")[#author]
      #v(1cm * scale)
      #if submission-date != none {
        text(14pt)[#translations.submission-date #submission-date]

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
    cover-page
  }
}
