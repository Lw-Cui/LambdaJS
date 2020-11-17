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

    function partition (array, left, right) {
        var pivot = array[right];
        var low = left, high = left;

        while (high <= right - 1) {
            if (array[high] <= pivot) {
                swap (array, low, high);
                low += 1;
            }
            high += 1;
        }

        swap (array, low, right);
        return low;
    }

    function do_sort (array, left, right) {
        if (array.length <= 1 || left >= right) return;
        var idx = partition (array, left, right);
        do_sort (array, left, idx - 1);
        do_sort (array, idx, right);
    }

    function quicksort (array) {
        do_sort (array, 0, array.length - 1);
        return array;
    }

    var array = [6, 3, 7, 8, 10, 0, 2, 3, 34, 42, 1];
    var sorted = quicksort (array);
    print_array (sorted);
    
") ^ "\n"