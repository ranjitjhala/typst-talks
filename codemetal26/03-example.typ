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

        *2. _Ownership_* `mut`, `&`, `&mut`, ...
      ]

      *3. _Example_* revisited
    ]
  ]
]


#slide[
  = 3. Example revisited

  #v(1.5em)

  #ttgreen[*_Types_*] make specification & verification #ttpurple[*_compositional_*]
  #v(1em)

]

#slide[
  = #text(1.2em)[`struct`]: _Refined Vectors_

  #v(1em)

  #codly(highlights: ((line: 100, start: 0, end: 0, fill: red),))
  #codebox(pad: 0.42fr, size: 1em)[
    ```rust

    struct RVec<T> {
      inner: Vec<T>;
    }
    ```
  ]

  `RVec` is a _refined wrapper_ around standard library `Vec`
]



#slide[
  = #text(1.2em)[`struct`]: _Refined Vectors_

  #v(1em)

  #codly(highlights: ((line: 100, start: 0, end: 0, fill: red),))
  #codebox(pad: 0.42fr, size: 1em)[
    ```rust
    #[refined_by(len: int)]
    struct RVec<T> {
      inner: Vec<T>;
    }
    ```
  ]

  *`refined_by`*: #ttpurple[_refinement value(s)_] tracked for #ttgreen[`RVec<T>`]

]

#slide[ = Refined Vectors: Specification ]

#slide[

  #v(-0.3em)

  = Refined Vectors: _Specification_

  #v(0.3em)

  #codly(highlights: ((line: 100, start: 0, end: 0, fill: red),))
  #codebox(pad: 0.18fr, size: .65em)[

    #reveal-code(lines: (1, 3, 6, 10, 14), full: true)[
      ```rust
      impl RVec<T> {
        // create a new refined vector of size 0
        fn new() -> RVec<T>[0];

        // retrieve the size of the vector
        fn len(&self[@n]) -> usize[n];

        // get/set element at index i statically checking bounds
        fn get(&self[@n], i: usize{v: v < n}) -> &T;
        fn set(&mut self[@n], i: usize{v: v < n}, val: T) -> &T;

        // insert element at the end of the vector
        fn push(&mut self[@n], val: T) ensures self: RVec<T>[n+1];
      }
      ```
    ]
  ]
]

#slide[

  = 21#super[st] Century Verification

  #v(1em)

  *_Iterations_*, Collections, $lambda$-Abstractions, ...

]



#slide[
  #v(-1em)

  = Iteration using `while`

  #v(0.3em)

  #toolbox.side-by-side(columns: (0.01fr, 0.62fr, 0.75fr, 0.01fr))[][
    #codly(
      highlights: (
        (line: 3, start: 3, end: 48, fill: yellow),
      ),
    )
    #text(size: 0.50em)[
      ```rust
      fn dot_product(x:&Vec<f64>, y:&Vec<f64>)
         -> f64
        requires x.len() == y.len(),
      {











      }
      ```
    ]
  ][
    #codly(
      highlights: (
        (line: 1, start: 27, end: 30, fill: yellow),
        (line: 1, start: 44, end: 46, fill: yellow),
      ),
    )
    #text(size: 0.50em)[
      ```rust
      fn dot_product(x:&Vec<f64>[@n], y:&Vec<f64>[n])
         -> f64

      {











      }
      ```
    ]
  ][]

  #v(-0.6em)

  *Same index* specifies same size precondition

]

