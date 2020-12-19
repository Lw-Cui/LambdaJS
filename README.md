# LambdaJS

LambdaJS is small, tested, reduction semantics for JavaScript. It was proposal by
Brown PLT group in 2010. Read their [paper](http://cs.brown.edu/~sk/Publications/Papers/Published/gsk-essence-javascript/). 

This repo reproduces the translation (*"desguar"*) between JavaScript and LambdaJS using **Ocaml**.


## Pipeline
![pipeline](./pipline.png)

1. JavaScript is processed by [Flow Parser](https://flow.org/) first to generate [JS AST](https://github.com/facebook/flow/blob/master/src/parser/flow_ast.ml). 
2. The translation is working on the JS AST, and the output is [LambdaJS AST](https://github.com/Lw-Cui/lambdaJS/blob/master/lib/desugar.ml). That is the core part of this repo.
3. A small utility is written to serialize the LambdaJS AST to S-expression.
4. LambdaJS S-expression interpreter is from original LambdaJS [codebase](https://github.com/brownplt/LambdaJS). The desugar result can be executed and tested directly by it.

## Build

Please install `opam`, `OCaml (>= 4.07)` and `Racket(>= 7.2)` first. You can find guide for installing `opam` [here](https://pl.cs.jhu.edu/fpse/coding.html).

Then a few third-party libraries are necessary:
```
opam install merlin user-setup menhir utop ppx_deriving ounit2 qcheck
opam pin add flow_parser https://github.com/facebook/flow.git
```

Finally,
```
dune build      # build the repo
dune runtest    # and run all unit tests!
```

## Run

You can translate JS in [example/qsort.js](./examples/qsort.js) and run generated lambdaJS directly by:
```
cat ./examples/qsort.js | dune exec ./src/translate.exe | ./interp/interp-shell.ss  
```

`dune exec` completes pipeline step 1-3 and `interp-shell` finishes pipeline step 4. The output is written to `stdout`.

Below lists supported feature. All of them are in `example` directory. You can replace the js file in above command and run it directly.

* Arithmetic: [arithmetic.js](./example/arithmetic.js)
* If statement: [condition.js](./example/condition.js)
  * Without alternative: [simple_cond.js](./examples/simple_cond.js)
* While statement: [while.js](./examples/while.js)
* Array: [array.js](./examples/array.js)
  * Array index: [array_index.js](./examples/array_index.js)
* Dictionary: [dict.js](./examples/dict.js)
  * Delete ops: [dict_delete.js](./examples/dict_delete.js)
  * Field manipulation: [arithmetic_dict.js](./examples/arithmetic_dict.js)
* Function: [argument_passing.js](./examples/argument_passing.js)
  * Function argument: [argument_changing.js](./examples/argument_changing.js)
  * High-order function: [high_order.js](./examples/high_order.js)
