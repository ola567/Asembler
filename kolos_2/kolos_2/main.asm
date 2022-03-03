.686
.model flat

extern __write : PROC

 public _main

 .data
 znaki db 'Politechnika'
 znaki2 db 12 dup (0)
 .code
 wrzucone_zeby_bylo_miejsce_na_kodowanie PROC
 	mov esi, offset znaki	;esi=>adres znaków
	mov ecx, 12				;liczba znaków w 'znaki'
	mov ebx, 0
ptl:
	mov al, [esi]
	mov [znaki2+ebx], al
	inc ebx
	mov [znaki2+ebx], byte ptr 20h
	inc ebx
	inc esi
	loop ptl

	mov ecx, 24

	push ecx
	push offset znaki2
	push 1
	call __write
	add esp, 12
 wrzucone_zeby_bylo_miejsce_na_kodowanie ENDP
 _main PROC
	mov al, 128
	mov bl, 129
	add al, bl
	sbb ebx, ebx
	neg ebx
	bts eax, ebx

	cmp eax, ebx
	;je dalej
	db 01110100b
	db 00001001b
ppp:
	;and eax, 0Fh		;3bajty
	db 10000011b
	db 11100000b
	db 00001111b
	;mov [edx+ebx], dl	;3najtów
	db 10001000b
	db 00010100b
	db 00011010b
	;inc edx				;1bajt
	db 01000010b
	;loop ppp			;2bajty
	db 11100010b
	db 11110111b
dalej:
	nop


 _main ENDP
 END