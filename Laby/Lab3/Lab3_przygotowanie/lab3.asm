;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;zadanie z szeregiem

.686
.model flat

extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC

public _main

.data
znaki		db 12 dup (?)
n			db 30

.code
wyswietl_EAX PROC

	pusha
	mov esi, 10			;index tablicy znaki
	mov ebx, 10			;dzielnik rowny 10

konwersja:
	mov edx, 0				; zerowanie starszej cz�ci dzielnej
	div ebx					; dzielenie przez 10, reszta w EDX,iloraz w eax
	add dl, 30H				; zamiana reszty z dzielenia na kod ascii
	mov znaki [esi], dl		; zapisanie cyfry w kodzie ASCII
	dec esi					; zmniejszenie indeksu
	cmp eax, 0				; sprawdzenie czy iloraz = 0
	jne konwersja

	cmp edi, 1
	je minus

wypeln:
	jmp wyswietl
	or esi, esi
	jz wyswietl
	mov byte PTR znaki[esi], 20h
	dec esi
	jmp wypeln

minus:
	mov byte PTR znaki[esi], 2Dh
	dec edi
	dec esi
	jmp wypeln

wyswietl:
	mov byte PTR znaki[11], 20h
	mov byte PTR znaki[12], 0Ah

	inc esi
	lea ecx, [znaki+esi]

	push dword PTR 12
	push ecx
	push dword PTR 1
	call __write
	add esp, 12

	popa
	ret

wyswietl_EAX ENDP

szereg PROC
	pusha

	mov ecx, 40
	mov ebx, 0
	mov eax, 1

ptl1:
	bt eax, 31					;sprawdzam, czy to co jest w eax jest ujemne, je�li tak, to �eby si� poprawnie wy�wietli�a liczba to musimy j� zanegowa�
	jc neguj					;a potem to negowanie przywr�ci� z powrotem, �eby kolejne wyniki by�y dobre
	call wyswietl_EAX
	inc ebx
	sub eax, ebx
	dec ecx
	jnz ptl2
	jmp koniec

neguj:
	mov edi, dword PTR 1
	neg eax
	call wyswietl_EAX
	neg eax
	mov edi, 0
	inc ebx
	sub eax, ebx
	dec ecx
	jnz ptl2
	jmp koniec

neguj2:
	mov edi, dword PTR 1
	neg eax
	call wyswietl_EAX
	neg eax
	mov edi, 0
	inc ebx
	add eax, ebx
	dec ecx
	jnz ptl1
	jmp koniec

ptl2:
	cmp eax, 0
	jl neguj2
	call wyswietl_EAX
	inc ebx
	add eax, ebx
	dec ecx
	jnz ptl1

koniec:

	popa
	ret

szereg ENDP

_main PROC

	call szereg
	push 0
	call _ExitProcess@4

_main ENDP
END

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;zadanie z now� wersj� tego wy�wietl

comment |
.686
.model flat

extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC

public _main

.data
	znaki			db 12 dup (?)

	obszar			db 12 dup (?)
	dziesiec		dd 10 ; mno�nik

	dekoder			db '0123456789ABCDEF'
	liczbabin		dd 110000101011000000001b

.code
wyswietl_EAX PROC

	pusha

	cmp ebx, 0
	je koniec
	mov eax,[ebx]

	mov esi, 10				;indeks w tablicy 'znaki'
	mov ecx, 10				;dzielnik r�wny 10

konwersja:
	mov edx, 0				; zerowanie starszej cz�ci dzielnej
	div ecx					; dzielenie przez 10, reszta w EDX,iloraz w eax
	add dl, 30H				; zamiana reszty z dzielenia na kod ascii
	mov znaki [esi], dl		; zapisanie cyfry w kodzie ASCII
	dec esi					; zmniejszenie indeksu
	cmp eax, 0				; sprawdzenie czy iloraz = 0
	jne konwersja			; skok, gdy iloraz niezerowy

wypeln:
	or esi, esi
	jz wyswietl						; skok, gdy ESI = 0
	mov byte PTR znaki [esi], 20H	; kod spacji
	dec esi							; zmniejszenie indeksu
	jmp wypeln

