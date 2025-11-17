#import "@preview/polylux:0.4.0": *
#import "../iowa_crisp.typ": *


#slide[ = _3. Verified Systems_ ]



#slide[

  #toolbox.side-by-side(gutter: 0.17em, columns: (2.8fr, 2.7fr, 3.9fr))[
    #hide[
      #text(1.2em)[*_1. Refinement_*]

      #section_subtitle[Index, Exist & Update]
    ]
  ][
    #hide[
      #text(1.2em)[*_2. Types_*]

      #section_subtitle[Struct & Enum]
    ]
  ][
    #text(1.2em)[*_3. Verified Systems_*]

    #section_subtitle[Isolation in Tock OS Kernel]
  ]
]

#slide[ = Verified Systems ]

#slide[
  #v(-1.2em)

  = #text(1.05em)[Verified Systems]

  #v(1.2em)

  #figure(image("../img/tock.png", height: 5cm))

  #text(1.4em)[An _Embedded_ OS Kernel]

  #v(-0.7em)

  #text(0.7em)[Levy _et al._ SOSP 2017, Schuermann _et al._ SOSP 2025]

]


#slide[
  #v(-1.2em)

  = #text(1.05em)[Verified Systems]

  #v(1.2em)

  #figure(image("../img/tock-chips.png", height: 5cm))

  #text(1.4em)[An _Embedded_ OS Kernel]

  #v(-0.7em)

  #text(0.7em)[Firmware in Microsoft Pluton "root of trust", Google ChromeBooks (GSC),...]

]

#slide[
  #v(-1em)

  = #text(1.05em)[Tock: Architecture]

  #v(.5em)

  #figure(image("../img/tock-arch-0.png", height: 9cm))

  #v(-0.5em)

  #text(fill: orange)[*Capsules*] enjoy Rust's safety guarantees
]


#slide[
  #v(-1em)

  = #text(1.05em)[Tock: Architecture]

  #v(.5em)

  #figure(image("../img/tock-arch-0.png", height: 9cm))

  #v(-0.5em)

  #text(fill: red)[*Core*] uses `unsafe` to manage hardware
]

#slide[
  #v(-1em)

  = #text(1.05em)[Tock: Architecture]

  #v(.5em)

  #figure(image("../img/tock-arch-1.png", height: 9cm))

  #v(-0.5em)

  User processes can run _arbitrary code_
]

#slide[
  #v(-1em)

  = #text(1.05em)[Tock: Architecture]

  #v(.5em)

  #figure(image("../img/tock-arch-2-vul.png", height: 9cm))

  #v(-0.5em)

  User processes run _arbitrary code_ #ttred[with vulnerabilities]
]

#slide[

  #v(-1em)

  = #text(1.05em)[Tock: Security by _Isolation_]

  #v(0.5em)

  #figure(image("../img/tock-arch-2-isolated.png", height: 9cm))

  #v(-0.5em)

  _Isolate_ processes from kernel and each other

]

#slide[

  #v(-1em)

  = #text(1.05em)[Tock: Security by _Isolation_]

  #v(0.5em)

  #figure(image("../img/tock-arch-3.png", height: 9cm))

  #v(-0.5em)

  *Process Memory:*  #ttred[`Kernel`] + #ttgreen[`Data`] + #ttpurple[`Code`]

]

#slide[

  #v(-1em)

  = #text(1.05em)[Tock: Security by _Isolation_]

  #v(0.5em)

  #figure(image("../img/tock-arch-4.png", height: 9cm))

  #v(-0.5em)

  *Process Memory:*  #ttred[`Kernel`] + #ttgreen[`Data`] + #ttpurple[`Code`]

]

#slide[

  #v(-1em)

  = #text(1.05em)[Tock: Security by _Isolation_]

  #v(0.5em)

  #figure(image("../img/tock-arch-5.png", height: 9cm))

  #v(-0.5em)

  *Process Memory:*  #ttred[`Kernel`] + #ttgreen[`Data`] + #ttpurple[`Code`]

]


#slide[

  #v(-1em)

  = #text(0.9em)[Isolation via Memory Protection Units]

  #v(0.5em)

  #figure(image("../img/mpu.png", height: 9cm))

  #v(-0.5em)

  MPU controls address (regions) allowed to `Rd`, `Wr`, `Ex`

]

#slide[

  #v(-1em)

  = #text(0.9em)[Isolation via Memory Protection Units]

  #v(0.5em)

  #figure(image("../img/tock-arch-6.png", height: 9cm))

  #v(-0.4em)

  *To _only_ allow* `Rd+Wr` in #ttgreen[`Data`#sub[`i`]] and `Rd+Ex` in #ttpurple[`Code`#sub[`i`]]

]

#slide[

  #v(-1.5em)

  = #text(0.9em)[Isolation via Memory Protection Units]

  #text(1.2em)[
    What could _possibly_ go wrong?
  ]

  #v(-0.5em)

  #uncover("2-")[
    #figure(image("../img/tock-known-bugs.png", height: 9.5cm))
  ]
]

#slide[

  #text(1.2em)[*What could _possibly_ go wrong?*]

  #uncover("1-")[
    Buggy _MPU configuration_
  ]

  #uncover("2-")[
    #hide[
      Buggy _context switching_
    ]
  ]

]

#slide[

  #text(1.2em)[*Buggy _MPU Configuration_*]


]
