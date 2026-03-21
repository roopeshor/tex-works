#import "@preview/hydra:0.6.2": anchor, hydra

// Possible values:
// doe-number
// number
// none
#let showFooterState = state("showFooterState", "doe-number")
#let showFooter(type) = showFooterState.update(type)

#let addToPDFBookmark(entry) = {
  show heading: none
  heading(numbering: none, bookmarked: true, outlined: false)[#entry]
}

#let project(body) = {
  set par(justify: true)
  set text(font: "EB Garamond", size: 12.5pt)
  set heading(numbering: "1.")
  set page(footer: context {
    if showFooterState.get() == "doe-number" {
      [
        _Division of Electronics Engg, SOE, CUSAT_
        #h(1fr)
        #counter(page).display()
      ]
    } else if showFooterState.get() == "number" {
      [
        #align(center)[#counter(page).display()]
      ]
    }
  })

  set page(header: context {
    if counter(heading).get().first() > 0 [
      // Display header from 1st numbered heading
      #emph[#hydra(1)]
      #h(1fr)
      #emph[#hydra(2)]
    ]
  })

  show bibliography: set heading(numbering: "1.")

  show heading.where(level: 1): it => {
    set align(center + top)
    pagebreak(weak: true)
    block[
      #v(0.5cm)
      #text(size: 24pt, weight: "bold")[
        Chapter #counter(heading).get().first(): #v(-15pt)
        #it.body
      ]
      #v(1cm)
    ]
  }

  show heading.where(level: 2): it => {
    block[
      #text(size: 20pt, weight: "bold", font: "Liberation Serif")[#counter(heading).display().trim(".") #it.body]
      #v(10pt)
    ]
  }

  show heading.where(level: 3): it => {
    block[
      #text(size: 15pt, weight: "bold", font: "Liberation Serif")[#counter(heading).display().trim(".") #it.body]
      #v(10pt)
    ]
  }
  // contents
  body
}
