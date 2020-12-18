function proc(x) {
    x = {'b': 'a'};
    print (x['b']);
}
var c = {'a': 'b'};
proc (c);
print (c['a']);