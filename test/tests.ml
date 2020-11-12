open Desugar
open OUnit2

let tests = "test suite for desugar" >::: [
  "dictionary" >:: (fun _ -> assert_equal 
    (desugar_code "
        var v = {'name': 'liwei', 'answer': 42}; 
        var c = 5, b = 6;
        print (v['name']) 
    ")

    {| (let  ( ($global  (alloc  (object ) ) ) )   (let  ( (@Object_prototype  (alloc  (object ) ) ) )   (begin  (begin  (set! $global  (update-field  (deref $global)  "v"  (alloc  (object  ("$proto" @Object_prototype)  ("$class" "Object")  ("name" "liwei")  ("answer"  42.) ) ) ) )  undefined)   (begin  (begin  (set! $global  (update-field  (deref $global)  "c"  5.) )   (begin  (set! $global  (update-field  (deref $global)  "b"  6.) )  undefined) )   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "v") )  "name") ) )  undefined) ) ) ) ) |}
  );

  "field" >:: (fun _ -> assert_equal
    (desugar_code "
        var v = {'name': 'liwei', 'answer': 42}; 
        v['name'] = 5;
        print (v['name']);
        delete v['name'];
        print (v['name']);
    ")

    {| (let  ( ($global  (alloc  (object ) ) ) )   (let  ( (@Object_prototype  (alloc  (object ) ) ) )   (begin  (begin  (set! $global  (update-field  (deref $global)  "v"  (alloc  (object  ("$proto" @Object_prototype)  ("$class" "Object")  ("name" "liwei")  ("answer"  42.) ) ) ) )  undefined)   (begin  (set!  (get-field  (deref $global)  "v")   (update-field  (deref  (get-field  (deref $global)  "v") )  "name"  5.) )   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "v") )  "name") ) )   (begin  (set!  (get-field  (deref $global)  "v")   (delete-field  (deref  (get-field  (deref $global)  "v") )  "name") )   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "v") )  "name") ) )  undefined) ) ) ) ) ) ) |}
  );

  "assignment" >:: (fun _ -> assert_equal
    (desugar_code "
        var x = {'a': 'b'};
        x = {'x': 'x'};
        print (x['x']);
    ")
    {| (let  ( ($global  (alloc  (object ) ) ) )   (let  ( (@Object_prototype  (alloc  (object ) ) ) )   (begin  (begin  (set! $global  (update-field  (deref $global)  "x"  (alloc  (object  ("$proto" @Object_prototype)  ("$class" "Object")  ("a" "b") ) ) ) )  undefined)   (begin  (set! $global  (update-field  (deref $global)  "x"  (alloc  (object  ("$proto" @Object_prototype)  ("$class" "Object")  ("x" "x") ) ) ) )   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "x") )  "x") ) )  undefined) ) ) ) ) |}
  );

  "big!" >:: (fun _ -> assert_equal
    (desugar_code "
        function proc(x) {
            print ('')
            print ('enter <proc>');
            print ('value of x[name]:');
            print (x['name']);

            delete x['name'];
            print ('after delete x[name]:');
            print (x['name']);

            x = {'answer': 99}

            print ('leave <proc>');
            print ('')
            return x['answer'];
        }

        var v = 5;
        v = {'age': 18, 'name': 'liwei', 'answer': 42}; 

        print ('value of v[name]:');
        print (v['name']);

        var c = proc (v);
        print('return from [proc]:');
        print(c);

        print ('value of v[age]:');
        print (v['age']);
        print ('value of v[name]:');
        print (v['name']);
        print('set v[name] to Cui:');
        v['name'] = 'Cui';
        print (v['name']);
    ")
  
    {| (let  ( ($global  (alloc  (object ) ) ) )   (let  ( (@Object_prototype  (alloc  (object ) ) ) )   (begin  (set! $global  (update-field  (deref $global)  "proc"  (lambda  (this x)   (let  ( (x  (alloc x) ) )   (label $return    (begin  (print-string  (prim->string "") )   (begin  (print-string  (prim->string "enter <proc>") )   (begin  (print-string  (prim->string "value of x[name]:") )   (begin  (print-string  (prim->string  (get-field  (deref  (deref x) )  "name") ) )   (begin  (set!  (deref x)   (delete-field  (deref  (deref x) )  "name") )   (begin  (print-string  (prim->string "after delete x[name]:") )   (begin  (print-string  (prim->string  (get-field  (deref  (deref x) )  "name") ) )   (begin  (set! x  (alloc  (object  ("$proto" @Object_prototype)  ("$class" "Object")  ("answer"  99.) ) ) )   (begin  (print-string  (prim->string "leave <proc>") )   (begin  (print-string  (prim->string "") )   (begin  (break $return    (get-field  (deref  (deref x) )  "answer") )  undefined) ) ) ) ) ) ) ) ) ) ) ) ) ) ) )   (begin  (begin  (set! $global  (update-field  (deref $global)  "v"  5.) )  undefined)   (begin  (set! $global  (update-field  (deref $global)  "v"  (alloc  (object  ("$proto" @Object_prototype)  ("$class" "Object")  ("age"  18.)  ("name" "liwei")  ("answer"  42.) ) ) ) )   (begin  (print-string  (prim->string "value of v[name]:") )   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "v") )  "name") ) )   (begin  (begin  (set! $global  (update-field  (deref $global)  "c"  ( (get-field  (deref $global)  "proc")  $global (get-field  (deref $global)  "v") ) ) )  undefined)   (begin  (print-string  (prim->string "return from [proc]:") )   (begin  (print-string  (prim->string  (get-field  (deref $global)  "c") ) )   (begin  (print-string  (prim->string "value of v[age]:") )   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "v") )  "age") ) )   (begin  (print-string  (prim->string "value of v[name]:") )   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "v") )  "name") ) )   (begin  (print-string  (prim->string "set v[name] to Cui:") )   (begin  (set!  (get-field  (deref $global)  "v")   (update-field  (deref  (get-field  (deref $global)  "v") )  "name" "Cui") )   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "v") )  "name") ) )  undefined) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) |}
  );

  "function" >:: (fun _ -> assert_equal
    (desugar_code "
        function proc(x) {
            x = {'b': 'a'};
            print (x['b']);
        }
        var c = {'a': 'b'};
        proc (c);
        print (c['a']);
    ")

    {| (let  ( ($global  (alloc  (object ) ) ) )   (let  ( (@Object_prototype  (alloc  (object ) ) ) )   (begin  (set! $global  (update-field  (deref $global)  "proc"  (lambda  (this x)   (let  ( (x  (alloc x) ) )   (label $return    (begin  (set! x  (alloc  (object  ("$proto" @Object_prototype)  ("$class" "Object")  ("b" "a") ) ) )   (begin  (print-string  (prim->string  (get-field  (deref  (deref x) )  "b") ) )  undefined) ) ) ) ) ) )   (begin  (begin  (set! $global  (update-field  (deref $global)  "c"  (alloc  (object  ("$proto" @Object_prototype)  ("$class" "Object")  ("a" "b") ) ) ) )  undefined)   (begin  ( (get-field  (deref $global)  "proc")  $global (get-field  (deref $global)  "c") )   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "c") )  "a") ) )  undefined) ) ) ) ) ) |}
  );

  "calc" >:: (fun _ -> assert_equal
    (desugar_code "
        var k = 72;
        var c = k + 12;
        print (c / 2);
    ")

    {| (let  ( ($global  (alloc  (object ) ) ) )   (let  ( (@Object_prototype  (alloc  (object ) ) ) )   (begin  (begin  (set! $global  (update-field  (deref $global)  "k"  72.) )  undefined)   (begin  (begin  (set! $global  (update-field  (deref $global)  "c"  (+  (get-field  (deref $global)  "k")  12.) ) )  undefined)   (begin  (print-string  (prim->string  (/  (get-field  (deref $global)  "c")  2.) ) )  undefined) ) ) ) ) |}
  );

  "literal" >:: (fun _ -> assert_equal
    (desugar_code "
        var k = {'v': 63, 'x': {'y': 42}};
        k.v += 1;
        k['v'] /= (1 + 1);
        print (k['v']);
        print (k.x.y + 1);
    ")

    {| (let  ( ($global  (alloc  (object ) ) ) )   (let  ( (@Object_prototype  (alloc  (object ) ) ) )   (begin  (begin  (set! $global  (update-field  (deref $global)  "k"  (alloc  (object  ("$proto" @Object_prototype)  ("$class" "Object")  ("v"  63.)  ("x"  (alloc  (object  ("$proto" @Object_prototype)  ("$class" "Object")  ("y"  42.) ) ) ) ) ) ) )  undefined)   (begin  (set!  (get-field  (deref $global)  "k")   (update-field  (deref  (get-field  (deref $global)  "k") )  "v"  (+  (get-field  (deref  (get-field  (deref $global)  "k") )  "v")  1.) ) )   (begin  (set!  (get-field  (deref $global)  "k")   (update-field  (deref  (get-field  (deref $global)  "k") )  "v"  (/  (get-field  (deref  (get-field  (deref $global)  "k") )  "v")  (+  1. 1.) ) ) )   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "k") )  "v") ) )   (begin  (print-string  (prim->string  (+  (get-field  (deref  (get-field  (deref  (get-field  (deref $global)  "k") )  "x") )  "y")  1.) ) )  undefined) ) ) ) ) ) ) |}
   );

  "remove array" >:: (fun _ -> assert_equal
    (desugar_code "
        var k = [1, 'liwei', 3];
        print (k[1]);
        delete k[1];
        print (k[1]);
        k[1] = 5;
        var c = 1;
        print (k[1]);
    ")

    {| (let  ( ($global  (alloc  (object ) ) ) )   (let  ( (@Object_prototype  (alloc  (object ) ) ) )   (begin  (begin  (set! $global  (update-field  (deref $global)  "k"  (alloc  (object  ("$class" "Array")  ("0"  1.)  ("1" "liwei")  ("2"  3.) ) ) ) )  undefined)   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "k") )  "1") ) )   (begin  (set!  (get-field  (deref $global)  "k")   (delete-field  (deref  (get-field  (deref $global)  "k") )  "1") )   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "k") )  "1") ) )   (begin  (set!  (get-field  (deref $global)  "k")   (update-field  (deref  (get-field  (deref $global)  "k") )  "1"  5.) )   (begin  (begin  (set! $global  (update-field  (deref $global)  "c"  1.) )  undefined)   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "k") )  "1") ) )  undefined) ) ) ) ) ) ) ) ) |}
  );

  "array property idx" >:: (fun _ -> assert_equal
    (desugar_code "
      function proc(arr, pos) {
          print (arr[pos]);
      }

      var k = [1, 'liwei', 3];
      print (k[1]);
      delete k[1];
      print (k[1]);
      k[1] = 42;
      print (k[1]);
      var c = 1;
      print (k[c]);
      proc (k, c);
    ")

    {| (let  ( ($global  (alloc  (object ) ) ) )   (let  ( (@Object_prototype  (alloc  (object ) ) ) )   (begin  (set! $global  (update-field  (deref $global)  "proc"  (lambda  (this arr pos)   (let  ( (arr  (alloc arr) )  (pos  (alloc pos) ) )   (label $return    (begin  (print-string  (prim->string  (get-field  (deref  (deref arr) )   (prim->string  (deref pos) ) ) ) )  undefined) ) ) ) ) )   (begin  (begin  (set! $global  (update-field  (deref $global)  "k"  (alloc  (object  ("$class" "Array")  ("0"  1.)  ("1" "liwei")  ("2"  3.) ) ) ) )  undefined)   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "k") )  "1") ) )   (begin  (set!  (get-field  (deref $global)  "k")   (delete-field  (deref  (get-field  (deref $global)  "k") )  "1") )   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "k") )  "1") ) )   (begin  (set!  (get-field  (deref $global)  "k")   (update-field  (deref  (get-field  (deref $global)  "k") )  "1"  42.) )   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "k") )  "1") ) )   (begin  (begin  (set! $global  (update-field  (deref $global)  "c"  1.) )  undefined)   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "k") )   (prim->string  (get-field  (deref $global)  "c") ) ) ) )   (begin  ( (get-field  (deref $global)  "proc")  $global (get-field  (deref $global)  "k")  (get-field  (deref $global)  "c") )  undefined) ) ) ) ) ) ) ) ) ) ) ) |}
  );

  "if statement" >:: (fun _ -> assert_equal
    (desugar_code "
      var c = 5;
      if (c == 5) {
          print ('add'); c += 1;
      } else {
          print ('minus'); c -= 1;
      }
      print (c);
    ")

    {| (let  ( ($global  (alloc  (object ) ) ) )   (let  ( (@Object_prototype  (alloc  (object ) ) ) )   (begin  (begin  (set! $global  (update-field  (deref $global)  "c"  5.) )  undefined)   (begin  (if  (==  (get-field  (deref $global)  "c")  5.)   (begin  (print-string  (prim->string "add") )   (begin  (set! $global  (update-field  (deref $global)  "c"  (+  (get-field  (deref $global)  "c")  1.) ) )  undefined) )   (begin  (print-string  (prim->string "minus") )   (begin  (set! $global  (update-field  (deref $global)  "c"  (-  (get-field  (deref $global)  "c")  1.) ) )  undefined) ) )   (begin  (print-string  (prim->string  (get-field  (deref $global)  "c") ) )  undefined) ) ) ) ) |}
  );

  "if statement - not equal" >:: (fun _ -> assert_equal
    (desugar_code "
      var c = 5;
      if (c != 7) {
          print ('add'); c += 1;
      }
      print (c);
    ")

    {| (let  ( ($global  (alloc  (object ) ) ) )   (let  ( (@Object_prototype  (alloc  (object ) ) ) )   (begin  (begin  (set! $global  (update-field  (deref $global)  "c"  5.) )  undefined)   (begin  (if  (if  (==  (get-field  (deref $global)  "c")  7.)  #f #t)   (begin  (print-string  (prim->string "add") )   (begin  (set! $global  (update-field  (deref $global)  "c"  (+  (get-field  (deref $global)  "c")  1.) ) )  undefined) )  undefined)   (begin  (print-string  (prim->string  (get-field  (deref $global)  "c") ) )  undefined) ) ) ) ) |}
  );
]

let _ = run_test_tt_main tests