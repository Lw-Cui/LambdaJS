# Lambda JS

LambdaJS is small, tested, reduction semantics for JavaScript. It was proposal by
Brown PLT group in 2010 [[paper]](http://cs.brown.edu/~sk/Publications/Papers/Published/gsk-essence-javascript/). 

This repo reproduces the translation between JavaScript and LambdaJS using **Ocaml**.


## Pipeline
![pipline](./pipline.png)



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

