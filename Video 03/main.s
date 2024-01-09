.global _start

.equ	MIN_RAND,	10
.equ	MAX_RAND,	20

.data
	num:		.asciz	"000000000000000"
	errormsg:	.asciz	"rand returned an error\n"
	nl:			.asciz	"\n"

.text

_start:
	mov		r3, #0

loop:
	mov		r0, #MIN_RAND
	mov		r1, #MAX_RAND

	bl		rand
	cmp		r1, #0
	blt		error

	ldr		r1, =num
	bl		itoa
	bl		print
	ldr		r1, =nl
	bl		print

	add		r3, #1
	cmp		r3, #10
	blt		loop

	b		exit

error:
	ldr		r1, =errormsg
	bl		print

exit:
	mov		r0, #0
	mov		r7, #1
	svc		0

.end