wyswietl:
	mov byte PTR znaki [0], 0AH		; kod nowego wiersza
	mov byte PTR znaki [11], 0AH	; kod nowego wiersza

	push dword PTR 12				; liczba wy�wietlanych znak�w
	push dword PTR OFFSET znaki		; adres wy�w. obszaru
	push dword PTR 1				; numer urz�dzenia (ekran ma numer 1)
	call __write					; wy�wietlenie liczby na ekranie
	add esp, 12						; usuni�cie parametr�w ze stosu

koniec:
	popa
	ret

wyswietl_EAX ENDP

najpierw_EBX PROC

	

najpierw_EBX ENDP

_main PROC

	mov ebx, offset liczbabin
	call wyswietl_EAX
	push 0
	call _ExitProcess@4

_main ENDP
END |

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;zadanie z dzieleniem

comment |

.686
.model flat

extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC

public _main

.data
	znaki			db 12 dup (?)

	obszar			db 12 dup (?)
	dwanascie		dd 12 ; mno�nik

	dekoder			db '0123456789AB'

.code
wyswietl_EAX PROC			;no i w rezultacie mamy w eax to co przed znakiem \ a w ebx mamy dzielnik

	pusha

	mov esi, 10				;indeks w tablicy 'znaki'

	mov edx, 0
	div ebx
	mov ecx, edx
	jmp konwersja

no_i_reszta:
	mov esi, 10
	mov eax, ecx
	mov ecx, 1000
	mul ecx
	div ebx
	mov ebx,10

konwersja:					;najpierw skaczemy do konwersji, bo chcemy na pocz�tku wy�wietli� tylko t� liczb� ca�kowit� i kropk�
	mov edx, 0				
	div ebx					; dzielenie przez 10, reszta w EDX,iloraz w eax
	add dl, 30H				; zamiana reszty z dzielenia na kod ascii
	mov znaki [esi], dl		; zapisanie cyfry w kodzie ASCII
	dec esi					; zmniejszenie indeksu
	cmp eax, 0				; sprawdzenie czy iloraz = 0
	jne konwersja			; skok, gdy iloraz niezerowy
	cmp ecx, 1000			; przypadek kiedy ju� obliczamy to co po reszcie, w�wczas wiemy, �e jest ecx jest r�wny 1000
	je wypeln2

wypeln:
	or esi, esi
	jz wyswietl1						; skok, gdy ESI = 0
	dec esi							; zmniejszenie indeksu
	jmp wypeln

wypeln2:
	or esi, esi
	jz wyswietl1						; skok, gdy ESI = 0
	cmp esi, 7
	ja zeroo
	dec esi							; zmniejszenie indeksu
	jmp wypeln2

zeroo:								; bity wype�niamy zerami 
	mov byte PTR znaki[esi], 30h
	dec esi
	jmp wypeln2

wyswietl2:							;wy�wietlanie warto�ci u�amkowej
	mov byte PTR znaki [0],0	
	mov byte PTR znaki [11], 0AH	; kod nowego wiersza
	jmp koniec

wyswietl1:							; wyswietlanie ca�o�ci
	cmp ecx, 1000
	je wyswietl2
	mov byte PTR znaki [0], 0AH		; kod nowego wiersza
	mov byte PTR znaki [11], 2EH	; kod kropki

koniec:

	push ecx						; robimy sobie tego pusha �eby nam si� niezmienia�a warto�� w ecx i pozosta�� taka, jaka by�a

	push dword PTR 12				; liczba wy�wietlanych znak�w
	push dword PTR offset znaki		; adres wy�w. obszaru
	push dword PTR 1				; numer urz�dzenia (ekran ma numer 1)
	call __write					; wy�wietlenie liczby na ekranie
	add esp, 12						; usuni�cie parametr�w ze stosu

	pop ecx
	cmp ecx, 1000
	jne no_i_reszta

	popa
	ret

wyswietl_EAX ENDP

