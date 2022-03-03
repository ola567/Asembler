.686
.model flat

public _plus_jeden

.code
_plus_jeden PROC
	push ebp 
	mov ebp,esp 

	push ebx ; przechowanie zawartoœci rejestru EBX

	mov ebx, [ebp+8]
	mov eax, [ebx] ; odczytanie wartoœci zmiennej
	inc eax ; dodanie 1
	mov [ebx], eax ; odes³anie wyniku do zmiennej

	pop ebx
	pop ebp
	ret
_plus_jeden ENDP
 END