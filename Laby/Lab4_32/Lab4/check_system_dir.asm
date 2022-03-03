.686
.model flat

extern _GetSystemDirectoryA@8 : PROC

public _check_system_dir

.data
lpBuffer	db 20 dup(0)
uSize		dd 20

.code
_check_system_dir PROC
	push ebp
	mov ebp, esp

	push ebx
	push edx
	push esi

	mov ebx, [ebp+8]
	mov esi, 0

	push offset uSize
	push offset lpBuffer
	call _GetSystemDirectoryA@8


ptl:
	mov dl, [ebx]					     ;w edx mamy ju¿ wartoœæ
	inc ebx
	mov cl, byte ptr [lpBuffer+esi]
	cmp cl, dl
	jne nie
	inc esi
	dec eax
	jnz ptl
	jmp tak

nie:
	mov eax, 0
	jmp koniec
tak:
	mov eax, 1
koniec:
	pop esi
	pop edx
	pop ebx
	pop ebp
	ret
_check_system_dir ENDP
END