print_string @@ 
(Desugar.desugar_code "
    function print_array (array) {
        var idx = 0;
        while (idx != array.length) {
            print (array[idx]);
            idx += 1;
        }
    }

    function swap(array, left, right) {
        var temp = array[left];
        array[left] = array[right];
        array[right] = temp;
    }

    function mid (left, right) {
        if ((left + right) % 2) 
            return (left + right - 1) / 2;
        else 
            return (left + right) / 2;
    }

    function partition (array, left, right) {
        var pivot = array[mid(left, right)];

        while (left < right) {
            while (array[left] < pivot) left += 1;
            while (array[right] > pivot) right -= 1;

            if (left < right) {
                swap (array, left, right);
                left += 1;
                right -= 1;
            }
        }
        return left;
    }

    function do_sort (array, left, right) {
        if (array.length <= 1) return array;
        if (left + 1 >= right) return array;
        var idx = partition (array, left, right);
        do_sort (array, left, idx - 1);
        do_sort (array, idx, right);
        return array;
    }

    function quicksort (array) {
        return do_sort (array, 0, array.length - 1);
    }

    var array = [5,3,7,6,2,9];
    var sorted = quicksort (array);
    print_array (sorted);
    
") ^ "\n"