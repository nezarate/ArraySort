.globl swap
.globl selectionSort
.globl printArray



# Authors: Nicholas Zarate and Logan Schwarz


selectionSort:

	addi sp, sp, -16 # allocate space on the stack
	sw ra, 12(sp) # save ra on the stack

	mv t0, a1 # t0 = i
	mv t1, zero # j = 0
	mv t2, a1 # min = i
	mv t3, a2 # t3 = size of array (n)
	mv t6, a0 # t6 = address of array
    

for1:
	addi t1, t0, 1	#j = i + 1
	b forloop1


forloop1:
	bge t1, t3, endfor1 # if the next value is greater than the size of array , go to swap because we must be done 	



if1:
 
	slli t4, t1, 4 # t4 = j * 16
	addi t4, t4, 8 # t4 = j * 16 + 8
	add t4, t4, t6 # t4 = &array[j].studentid
	lw t4, 0(t4) # t4 = array[j].studentid
	
	
	slli t5, t2, 4 # t5 = j * 4
	addi t5, t5, 8 # t5 = j * 16 + 8
	add t5, t5, t6 # t5 = &array[min].sutdentid
	lw t5, 0(t5) # t5 = array[min].studentid
	
			
	bge t4, t5, endif1 # if arr[j].studentid < arr[min].studentid
	mv t2, t1 # min = j
		

endif1:
	addi t1, t1, 1 # j++
	b forloop1

endfor1:
	mv a0, t6 #    swap(arr, min, i);
	mv a1, t2
	mv a2, t0
	b swap


if2:
	addi t0, t0, 1
	bge t0, t3, endif2 # i + 1 < n
	mv a0, t6
	mv a1, t0
	mv a2, t3
	jal selectionSort # selectionSort(arr, i + 1, n)


endif2:
	b endsort
    


printArray:
#callee setup goes here
	addi    sp, sp, -16 # allocate space on the stack
        sw      ra, 12(sp) # save ra adress 
 
        mv t1, a0 # t1= address
        mv t2, a1 # t2 = size n
        li t4, 8  # t4 = 8
        li t5, 12 # t5 = 12

        
        
        
        for2:
        	mv t0, zero # i=0
        	
        forloop2:
        	bge t0, t2, forend2 # i < n
        	slli t3, t0, 4 # t3 = i * 16
		add t3, t3, t1 # adress of i
		addi t3, t3, 8 # adress of srudent ID
			
		lw t6, 0(t3) # load student ID
		
		mv a0, t6 # print student ID
		li a7, 1
		ecall 
		
		mv t6, zero 
		li t6, ' ' 
		
		mv a0, t6 # print space
		li a7, 11
		ecall
		
		sub t3, t3, t4	# substract 8 bytes to get back to start of current node, to find name of student
		
		mv a0, t3 # print student name
		li a7, 4
		ecall 
		
		li t6, ' ' 
		
		mv a0, t6 # print space
		li a7, 11
		ecall
		
		mv t6, zero # clear t6
		add t3, t3, t5 # get adress of course number
		lw t6, 0(t3)
		
		mv a0, t6 # print course number
		li a7, 1
		ecall
		
		addi t0, t0, 1 # i++
		
		li t6, '\n' # print newline char
		mv a0, t6
		li a7, 11
		ecall
		 
		b forloop2
		
	forend2:
	
		lw ra, 12(sp) #restore ra
		addi sp, sp, 16 # return sp
		ret


swap:
	
	addi sp, sp, -16 # allocate space on the stack
	sw s0, 12(sp) # save s registers to the stack to use within function
	sw s1, 8(sp)
	sw s2, 4(sp)
	sw s3, 0(sp)
	

	# studentNode temp = arr[i];
	slli t5, a2, 4 # t5 = i * 16
	add t5, t5, a0 # t5 = &array[i]
	mv s0, t5	# s0 = &array[i]
	
	
	# studentNode temp = arr[i];
	slli t4, a1, 4 # t4 = j * 16
	add t4, t4, a0 # t4 = &array[j]
	mv s1, t4	# s1 = &array[j]
	
	
	lw s2, 0(t4) # s2 = array[j].name
	lw s3, 0(t5) # s3 = array[j].name
	  
	sw s2, 0(s0)  # swap names
	sw s3, 0(s1)
		
	addi t4, t4, 4	# increment by 4 bytes to get last chars of name
	addi t5, t5, 4
				

	lw s2, 0(t4) # s2 = array[j].name
	lw s3, 0(t5) # s3 = array[j].name
	
	sw s2, 4(s0) # swap names
	sw s3, 4(s1)
	
	
	addi t4, t4, 4	# increment by 4 bytes to get student num
	addi t5, t5, 4
				

	lw s2, 0(t4) # s2 = array[j].studentID
	lw s3, 0(t5) # s3 = array[j].studentID
	
	sw s2, 8(s0) # swap studentID's
	sw s3, 8(s1)
	
	
	addi t4, t4, 4	# increment by 4 bytes to get student courses
	addi t5, t5, 4
				

	lw s2, 0(t4) # s2 = array[j].coursenum
	lw s3, 0(t5)# s3 = array[j].coursenum
	
	sw s2, 12(s0) # swap courses nums
	sw s3, 12(s1)
	

	
	lw s0, 12(sp) # restore s registers from values saved on the stack
	lw s1, 8(sp)
	lw s2, 4(sp)
	lw s3, 0(sp)
	
	addi sp, sp, 16 # restore sp

	b if2

endsort:

	lw ra, 12(sp) #restore ra
	addi sp, sp, 16 # restore sp
	ret


