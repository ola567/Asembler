.686
.model flat

public _przeciwna

.code
_przeciwna PROC

	push ebp
	mov ebp, esp

	push ebx
	mov eax, [ebp+8]
	mov ebx, [eax]
	neg ebx
	mov [eax],ebx

	pop ebx
	pop ebp
	ret

_przeciwna ENDP
END