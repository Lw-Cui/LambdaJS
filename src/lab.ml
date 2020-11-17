print_string @@ 
(Desugar.desugar_code "
    var c = [1, 2, 3, 4];
    print (c.length == 5)
") ^ "\n"