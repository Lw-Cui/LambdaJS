print_string @@ 
(Desugar.desugar_code "
    var c = 5 % 3;
    print (c)
") ^ "\n"