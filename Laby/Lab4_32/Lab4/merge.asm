.686
.model flat

public _merge

.data 
nowa_tablica db 32 dup(?)

.code
_merge PROC

	push ebp
	mov ebp, esp

	push ebx
	push esi
	push edi

	;na razie zajmujemy siê pierwsz¹ tablic¹
	mov ecx, [ebp+16]		;ecx zawieta liczbê elem tablic
	mov ebx, [ebp+8]		;ebx zawiera adres tab1
	mov edi, 0

	cmp ecx, 4
	jg za_duzo_elem

ptl:
	mov eax, [ebx]
	mov dword ptr [nowa_tablica+edi], eax
	add edi, 4
	add ebx, 4
	dec ecx
	jnz ptl

	mov ecx, [ebp+16]		;ecx zawieta liczbê elem tablic
	mov ebx, [ebp+12]		;ebx zawiera adres tab2
ptl1:
	mov eax, [ebx]
	mov dword ptr [nowa_tablica+edi], eax
	add edi, 4
	add ebx, 4
	dec ecx
	jnz ptl1

	mov eax, offset nowa_tablica

koniec:
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret

za_duzo_elem:
	mov eax, 0
	jmp koniec

_merge ENDP
END