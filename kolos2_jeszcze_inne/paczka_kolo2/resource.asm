.686
.model flat

public _compute

.data
L1 dd 00111111100000000000000000000001b
L2 dd 01000000000000000000000000000001b
L3 dd 0
.code
_compute PROC
	push ebp
	mov ebp, esp
	
	mov edx, 00000004h
	mov ebx, 00000001h

	stc
	sbb edx, edx
	neg edx
	bts ebx, edx

	fld L1
	fadd l2
	fst L3

	mov eax, [ebp+8]
	mov ebx, [ebp+12]
	mov edi, [ebp+16]

	and eax, 7fffffh
	shl eax, 23
	add ebx, eax

	mov [edi], ebx

	pop ebp
	ret
_compute ENDP
END