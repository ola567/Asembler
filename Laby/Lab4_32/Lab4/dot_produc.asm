.686
.model flat

public _dot_produc

.code
_dot_produc PROC

	push ebp
	mov ebp, esp

	push ebx
	push edi
	push esi

	mov ecx, [ebp+16]		;w ecx mamy warto�� n, kt�ra b�dzie naszym licznikiem p�tli
	mov ebx, [ebp+8]		;adres pierwszej tablicy
	mov edi, [ebp+12]		;adres drugiej tablicy
	sub esp, 4
	mov [ebp-4], dword ptr 0;wynik musimy przechowa� na stosie z powodu braku dost�pnych rejestr�w
ptl:
	mov eax, [ebx]			;pierwszy element tablicy tab1
	mov esi, [edi]			;pierwszy element tablicy tab2
	mul esi					;w eax mamy wynik mno�enia pierwszych wsp�rz�dnych
	add [ebp-4], eax		;tytaj nasz wynik
	add ebx, 4
	add edi, 4
	dec ecx
	jnz ptl

	mov eax, dword ptr [ebp-4]
	add esp, 4

	pop esi
	pop edi
	pop ebx
	pop ebp
	ret

_dot_produc ENDP
END