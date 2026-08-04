#import "@preview/polylux:0.4.0": *
#import "../iowa_crisp.typ": *

#slide[

  #v(-1em)

  = #text(1.2em)[Weave #ttpurple[Assertions] into #ttgreen[Types]]

  #v(2em)

  #center-block(pad: 0.25fr)[

    #text(1.4em)[

      #hide[
        *1. _Refinements_* `i32`, `bool`, ...
      ]

      *2. _Ownership_* `mut`, `&`, `&mut`, ...

      #hide[
        *3. _Example_* revisited
      ]
    ]
  ]
]

#slide[#my-outline(4)]

#slide[
  = _2. Ownership_

  #v(1em)

  #one-by-one[
  ][

    *Update* types at #ttgreen[_owned locations_]

  ][

    *Preserve* refinements in #ttgreen[_borrows_]

  ][

    *Strong* updates at #ttgreen[_mutable borrows_]

  ]

]

#slide[
  = _2. Ownership_

  #v(1em)

  *Update* types at #ttgreen[_owned locations_]

  #hide[

    *Preserve* refinements in #ttgreen[_borrows_]

    *Strong* updates at #ttgreen[_mutable borrows_]

  ]

]


#slide[ = *Update* types at #ttgreen[_owned locations_] ]

#slide[
  == *Update* types at #ttgreen[_owned locations_]

  #v(1em)

  #codly(highlights: ((line: 100, start: 0, end: 0, fill: red),))
  #codebox(size: 0.8em, pad: .20fr)[
    #reveal-code(lines: (2, 4, 6), full: false)[
      ```rust
      let mut x = 0;    // x : i32[0]
      assert(x == 0);
      x += 10;          // x : i32[10]
      assert(x == 10);
      x += 10;          // x : i32[20]
      assert(x == 20);
      ```
    ]
  ]
  Exclusive ownership allows strong updates
]

#slide[
  = _2. Ownership_

  #v(1em)

  #hide[
    *Update* types at #ttgreen[_owned locations_]
  ]

  *Preserve* refinements in #ttgreen[_borrows_]

  #hide[

    *Strong* updates at #ttgreen[_mutable borrows_]

  ]

]

#slide[ = *Preserve* refinements in #ttgreen[_borrows_] ]

#slide[
  == *Preserve* refinements in #ttgreen[_borrows_]

  #v(1em)

  #codly(highlights: ((line: 100, start: 0, end: 0, fill: red),))
  #codebox(size: 1em, pad: .28fr)[
    ```rust
    fn read(x: &i32{v: 0 < v}) {
      let n = *x;
      assert(0 < n);
    }
    ```
  ]

  #v(-0.08em)

  *`&` reference = aliasing but _no mutation_*

  #v(-0.5em)

  Value _read_ through `&` reference satisfies refinements
]

#slide[
  = _2. Ownership_

  #v(1em)

  #hide[
    *Update* types at #ttgreen[_owned locations_]

    *Preserve* refinements in #ttgreen[_borrows_]
  ]

  *Strong* updates at #ttgreen[_mutable borrows_]

]

#slide[ = *Strong* updates at #ttgreen[_mutable borrows_] ]

#slide[

  #v(-1.75em)

  == *Strong* updates at #ttgreen[_mutable borrows_]

  #v(0.5em)

  #codly(highlights: ((line: 200, start: 0, end: 5, fill: red),))
  #codebox(size: 0.7em, pad: .20fr)[
    #reveal-code(lines: (3, 5, 8), full: false)[
      ```rust
      fn incr(x: &mut i32[@n]) ensures x: i32[n+1] {
        *x += 1;
      }
      fn test() {
        let mut z = 1;  // z: i32[1]
        incr(&z);
        assert(z == 2); // z: i32[2]
      }
      ```
    ]
  ]
]

#slide[
  == *Strong* updates at #ttgreen[_mutable borrows_]

  #v(0.5em)

  #codly(highlights: ((line: 200, start: 0, end: 5, fill: red),))
  #codebox(size: 0.7em, pad: .20fr)[
    ```rust
    fn incr(x: &mut i32[@n]) ensures x: i32[n+1] {
      *x += 1;
    }
    fn test() {
      let mut z = 1;  // z: i32[1]
      incr(&z);
      assert(z == 2); // z: i32[2]
    }
    ```
  ]

  #v(-0.5em)

  Sound as `&mut` is _unique_ (no aliasing)

]


#slide[
  = _2. Ownership_

  #v(1em)

  *Update* types at #ttgreen[_owned locations_]

  *Preserve* refinements in #ttgreen[_borrows_]

  *Strong* updates at #ttgreen[_mutable borrows_]

]
