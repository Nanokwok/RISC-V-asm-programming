.text
main:
    addi a0, x0, 110            # Set a0 to 110 (a)
    addi a1, x0, 50             # Set a1 to 50 (b)
    jal multiply

print:
    mv a1, a0                   # Move result to a1 (print result)
    addi a0, x0, 1              # Set a0 to 1 (print integer)
    ecall                       
    addi a0, x0, 10             # Set a0 to 10 (program exit)
    ecall                       

multiply:
    addi t0, x0, 1              # Set t0 to 1 (base case)
    beq a1, t0, exit            # If b equals 1, go to exit_base_case
    addi sp, sp, -4             # Adjust stack pointer
    sw ra, 0(sp)                # Store return address on stack
    addi sp, sp, -4             # Adjust stack pointer
    sw a0, 0(sp)                # Store a0 on stack
    addi a1, a1, -1             # Decrement b
    jal multiply                # Recursive call
    mv t1, a0                   # Store result in t1
    lw a0, 0(sp)                # Load a0 from stack
    addi sp, sp, 4              # Restore stack pointer
    add a0, a0, t1              # Calculate result: a + result_of_recursive_call
    lw ra, 0(sp)                # Load return address from stack
    addi sp, sp, 4              # Restore stack pointer
    jr ra                       # Return
    add a0, a0, t0              # Add t0 to a0

exit:
    jr ra                       # Return
