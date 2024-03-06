.data
arraya: .word 1, 2, 3, 4, 5    # Initialize arraya with values 1, 2, 3, 4, 5
arrayb: .word 6, 7, 8, 9, 10   # Initialize arrayb with values 6, 7, 8, 9, 10
output: .string "The dot product is: "  # String for output message
newline: .string "\n"          # String for new line character

.text
main:
    la a0, arraya              # Load address of arraya into a0
    la a1, arrayb              # Load address of arrayb into a1
    li a5, 5                   # Load size of arrays into a5
    addi t0, x0, 1             # Initialize counter to 1
    jal calculate              # Jump to calculate function
  
    mv t3, a0                  # Move result to t3
    li a0, 4                   # Print output label
    la a1, output
    ecall
    li a0, 1                   # Print result
    mv a1, t3
    ecall    
    li a0, 4                   # Print newline
    la a1, newline
    ecall
    li a0, 10                  # Exit program
    ecall
      
calculate:
    beq a5, t0, exit           # Base case: if size == 1, exit recursion    
    addi sp, sp, -12           # Allocate space on stack for saving registers
    sw a0, 8(sp)               # Save a0 onto stack
    sw a1, 4(sp)               # Save a1 onto stack
    sw ra, 0(sp)               # Save ra onto stack
    addi a0, a0, 4             # Move pointer to next element in arraya
    addi a1, a1, 4             # Move pointer to next element in arrayb
    addi a5, a5, -1            # Decrement size
    jal calculate              # Recursive call to calculate function

    lw t1, 8(sp)               # Restore saved registers
    lw t2, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 12            # Deallocate space from stack
    lw t1, 0(t1)               # Load values from arraya and arrayb
    lw t2, 0(t2)   
    mul t1, t1, t2             # Calculate product of corresponding elements
    add a0, a0, t1             # Accumulate result
    jr ra                       # Return to caller
    
exit:
    lw t1, 0(a0)               # Load last elements of arraya and arrayb
    lw t2, 0(a1)
    mul a0, t1, t2             # Calculate product of last elements
    jr ra                       # Return to caller
