.text
#Program to find the first 47 values of fibonacci
Init:
		addi    x31 , x0 , 48
		addi    x30 , x0 , 1
		addi    x29 , x0 , 1
        sw      x30 , 0(x28)
        sw      x29 , 4(x28)
		addi    x28 , x0 , 8
		addi    x27 , x0 , 3
Fibo:
		beq     x27 , x31 , Check
		add     x26 , x30 , x29
		addi    x29 , x30 , 0
		addi    x30 , x26 , 0
		addi    x27 , x27 , 1
		sw      x26  , 0(x28)
        addi    x28 , x28 , 4
		jal     x0  , Fibo
Check:
        lw      x10, -4(x28)
        lui     x12,  0xb1
        addi    x12, x12, 0x192
        lui     x12, 0xb1192
        addi    x12, x12,0x4e1
        bne     x10, x12, Fail
Pass:
		addi    x1, x0, 70
		jal     x0, End
Fail:
		addi    x1, x0, 84
		jal     x0, End
End: