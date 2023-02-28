.globl swap
.globl selectionSort
.globl printArray

#struct def'n for reference
#struct studentNode {
#   char name[6];
#   int studentid;
#   int coursenum;
#};

 
#/* Recursive function to perform selection sort on subarray `arr[i…n-1]` */
#void selectionSort(studentNode arr[], int i, int n) {
selectionSort:
#callee setup goes here

	addi sp, sp, -16
	sw ra, 12(sp)

	mv t0, a1 # t0 = i
	mv t1, zero # j = 0
	mv t2, a1 # min = i
	mv t3, a2 # t3 = size of array (n)
	mv t6, a0 # t6 = address of array
    

#    for (j = i + 1; j < n; j++)    {
for1:
	addi t1, t0, 1	#j = i + 1
	b forloop1


forloop1:
	bge t1, t3, endfor1 # if the next value is greater than the size of array , go to swap because we must be done 	

#        /* if `arr[j]` is less, then it is the new minimum */
#        if (arr[j].studentid < arr[min].studentid) {

if1:
	# j * 16 + 8 = the address of the value we want for sorting 
	slli t4, t1, 4 # t4 = j * 16
	addi t4, t4, 8 # t4 = j * 16 + 8
	add t4, t4, t6 # t4 = &array[j].studentid
	lw t4, 0(t4) # t4 = array[j].studentid
	
	
	
	slli t5, t2, 4 # t5 = j * 4
	addi t5, t5, 8 # t5 = j * 16 + 8
	add t5, t5, t6 # t5 = &array[min].sutdentid
	lw t5, 0(t5) # t5 = array[min].studentid
	
	#mv a0, t5
	#li a7, 1
	#ecall
	
			
	bge t4, t5, endif1
	mv t2, t1
		

#       min = j;    /* update the index of minimum element */


#        }
endif1:
	addi t1, t1, 1 # j++
	b forloop1

endfor1:
#    swap(arr, min, i);
	mv a0, t6
	mv a1, t2
	mv a2, t0
	b swap

#    }
 
#    /* swap the minimum element in subarray `arr[i…n-1]` with `arr[i] */
#caller setup goes here


#caller teardown goes here (if needed)
 
#    if (i + 1 < n) {
if2:
	addi t0, t0, 1
	bge t0, t3, endif2
	mv a0, t6
	mv a1, t0
	mv a2, t3
	jal selectionSort

#caller setup goes here

#        selectionSort(arr, i + 1, n);

#caller teardown goes here (if needed)


#    }
endif2:
	b endsort
    
#callee teardown goes here (if needed)


#}
 
#/* Function to print `n` elements of array `arr` */ 
#void printArray(studentNode arr[], int n) {
printArray:
#callee setup goes here
	addi    sp, sp, -16
        sw      ra, 12(sp)

        
 
        mv t1, a0 # t1= address
        mv t2, a1 # t2 = size n
        li t4, 8
        li t5, 12

        
        
        
        for2:
        	mv t0, zero # i=0
        	
        forloop2:
        	bge t0, t2, forend2
        	slli t3, t0, 4 
		add t3, t3, t1  
		addi t3, t3, 8
			
		lw t6, 0(t3)
		
		mv a0, t6 
		li a7, 1
		ecall 
		
		mv t6, zero
		li t6, ' ' 
		
		mv a0, t6
		li a7, 11
		ecall
		
		sub t3, t3, t4	# print string name
		
		mv a0, t3
		li a7, 4
		ecall 
		
		li t6, ' ' 
		
		mv a0, t6
		li a7, 11
		ecall
		
		mv t6, zero
		add t3, t3, t5	
		lw t6, 0(t3)
		
		mv a0, t6
		li a7, 1
		ecall
		

		
		addi t0, t0, 1
		
		
		li t6, 10
		beq t6, t0, forend2
		
		li t6, '\n' 
		mv a0, t6
		li a7, 11
		ecall
		 
		b forloop2
		
	forend2:
	
		lw ra, 12(sp) #restore ra
		addi sp, sp, 16
		ret

 
 
 
 

#/* Utility function to swap values at two indices in an array*/
#void swap(studentNode arr[], int i, int j) {
swap:
#caller setup goes here

#    studentNode temp = arr[i];


#    arr[i] = arr[j];


#    arr[j] = temp;
# swap callee setup goes here
	#addi sp, sp, -40 # allocating 40 because each node takes up 16 bytes plus 8
	#sw s0, 36(sp)	# start of node 2 is 36
	#sw s1, 20(sp)	# start of node 1 is 20
	
	addi sp, sp, -16
	sw s0, 12(sp)
	sw s1, 8(sp)
	sw s2, 4(sp)
	sw s3, 0(sp)
	

#    studentNode temp = arr[i];
	slli t5, a2, 4 # t5 = i * 16
	add t5, t5, a0 # t5 = &array[i]
	mv s0, t5	# s0 = &array[i]
	#lw t5, 0(t5)   # t5 = array[i].stringname 
	
	
	slli t4, a1, 4 # t4 = j * 16
	add t4, t4, a0 # t4 = &array[j]
	mv s1, t4	# s1 = &array[j]
	
	
	lw s2, 0(t4)
	lw s3, 0(t5) 
	  
	sw s2, 0(s0)   
	sw s3, 0(s1)
		
	addi t4, t4, 4	
	addi t5, t5, 4
				

	lw s2, 0(t4)
	lw s3, 0(t5)
	
	sw s2, 4(s0)
	sw s3, 4(s1)
	
	
	addi t4, t4, 4	
	addi t5, t5, 4
				

	lw s2, 0(t4)
	lw s3, 0(t5)
	
	sw s2, 8(s0)
	sw s3, 8(s1)
	
	
	addi t4, t4, 4	
	addi t5, t5, 4
				

	lw s2, 0(t4)
	lw s3, 0(t5)
	
	sw s2, 12(s0)
	sw s3, 12(s1)
	
	

	
	lw s0, 12(sp)
	lw s1, 8(sp)
	lw s2, 4(sp)
	lw s3, 0(sp)
	
	addi sp, sp, 16

	b if2
#    arr[j] = temp;


endsort:
	
	mv t5, zero
	slli t5, t2, 4 # t5 = j * 4
	addi t5, t5, 8 # t5 = j * 16 + 8
	add t5, t5, t6 # t5 = &array[min].sutdentid
	lw t5, 0(t5) # t5 = array[min].studentid

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
	

#caller teardown goes here


#}

