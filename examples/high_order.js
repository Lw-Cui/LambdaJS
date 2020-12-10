function addn (n) {
    return function (x) { return x + n;}
}

var c = addn (5);
print (c (6));