wczytaj_do_EAX_dwunastkowy PROC		; wczytywanie liczby dziesi�tnej z klawiatury, kt�ra jest w formie dwunastkowej

	push esi
	push edi
	push ecx

	push dword PTR 12
	push dword PTR OFFSET obszar	; adres obszaru pami�ci
	push dword PTR 0				; numer urz�dzenia (0 dla klawiatury)
	call __read						; odczytywanie znak�w z klawiatury
	add esp, 12						; usuni�cie parametr�w ze stosu

	mov eax, 0
	mov ebx, OFFSET obszar			; adres obszaru ze znakami

pobieraj_znaki:
	mov cl, [ebx]					; pobranie kolejnej cyfry w kodzie ascii
	inc ebx							; zwi�kszenie indeksu
	cmp cl,10						; sprawdzenie czy naci�ni�to Enter
	je byl_enter					; skok, gdy naci�ni�to Enter
	cmp cl, '\'						; sprawdzenie, czy wpisano znak \ i wtedy przej�cie do funkcji, kt�ra nam wczytuje do ebx
	je do_ebx						; dlatego tego ebx nie mogli�my nie mogli�my zpushowa� i zpopowa� bo jest on licznikiem  

	cmp cl, '9'
	ja sprawdzaj_dalej
	sub cl, '0'						;zamiana kodu ASCII na warto�� cyfry
	jmp dajesz

sprawdzaj_dalej:
	cmp cl, 'A'
	jb pobieraj_znaki				; inny znak jest ignorowany
	cmp cl, 'B'
	ja sprawdzaj_dalej2
	sub cl, 'A' - 10				; wyznaczenie kodu binarnego
	jmp dajesz
						
sprawdzaj_dalej2:
	cmp cl, 'a'
	jb pobieraj_znaki				; inny znak jest ignorowany
	cmp cl, 'b'
	ja pobieraj_znaki				; inny znak jest ignorowany
	sub cl, 'a' - 10
	jmp dajesz
	
dajesz:	
	movzx ecx, cl					;ta w�a�ciwa konwersja liczby zapisanej w systemie dwunastkowym na liczb� bin
	mul dword PTR dwanascie
	add eax, ecx					; dodanie ostatnio odczytanej cyfry
	jmp pobieraj_znaki				; skok na pocz�tek p�tli

do_ebx:
	call wczytaj_do_EBX_dwunastkowy
byl_enter:
	pop ecx
	pop edi
	pop esi
	ret

wczytaj_do_EAX_dwunastkowy ENDP

wczytaj_do_EBX_dwunastkowy PROC					; wczytywanie liczby dziesi�tnej z klawiatury do ebx

	push ecx
	push esi
	push edi
	push eax

	mov eax, 0

pobieraj_znaki:
	mov cl, [ebx]							; pobranie kolejnej cyfry w kodzie ascii
	inc ebx									; zwi�kszenie indeksu
	cmp cl,10								; sprawdzenie czy naci�ni�to Enter
	je byl_enter							; skok, gdy naci�ni�to Enter

	cmp cl, '9'
	ja sprawdzaj_dalej
	sub cl, '0'								; zamiana kodu ASCII na warto�� cyfry
	jmp dajesz

sprawdzaj_dalej:
	cmp cl, 'A'
	jb pobieraj_znaki						; inny znak jest ignorowany
	cmp cl, 'B'
	ja sprawdzaj_dalej2
	sub cl, 'A' - 10						; wyznaczenie kodu binarnego
	jmp dajesz
						
sprawdzaj_dalej2:
	cmp cl, 'a'
	jb pobieraj_znaki						; inny znak jest ignorowany
	cmp cl, 'b'
	ja pobieraj_znaki						; inny znak jest ignorowany
	sub cl, 'a' - 10
	jmp dajesz
	
dajesz:	
	movzx ecx, cl							; przechowanie warto�ci cyfry w ecx
	mul dword PTR dwanascie
	add eax, ecx							; dodanie ostatnio odczytanej cyfry
	jmp pobieraj_znaki						; skok na pocz�tek p�tli

byl_enter:
	mov ebx, eax
	pop eax
	pop edi
	pop esi
	pop ecx
	ret

wczytaj_do_EBX_dwunastkowy ENDP

_main PROC

	call wczytaj_do_EAX_dwunastkowy
	call wyswietl_EAX

	push 0
	call _ExitProcess@4

