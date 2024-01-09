.global _start

.equ	MIN_RAND,	1
.equ	MAX_RAND,	100

.data

.text

_start:
	mov		r0, #MIN_RAND
	mov		r1, #MAX_RAND

	bl		rand

exit:
	mov		r0, #0
	mov		r7, #1
	svc		0

.end