#slide[
  #v(-1em)

  = Iteration using `while`

  #v(0.3em)

  #toolbox.side-by-side(columns: (0.01fr, 0.62fr, 0.75fr, 0.01fr))[][
    #codly(
      highlights: (
        (line: 8, start: 5, end: 48, fill: yellow),
        (line: 9, start: 7, end: 48, fill: yellow),
        (line: 10, start: 7, end: 48, fill: yellow),
      ),
    )
    #text(size: 0.50em)[
      ```rust
      fn dot_product(x:&Vec<f64>, y:&Vec<f64>)
         -> f64
        requires x.len() == y.len(),
      {
        let mut sum = 0.0;
        let mut i = 0;
        while i < x.len()
          invariant
            i <= x.len(),
            x.len() == y.len()
        {
          sum += x[i] * y[i];
          i += 1;
        }
        sum
      }
      ```
    ]
  ][
    #codly(
      highlights: (),
    )
    #text(size: 0.50em)[
      ```rust
      fn dot_product(x:&Vec<f64>[@n], y:&Vec<f64>[n])
         -> f64

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
  ][]

  #v(-0.6em)

  *Invariant* via _immutable type_
]



#slide[

  = Iteration with `for` loop

  #v(0.5em)

  #codly(
    highlights: (
      (line: 1, start: 27, end: 30, fill: yellow),
      (line: 1, start: 44, end: 46, fill: yellow),
    ),
  )
  #codebox(pad: 0.09fr, size: 0.77em)[
    ```rust
    fn dot_product(x:&Vec<f64>[@n], y:&Vec<f64>[n]) -> f64
    {
      let mut sum = 0.0;
      for i in 0..x.len() {   // iterator guarantees
        sum += x[i] * y[i];   //   0 <= i < n
      }
      sum
    }
    ```
  ]

  #v(-0.5em)

  *Permits _range_ iteration* instead of old school `while`

]

#slide[

  = 21#super[st] Century Verification

  #v(1em)

  Iterations, *_Collections_*, $lambda$-Abstractions, Datatypes,...

]



#slide[

  #v(-0.5em)

  = Collections

  #v(0.1em)

  #toolbox.side-by-side(columns: (0.75fr, 0.70fr))[
    #codly(
      highlights: (
        (line: 4, start: 5, end: 62, fill: yellow),
      ),
    )
    #text(size: 0.42em)[
      ```rust
      fn forward(ws: &Vec<Vec<f64>>, ins: &Vec<f64>)
        -> Vec<f64>
        requires
          ∀ |i:int| 0 <= i < ws.len() ==> ws[i].len() == ins.len()
      {












      }
      ```
    ]
  ][
    #codly(
      highlights: (
        (line: 1, start: 29, end: 31, fill: yellow),
        (line: 1, start: 49, end: 52, fill: yellow),
      ),
    )
    #text(size: 0.42em)[
      ```rust
      fn forward(ws: &Vec<Vec<f64>[n]>, ins: &Vec<f64>[@n])
        -> Vec<f64>


      {












      }
      ```
    ]
  ]
  #v(-0.7em)

  *Quantified contracts* via _type composition_
]


#slide[

  #v(-0.5em)

  = Collections

  #v(0.1em)

  #toolbox.side-by-side(columns: (0.75fr, 0.70fr))[
    #codly(
      highlights: (
        (line: 9, start: 5, end: 69, fill: yellow),
        (line: 10, start: 7, end: 69, fill: yellow),
        (line: 11, start: 7, end: 69, fill: yellow),
      ),
    )
    #text(size: 0.42em)[
      ```rust
      fn forward(ws: &Vec<Vec<f64>>, ins: &Vec<f64>)
        -> Vec<f64>
        requires
          ∀ |i:int| 0 <= i < ws.len() ==> ws[i].len() == ins.len()
      {
        let mut res = Vec::new();
        let mut i = 0;
        while i < ws.len()
          invariant
            i <= ws.len(),
            ∀ |j:int| 0 <= j < ws.len() ==> ws[j].len() == ins.len()
        {
          let weighted_input = dot_product(&ws[i], ins);
          res.push(sigmoid(weighted_input));
          i += 1;
        }
        res
      }
      ```
    ]
  ][
    #codly(
      highlights: (),
    )
    #text(size: 0.42em)[
      ```rust
      fn forward(ws: &Vec<Vec<f64>[n]>, ins: &Vec<f64>[@n])
        -> Vec<f64>


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
  ]
  #v(-0.7em)

  *Quantified invariants* via _syntactic typing_
]


#slide[

  = 21#super[st] Century Verification

  #v(1em)

  Iterations, Collections, *_$lambda$-Abstractions_*, Datatypes, ...

]