_main ENDP
END

|

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;zadanie z dodawaniem
comment |

.686
.model flat

extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC

public _main

.data
	znaki			db 12 dup (?)

	obszar			db 12 dup (?)
	dwanascie		dd 12 ; mno�nik

	dekoder			db '0123456789AB'

.code
wyswietl_EAX PROC

	pusha

	add eax, ebx

	mov esi, 10				;indeks w tablicy 'znaki'
	mov ebx, 10				;dzielnik r�wny 10

konwersja:
	mov edx, 0				; zerowanie starszej cz�ci dzielnej
	div ebx					; dzielenie przez 10, reszta w EDX,iloraz w eax
	add dl, 30H				; zamiana reszty z dzielenia na kod ascii
	mov znaki [esi], dl		; zapisanie cyfry w kodzie ASCII
	dec esi					; zmniejszenie indeksu
	cmp eax, 0				; sprawdzenie czy iloraz = 0
	jne konwersja			; skok, gdy iloraz niezerowy


wypeln:
	or esi, esi
	jz wyswietl						; skok, gdy ESI = 0
	mov byte PTR znaki [esi], 20H	; kod spacji
	dec esi							; zmniejszenie indeksu
	jmp wypeln

wyswietl:
	mov byte PTR znaki [0], 0AH		; kod nowego wiersza
	mov byte PTR znaki [11], 0AH	; kod nowego wiersza

	push dword PTR 12				; liczba wy�wietlanych znak�w
	push dword PTR OFFSET znaki		; adres wy�w. obszaru
	push dword PTR 1				; numer urz�dzenia (ekran ma numer 1)
	call __write					; wy�wietlenie liczby na ekranie
	add esp, 12						; usuni�cie parametr�w ze stosu

	popa
	ret

wyswietl_EAX ENDP

wczytaj_do_EAX_dwunastkowy PROC		; wczytywanie liczby dziesi�tnej z klawiatury, kt�ra jest w formie dwunastkowej

	push esi
	push edi
	push ecx

	push dword PTR 12
	push dword PTR OFFSET obszar	; adres obszaru pami�ci
	push dword PTR 0				; numer urz�dzenia (0 dla klawiatury)
	call __read						; odczytywanie znak�w z klawiatury
	add esp, 12						; usuni�cie parametr�w ze stosu

	mov eax, 0
	mov ebx, OFFSET obszar			; adres obszaru ze znakami

pobieraj_znaki:
	mov cl, [ebx]					; pobranie kolejnej cyfry w kodzie ascii
	inc ebx							; zwi�kszenie indeksu
	cmp cl,10						; sprawdzenie czy naci�ni�to Enter
	je byl_enter					; skok, gdy naci�ni�to Enter
	cmp cl, '+'						; sprawdzenie, czy wpisano znak + i wtedy przej�cie do funkcji, kt�ra nam wczytuje do ebx
	je do_ebx						; dlatego tego ebx nie mogli�my nie mogli�my zpushowa� i zpopowa� bo jest on licznikiem  

	cmp cl, '9'
	ja sprawdzaj_dalej
	sub cl, '0'						;zamiana kodu ASCII na warto�� cyfry
	jmp dajesz

sprawdzaj_dalej:
	cmp cl, 'A'
	jb pobieraj_znaki				; inny znak jest ignorowany
	cmp cl, 'B'
	ja sprawdzaj_dalej2
	sub cl, 'A' - 10				; wyznaczenie kodu binarnego
	jmp dajesz
						
sprawdzaj_dalej2:
	cmp cl, 'a'
	jb pobieraj_znaki				; inny znak jest ignorowany
	cmp cl, 'b'
	ja pobieraj_znaki				; inny znak jest ignorowany
	sub cl, 'a' - 10
	jmp dajesz
	
dajesz:	
	movzx ecx, cl					;ta w�a�ciwa konwersja liczby zapisanej w systemie dwunastkowym na liczb� bin
	mul dword PTR dwanascie
	add eax, ecx					; dodanie ostatnio odczytanej cyfry
	jmp pobieraj_znaki				; skok na pocz�tek p�tli

do_ebx:
	call wczytaj_do_EBX_dwunastkowy
