# Lambda JS Translation

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