#slide[
  #v(-0.5em)

  = $lambda$-Abstractions

  #v(0.1em)

  #toolbox.side-by-side(gutter: 0.2em, columns: (0.7fr, 0.743fr))[
    #codly(
      highlights: (
        (line: 2, start: 3, end: 69, fill: yellow),
        (line: 3, start: 5, end: 69, fill: yellow),
        (line: 4, start: 3, end: 69, fill: yellow),
        (line: 5, start: 5, end: 69, fill: yellow),
        (line: 6, start: 5, end: 69, fill: yellow),
        (line: 11, start: 7, end: 69, fill: yellow),
        (line: 12, start: 9, end: 69, fill: yellow),
        (line: 13, start: 9, end: 69, fill: yellow),
        (line: 14, start: 9, end: 69, fill: yellow),
      ),
    )
    #text(size: 0.41em)[
      ```rust
      fn init<A>(n: usize, mut f: impl FnMut(usize) -> A) -> Vec<A>
        requires
          ∀ |i:int| 0 <= i < n ==> call_requires(f, i)
        ensures
          res.len() == n,
          ∀ |i:int| 0 <= i < n ==> call_ensures(f, i, res[i])
      {












      }
      ```
    ]
  ][
    #codly(
      highlights: (
        (line: 1, start: 62, end: 64, fill: yellow),
      ),
    )
    #text(size: 0.41em)[
      ```rust
      fn init<A>(n: usize, mut f: impl FnMut(usize) -> A) -> Vec<A>[n]





      {












      }
      ```
    ]
  ]
  #v(-0.7em)

  *Higher-order contracts* via _parametric polymorphism_

]

#slide[
  #v(-0.5em)

  = $lambda$-Abstractions

  #v(0.1em)

  #toolbox.side-by-side(gutter: 0.2em, columns: (0.7fr, 0.743fr))[
    #codly(
      highlights: (
        (line: 11, start: 7, end: 69, fill: yellow),
        (line: 12, start: 9, end: 69, fill: yellow),
        (line: 13, start: 9, end: 69, fill: yellow),
        (line: 14, start: 9, end: 69, fill: yellow),
      ),
    )
    #text(size: 0.41em)[
      ```rust
      fn init<A>(n: usize, mut f: impl FnMut(usize) -> A) -> Vec<A>
        requires
          ∀ |i:int| 0 <= i < n ==> call_requires(f, i)
        ensures
          res.len() == n,
          ∀ |i:int| 0 <= i < n ==> call_ensures(f, i, res[i])
      {
          let mut res = Vec::new();
          let mut i = 0;
          while i < n
            invariant
              i <= n, res.len() == i,
              ∀ |i:int| 0 <= i < n ==> call_requires(f, i),
              ∀ |j:int| 0 <= j < i ==> call_ensures(f, j, res[j])
          {
              res.push(f(i));
              i += 1;
          }
          res
      }
      ```
    ]
  ][
    #codly(
      highlights: (),
    )
    #text(size: 0.41em)[
      ```rust
      fn init<A>(n: usize, mut f: impl FnMut(usize) -> A) -> Vec<A>[n]





      {
          let mut res = Vec::new(); // res: Vec<A>[0]
          let mut i = 0;
          while i < n               // res: Vec<A>[i]




          {
              res.push(f(i));
              i += 1;
          }
          res                       // res: Vec<A>[n]
      }
      ```
    ]
  ]
  #v(-0.7em)

  *Quantifier-free Invariant* via _refinement synthesis_

]


// #slide[
//   #v(-0.5em)

//   = $lambda$-Abstractions

//   #v(0.1em)

