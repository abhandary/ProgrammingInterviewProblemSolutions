// quick sort
private fun quicksort(a: MutableList<Int>, start: Int, end: Int) {
    
    if (start >= end) { return }
    
    var pivot = start
    
    // position the pivot within start and end.
    var left = pivot + 1
    var right = end
    while (left <= right) {
        if (a[left] > a[pivot]) {
            a[left] = a[right].also { a[right] = a[left] }
            right--
        } else {
            left++            
        }
    
        // bring pivot into the right place.
        a[pivot] = a[right].also { a[right] = a[pivot] }
    
        // sort the sub arrays
        quicksort(a, start, right - 1)
        quicksort(a, right + 1, end)
    }

    private var startIx = 0

    fun reverseInParentheses(inputString: String): String {
        var result = ""
        while (startIx < inputString.length) {
        if (inputString[startIx] == '(') {
            startIx++
            val nested = reverseInParentheses(inputString)
            result += nested
        } else if (inputString[startIx] == ')') {
            startIx++
            return result.reversed()
        } else {
            result += inputString[startIx]
            startIx++
        }
    }
    return result
}

