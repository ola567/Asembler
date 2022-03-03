.686
.model flat

extern _GetPhysicallyInstalledSystemMemory@4 : PROC

public _ram

.data
wynik dd ?
.code
_ram PROC

	push ebp
	mov ebp, esp
	sub esp, 8
	lea eax, [ebp-8]

	push eax
	call _GetPhysicallyInstalledSystemMemory@4

	mov eax, [ebp-8]
	mov edx, [ebp-4]

	add esp, 8
	pop ebp
	ret
_ram ENDP
END