//   #toolbox.side-by-side(gutter: 0.2em, columns: (0.7fr, 0.72fr))[
//     #codly(
//       highlights: (
//         (line: 11, start: 7, end: 69, fill: yellow),
//         (line: 12, start: 9, end: 69, fill: yellow),
//         (line: 13, start: 9, end: 69, fill: yellow),
//         (line: 14, start: 9, end: 69, fill: yellow),
//       ),
//     )
//     #text(size: 0.41em)[
//       ```rust
//       fn init<A>(n: usize, mut f: impl FnMut(usize) -> A) -> Vec<A>
//         requires
//           ∀ |i:int| 0 <= i < n ==> call_requires(f, i)
//         ensures
//           res.len() == n,
//           ∀ |i:int| 0 <= i < n ==> call_ensures(f, i, res[i])
//       {
//           let mut res = Vec::new();
//           let mut i = 0;
//           while i < n
//             invariant
//               i <= n, res.len() == i,
//               ∀ |i:int| 0 <= i < n ==> call_requires(f, i),
//               ∀ |j:int| 0 <= j < i ==> call_ensures(f, j, res[j])
//           {
//               res.push(f(i));
//               i += 1;
//           }
//           res
//       }
//       ```
//     ]
//   ][
//     #codly(
//       highlights: (),
//     )
//     #text(size: 0.41em)[
//       ```rust
//       fn init<A>(n: usize, mut f: impl FnMut(usize) -> A) -> Vec<A>[n]
//       {
//           let mut res = Vec::new();
//           let mut i = 0;
//           while i < n
//           {
//               res.push(f(i));
//               i += 1;
//           }
//           res
//       }

//       // Create a 2-d out_size x in_size weight matrix
//       fn mk_weights(in_size: usize, out_size: usize)
//         -> Vec<Vec<f64>[in_size]>[out_size]
//       {
//         init(out_size, |_| {          // A := Vec<f64>[in_size]
//           init(in_size, |_| random()) // A := f64
//         })
//       }
//       ```
//     ]
//   ]
//   #v(-0.7em)

//   *Polymorphic Instantiation* via _refinement synthesis_

// ]


#slide[
  #v(-0.5em)

  = $lambda$-Abstractions

  #v(0.4em)
  #codly(
    highlights: (),
  )
  #codebox(pad: .125fr, size: 0.65em)[

    #reveal-code(lines: (3, 11), full: true)[
      ```rust
      fn init<A>(n: usize, mut f: impl FnMut(usize) -> A) -> Vec<A>[n]
      { /* ... */ }

      // Create a 2-d out_size x in_size weight matrix
      fn mk_weights(in_size: usize, out_size: usize)
         -> Vec<Vec<f64>[in_size]>[out_size]
      {
        init(out_size, |_| {          // A := Vec<f64>[in_size]
          init(in_size, |_| random()) // A := f64
        })
      }
      ```
    ]
  ]
  #v(-0.4em)

  *Polymorphic Instantiation* via _refinement synthesis_
]

#slide[

  = 21#super[st] Century Verification

  #v(1em)

  Iterations, Collections, $lambda$-Abstractions, *_Datatypes_*, #link(<my_anchor>)[...]

]


#slide[
  #v(-0.45em)

  = Datatypes

  #v(2em)

  #toolbox.side-by-side()[
    #text(1.5em)[#ttgreen[`struct`]]

    _"Product"_ types
  ][
    #hide[
      #text(1.5em)[#ttgreen[`enum`]]

      _"Sum"_ types
    ]
  ]
]

#slide[
  = *Example:* _Neuron Layer_

  #v(1em)

  #figure(image("../img/neural-layer-2.png", height: 70%))

]

#slide[
  = Neuron Layer: _Specification_

  #v(1em)

  #center-block2(pad: 0.00fr)[
    #figure(image("../img/neural-layer-2.png", height: 70%))
  ][
    #codly(highlights: ((line: 100, start: 0, end: 0, fill: red),))
    #codebox(pad: 0.0fr, size: 0.7em)[
      #reveal-code(lines: (2, 4, 5, 6, 8), full: true)[
        ```rust
        #[refined_by(i: int, o: int)]
        struct Layer {
          num_inputs: usize[i],
          num_outputs: usize[o],
          weight: RVec<RVec<f64>[i]>[o],
          bias: RVec<f64>[o],
          outputs: RVec<f64>[o],
        }
        ```
      ]
    ]
  ]
]

#slide[
  = Neuron Layer: _Verification_

  #v(0.5em)

  #codly(highlights: ((line: 100, start: 0, end: 0, fill: red),))
  #codebox(pad: 0.15fr, size: 0.65em)[
    ```rust
    fn new(i: usize, o: usize) -> Layer[i, o] {
      let mut rng = rand::thread_rng();
      Layer {
        num_inputs: i,
        num_outputs: o,
        weight: init(o, |_| init(i, |_| rng.gen_range(-1.0..1.0))),
        bias: init(o, |_| rng.gen_range(-1.0..1.0)),
        outputs: init(o, |_| 0.0),
      }
    }
    ```
  ]
]

