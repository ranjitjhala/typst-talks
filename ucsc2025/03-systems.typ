#import "@preview/polylux:0.4.0": *
#import "../iowa_crisp.typ": *

#let sosp25() = {
  text(size: 0.8em, fill: blue)[#link("https://ranjitjhala.github.io/static/sosp25-ticktock.pdf")[\[SOSP'25\]]]
}


#slide[ = _3. Verified Systems_ ]

#slide[
  #v(-1.2em)

  = #text(1.05em)[Verified Systems]

  #v(1.2em)

  #figure(image("../img/tock.png", height: 5cm))

  #uncover("2-")[
    #text(1.4em)[An _Embedded_ OS Kernel]

    #v(-0.7em)

    #text(0.7em)[Levy _et al._ SOSP 2017, Schuermann _et al._ SOSP 2025]
  ]
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

  #uncover("2-")[
  #figure(image("../img/tock-arch-0.png", height: 9cm))

  #v(-0.5em)

  #text(fill: orange)[*Capsules*] enjoy Rust's safety guarantees
  ]
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

  #v(-2.1em)

  = #text(0.9em)[Isolation via Memory Protection Units]

  #text(1.2em)[
    What could _possibly_ go wrong?
  ]

  #v(-0.5em)

  #uncover("2-")[
    #figure(image("../img/tock-known-bugs.png", height: 8.0cm))
  ]
]

#slide[

  #text(1.2em)[*What could _possibly_ go wrong?*]

  #uncover("1-")[
    Buggy _MPU configuration_
  ]

  #uncover("2-")[
    #hide[
      Buggy _interrupts & context switching_
    ]
  ]

]

#slide[

  #text(1.2em)[*Buggy _MPU Configuration_*]

  MPUs permit access control over #ttblue[*_fixed size regions_*]

]

#slide[

  #text(1.2em)[*Buggy _MPU Configuration_*]

  #move(dx: 1.5cm)[#figure(image("../img/tock-bug-1.png", height: 8cm))]

  #v(-0.5em)

  MPUs permit access control over #ttblue[*_fixed size regions_*]

]

#slide[

  #text(1.2em)[*Buggy _MPU Configuration_*]

  #move(dx: 1.5cm)[#figure(image("../img/tock-bug-2.png", height: 8cm))]

  #v(-0.5em)

  MPUs permit access control over #ttblue[*_fixed size regions_*]

]

#slide[

  #text(1.2em)[*Buggy _MPU Configuration_*]

  #move(dx: 1.5cm)[#figure(image("../img/tock-bug-3.png", height: 8cm))]

  #v(-0.5em)

  Process Accesses `Heap` + `Stack`

]

#slide[

  #text(1.2em)[*Buggy _MPU Configuration_*]

  #move(dx: 1.5cm)[#figure(image("../img/tock-bug-4.png", height: 8cm))]

  #v(-0.5em)

  `Heap` can _grow_ via kernel syscall

]

#slide[

  #text(1.2em)[*Buggy _MPU Configuration_*]

  #move(dx: 1.5cm)[#figure(image("../img/tock-bug-5.png", height: 8cm))]

  #v(-0.5em)

  `Heap` can _grow_ via kernel syscall

]

#slide[

  #text(1.2em)[*Buggy _MPU Configuration_*]

  #move(dx: 1.5cm)[#figure(image("../img/tock-bug-7.png", height: 8cm))]

  #v(-0.5em)

  Covering #ttblue[*_regions_*] lets process `R+W` kernel data!

]

#slide[

  #text(1.2em)[*Buggy _MPU Configuration_*]

  #move(dx: 1.5cm)[#figure(image("../img/tock-bug-7.png", height: 8cm))]

  #v(-0.5em)

  *Challenge:* Ensure _gap_ to avoid overlap!

]


#slide[

  #v(-3em)

  #text(1.2em)[*Verified MPU Configuration*]

  #v(-0.5em)

  *Challenge:* Ensure _gap_ to avoid overlap!

  #v(1.2em)

  #uncover("2-")[
    Refine kernel's type for *_process memory_*
  ]

  #uncover("3-")[
    Refine MPU's type for *_region configuration_*
  ]
]

#slide[

  #text(1.2em)[*Verified MPU Configuration*]

  #move(dx: -2cm)[
    #figure(image("../img/tock-breaks.png", height: 8cm))
  ]
  #v(-0.5em)

  Refine kernel's type for *_process memory_*

]

