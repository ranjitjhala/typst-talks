#import "@preview/polylux:0.4.0": *
#import "iowa_crisp.typ": *
#show: crisp

#include "codemetal26/00-problem.typ"
#include "codemetal26/01-refinements.typ"
#include "codemetal26/02-ownership.typ"
#include "codemetal26/03-example.typ"
#include "codemetal26/04-systems.typ"


#slide[

  == Program Verification for the 21st Century

  #v(1.5em)

  #toolbox.side-by-side(columns: (0.05fr, 1.5fr, 1fr))[][
    #align(left)[
      #text(0.71em)[
        #my-outline-codemetal(6, full: true)
      ]
    ]
  ][
    #figure(image("img/flux-qr.png", width: 95%))
  ]

]