#slide[
  = Neuron Layer: _Forward Propagation_

  #v(0.5em)

  #figure(image("../img/neural-layer-3.png", height: 77%))

]

#slide[

  #v(-0.60em)

  = Neuron Layer: _Forward Propagation_

  #v(1em)

  #center-block2(pad: 0.00fr, size1: 0.45fr, size2: 0.7fr)[
    #figure(image("../img/neural-layer-3.png", height: 65%))
  ][
    #codly(highlights: ((line: 100, start: 0, end: 0, fill: red),))
    #codebox(pad: 0.0fr, size: 0.66em)[
      #reveal-code(lines: (1, 2, 3, 4, 5), full: true)[
        ```rust
        fn forward(&mut self, input: &RVec<f64>) {
          (0..self.num_outputs).for_each(|i| {
            let wt = dot(&self.weight[i], input);
            let sum = wt + self.bias[i];
            self.outputs[i] = sigmoid(sum);
          })
        }
        ```
      ]
    ]
    #ttwhite()[*Exercise:* Can you _fix_ the error?]
  ]
]

#slide[

  #v(-0.60em)

  = Neuron Layer: _Forward Propagation_

  #v(1em)

  #center-block2(pad: 0.00fr, size1: 0.45fr, size2: 0.7fr)[
    #figure(image("../img/neural-layer-3.png", height: 65%))
  ][
    #codly(highlights: ((line: 3, start: 14, end: 46, fill: red),))
    #codebox(pad: 0.0fr, size: 0.66em)[
      ```rust
      fn forward(&mut self, input: &RVec<f64>) {
        (0..self.num_outputs).for_each(|i| {
          let wt = dot(&self.weight[i], input);
          let sum = wt + self.bias[i];
          self.outputs[i] = sigmoid(sum);
        })
      }
      ```
    ]
    *Exercise:* Can you _fix_ the error?
  ]
]

#slide[

  = Datatypes

  #v(2em)

  #toolbox.side-by-side()[
    #hide[
      #text(1.5em)[#ttgreen[`struct`]]

      _"Product"_ types
    ]
  ][
    #text(1.5em)[#ttgreen[`enum`]]

    _"Sum"_ types
  ]
]

#slide[
  = #text(1.5em)[`enum`]

  #v(1em)

  *Example:* _Neural Network_
]

#slide[
  == *Neural Network has _Many_ Layers*

  #v(0.5em)

  #figure(image("../img/neural-network-1.png", height: 65%))

  #v(-0.75em)

  #ttwhite[How to ensure _layers compose_ correctly?]
]


#slide[
  == *Neural Network has _Many_ Layers*

  #v(0.5em)

  #figure(image("../img/neural-network-2.png", height: 65%))

  #v(-0.75em)

  #ttwhite[How to ensure _layers compose_ correctly?]
]


#slide[
  == *Neural Network has _Many_ Layers*

  #v(0.5em)

  #figure(image("../img/neural-network-3.png", height: 65%))

  #v(-0.75em)

  #ttwhite[How to ensure _layers compose_ correctly?]
]

#slide[
  == *Neural Network has _Many_ Layers*

  #v(0.5em)

  #figure(image("../img/neural-network-4.png", height: 65%))

  #v(-0.75em)

  #ttwhite[How to ensure _layers compose_ correctly?]
]



#slide[
  == *Neural Network has _Many_ Layers*

  #v(0.5em)

  #figure(image("../img/neural-network-4.png", height: 65%))

  #v(-0.75em)

  How to ensure layers _compose_ correctly?
]


#slide[

  #v(-1.5em)

  = *Neural Network:* _Specification_

  #v(1em)

  #codly(highlights: ((line: 100, start: 0, end: 0, fill: red),))
  #codebox(pad: 0.00fr, size: 0.8em)[
    ```rust

    enum Network {
      Last(Layer),
      Next(Layer, Box<Network>),
    }
    ```
  ]

  How to ensure layers _compose_ correctly?
]

