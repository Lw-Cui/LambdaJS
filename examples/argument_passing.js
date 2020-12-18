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