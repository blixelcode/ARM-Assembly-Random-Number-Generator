// Input:
//		r1 MUST contain the memory address of the string we want to convert.
//
// Output:
//		r1 will contain the converted value.
//
.global atoi

atoi:
	push	{r0, r2-r4, lr}

	mov		r2, #0
	mov		r3, #10
	mov		r4, #1

	ldrb	r0, [r1], #1
	cmp		r0, #'-'
	moveq	r4, #-1
	subne	r1, #1

loop:
	ldrb	r0, [r1], #1
	sub		r0, #'0'
	cmp		r0, #0
	blt		exit
	mla		r2, r3, r2, r0
	b		loop

exit:
	mul		r2, r4, r2
	mov		r1, r2

	pop		{r0, r2-r4, lr}
	bx		lr

.end
