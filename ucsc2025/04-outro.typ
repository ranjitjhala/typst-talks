#import "@preview/polylux:0.4.0": *
#import "../iowa_crisp.typ": *


#slide[
  #flux_logo()

  #toolbox.side-by-side(gutter: 0.17em, columns: (2.8fr, 2.7fr, 3.9fr))[
      #text(1.2em)[*_1. Refinement_*]

      #section_subtitle[Index, Exist & Update]
  ][
      #text(1.2em)[*_2. Types_*]

      #section_subtitle[Struct & Enum]
  ][
    #text(1.2em)[*_3. Verified Systems_*]

    #section_subtitle[Isolation in Tock OS Kernel]
  ]
]

#slide[

  #figure(image("../img/flux-site.png", width: 80%))

]

#slide[

  #toolbox.side-by-side(columns: (1fr, 1.3fr))[
    #align(left)[

      *1. _Refinement_*

      #section_subtitle[Index, Exist & Update]

      *2. _Types_*

      #section_subtitle[Struct & Enum]

      *3. _Verified Systems_*

      #section_subtitle[Isolation in Tock OS Kernel]

    ]
  ][
      #figure(image("../img/flux-qr.png", width: 95%))
  ]
]
