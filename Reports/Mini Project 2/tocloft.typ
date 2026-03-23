#import "settings.typ": addToPDFBookmark
// Table Of Contents, List Of Figures and Tables


// set listing heading style
#show heading.where(level: 1): it => {
  set align(center + top)
  block[
    #text(size: 21pt, weight: "bold")[#it.body]
    #v(.5cm)
  ]
}

// Set spacing for heading outline
#show outline.entry.where(level: 1): it => {
  if it.element.func() == heading {
    v(5pt)
    strong(it)
  } else {
    v(3pt)
    it
  }
}

#show outline.entry: it => {
  // things that shouldnt be numbered
  let no-nums = query(label("unnumbered"))
  if it.element in no-nums {
    return strong[
      #it.body()
      // dots
      #box(width: 1fr, repeat(gap: 0.15em)[.]) #it.page()
    ]
  }
  it
}

#counter(page).update(1)
#set page(numbering: "i")

#addToPDFBookmark("Table of contents")
#outline(
  title: [Table of contents],
  target: heading,
)

#pagebreak()

#{
  show heading: none
  heading(numbering: none)[List of Figures]
}

#outline(
  title: [List of Figures],
  target: figure.where(kind: image),
)

#v(1cm)

#{
  show heading: none
  heading(numbering: none)[List of Tables]
}
#outline(
  title: [List of Tables],
  target: figure.where(kind: table),
)

#pagebreak()
