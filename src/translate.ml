let acc = ref [] in
try
    while true do
        acc := read_line () :: !acc;
    done
with
    End_of_file -> 
        let code = List.rev !acc in
        print_string @@
        (Desugar.desugar_code @@ String.concat "\n" code) ^ "\n"