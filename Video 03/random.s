// Input:
//		r0 MUST contain MIN_RAND
//		r1 MUST contain MAX_RAND
//
// Output:
//		r0 will contain the value zero, if there was an error.
//		r0 will contain the random number, if there was no error.
//		r1 will contain the error code, if there is one.
//		r1 will contain the value zero, if there is no error.
//

.global rand

.equ	MODE,		0
.equ	O_RDONLY,	0
.equ	SVC_CALL,	0
.equ	READ,		3
.equ	BUF_SIZE,	4
.equ	OPEN,		5
.equ	CLOSE,		6

.data
	filename:		.asciz	"/dev/urandom"
	buffer:			.ds.b	BUF_SIZE,0
	fd:				.int	0

.text

rand:
	push	{r2-r7, lr}

	mov		r3, r0		// MIN_RAND
	mov		r4, r1		// MAX_RAND
	sub		r5, r4, r3	// RANGE

	cmp		r5, #0
	movle	r1, #-1
	ble		error

	add		r5, #1

	// Open File
	ldr		r0, =filename
	mov		r1, #O_RDONLY
	mov		r2, #MODE
	mov		r7, #OPEN
	svc		SVC_CALL

	// Store fd
	ldr		r1, =fd
	str		r0, [r1]

	// Read File
	ldr		r1, =buffer
	mov		r2, #BUF_SIZE
	mov		r7, #READ
	svc		SVC_CALL

	// Close File
	ldr		r0, =fd
	ldr		r0, [r0]
	mov		r7, #CLOSE
	svc		SVC_CALL

	// Constraining the Random Number
	ldr		r0, [r1]
	udiv	r6, r0, r5
	mul		r7, r6, r5
	sub		r0, r0, r7
	add		r0, r0, r3

	mov		r1, #0
	b		exit

error:
	mov		r0, #0

exit:
	pop		{r2-r7, lr}
	bx		lr

.end
