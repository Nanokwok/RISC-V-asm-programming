# #include <stdio.h>

# int a[5] = {1, 2, 3, 4, 5};
# int b[5] = {6, 7, 8, 9, 10};

# int main() {
#     int i, sop = 0;
    
#     for (i = 0; i < 5; i++) {
#         sop += a[i] * b[i];
#     }
    
#     printf("The dot product is: %d\n", sop);
#     return 0;
# }

.data
a:  .word   1, 2, 3, 4, 5        # Array a
b:  .word   6, 7, 8, 9, 10       # Array b
output: .string "The dot product is: "    # Output label
new_line: .string "\n"          # New line character

.text
main:
    li x5, 5                    # x5 = size = 5
    li x6, 0                    # x6 = dot product
    li x7, 0                    # x7 = i

    la x18, a                   # Load address of a[] to x18
    la x19, b                   # Load address of b[] to x19

Loop:
    bge x7, x5, Exit            # Exit loop if i >= size

    slli x20, x7, 2             # Calculate i*4
    add x21, x20, x18           # Calculate address of a[i]
    lw x24, 0(x21)              # Load a[i]

    add x22, x20, x19           # Calculate address of b[i]
    lw x23, 0(x22)              # Load b[i]

    mul x24, x24, x23           # Calculate a[i] * b[i]
    add x6, x6, x24             # Add to dot product

    addi x7, x7, 1              # Increment i

    j Loop                     # Jump to loop

Exit:
    li a0, 4                    # Print output label
    la a1, output
    ecall

    la a1, new_line             # Print new line
    ecall

    li a0, 1                    # Print dot product
    mv a1, x6
    ecall

    li a0, 10                   # Exit program
    ecall




