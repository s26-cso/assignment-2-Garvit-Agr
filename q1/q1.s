.text

.global make_node
.global insert
.global get
.global getAtMost



make_node:
    addi sp, sp, -16
    sd ra, 8(sp)
    sw a0, 0(sp)

    li a0, 24
    call malloc

    lw t1, 0(sp)

    sw t1, 0(a0)
    sw x0, 4(a0)
    sd x0, 8(a0)
    sd x0, 16(a0)

    ld ra, 8(sp)
    addi sp, sp, 16
    ret




insert:
    addi sp, sp, -24
    sd ra, 16(sp)
    sd s0, 8(sp)
    sd s1, 0(sp)

    # s0 = root of tree
    # s1 = val of new node

    mv s0, a0
    mv s1, a1

    bne x0, s0, recursive_step

    mv a0, s1
    call make_node

    ld s1, 0(sp)
    ld s0, 8(sp)
    ld ra, 16(sp)
    addi sp, sp, 24
    ret

    recursive_step:
        lw t0, 0(s0)
        blt t0, s1, insert_right
        bge t0, s1, insert_left

    insert_left:
        ld a0, 8(s0)
        mv a1, s1
        call insert
        sd a0, 8(s0)
        beq x0, x0, insert_return

    insert_right:
        ld a0, 16(s0)
        mv a1, s1
        call insert
        sd a0, 16(s0)
        beq x0, x0, insert_return

    insert_return:
        mv a0, s0

        ld ra, 16(sp)
        ld s0, 8(sp)
        ld s1, 0(sp) 
        addi sp, sp, 24
        ret



get:
    beq x0, a0, dead_end

    # t0 = root value
    lw t0, 0(a0)

    bne a1, t0, get_loop
    ret

    dead_end:
        ret
    
    get_loop:
        blt t0, a1, get_right
        ld t1, 8(a0)
        mv a0, t1
        beq x0, x0, get

    get_right:
        ld t1, 16(a0)
        mv a0, t1
        beq x0, x0, get

    
getAtMost:
    # t0 = ans
    li t0, -1


    getAtMost_loop:
        beq x0, a1, getAtMost_Exit

        # t1 = root val
        # t2 = left pointer
        # t3 = right pointer
        lw t1, 0(a1)
        ld t2, 8(a1)
        ld t3, 16(a1)

        bge a0, t1, possible_ans

        beq x0, x0, no_possible_ans

    no_possible_ans:
        mv a1, t2
        beq x0, x0, getAtMost_loop

    possible_ans:
        mv t0, t1
        mv a1, t3
        beq x0, x0, getAtMost_loop

    getAtMost_Exit:
        mv a0, t0
        ret



