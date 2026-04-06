.section .rodata
    yes: .string "Yes\n"
    no: .string "No\n"
    filename: .string "input.txt"
    mode: .string "r"

.text
.globl main


main:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s0, 32(sp)
    sd s1, 24(sp)
    sd s2, 16(sp)
    sd s3, 8(sp)
    sd s4, 0(sp)


    # s0 = pointer to "input.txt"
    # s1 = Index of start of "input.txt"
    # s2 = Index of end of "input.txt"
    la a0, filename
    la a1, mode
    call fopen
    mv s0, a0
    

    mv a0, s0
    li a1, 0
    li a2, 2
    call fseek
    
    mv a0, s0
    call ftell

    li s1, 0
    addi s2, a0, -1

    # s3 = char at s1
    # s4 = char at s2

    loop:
        bge s1, s2, True

        mv a0, s0
        mv a1, s1
        li a2, 0
        call fseek
        
        mv a0, s0
        call fgetc
        mv s3, a0
        


        mv a0, s0
        mv a1, s2
        li a2, 0
        call fseek
        
        mv a0, s0
        call fgetc
        mv s4, a0

        bne s3, s4, False

        addi s1, s1, 1
        addi s2, s2 -1
        
        jal x0, loop


    True:
        la a0, yes
        call printf
        jal x0, Exit

    False:
        la a0, no
        call printf
        jal x0, Exit

    Exit:
        ld ra, 40(sp)
        ld s0, 32(sp)
        ld s1, 24(sp)
        ld s2, 16(sp)
        ld s3, 8(sp)
        ld s4, 0(sp)
        addi sp, sp, 48
        
        li a0, 0
        ret
