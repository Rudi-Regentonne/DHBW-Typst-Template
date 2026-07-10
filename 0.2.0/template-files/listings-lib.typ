#import "i18n.typ": strings

#let code(
  caption: none, // content of caption bubble (string, none)
  bgcolor: rgb("#eaeaea"), // back ground color (color)
  strokecolor: auto, // frame color (color)
  hlcolor: auto, // color to use for highlighted lines (auto, color)
  width: 100%,
  radius: 3pt,
  inset: 5pt,
  numbers: false, // show line numbers (boolean)
  stepnumber: 1, // only number lines divisible by stepnumber (integer)
  numberfirstline: false, // if the firstline isn't divisible by stepnumber, force it to be numbered anyway (boolean)
  numberstyle: auto, // style function to apply to line numbers (auto, style)
  firstnumber: 1, // number of the first line (integer)
  highlight: none, // line numbers to highlight (none, array of integer)
  code_label: none,
  breakable: false,
  lang: "de",
  content,
) = {
  let translations = strings(lang)
  show figure.where(kind: "listing"): set block(breakable: breakable)
  if hlcolor == auto {
    hlcolor = bgcolor.darken(10%)
  }
  if highlight == none {
    highlight = ()
  }
  let final_strokecolor = if strokecolor == auto {
    0.5pt + bgcolor.darken(20%)
  } else {
    strokecolor
  }
  let code_block = block(
    width: width,
    fill: bgcolor,
    stroke: final_strokecolor,
    radius: radius,
    inset: inset,
    clip: false,
    {
          set par(justify: false)
  let (columns, align, make_row) = {
    if numbers {
      if numberstyle == auto {
        numberstyle = text.with(
          style: "italic",
          slashed-zero: false,
          size: .6em,
        )
      }
      
      (
        (auto, 1fr),
        (right + top, left + top),
        e => {
          let (i, l) = e
          let m = l.match(regex("^ +"))
          let leading = if m != none { m.text.len() } else { 0 }
          let trimmed = if leading > 0 { l.slice(leading) } else { l }
          let n = i + firstnumber
          let n_str = if (
            (
              calc.rem(n, stepnumber) == 0
            )
              or (
                numberfirstline and i == 0
              )
          ) {
            numberstyle(str(n))
          } else {
            none
          }
          
          (
            n_str + h(.5em),
            context {
              let space-width = measure(raw(" ")).width
              let indent = leading * space-width
              pad(left: indent, raw(lang: content.lang, trimmed))
            },
          )
        },
      )
    } else {
      (
        (1fr,),
        (left,),
        e => {
          let (i, l) = e
          let m = l.match(regex("^ +"))
          let leading = if m != none { m.text.len() } else { 0 }
          let trimmed = if leading > 0 { l.slice(leading) } else { l }
          
          context {
            let space-width = measure(raw(" ")).width
            let indent = leading * space-width
            pad(left: indent, raw(lang: content.lang, trimmed))
          }
        },
      )
    }
  }
      grid(
        stroke: none,
        columns: columns,
        rows: (auto,),
        gutter: 0pt,
        inset: 2pt,
        align: (col, _) => align.at(col),
        fill: (c, row) => if (row + firstnumber) in highlight { hlcolor } else { none },
        ..content
          .text
          .split("\n")
          .enumerate()
          .map(make_row)
          .flatten()
          .map(c => if c.has("text") and c.text == "" { v(1em) } else { c })
      )
    },
  )
  let fig = figure(
    code_block,
    caption: caption,
    kind: "listing",
    supplement: translations.listing-supplement,
  )
  
  if code_label != none [
    #fig #label(code_label)
  ] else {
    fig
  }
}
