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
#include "tocloft.typ"

#counter(page).update(1)
#set page(
  numbering: "1",
  margin: (x: 1in, y: 1.5in),
)
#showFooter("doe-number")
#include "introduction.typ"
#include "research.typ"
#include "components.typ"
#include "System Overview.typ"
#include "results.typ"
#include "scope.typ"

#bibliography("bib.yaml", style: "ieee")
#include "appendix.typ"
