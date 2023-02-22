.globl swap 
.globl selectionSort
 
#void selectionSort(int arr[], int i, int n){
selectionSort:
# callee setup goes here

#a0 = array 
#a1 = starting element for sort
#a2 = size of array 

#t0 = i (used in loop)
#t1 = j
#t2 = min
#t3 = swapping temp register
#t4 array element value 
#t5 = minimum element value 

	addi t0, a1, 0	# move i from arg to t1

    /* find the minimum element in the unsorted subarray `[i…n-1]`
    // and swap it with `arr[i]`  */
#    int j;
	li t1, 0;

#    int min = i;
	addi t2, a1, 0 

#    for (j = i + 1; j < n; j++)    {

for:
#j = i + 1;
	add t1, t0, 1	# aleady moved a1 -> t1
	b forLoop

forloop:
# j < n
	bge t1, a2, swap 	
	b if1
	

#        /* if `arr[j]` is less, then it is the new minimum */
#        if (arr[j] < arr[min]) {
if1:
	slli t4, t1, 2 # t4 = j * 4 
	add t4, t4, a0 # t4 = &array[j]
	lw t4, 0(t4) # t4 = array[j]
	
	slli t5, t1, 2 # t5 = j * 4 
	add t5, t5, a0 # t5 = &array[min]
	lw t5, 0(t5) # t5 = array[min]
	
	blt t4, t5, update_min # if array element is less than minimum
	addi t1, t1, 1 # j++
	j forloop
	
update_min:
#            min = j;    /* update the index of minimum element */
	add t2, t1, zero # min = j
	j forloop
#        }
endif1:


#    }
endfor:
 
#    /* swap the minimum element in subarray `arr[i…n-1]` with `arr[i] */
#    swap(arr, min, i);
#caller setup and subroutine call for swap goes here.

#caller teardown for swap goes here (if needed).
 
#    if (i + 1 < n) {
if2:


#        selectionSort(arr, i + 1, n);
#caller setup and subroutine call for selectionSort goes here.

#caller teardown for selectionSort goes here (if needed).



#    }
endif2:

	
# callee teardown goes here


#}

 

#/* Utility function to swap values at two indices in an array*/
#void swap(int arr[], int i, int j) {
swap: 
# swap callee setup goes here

#    int temp = arr[i];
	slli t3, t0, 2 # t3 = i * 4
	add t3, t3, a0 # t3 = &array[i]
	lw t3, 0(t3)   # t3 = array[i]
	
	
#    arr[i] = arr[j];
	slli t4, t2, 2 # t4 = min * 4
	add t4, t4, a0 # t4 = &array[min]
	lw t4, 0(t4)   # t4 = array[min]
	sw t4, 0(t3)	# array[i] = array[min]
	sw t3, 0(t3)   # array[min] = array[i]

#    arr[j] = temp;
	

# swap callee teardown goes here



#}
