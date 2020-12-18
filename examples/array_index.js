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