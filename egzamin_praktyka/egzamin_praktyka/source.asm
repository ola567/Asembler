.686
.model flat

extern _malloc : PROC

public _wystapienia, _sortuj, _podciag, _float_to_fp24

.data
zmienna dw 10000 dup(0)
.code
_float_to_fp24 PROC
	push ebp
	mov ebp, esp
	pusha

	mov eax, 0			;tu bêdzie nasz wynik
	mov ecx, [ebp+8]	;tutaj float
	mov edx, [ebp+8]	;tutaj float

	bt ecx, 31
	jc ujemna
	btr eax,7
	jmp dalej
ujemna:
	bts eax, 7
dalej:
	rol ecx, 9
	and ecx, 000000ffh
	sub ecx, 127
	add ecx, 63
	or eax, ecx
	shl eax, 16
	and edx, 007fffffh
	shr edx, 8
	or eax, edx


	popa
	pop ebp
	ret
_float_to_fp24 ENDP
_podciag PROC
	push ebp
	mov ebp, esp
	pusha
	
	sub esp, 8
	mov dword ptr [ebp-4], 0
	mov esi, [ebp+12]		;tab2
	mov edi, [ebp+8]		;tab1
	mov ebx, [esi]

ptl:
	cmp dword ptr [edi], 0
	je koniec
	cmp dword ptr ebx, 0
	je koniec
	cmp dword ptr [edi], ebx
	je znaleziono
	add edi, 4
	jmp ptl

znaleziono:
	add dword ptr [ebp-4], 1
	add edi, 4
	add esi, 4
	mov ebx, [esi]
	jmp ptl

koniec:	
	popa
	pop ebp
	ret
_podciag ENDP
_sortuj PROC
	push ebp 
	mov ebp, esp
	pusha

	mov ecx, [ebp+12]
	mov edx, [ebp+8]
	jmp $-4
	push ecx
	push edx
	call _wystapienia
	add esp, 8

	popa
	pop ebp
	ret
_sortuj ENDP
_wystapienia PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx

	mov eax, 1280			;256*5
	push eax
	call _malloc
	add esp, 4				;w eax mamy adres obszaru tablicy wyst¹pienia

	mov ecx, 256
	mov bl, 30h
	push eax
ptl:
	mov byte ptr [eax], bl
	inc eax
	mov dword ptr [eax], 0
	inc ebx
	add eax, 4
	loop ptl
	pop eax

	mov ecx, [ebp+12]		;liczba elementów w tablicy Ÿród³owej
	mov esi, [ebp+8]		;adres obszaru
ptl1:
	mov ebx, [esi]
	mov edx, 256
	push eax
	ptl3:
	cmp byte ptr [eax], bl 
	je jest
	add eax, 5
	dec edx
	jnz ptl3

	jest:
	mov edx, 0
	add [eax+1], dword ptr 1
	pop eax
	add esi, 1
	loop ptl1

	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_wystapienia ENDP
END