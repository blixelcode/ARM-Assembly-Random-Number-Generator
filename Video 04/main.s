.global _start

.equ	MIN_RAND,	1
.equ	MAX_RAND,	100

.data
	num:		.asciz	"000000000000000"
	rangemsg:	.asciz	"Range error\n"
	openmsg:	.asciz	"Error opening file\n"
	readmsg:	.asciz	"Error reading file\n"
	closemsg:	.asciz	"Error closing file\n"
	nl:			.asciz	"\n"

.text

_start:
	mov		r3, #0

loop:
	mov		r0, #MIN_RAND
	mov		r1, #MAX_RAND

	bl		rand

	cmp		r1, #-1
	ldreq	r1, =rangemsg
	beq		error

	cmp		r1, #-2
	ldreq	r1, =openmsg
	beq		error

	cmp		r1, #-3
	ldreq	r1, =readmsg
	beq		error

	cmp		r1, #-4
	ldreq	r1, =closemsg
	beq		error

	ldr		r1, =num
	bl		itoa
	bl		print
	ldr		r1, =nl
	bl		print

	add		r3, #1
	cmp		r3, #25
	blt		loop

	b		exit

error:
	bl		print

exit:
	mov		r0, #0
	mov		r7, #1
	svc		0

.end
