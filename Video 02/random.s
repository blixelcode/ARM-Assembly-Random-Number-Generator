// Input:
//		r0 MUST contain MIN_RAND
//		r1 MUST contain MAX_RAND
//
// Output:
//		r0 will contain the error code, if there is one.
//		r0 will contain the value zero, if there is no error.
//		r1 will contain the value zero, if there was an error.
//		r1 will contain the random number, if there was no error.
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

exit:
	pop		{r2-r7, lr}
	bx		lr

.end
