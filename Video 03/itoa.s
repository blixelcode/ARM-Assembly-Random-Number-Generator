// Input:
//		r0 MUST contain the integer to be converted.
//		r1 MUST contain the memory address to the variable where
//         we will store out result.
//
// Output:
//		The memory address that r1 points to, will have been updated
//      with the result.
//
.global itoa

itoa:
	push	{r0-r7, lr}

	mov		r2, #1
	mov		r3, #10
	mov		r4, r0
	mov		r7, #1

	cmp		r0, #0
	blt		negative_value
	b		loop1

negative_value:
	mov		r7, #-1
	mul		r4, r7, r4
	mov		r5, #'-'
	strb	r5, [r1], #1

loop1:
	cmp		r4, r3
	udivge	r4, r4, r3
	mulge	r2, r3, r2
	bge		loop1

	mov		r4, r0
	mul		r4, r7, r4

loop2:
	cmp		r2, #0
	ble		nullbyte
	udiv	r5, r4, r2
	mul		r6, r2, r5
	sub		r4, r4, r6
	add		r5, #'0'
	strb	r5, [r1], #1
	udiv	r2, r2, r3
	b		loop2

nullbyte:
	mov		r5, #0
	strb	r5, [r1], #1

exit:
	pop		{r0-r7, lr}
	bx		lr

.end
