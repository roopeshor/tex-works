#import "settings.typ": *
#show: project

#set page(numbering: "a")
#showFooter("none")
#include "title.typ"
#include "certificate.typ"
#include "acknowledgment.typ"
#include "abstract.typ"

#set page(numbering: "i")
#showFooter("number")
#counter(page).update(1)
#include "tocloft.typ"

#counter(page).update(1)
#set page(
  numbering: "1",
  margin: (x: 1in, y: 1.5in),
)
#showFooter("doe-number")
#include "introduction.typ"
#include "research.typ"
#include "implementation.typ"
#include "results.typ"
#include "scope.typ"


// Disable chapter numbering
#show heading.where(level: 1): it => {
  set align(center + top)
  pagebreak(weak: true)
  block[
    #v(0.5cm)
    #text(size: 18pt, weight: "bold")[#it.body]
    #v(1cm)
  ]
}

#showFooter("none")
#showHeader(false)
#bibliography("bib.yaml", style: "ieee", title: [References])
#include "appendix.typ"
