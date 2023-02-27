.globl swap 
.globl selectionSort
 
#void selectionSort(int arr[], int i, int n){
selectionSort:
# callee setup goes here

	addi sp, sp, -16
	sw ra, 12(sp)

	mv t0, a1 # t0 = i
	mv t1, zero # j = 0
	mv t2, a1 # min = i
	mv t3, a2 # t3 = size of array (n)
	mv t6, a0 # t6 = address of array

	for:
		addi t1, t0, 1	#j = i + 1
		b forloop

	forloop: # j < n 
		bge t1, t3, forend # if the next value is greater than the size of array , go to swap because we must be done 
		#bge t1, t3, endsort
	
	if: 
		slli t4, t1, 2 # t4 = j * 4 (multiply by 4 to turn from index to location in array)
		add t4, t4, t6 # t4 = &array[j]
		lw t4, 0(t4) # t4 = array[j]
		
		#mv a0, t4
		#li a7, 1
		#ecall
		
	
		slli t5, t2, 2 # t5 = j * 4 
		add t5, t5, t6 # t5 = &array[min]
		lw t5, 0(t5) # t5 = array[min]
		
		#mv a0, t5
		#li a7, 1
		#ecall
		
		bge t4, t5, endif
		mv t2, t1
		
		#mv a0, t2
		#li a7, 1
		#ecall
		
		
	endif:
		addi t1, t1, 1 # j++
		b forloop

	forend:
		mv a0, t6
		mv a1, t2
		mv a2, t0
		b swap
		
		if2:
			addi t0, t0, 1
			bge t0, t3, endif2
			mv a0, t6
			mv a1, t0
			mv a2, t3
			jal selectionSort
		endif2:
			b endsort
			
			
		
swap: 
# swap callee setup goes here

#    int temp = arr[i];
	addi sp, sp, -16
	sw s0, 12(sp)
	sw s1, 8(sp)
	
	slli t5, a2, 2 # t3 = i * 4
	add t5, t5, a0 # t3 = &array[i]
	mv s0, t5	
	lw t5, 0(t5)   # t3 = array[i]

	
#    arr[i] = arr[j];
	slli t4, a1, 2 # t4 = min * 4 (multiply by four to get value of this index number)
	add t4, t4, a0 # t4 = &array[min]
	mv s1, t4
	lw t4, 0(t4)   # t4 = array[min]
	
	#mv a0, t4
	#li a7, 1
	#ecall
	
	sw t4, 0(s0)	# array[i] = array[min]
	sw t5, 0(s1)   # array[min] = array[i]
	
	lw s0, 12(sp)
	lw s1, 8(sp)
	
	addi sp, sp, 16

	b if2
#    arr[j] = temp;

endsort:
	
	#lw t0, 0(t6)
	#mv a0, t0
	#li a7, 1
	#ecall

	
	lw ra, 12(sp) #restore ra
	addi sp, sp, 16
	ret
	#li t1, 16
	#mul t0, t0, t1 # becuase stack is added to each time it recursively calls itself (i * 16)
	#add sp, sp, t0
	#ret	
	
