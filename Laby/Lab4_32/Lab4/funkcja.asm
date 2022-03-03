.686
.model flat

extern _malloc : PROC

public _funkcja

.code
_funkcja PROC
	push ebp
	mov ebp, esp

	sub esp, 8

	push 16
	call _malloc		;czyli teraz w eax mamy adres lub NULL jeœli siê nie powiod³o

	push ebx
	push edi
	push esi

	mov [ebp-4], eax	;czyli pod tym adresem bêdzie adres malloc
	mov ebx, [ebp-4]	;ebx zwaiera adres
	cmp ebx, 0
	je zero

	mov [esp-8], dword ptr 0
	mov esi, [esp-8]	;wartoœæ h
	mov ecx, [ebp+8]	;wartoœæ e
ptl:
	mov eax, esi
	mov edi, 3
	mul edi
	sub eax, 1
	mov [ebx], dword ptr eax
	inc ebx
	inc esi
	cmp esi, ecx
	jl ptl
	jmp koniec

zero:
	mov eax, -1

koniec:
	pop esi
	pop edi
	pop ebx
	add esp, 12
	mov eax, ecx
	pop ebp
	ret
_funkcja ENDP
END