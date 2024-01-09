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
.equ	BUF_SIZE,	4
.equ	OPEN,		5

.data
	filename:		.asciz	"/dev/urandom"
	buffer:			.ds.b	BUF_SIZE,0
	fd:				.int	0

.text

rand:
	// Open File
	ldr		r0, =filename
	mov		r1, #O_RDONLY
	mov		r2, #MODE
	mov		r7, #OPEN
	svc		SVC_CALL

	// Save the fd

	// Read File

	// Close File

	// Constraining the Random Number

exit:

.end
