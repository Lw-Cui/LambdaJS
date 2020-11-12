print_string @@ 
(Desugar.desugar_code "
    var c = 5;
    if (c == 5) {
        print ('add'); c += 1;
    } else {
        print ('minus'); c -= 1;
    }
    print (c);
") ^ "\n"