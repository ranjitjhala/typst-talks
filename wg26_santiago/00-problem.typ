#import "@preview/polylux:0.4.0": *
#import "../iowa_crisp.typ": *


#slide[

  #text(size: 38pt)[*Program Verification for the 21#super[st] Century*]


  #figure(image("../img/flux.png", width: 60%))

  Ranjit Jhala, _UC San Diego_

]



#slide[
  = #text(1.2em)[Hoare Logic (1969)]

  #v(.8em)

  #figure(image("../img/hoare-axiomatic.png", width: 40%))

]

#slide[

  #v(-1.62em)

  = #text(1.2em)[Hoare Logic (1969)]

  #v(3em)

  #fhtriple([P], [c], [Q])

  #v(1em)

  #ttblue[Precondition] #h(0.8em) Command #h(0.8em) #ttgreen[Postcondition]

]

#slide[

  #v(-1em)

  = #text(1.2em)[Floyd (1967)]

  "Assigning Meanings to Programs"

  #figure(image("../img/floyd-meaning.png", width: 40%))

]

#slide[

  #v(-1em)

  = #text(1.2em)[Turing (1949)]

  "Checking a Large Routine"

  #figure(image("../img/turing-proof.png", width: 65%))

]

#slide[
  = _The Problem_

  #v(1em)

  Program Logic _vs._ 21#super[st] Century Code
]

#slide[

  = Program Logic#super[★] _vs._ 21#super[st] Century Code

  #v(1em)

  #one-by-one[][Iterations, ][Collections, ][$lambda$-Abstractions, ...][#place(bottom + center)[
      #text(size: 0.8em)[#super[★] Illustrated using `Verus`, a Rust verifier similar to `Dafny`]
    ]
  ]
]

#slide[

  = Program Logic _vs._ 21#super[st] Century Code

  #v(1em)

  *_Iterations_*, Collections, $lambda$-Abstractions, ...

]

#slide[

  #v(-1em)

  = Iteration using `while`

  #v(0.3em)

  #codly(
    highlights: ((line: 9, start: 19, end: 22, fill: red),),
  )
  #codebox(pad: 0.25fr, size: 0.55em)[
    ```rust
    fn dot_product(x: &Vec<f64>, y: &Vec<f64>) -> f64

    {
      let mut sum = 0.0;
      let mut i = 0;
      while i < x.len()

      {
        sum += x[i] * y[i];
        i += 1;
      }
      sum
    }
    ```
  ]

  #v(-0.6em)

  *Goal:* Verify vector access _in-bounds_

]


#slide[

  #v(-1em)

  = Iteration using `while`

  #v(0.3em)

  #codly(
    highlights: (
      (line: 7, start: 5, end: 48, fill: yellow),
    ),
  )
  #codebox(pad: 0.25fr, size: 0.55em)[
    ```rust
    fn dot_product(x: &Vec<f64>, y: &Vec<f64>) -> f64
      requires x.len() == y.len(),
    {
      let mut sum = 0.0;
      let mut i = 0;
      while i < x.len()
        invariant i <= x.len() && x.len() == y.len()
      {
        sum += x[i] * y[i];
        i += 1;
      }
      sum
    }
    ```
  ]

  #v(-0.6em)

  *Feasible:* Need invariant on _explicit_ iterator state!

]


#slide[

  #v(-1em)

  = Iteration using `for`

  #v(0.3em)

  #codly(
    highlights: (
      (line: 6, start: 5, end: 18, fill: red),
    ),
  )
  #codebox(pad: 0.28fr, size: 0.6em)[
    ```rust
    fn dot_product(x: &Vec<f64>, y: &Vec<f64>) -> f64
      requires x.len() == y.len(),
    {
      let mut sum = 0.0;
      for i in 0..x.len()
        invariant ???
      {
        sum += x[i] * y[i];
      }
      sum
    }
    ```
  ]

  #v(-0.6em)

  *Problem:* Need invariant on _implicit_ iterator state!

]

#slide[

  = Program Logic _vs._ 21#super[st] Century Code

  #v(1em)

  Iterations, *_Collections_*, $lambda$-Abstractions, ...

]

