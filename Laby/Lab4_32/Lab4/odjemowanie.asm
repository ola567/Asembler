.686
.model flat

public _odejmowanie

.code
_odejmowanie PROC

	push ebp
	mov ebp, esp

	push ebx

	mov ebx, [ebp+8]		;w ebx mamy adres na adres liczby a
	mov edx, [ebx]			;w edx mamy adres na liczb� a
	mov eax, [edx]			;w eax mamy ju� t� liczb�

	mov ebx, [ebp+12]		;w ebx mamy adres na liczb�b
	mov edx, [ebx]			;w edx mamy liczb� b

	sub eax, edx

	pop ebx
	pop ebp
	ret

_odejmowanie ENDP
END