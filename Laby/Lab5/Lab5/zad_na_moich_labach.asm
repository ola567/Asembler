.686
.model flat

extern __write : PROC

public _main

.data
; deklaracja tablicy 12-bajtowej do przechowywania
; tworzonych cyfr
znaki db 12 dup (?)
testk dd 234.0

.code
wyswietl_EAX PROC
	pusha

	mov esi, 10 ; indeks w tablicy 'znaki'
	mov ebx, 10 ; dzielnik równy 10
konwersja:
	mov edx, 0 ; zerowanie starszej czêœci dzielnej
	div ebx ; dzielenie przez 10, reszta w EDX,
	; iloraz w EAX
	add dl, 30H ; zamiana reszty z dzielenia na kod
	; ASCII
	mov znaki [esi], dl; zapisanie cyfry w kodzie ASCII
	dec esi ; zmniejszenie indeksu
	cmp eax, 0 ; sprawdzenie czy iloraz = 0
	jne konwersja ; skok, gdy iloraz niezerowy
	; wype³nienie pozosta³ych bajtów spacjami i wpisanie
	; znaków nowego wiersza
wypeln:
	or esi, esi
	jz wyswietl ; skok, gdy ESI = 0
	mov byte PTR znaki [esi], 20H ; kod spacji
	dec esi ; zmniejszenie indeksu
	jmp wypeln
wyswietl:
	mov byte PTR znaki [0], 0AH ; kod nowego wiersza
	mov byte PTR znaki [11], 0AH ; kod nowego wiersza
	; wyœwietlenie cyfr na ekranie
	push dword PTR 12 ; liczba wyœwietlanych znaków
	push dword PTR OFFSET znaki ; adres wyœw. obszaru
	push dword PTR 1; numer urz¹dzenia (ekran ma numer 1)
	call __write ; wyœwietlenie liczby na ekranie
	add esp, 12 ; usuniêcie parametrów ze stosu

	popa
	ret
wyswietl_EAX ENDP
wysw_zm PROC
	push ebp
	mov ebp, esp

	push esi
	push edi
	push ebx
	mov edx, 32

	mov ebx, eax	;w ebx mamy sobie to co w eax
	shl ebx, 1		;pozbywamy siê bitu znaku
	and ebx, 0ff000000h
	shr ebx, 24
	sub ebx, 127	;w ebx mamy sobie wyk³adnik

	shl eax, 9
	shr eax, 1
	bts eax, 31
	inc ebx
	sub edx, ebx
	mov ecx, edx
	shr eax, cl

	call wyswietl_EAX

	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
wysw_zm ENDP
_main PROC
	mov eax, testk
	call wysw_zm
	nop
_main ENDP
END