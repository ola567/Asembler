.686
.model flat

extern __write : PROC
extern _puts : PROC

public _srednia_harm, _nowy_exp, _obj_stozka, _tan, _find_max_range
public _oblicz_potege


.data
mianownik dd 0
suma dd 0

jeden dd 1

trzy dd 3.0

kat	dd 0.0
pietnascie dd 15.0
sto_osm	dd 180.0
tys dd 1000.0

g  dd 9.81
dwa dd 2.0

znaki db 12 dup (?)

.code
_oblicz_potege PROC
	push ebp
	mov ebp, esp

	sub dword ptr [ebp+8], 1
	fild dword ptr [ebp+8]
	fld dword ptr dwa	
	fscale
	fxch st(1)
	fstp st(0)
	fild dword ptr [ebp+12]
	fadd

	pop ebp
	ret
_oblicz_potege ENDP
_find_max_range PROC
	push ebp
	mov ebp, esp

	fld dword ptr [ebp+8]
	fmul st(0), st(0)
	fld dword ptr g
	fdiv
	fld dword ptr [ebp+12]
	fldpi
	fmul
	fld dword ptr sto_osm
	fdiv
	fld dword ptr dwa
	fmul
	fsincos
	fstp st(0)
	fmul

	pop ebp
	ret
_find_max_range ENDP
wyswietl_EAX PROC
	pusha

	mov ecx, 3
	mov esi, 15				;indeks w tablicy 'znaki'
	mov ebx, 10				;dzielnik równy 10
	mov edi, ecx

konwersja:
	mov edx, 0				; zerowanie starszej czêœci dzielnej
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
	;cmp eax, 0
	;je wypeln
	mov byte PTR znaki [esi], 2Eh	; kod kropki
	dec esi
	cmp eax, 0
	je wpisz_0
dalej:
	mov ecx, edi
	jmp konwersja
wpisz_0:
	dec esi
	mov byte ptr znaki [esi], '0'
	jmp dalej

wyswietl:
	mov byte PTR znaki [0], 0AH		; kod nowego wiersza
	mov byte PTR znaki [16], 0AH

	inc esi
	lea ecx, [znaki+esi]

	push dword ptr 12
	push ecx
	push dword ptr 1; adres wyœw. obszaru
	call __write						; wyœwietlenie liczby na ekranie
	add esp, 12						; usuniêcie parametrów ze stosu

	popa
	ret
wyswietl_EAX ENDP

_tan PROC
	push ebp
	mov ebp, esp

	push ebx
	push edi
	push esi

	mov ecx, 5
	mov ebx, 15
	finit
	fld dword ptr kat
	fld dword ptr pietnascie
	fld dword ptr kat
ptl:
	fldpi
	fmul
	fld dword ptr sto_osm
	fdiv
	fptan
	fdiv
	fld dword ptr tys
	fmul
	frndint
	fist dword ptr [esp-4]
	mov eax, [esp-4]
	call wyswietl_EAX
	fxch st(2)
	fadd st(0), st(1)
	fst st(2)
	dec ecx
	jnz ptl

	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_tan ENDP

_obj_stozka PROC
	push ebp
	mov ebp, esp

	push ebx
	push edi
	push esi

	fild dword ptr [ebp+12]
	fmul st(0), st(0)
	fild dword ptr [ebp+12]
	fild dword ptr [ebp+8]
	fmul
	fadd 
	fild dword ptr [ebp+8]
	fmul st(0), st(0)
	fadd
	fld dword ptr [ebp+16]
	fmul
	fldpi
	fmul
	fld dword ptr trzy
	fdiv

	pop esi
	pop edi
	pop ebx
	pop ebp
	ret 
_obj_stozka ENDP

_nowy_exp PROC
	push ebp
	mov ebp, esp

	push ebx
	push esi
	push edi

	mov ecx, 20

	finit

	fld1
	fld dword ptr [ebp+8]
	fld1
	fadd st(1), st(0)		;suma dwóch pierwszych wyrazów, w st(4) mamy wynik
	fstp st(0)

	fld dword ptr [ebp+8]	;mno¿nik x do potêgowanie st(3)
	fld1					;st(2) mno¿nik mianownika
	fld1					;st(1) mianownik do dzielenia
	fld dword ptr [ebp+8]	;aktualny x

	sub ecx, 2

ptl:
	fmul st(0), st(3)
	fst st(3)
	fxch st(1)				;mianownik na wierzcho³ku stostu
	fxch st(5)
	fadd st(2),st(0)
	fxch st(5)
	fmul st(0), st(2)
	fxch
	fdiv st(0), st(1)
	fadd st(4), st(0)

	fstp st(0)
	fld dword ptr [ebp+8]
	loop ptl

	fxch st(4)

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_nowy_exp ENDP
_srednia_harm PROC
	push ebp
	mov ebp, esp

	push edi
	push esi
	push ebx

	mov ecx, [ebp+12]
	mov esi, [ebp+8]

	finit
	fldz
ptl:
	fld1
	fld dword ptr [esi]
	fdiv
	fadd st(1), st(0)
	fstp st(0)
	add esi, 4
	loop ptl

	fild dword ptr [ebp+12]
	fxch st(1)
	fdiv

	pop ebx
	pop esi
	pop edi
	pop ebp
	ret
_srednia_harm ENDP
END