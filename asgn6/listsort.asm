	.globl	recurSelectionSort
recurSelectionSort:
    # Save register values on the stack
    addi    sp, sp, -20
    sw      ra, 0(sp)
    sw      s0, 4(sp)
    sw      s1, 8(sp)
    sw      s2, 12(sp)
    sw      s3, 16(sp)

    # Load function arguments
    lw      s0, 0(a0)

    # Check if list is empty or has only one node
    lb      s1, 4(s0)
    beqz    s1, end_recurSelectionSort

    # Set minimum node as the first node
    mv    s2, s0

loop_recurSelectionSort:
    # Find the minimum node
    lw      s1, 4(s0)
    beqz    s1, check_swap_recurSelectionSort
    lw      t0, 0(s1)
    lw      t1, 0(s2)
    bltu    t0, t1, update_min_recurSelectionSort
    j       next_recurSelectionSort

update_min_recurSelectionSort:
    mv    s2, s1
    mv    s1, s1
    j       next_recurSelectionSort

check_swap_recurSelectionSort:
    # Swap nodes if necessary
    bne     s2, s0, end_check_swap_recurSelectionSort
    j       next_recurSelectionSort
end_check_swap_recurSelectionSort:
    la      t0, studentArr
    add     t0, t0, s0
    la      t1, studentArr
    add     t1, t1, s2
    jal     swapNodes
    mv    s3, s0   # Store current node address
    mv    a0, s0   # Argument 1 for swapNodes
    mv    a1, s2   # Argument 2 for swapNodes
    lw      t0, 0(s2)
    mv    a2, t0   # Argument 3 for swapNodes
    jal     recurSelectionSort
    mv    a0, s1   # Argument 1 for recurSelectionSort
    la      t0, studentArr
    add     t0, t0, s3
    sw      a0, 4(t0)  # Store return value in next field of current node

next_recurSelectionSort:
    # Move to the next node
    lw      s1, 4(s0)
    beqz    s1, end_recurSelectionSort
    mv    s0, s1
    j       loop_recurSelectionSort

end_recurSelectionSort:
    # Restore register values and return
    lw      ra, 0(sp)
    lw      s0, 4(sp)
    lw      s1, 8(sp)
    lw      s2, 12(sp)
    lw      s3, 16(sp)
    addi    sp, sp, 20

    lw      s0, 0(a0)
    lw      s1, 4(s0)
    beqz    s1, return_recurSelectionSort
    jal     recurSelectionSort
    mv    a0, s1
    la      t0, studentArr
    add     t0, t0, s0
    sw      a0, 4(t0)

return_recurSelectionSort:
    jr      ra