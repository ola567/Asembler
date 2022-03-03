.686
.model flat

public _szukaj_max

.code
_szukaj_max PROC

	push ebp
	mov ebp, esp
	mov ecx, 0
	mov edx, 4

	mov eax, [ebp+8]		;w eax mamy x

ptl:
	add ecx, 4
	dec edx
	cmp edx, 0
	jz koniec
	cmp eax, [ebp+8+ecx]
	jl mniej
	jmp ptl
	
mniej:
	mov eax, [ebp+8+ecx]	;w eax mamy kolejny element do porównania
	jmp ptl

koniec:
	pop ebp
	ret

_szukaj_max ENDP
END