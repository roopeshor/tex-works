#import "settings.typ": addToPDFBookmark
#import "@preview/acrostiche:0.7.0": *
// Table Of Contents, List Of Figures and Tables

#init-acronyms((
  "IoT": "Internet of Things",
  "M2M": "machine-to-machine",
  "COTS": "Commercial off-the-shelf",
  "UAV": "Unmanned Aerial Vehicle",
  "WSN": "Wireless Sensor Netwok",
  "MANET": "Mobile Adhoc Network",
  "VANET": "Vehicular Adhoc Network",
  "AODV": "Ad-hoc On-demand Distance Vector",
  "GNSS": "Global Navigation Satellite Systems",
  "ACK": "Acknowledgment",
))

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

#addToPDFBookmark("Table of contents")
#outline(
  title: [Table of contents],
  target: heading,
)

#pagebreak()

#addToPDFBookmark("List of Figures")
#outline(
  title: [List of Figures],
  target: figure.where(kind: image),
)
#v(1cm)

#addToPDFBookmark("List of Tables")
#outline(
  title: [List of Tables],
  target: figure.where(kind: table),
)
#v(1cm)

#addToPDFBookmark([List of Abbreviations])
#print-index(
  title: [List of Abbreviations],
  row-gutter: 10pt,
)

#pagebreak()
