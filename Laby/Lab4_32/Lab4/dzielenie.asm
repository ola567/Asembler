.686
.model flat

public _dzielenie

.code
_dzielenie PROC

	push ebp
	mov ebp, esp

	push ebx
	push edi
	push esi

	mov ebx, [ebp+8]		;w ebx mamy adres dzielnej
	mov eax, [ebx]			;w eax mamy dzieln¹
	mov ebx, [ebp+12]		;w ebx mamy adres na adres dzielnika
	mov edi, [ebx]
	mov esi, [edi]			; w esi mamy dzielnik

	cmp eax, 0				;tutaj trzeba to sprawdziæ, bo jeœli jest ujemna to wtedy musimy w edx wpisaæ same f
	jl ujemna
	jmp dziel

ujemna:
	mov edx, 0ffffffffh

dziel:
	idiv esi


	pop esi
	pop edi
	pop ebx
	pop ebp
	ret

_dzielenie ENDP
END