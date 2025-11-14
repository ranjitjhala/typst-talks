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

  #v(-0.7em)

  === #text(1.1em)[What _is_ Programming Languages Research?]

  #v(0.6em)

  #toolbox.side-by-side(gutter: 1em, columns: (1fr, 1fr))[
    #hide[
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
  ][
    #text(0.8em)[

      #one-by-one()[

        Null Derefs

      ][

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

  #v(-0.9em)

  === #text(1.1em)[What _is_ Programming Languages Research?]

  #v(0.9em)

  #toolbox.side-by-side(gutter: 1em, columns: (1fr, 1fr))[

    #text(2em)[But ... _how_?]

  ][
    #hide[
      #text(0.8em)[

        Null Derefs


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

  #v(-0.9em)

  === #text(1.1em)[What _is_ Programming Languages Research?]

  Advances in Program Analysis and Verification

  #v(-0.2em)

  #table(
    columns: 4,
    stroke: none,
    align: left,
    inset: 20pt,
    [#uncover("2-")[#text(fill: rgb("#3803e8"))[_SMT_]]],
    [#uncover("3-")[#text(fill: purple)[_Abs-Interp._]]],
    [#uncover("4-")[#text(fill: orange)[_Dataflow_]]],
    [#uncover("5-")[#text(fill: rgb("#e8ca03"))[_Proof Assist._]]],

    [#uncover("6-")[#text(fill: red)[_Symex_]]],
    [#uncover("7-")[#text(fill: darkgreen)[_Model-Check_]]],
    [#uncover("8-")[#text(fill: rgb("#964B00"))[_Synthesis_]]],
    [#uncover("9-")[#text(fill: teal)[_LLMs_...]]],
  )

  #uncover("10-")[
    *Why limited impact and adoption?*
    #v(-0.3em)
    #text(0.95em)[(_cf._ _Profilers, Garbage Collection, Version Control, Debuggers…_)]
  ]
]


#slide[

  #v(-0.9em)

  === Why limited impact and adoption?

  #v(0.2em)

  #figure(image("../img/adoption-1.png", width: 95%))
]

#slide[

  #v(-0.9em)

  === Why limited impact and adoption?

  #v(0.2em)

  #figure(image("../img/adoption-2.png", width: 95%))
]

#slide[

  #v(-0.9em)

  === Why limited impact and adoption?

  #v(0.2em)

  #figure(image("../img/adoption-3.png", width: 95%))
]

#slide[

  #toolbox.side-by-side(gutter: 1em, columns: (1fr, 1fr))[

    #text(2em)[But ... _how_?]

  ][
    #figure(image("../img/reftypes-cycle-1.png", width: 95%))

  ]
]

#slide[

  #toolbox.side-by-side(gutter: 1em, columns: (1fr, 1fr))[

    #text(2em)[But ... _how_?]

  ][
    #figure(image("../img/reftypes-cycle-2.png", width: 95%))

  ]
]



#slide[

  #v(-0.5em)

  == Refinement Types for Verified Systems

  #v(0.6em)

  #toolbox.side-by-side(gutter: 1em, columns: (1fr, 1fr))[

    #figure(image("../img/reftypes-cycle-2.png", width: 85%))

  ][
    #text(0.7em)[

      Null Derefs

      Array Overflows

      Integer Overflows

      User def. invariants

      Security Requirements

      Functional Correctness
    ]
  ]
]


#slide[
  #v(-0.9em)

  == Refinement Types for Verified Systems

  #v(1.5em)

  #toolbox.side-by-side(gutter: 0em, columns: (3.5fr, 3fr))[
    #center-block(pad: 2em)[
      #uncover("1-")[
        *1. _Refinement_*

        #text(fill: white, size: 0.8em)[Values & References]
      ]

      #v(1em)

      #uncover("3-")[
        *3. _Verified_*

        #text(fill: white, size: 0.8em)[SMT & CHC Solving]
      ]
    ]
  ][
    #center-block(pad: 2em)[
      #uncover("2-")[
        *2. _Types_*

        #text(fill: white, size: 0.8em)[Structs & Enums]
      ]

      #v(1em)

      #uncover("4-")[
        *4. _Systems_*

        #text(fill: white, size: 0.8em)[Isolation in Tock OS]
      ]
    ]
  ]
]
