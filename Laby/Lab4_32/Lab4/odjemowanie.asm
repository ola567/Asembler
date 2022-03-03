.686
.model flat

public _odejmowanie

.code
_odejmowanie PROC

	push ebp
	mov ebp, esp

	push ebx

	mov ebx, [ebp+8]		;w ebx mamy adres na adres liczby a
	mov edx, [ebx]			;w edx mamy adres na liczbê a
	mov eax, [edx]			;w eax mamy ju¿ t¹ liczbê

	mov ebx, [ebp+12]		;w ebx mamy adres na liczbêb
	mov edx, [ebx]			;w edx mamy liczbê b

	sub eax, edx

	pop ebx
	pop ebp
	ret

_odejmowanie ENDP
END