#slide[

  #v(-0.5em)

  = Collections

  #v(0.1em)

  #codly(
    highlights: (
      (line: 11, start: 26, end: 49, fill: red),
    ),
  )
  #codebox(pad: 0.25fr, size: 0.48em)[
    ```rust
    fn forward(ws: &Vec<Vec<f64>>, ins: &Vec<f64>) -> Vec<f64>

    {
      let mut res = Vec::new();
      let mut i = 0;
      while i < ws.len()



      {
        let weighted_input = dot_product(&ws[i], ins);
        res.push(sigmoid(weighted_input));
        i += 1;
      }
      res
    }
    ```
  ]

  #v(-0.7em)

  *Goal:* Verify _precondition_ of `dot_product`

]

#slide[

  #v(-0.5em)

  = Collections

  #v(0.1em)

  #codly(
    highlights: (
      (line: 2, start: 3, end: 75, fill: yellow),
      (line: 9, start: 7, end: 69, fill: yellow),
    ),
  )
  #codebox(pad: 0.25fr, size: 0.48em)[
    ```rust
    fn forward(ws: &Vec<Vec<f64>>, ins: &Vec<f64>) -> Vec<f64>
      requires forall |i: int| 0 <= i < ws.len() ==> ws[i].len() == ins.len()
    {
      let mut res = Vec::new();
      let mut i = 0;
      while i < ws.len()
        invariant
          i <= ws.len(),
          forall |j: int| 0 <= j < ws.len() ==> ws[j].len() == ins.len(),
      {
        let weighted_input = dot_product(&ws[i], ins);
        res.push(sigmoid(weighted_input));
        i += 1;
      }
      res
    }
    ```
  ]

  #v(-0.7em)

  *Problem:* Quantified contracts (hard to write & verify)
]

#slide[

  = Program Logic _vs._ 21#super[st] Century Code

  #v(1em)

  Iterations, Collections, *_$lambda$-Abstractions_*, ...

]

#slide[

  #v(-1em)

  = $lambda$-Abstractions

  #v(0.5em)

  #codebox(pad: 0.2fr, size: 0.58em)[
    #reveal-code(lines: (1, 6, 50), full: false)[
      ```rust
      // Create a 2-d out_size x in_size weight matrix
      fn mk_weights(in_size: usize, out_size: usize) -> Vec<Vec<f64>> {
        init(out_size, |_| {
          init(in_size, |_| random())
        })
      }

      fn init<A>(n: usize, f: impl FnMut(usize) -> A) -> Vec<A> {
        let mut res = Vec::new();
        for i in 0 .. n {
          res.push(f(i));
        }
        res
      }
      ```
    ]
  ]
]

#slide[

  #v(-0.7em)

  = $lambda$-Abstractions

  #v(0.1em)

  #codebox(pad: 0.45fr, size: 0.4em)[
    ```rust
    fn init<A>(n: usize, mut f: impl FnMut(usize) -> A) -> Vec<A>





    {
        let mut res = Vec::new();
        let mut i = 0;
        while i < n





        {
            res.push(f(i));
            i += 1;
        }
        res
    }
    ```
  ]
  #v(-0.7em)
  #ttwhite[*Problem:* Hairy _higher-order_ contracts!]
]

#slide[

  #v(-0.7em)

  = $lambda$-Abstractions

  #v(0.1em)

  #codly(
    highlights: (
      (line: 3, start: 5, end: 75, fill: yellow),
      (line: 6, start: 5, end: 75, fill: yellow),
      (line: 14, start: 9, end: 61, fill: yellow),
      (line: 15, start: 9, end: 67, fill: yellow),
    ),
  )
  #codebox(pad: 0.45fr, size: 0.4em)[
    ```rust
    fn init<A>(n: usize, mut f: impl FnMut(usize) -> A) -> Vec<A>
      requires
        forall|i:int| 0 <= i < n ==> call_requires(f, i),
      ensures
        res.len() == n,
        forall|i: int| 0 <= i < n ==> call_ensures(f, i, res[i])
    {
        let mut res = Vec::new();
        let mut i = 0;
        while i < n
          invariant
            i <= n,
            res.len() == i,
            forall|i: int| 0 <= i < n ==> call_requires(f, i),
            forall|j: int| 0 <= j < i ==> call_ensures(f, j, res[j])
        {
            res.push(f(i));
            i += 1;
        }
        res
    }
    ```
  ]

  #v(-0.7em)

  *Problem:* Hairy _higher-order_ contracts!
]

#slide[

  = Program Logic _vs._ 21#super[st] Century Code

  #v(1em)

  Iterations, Collections, $lambda$-Abstractions, ...

]

#slide[#my-outline(2)]
