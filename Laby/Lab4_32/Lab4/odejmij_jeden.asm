.686
.model flat

public _odejmij_jeden

.code
_odejmij_jeden PROC

	push ebp
	mov ebp, esp

	push ebx
	push edi

	mov eax, [ebp+8]
	mov ebx, [eax]
	mov edi, [ebx]
	dec edi
	mov [ebx], edi
	mov [eax], ebx

	pop edi
	pop ebx
	pop ebp
	ret

_odejmij_jeden ENDP
END