#slide[

  #v(-0.8em)
  #text(1.2em)[*Verified MPU Configuration*]

  #v(0.5em)

  #toolbox.side-by-side(gutter: -5em, columns: (0.56fr, 1fr))[
    #codebox(pad: 0.0fr, size: 0.6em)[
      ```rust
      struct ProcessMemory
      {
        mem_end: Ptr[v: mem_start < v],
        kernel_brk: Ptr[v: app_brk < v],
        app_brk: Ptr[v: mem_start <= v],
        mem_start: Ptr,
      }
      ```
    ]
  ][

    #figure(image("../img/tock-breaks.png", height: 8cm))

  ]

  #v(-0.2em)

  Refine kernel's type for *_process memory_*

]

#slide[

  #v(-0.8em)
  #text(1.2em)[*Verified MPU Configuration*]

  #v(0.5em)

  #toolbox.side-by-side(gutter: -2em, columns: (1fr, 0.880fr))[

    #figure(image("../img/tock-breaks-regions.png", height: 8cm))

  ][
    #reveal-code(lines: (5, 12), full: true)[
      #codebox(pad: 0.0fr, size: 0.55em)[
        ```rust
        struct RegionConfig<R: Region>,
        {
          brks: Breaks,
          regions: Array<R>{v: ok_regions(brks, v)}
        }

        fn ok_regions(brks, regions) -> Bool {
          can_access_ram(breaks, regions) &&
          cannot_access_other(breaks, regions)
        }
        ```
      ]
    ]
  ]

  #v(-0.2em)

  Refine MPU's type for *_region configuration_*

]

#slide[

  #v(-0.8em)
  #text(1.2em)[*Verified MPU Configuration*]

  #v(0.5em)

  #toolbox.side-by-side(gutter: -2em, columns: (1fr, 0.880fr))[

    #figure(image("../img/tock-breaks-regions-overlap.png", height: 8cm))

  ][

    #codly(highlights: ((line: 9, start: 3, end: 38, fill: red),))
    #codebox(pad: 0.0fr, size: 0.55em)[
      ```rust
      struct RegionConfig<R: Region>,
      {
        brks: Breaks,
        regions: Array<R>{v: ok_regions(brks, v)}
      }

      fn ok_regions(brks, regions) -> Bool {
        can_access_ram(breaks, regions) &&
        cannot_access_other(breaks, regions)
      }
      ```
    ]
  ]

  #v(-0.2em)

  Refine MPU's type for *_region configuration_*

]


#slide[

  #v(-1.6em)

  = Verified _Isolation_ in Tock #sosp25()

  #v(1em)

  Verified _MPU configuration_

  #hide[
    Verified _interrupts & context switching_
  ]

]

#slide[

  #v(-1.6em)

  = Verified _Isolation_ in Tock #sosp25()

  #v(1em)

  #hide[
    Verified _MPU configuration_
  ]

    Verified _interrupts & context switching_

]



#slide[

  #v(-1.6em)

  == Verified Interrupts & Context switching

  _Interrupts_ can break isolation in various ways

  #uncover("2-")[
    #figure(image("../img/interrupt-bug.png", width: 50%))
  ]

]

#slide[

  #v(-1.8em)

  == Verified Interrupts & Context switching

  Lift `ARM` assembly to _Refined_ Rust methods `FluxARM`

  #uncover("2-")[
    #figure(image("../img/flux-arm.png", width: 60%))
  ]

  #uncover("3-")[
    #text(0.8em)[Verify handlers save & restore kernel/MPU configuration]
  ]
]

#slide[

  #v(-1.6em)

  = Verified _Isolation_ in Tock #sosp25()

  #v(1em)

    Verified _MPU configuration_

    Verified _interrupts & context switching_

]



#slide[

  #v(-1.6em)

  = Verified _Isolation_ in Tock #sosp25()

  #v(1em)

  #figure(image("../img/tock-sloc.png", width: 80%))

  #v(-0.5em)

  Specs = 6.5% lines of SLOC
]

#slide[
  #v(-1.05em)

  = Verified _Isolation_ in Tock #sosp25()

  #v(0.2em)

  #figure(image("../img/tock-issues.png", height: 9cm))

  #v(-0.5em)

  Verification helped find & fix *_six vulnerabilities_* ...

]

#slide[
  #v(-1.05em)

  = Verified _Isolation_ in Tock #sosp25()

  #v(0.2em)

  #figure(image("../img/tock-issues.png", height: 9cm))

  #v(-0.5em)

  ... and a *_clearer_* design with a *_faster_* kernel

]


#slide[
  #flux_logo()

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
