.section .rodata
    fmt_in: .string "%d "

.text
.global main


main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)
    sd s1, 40(sp)
    sd s2, 32(sp)
    sd s3, 24(sp)
    sd s4, 16(sp)
    sd s5, 8(sp)
    sd s6, 0(sp)
 
    # s0 = Total elements
    # s1 = (array start pointer - 8bytes)
    # s2 = array end pointer
    # s6 = val at array end pointer

    # s3 = Stack base pointer
    # s4 = Stack's top pointer
    # s5 = ans_array base pointer


    mv s0, a0
    addi s0, s0, -1

    addi s1, a1, 8

    # t0 = n*8bytes
    slli t0, s0, 3
    add s2, t0, s1

    # t0 = n*16bytes (8 for val and 8 for index)
    slli t0, s0, 4
    mv a0, t0
    call malloc
    mv s3, a0
    mv s4, a0

    # t0 = n*8bytes
    slli t0, s0, 3
    mv a0, t0
    call malloc
    mv s5, a0


    loop:
        beq s2, s1, print_ans_loop
        addi s2, s2, -8

        ld a0, 0(s2)
        call atoi
        mv s6, a0

        jal ra, while_loop

        beq s3, s4, Empty_stack

        # t0 = current - start address of array
        sub t0, s2, s1
        # t0 = ans_array index where ans should be inserted
        add t0, s5, t0

        # t1 = index at top of stack (value at -16, index at -8)
        ld t1, -8(s4)

        sd t1, 0(t0)

        sd s6, 0(s4)
        
        # t2 = Index of array val
        sub t2, s2, s1
        srai t2, t2, 3         
        sd t2, 8(s4)
        
        addi s4, s4, 16

        jal x0, loop



    while_loop:
        beq s3, s4, jump_back

        # t0 = Stack's top val, not ind ex
        ld t0, -16(s4)

        bge s6, t0, remove_top
        
        jalr x0, ra


    remove_top:
        addi s4, s4, -16
        jal x0, while_loop


    jump_back:
        jalr x0, ra




    Empty_stack:
        sub t0, s2, s1
        add t0, s5, t0
        li t1, -1
        sd t1, 0(t0)

        sd s6, 0(s4)
        
        # t2 = Index of array val
        sub t2, s2, s1
        srai t2, t2, 3         
        sd t2, 8(s4)
        
        addi s4, s4, 16

        jal x0, loop


    print_ans_loop:
        beq s0, x0, Exit
        
        la a0, fmt_in
        ld a1, 0(s5)
        call printf

        addi s5, s5, 8
        li t0, -1
        add s0, s0, t0

        jal x0, print_ans_loop



    Exit:
        ld ra, 56(sp)
        ld s0, 48(sp)
        ld s1, 40(sp)
        ld s2, 32(sp)
        ld s3, 24(sp)
        ld s4, 16(sp)
        ld s5, 8(sp)
        ld s6, 0(sp)
        addi sp, sp, 64
        ret

    # t0 = n*8bytes
    slli t0, s0, 3
    mv a0, t0
    call malloc
    mv s3, a0
    mv s4, a0

    # t0 = n*8bytes
    slli t0, s0, 3
    mv a0, t0
    call malloc
    mv s5, a0


    loop:
        beq s2, s1, print_ans_loop
        addi s2, s2, -8

        ld a0, 0(s2)
        call atoi
        mv s6, a0

        jal ra, while_loop

        beq s3, s4, Empty_stack

        # t0 = current - start address of array
        sub t0, s2, s1
        # t0 = ans_array index where ans should be inserted
        add t0, s5, t0

        # t1 = value at top of stack
        ld t1, -8(s4)

        sd t1, 0(t0)

        sd s6, 0(s4)
        addi s4, s4, 8

        jal x0, loop

        

    while_loop:
        beq s3, s4, jump_back

        # t0 = Stack's top value
        ld t0, -8(s4)

        bge s6, t0, remove_top
        
        jalr x0, ra


    remove_top:
        addi s4, s4, -8
        jal x0, while_loop


    jump_back:
        jalr x0, ra




    Empty_stack:
        sub t0, s2, s1
        add t0, s5, t0
        li t1, -1
        sd t1, 0(t0)

        sd s6, 0(s4)
        addi s4, s4, 8

        jal x0, loop


    print_ans_loop:
        beq s0, x0, Exit
        
        la a0, fmt_in
        ld a1, 0(s5)
        call printf

        addi s5, s5, 8
        li t0, -1
        add s0, s0, t0

        jal x0, print_ans_loop



    Exit:
        ld ra, 56(sp)
        ld s0, 48(sp)
        ld s1, 40(sp)
        ld s2, 32(sp)
        ld s3, 24(sp)
        ld s4, 16(sp)
        ld s5, 8(sp)
        ld s6, 0(sp)
        addi sp, sp, 64
        ret
