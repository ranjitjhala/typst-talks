#import "@preview/polylux:0.4.0": *
#import "iowa_crisp.typ": *
#show: crisp

#include "wg26_santiago/00-problem.typ"
#include "wg26_santiago/01-refinements.typ"
#include "wg26_santiago/02-ownership.typ"
#include "wg26_santiago/03-example.typ"
#include "wg26_santiago/04-interaction.typ"


#slide[

  = Verification for the 21#super[st] Century


  #v(1.5em)

  #toolbox.side-by-side(columns: (0.05fr, 1.5fr, 1fr))[][
    #align(left)[
      #text(0.71em)[
        #my-outline(6, full: true)
      ]
    ]
  ][
    #figure(image("img/flux-qr.png", width: 95%))
  ]

]
