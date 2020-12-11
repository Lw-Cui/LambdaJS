# Lambda JS

LambdaJS is small, tested, reduction semantics for JavaScript. It was proposal by
Brown PLT group in 2010. See their [paper](http://cs.brown.edu/~sk/Publications/Papers/Published/gsk-essence-javascript/). 

This repo reproduces the translation (so-called *"desguar"*) between JavaScript and LambdaJS using **Ocaml**.


## Pipeline
![pipline](./pipline.png)

1. JavaScript is processed by [Flow Parser](https://flow.org/) first to generate [JS AST](https://github.com/facebook/flow/blob/master/src/parser/flow_ast.ml). 
2. The translation is working on the JS AST, and the output is [LambdaJS AST](https://github.com/Lw-Cui/lambdaJS/blob/master/lib/desugar.ml). That is the core part of this repo.
3. A small utility is written to serialize the LambdaJS AST to S-expression.
4. LambdaJS S-expression interpreter is adopted from original LambdaJS [codebase](https://github.com/brownplt/LambdaJS), hence the desugar result can be executed and tested directly.

## Build

## Run the code

Run an example javascript snippet:
```
cat ./examples/qsort.js | dune exec ./src/translate.exe | ./interp/interp-shell.ss  
```

Run all unit tests:
```
dune runtest
```

