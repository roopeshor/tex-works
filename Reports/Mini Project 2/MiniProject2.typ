#import "@preview/ilm:2.0.0": *

#set par(justify: true)
#set text(font: "Nimbus Roman")
#set heading(numbering: "1.1")
#show heading.where(level: 1): it => {
  set align(center + top)
	//new page starts for the chapter
  pagebreak(weak: true)
  block[
		// Use a block to contain the content and apply alignment
    #v(0.5cm)
    #text(size: 24pt, weight: "bold")[
      Chapter #context counter(heading).display(): #v(-15pt)
			#it.body // The actual chapter title
    ]
		#v(1cm)
  ]
}

// Example usage
= First Chapter
== sub chapter
=== sub chapter
#lorem(100)

= Second Chapter
#lorem(200)