byl_enter:
	pop ecx
	pop edi
	pop esi
	ret

wczytaj_do_EAX_dwunastkowy ENDP

wczytaj_do_EBX_dwunastkowy PROC					; wczytywanie liczby dziesi�tnej z klawiatury do ebx

	push ecx
	push esi
	push edi
	push eax

	mov eax, 0

pobieraj_znaki:
	mov cl, [ebx]							; pobranie kolejnej cyfry w kodzie ascii
	inc ebx									; zwi�kszenie indeksu
	cmp cl,10								; sprawdzenie czy naci�ni�to Enter
	je byl_enter							; skok, gdy naci�ni�to Enter

	cmp cl, '9'
	ja sprawdzaj_dalej
	sub cl, '0'								; zamiana kodu ASCII na warto�� cyfry
	jmp dajesz

sprawdzaj_dalej:
	cmp cl, 'A'
	jb pobieraj_znaki						; inny znak jest ignorowany
	cmp cl, 'B'
	ja sprawdzaj_dalej2
	sub cl, 'A' - 10						; wyznaczenie kodu binarnego
	jmp dajesz
						
sprawdzaj_dalej2:
	cmp cl, 'a'
	jb pobieraj_znaki						; inny znak jest ignorowany
	cmp cl, 'b'
	ja pobieraj_znaki						; inny znak jest ignorowany
	sub cl, 'a' - 10
	jmp dajesz
	
dajesz:	
	movzx ecx, cl							; przechowanie warto�ci cyfry w ecx
	mul dword PTR dwanascie
	add eax, ecx							; dodanie ostatnio odczytanej cyfry
	jmp pobieraj_znaki						; skok na pocz�tek p�tli

byl_enter:
	mov ebx, eax
	pop eax
	pop edi
	pop esi
	pop ecx
	ret

wczytaj_do_EBX_dwunastkowy ENDP

_main PROC

	call wczytaj_do_EAX_dwunastkowy
	call wyswietl_EAX

	push 0
	call _ExitProcess@4

_main ENDP
END
|

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.686
.model flat

extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC
extern _puts : PROC

public _main

.data
	znaki			db 17 dup (?)

	obszar			db 13 dup (?)
	dziesiec		dd 10 ; mno�nik

	dekoder			db '0123456789ABCDEF'

.code
wyswietl_EAX PROC

	pusha

	mov esi, 15				;indeks w tablicy 'znaki'
	mov ebx, 10				;dzielnik r�wny 10
	mov edi, ecx

konwersja:
	mov edx, 0				; zerowanie starszej cz�ci dzielnej
	div ebx					; dzielenie przez 10, reszta w EDX,iloraz w eax
	add dl, 30H				; zamiana reszty z dzielenia na kod ascii
	mov znaki [esi], dl		; zapisanie cyfry w kodzie ASCII
	dec esi					; zmniejszenie indeksu
	dec ecx
	cmp ecx, 0
	je kropke_daj
	cmp eax, 0				; sprawdzenie czy iloraz = 0
	jne konwersja			; skok, gdy iloraz niezerowy

wypeln:
	jmp wyswietl
	or esi, esi
	jz wyswietl						; skok, gdy ESI = 0
	mov byte PTR znaki [esi], 20H	; kod spacji
	dec esi							; zmniejszenie indeksu
	jmp wypeln

kropke_daj:
	cmp eax, 0
	je wypeln
	mov byte PTR znaki [esi], 2Eh	; kod kropki
	dec esi
	mov ecx, edi
	jmp konwersja

wyswietl:
	mov byte PTR znaki [0], 0AH		; kod nowego wiersza
	mov byte PTR znaki [16], 0AH

	inc esi
	lea ecx, [znaki+esi]

	push ecx						; adres wy�w. obszaru
	call _puts						; wy�wietlenie liczby na ekranie
	add esp, 12						; usuni�cie parametr�w ze stosu

	popa
	ret

wyswietl_EAX ENDP

_main PROC
	
	mov eax, 1
	mov ecx, 0
	mov cl,5		
	call wyswietl_EAX

	push 0
	call _ExitProcess@4

_main ENDP
END
