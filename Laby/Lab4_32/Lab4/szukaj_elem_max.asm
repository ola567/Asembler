.686
.model flat

public _szukaj_elem_max

.code
_szukaj_elem_max PROC

	push ebp
	mov ebp, esp
	push esi
	push edi

	mov ecx, 0
	mov esi, [ebp+8]
	mov eax, [esi]			;w eax mamy wartoœæ pierwszego elementu tablicy
	mov edx, [ebp+12]		;nasz licznik -> liczba elem w tablicy

ptl:
	add esi, 4
	dec edx
	cmp edx, 0
	jz koniec
	cmp eax, [esi]
	jl mniej
	jmp ptl
	
mniej:
	mov eax, [esi]	;w eax mamy kolejny element do porównania
	jmp ptl

koniec:
	mov dword ptr [ebx], eax
	mov eax, ebx

	pop edi
	pop esi
	pop ebp
	ret

_szukaj_elem_max ENDP
END