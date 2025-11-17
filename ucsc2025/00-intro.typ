#import "@preview/polylux:0.4.0": *
#import "../iowa_crisp.typ": *


#slide[
  #text(1.3em)[*Refinement Types for Verified Systems*]

  #v(1em)

  #figure(image("../img/flux.png", width: 50%))

  #v(.2em)

  #ttblue[_*Ranjit Jhala*_], UC San Diego

]

#slide[
  === *What _is_ Programming Languages Research?*
]

#slide[

  #toolbox.side-by-side(gutter: 3em, columns: (1fr, 1.1fr))[

    #figure(image("../img/orwell.jpg", height: 135%))

  ][

    #text(1.0em)[
      #align(left)[
        _“We shall make_
        #v(-0.5em)
        _thoughtcrime_
        #v(-0.5em)
        _literally impossible:_
        #v(-0.5em)
        _there will be no words_
        #v(-0.5em)
        _to express it.”_

        --- George Orwell (1984)
      ]
    ]
  ]
]

#slide[

  #toolbox.side-by-side(gutter: 3em, columns: (1fr, 1.1fr))[

    #figure(image("../img/orwell.jpg", height: 135%))

  ][

    #text(1.0em)[
      #align(left)[
        _“We shall make_
        #v(-0.5em)
        #strike(stroke: 3pt + myred)[_thoughtcrime_] #ttred[*_bugs_*]
        #v(-0.5em)
        _literally impossible:_
        #v(-0.5em)
        _there will be no words_
        #v(-0.5em)
        _to express it.”_

        --- George Orwell (1984)
      ]
    ]
  ]
]

#slide[

  #v(-2.2em)

  === #text(1.1em)[What _is_ Programming Languages Research?]

  #v(0.3em)

  #toolbox.side-by-side(gutter: 3em, columns: (1fr, 1.1fr))[

    #figure(image("../img/rust-logo.png", height: 70%))

  ][

    #text(1.0em)[
      #align(left)[
        _“We shall make_
        #v(-0.5em)
        #strike(stroke: 3pt + myred)[_thoughtcrime_] #ttred[*_bugs_*]
        #v(-0.5em)
        _literally impossible:_
        #v(-0.5em)
        _there will be no words_
        #v(-0.5em)
        _to express it.”_

        --- George Orwell (1984)
      ]
    ]
  ]
]


#slide[

  #v(-3.1em)

  === #text(1.1em)[What _is_ Programming Languages Research?]

  #v(1.2em)

  #toolbox.side-by-side(gutter: 3em, columns: (1fr, 1.1fr))[

    #figure(image("../img/rust-logo.png", height: 70%))

  ][

    #text(1.0em)[

      *Rust Types Ensure*

      Memory safety

      Race freedom

    ]
  ]
]

#slide[
  #v(-3.1em)

  === #text(1.1em)[What _is_ Programming Languages Research?]

  #v(1.2em)

  #toolbox.side-by-side(gutter: 3em, columns: (1fr, 1.1fr))[

    #figure(image("../img/rust-logo.png", height: 70%))

  ][

    #figure(image("../img/android-rust-stats.png", height: 63%))

  ]
]

#slide[
  #v(-3.5em)

  === #text(1.1em)[What _is_ Programming Languages Research?]

  #v(1.6em)

  #toolbox.side-by-side(gutter: 3em, columns: (1fr, 1.1fr))[

    #text(1.8em)[_Other bugs?_]

  ][

    #figure(image("../img/android-rust-stats.png", height: 63%))

  ]
]



#slide[
  #v(-3.3em)

  === #text(1.1em)[What _is_ Programming Languages Research?]

  #v(1.4em)

  #toolbox.side-by-side(gutter: 3em, columns: (1fr, 1.1fr))[

    #text(1.8em)[_Other bugs?_]

  ][
      #text(0.8em)[
        #one-by-one()[

          Array Overflows

        ][

          Integer Overflows

        ][

          User def. invariants

        ][

          Security Requirements

        ][

          Functional Correctness

        ]
    ]
  ]
]


#slide[
  #v(-3.3em)

  === #text(1.1em)[What _is_ Programming Languages Research?]

  #v(1.4em)

  #toolbox.side-by-side(gutter: 3em, columns: (1fr, 1.1fr))[

    #text(1.8em)[_Other bugs?_]

  ][
    #hide[
      #text(0.8em)[
        Array Overflows

        Integer Overflows

        User def. invariants

        Security Requirements

        Functional Correctness
      ]
    ]
  ]
]


#slide[

  #v(-3.3em)

  == Refinement Types for Verified Systems

  #v(1.4em)

  #toolbox.side-by-side(gutter: 3em, columns: (1fr, 1.1fr))[

    #figure(image("../img/flux.png", width: 115%))

  ][
    #text(0.8em)[

      Array Overflows

      Integer Overflows

      User def. invariants

      Security Requirements

      Functional Correctness
    ]
  ]
]


#slide[

  #toolbox.side-by-side(gutter: 0.17em, columns: (2.8fr, 2.7fr, 3.9fr))[
    #uncover("1-")[
      #text(1.2em)[*_1. Refinement_*]

      #section_subtitle(fill: white)[Index, Exist & Update]
    ]
  ][
    #uncover("2-")[
      #text(1.2em)[*_2. Types_*]

      #section_subtitle(fill: white)[Struct & Enum]
    ]
  ][
    #uncover("3-")[
      #text(1.2em)[*_3. Verified Systems_*]

      #section_subtitle(fill: white)[Isolation in Tock OS Kernel]
    ]
  ]
]