#slide[

  #v(-1.5em)

  = *Neural Network:* _Specification_

  #v(1em)

  #codly(highlights: ((line: 100, start: 0, end: 0, fill: red),))
  #codebox(pad: 0.00fr, size: 0.8em)[
    #reveal-code(lines: (2, 3, 5), full: true)[
      ```rust
      #[refined_by(i: int, o: int)]
      enum Network {
        Last(Layer[@i, @o]) -> Network[i, o],
        Next(Layer[@i, @n], Box<Network[n, @o]>) -> Network[i, o],
      }
      ```
    ]
  ]

  How to ensure layers _compose_ correctly?
]

#slide[
  === *Refinements Ensure Correct _Composition_*

  #v(0.5em)

  #figure(image("../img/neural-network-1.png", height: 65%))

  #v(-0.15em)

  `Last(Layer[3,4]) ---> Network[3, 4]`

]


#slide[
  === *Refinements Ensure Correct _Composition_*

  #v(0.5em)

  #figure(image("../img/neural-network-2.png", height: 65%))

  #v(-0.15em)

  `Next(Layer[2,3], Network[3,4]) ---> Network[2, 4]`
]


#slide[
  === *Refinements Ensure Correct _Composition_*

  #v(0.5em)

  #figure(image("../img/neural-network-3.png", height: 65%))

  #v(-0.15em)

  `Next(Layer[4,2], Network[2,4]) ---> Network[4, 4]`
]

#slide[
  === *Refinements Ensure Correct _Composition_*

  #v(0.5em)

  #figure(image("../img/neural-network-4.png", height: 65%))

  #v(-0.15em)

  `Next(Layer[3,4], Network[4,4]) ---> Network[4, 4]`
]


#slide[
  == Neural Network: _Verification_

  #v(0.5em)

  #codly(highlights: ((line: 100, start: 0, end: 0, fill: red),))
  #codebox(pad: 0.22fr, size: 0.6em)[
    #reveal-code(lines: (2, 5, 7, 8, 9, 12), full: true)[
      ```rust
      fn new(input: usize, hidden: &[usize], output: usize)
         -> Network[input, output]
      {
        if hidden_sizes.len() == 0 {
          Network::Last(Layer::new(input, output))
        } else {
          let n = hidden[0];
          let layer = Layer::new(input, n);
          let rest = Network::new(n, &hidden[1..], output);
          Network::Next(layer, Box::new(rest))
        }
      }
      ```
    ]
  ]
]

#slide[
  == Neural Network: _Verification_

  #v(0.2em)

  #codly(
    highlights: (
      (line: 4, start: 7, end: 26, fill: red),
      (line: 8, start: 7, end: 26, fill: red),
    ),
  )
  #codebox(pad: 0.23fr, size: 0.53em)[
    #reveal-code(lines: (1, 3, 6, 7, 8, 12), full: true)[
      ```rust
      fn forward(&mut Network, input: &RVec<f64>) -> RVec<f64> {
        match self {
          NeuralNetwork::Last(layer) => {
            layer.forward(input);
            layer.outputs.clone()
          }
          NeuralNetwork::Next(layer, next) => {
            layer.forward(input);
            next.forward(&layer.outputs)
          }
        }
      }
      ```
    ]
  ]

  #v(-0.58em)

  #ttwhite[*Exercise:* _Fix_ the specification for #text(size: 1.2em)[`forward`]?]

]

#slide[
  == Neural Network: _Verification_

  #v(0.2em)

  #codly(
    highlights: (
      (line: 4, start: 7, end: 26, fill: red),
      (line: 8, start: 7, end: 26, fill: red),
    ),
  )
  #codebox(pad: 0.23fr, size: 0.53em)[
    ```rust
    fn forward(&mut Network, input: &RVec<f64>) -> RVec<f64> {
      match self {
        NeuralNetwork::Last(layer) => {
          layer.forward(input);
          layer.outputs.clone()
        }
        NeuralNetwork::Next(layer, next) => {
          layer.forward(input);
          next.forward(&layer.outputs)
        }
      }
    }
    ```
  ]

  #v(-0.58em)

  *Exercise:* _Fix_ the specification for #text(size: 1.2em)[`forward`]?

]

#slide[

  #my-outline-codemetal(6) <my_anchor>

]
