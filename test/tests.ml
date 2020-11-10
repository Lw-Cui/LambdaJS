open Desugar
open OUnit2

let tests = "test suite for desugar" >::: [
  "dictionary" >:: (fun _ -> assert_equal 
    (desguar_code "
        var v = {'name': 'liwei', 'answer': 42}; 
        var c = 5, b = 6;
        print (v['name']) 
    ")

    {| (let  ( ($global  (alloc  (object ) ) ) )   (let  ( (@Object_prototype  (alloc  (object ) ) ) )   (begin  (begin  (set! $global  (update-field  (deref $global)  "v"  (alloc  (object  ("$proto" @Object_prototype)  ("$class" "Object")  ("name" "liwei")  ("answer"  42.) ) ) ) )  undefined)   (begin  (begin  (set! $global  (update-field  (deref $global)  "c"  5.) )   (begin  (set! $global  (update-field  (deref $global)  "b"  6.) )  undefined) )   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "v") )  "name") ) )  undefined) ) ) ) ) |}
  );

  "field" >:: (fun _ -> assert_equal
    (desguar_code "
        var v = {'name': 'liwei', 'answer': 42}; 
        v['name'] = 5;
        print (v['name']);
        delete v['name'];
        print (v['name']);
    ")

    {| (let  ( ($global  (alloc  (object ) ) ) )   (let  ( (@Object_prototype  (alloc  (object ) ) ) )   (begin  (begin  (set! $global  (update-field  (deref $global)  "v"  (alloc  (object  ("$proto" @Object_prototype)  ("$class" "Object")  ("name" "liwei")  ("answer"  42.) ) ) ) )  undefined)   (begin  (set!  (get-field  (deref $global)  "v")   (update-field  (deref  (get-field  (deref $global)  "v") )  "name"  5.) )   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "v") )  "name") ) )   (begin  (set!  (get-field  (deref $global)  "v")   (delete-field  (deref  (get-field  (deref $global)  "v") )  "name") )   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "v") )  "name") ) )  undefined) ) ) ) ) ) ) |}
  );

  "assignment" >:: (fun _ -> assert_equal
    (desguar_code "
        var x = {'a': 'b'};
        x = {'x': 'x'};
        print (x['x']);
    ")
    {| (let  ( ($global  (alloc  (object ) ) ) )   (let  ( (@Object_prototype  (alloc  (object ) ) ) )   (begin  (begin  (set! $global  (update-field  (deref $global)  "x"  (alloc  (object  ("$proto" @Object_prototype)  ("$class" "Object")  ("a" "b") ) ) ) )  undefined)   (begin  (set! $global  (update-field  (deref $global)  "x"  (alloc  (object  ("$proto" @Object_prototype)  ("$class" "Object")  ("x" "x") ) ) ) )   (begin  (print-string  (prim->string  (get-field  (deref  (get-field  (deref $global)  "x") )  "x") ) )  undefined) ) ) ) ) |}
  );
]

let _ = run_test_tt_main tests