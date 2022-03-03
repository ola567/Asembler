.686
.model flat

extern __write : PROC
extern _MessageBoxA@16 :PROC 
extern _ExitProcess@4 : PROC 
extern _malloc : PROC

public _NWD, _obj_stozka_sc, _MIESZ2float, _float_razy_float, _float_to_half
public _szereg, _druk_szeroki, _float2MIESZ, _wyswietl, _podziel, _ciag, _XYZ
public _spacje, _funkcja, _format, _zamien_na_binarny, _zamien_na_base12, _szereg2
public _rozklad, _uint48_float

.data
trzy dd 3.0
m2f dd ?
frazyf dd ?
dwa dd 2.0
elem dd ?
wykladnik db ?
szesc dq 6.0
piec dq 5.0
zmienna1 dd ?
x dd 3.063
y dd 1.393
zet dd 0.476
jedendwa dd 1.2
zm_pom dq ?
mnoznik dd 12

.code
_uint48_float PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	fild qword ptr [ebp+8]		;za³akowanie liczby
	fld dwa
	fld dwa
	mov ecx, 15
ptl:
	fmulp st(1), st(0)
	fld dwa
	loop ptl

	fstp st(0)
	fdiv

	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_uint48_float ENDP
_rozklad PROC
	push ebp
	mov ebp, esp
	push edi
	push esi
	push ebx

	mov eax, 64
	push eax
	call _malloc		;w eax mamy arezerwowany obszar pamiêci
	mov edi, eax

	mov ecx, 16
wstaw_zera:
	mov [eax], dword ptr 0
	add eax, 4
	loop wstaw_zera

	mov ecx, [ebp+12]	;liczba elementów w tablicy
	mov esi, [ebp+8]
	mov ebx, 16
ptl:
	mov edx, 0
	mov eax, [esi]
	div ebx				;edx to jest nasz indeks w tablicy zaalokowanej przez malloc
	mov eax, [edi+4*edx]
	inc eax
	mov [edi+4*edx], eax
	add esi, 8
	loop ptl

	mov eax, edi

	pop ebx
	pop esi
	pop edi
	pop ebp
	ret
_rozklad ENDP
_szereg2 PROC
	push ebp
	mov ebp, esp
	push edi
	push esi
	push ebx

	mov ecx, [ebp+8]		;liczba 

	fldz
	fld1
	fld1
	fld1
	fadd
	fxch
ptl:
	fdiv st(0), st(1)		;st(0)=>wynik dzielnia
	fadd st(2), st(0)		;wynik dodawania
	fstp st(0)				;zlikwidowanie wierzcho³ka
	fld1
	fadd st(1), st(0)
	loop ptl

	fstp st(0)
	fstp st(0)

	pop ebx
	pop esi
	pop edi
	pop ebp
	ret
_szereg2 ENDP
_zamien_na_base12 PROC
	push ebp
	mov ebp,esp
	push edi
	push esi
	push ebx

	mov eax, [ebp+8]
	mov ebx, 12
	mov ecx, 0

sprawdz_ilosc:
	mov edx, 0
	div ebx
	inc ecx
	cmp eax, 0
	jnz sprawdz_ilosc

	mov ebx, 2
	mov eax, ecx
	mul ebx					;w eax mamy liczbê bajtów
	mov esi, eax			;w ebx mamy zapamiêtan¹ liczbê bajtów
	add eax, 2
	push esi

	push eax
	call _malloc			;w eax mamy adres zarezerwowanego obszaru pamiêci
	add esp, 4
	
	mov edi, eax
	mov eax, [ebp+8]
	mov ebx, 12
	sub esi, 2
konwersja:
	mov edx, 0
	div ebx
	cmp dx, 9
	ja znaczek
	add dx, 30H
juhu:
	mov word ptr [edi+esi], dx
	sub esi, 2
	cmp eax, 0
	jne konwersja
	jmp the_end

znaczek:
	sub dx, 10
	add dx, 'A'
	jmp juhu

the_end:
	pop esi
	mov word ptr [edi+esi], 0
	mov eax, edi

	pop ebx
	pop esi
	pop edi
	pop ebp
	ret
_zamien_na_base12 ENDP
_zamien_na_binarny PROC
	push ebp
	mov ebp, esp

	mov esi, [ebp+8]		;adres tablicy znaki
	mov ecx, 0
	mov eax, 0

lecimy:
	mov cx, [esi]
	cmp cx, 0
	je koniec_znakow
	add esi, 2
	cmp cx, 218Ah
	je odejmij_wiecej
	cmp cx, 218Bh
	je odejmij_wiecej
	sub cx, 30h
	jmp dalej
odejmij_wiecej:
	sub cx, 2180h
dalej:
	movzx ecx, cx
	mul dword ptr mnoznik
	add eax, ecx
	jmp lecimy

koniec_znakow:

	pop ebp
	ret
_zamien_na_binarny ENDP
_format PROC
	add esp, 10
	mov [esp], dword ptr 00000000h
	mov [esp+4], dword ptr 0D0000000h
	mov [esp+8], word ptr 4000h

	mov eax, 00000000h
	xor eax, [esp]
	jne koniec
	mov eax, 80000000h
	xor eax, [esp+4]
	jne koniec
	mov ax, 4000h
	xor ax, [esp+8]
	jne koniec
	stc
	jmp the

koniec:
	clc
the:
_format ENDP
_funkcja PROC
	push ebp
	mov ebp, esp

	fild qword ptr [ebp+8]
	fld1
	fcomi st(0), st(1)
	je zwroc_jeden_lub_dwa
	fstp st(0)
	fld dword ptr dwa
	fcomi st(0), st(1)
	je zwroc_jeden_lub_dwa
	fstp st(0)
	fld1
	fsub
	sub esp, 8
	fistp qword ptr [esp]
	call _funkcja
	fild qword ptr [esp]
	add esp, 8
	fld1
	fadd
	fxch
	fld dword ptr jedendwa
	fxch
	fsub
	fxch
	fdiv
	jmp dalej
zwroc_jeden_lub_dwa:
	fxch
	fstp st(0)

dalej:
	pop ebp
	ret
_funkcja ENDP
_spacje PROC
	push ebp
	mov ebp, esp

	mov ecx, 129
	push ecx
	call _malloc
	add esp, 4

	mov ecx, 128
	mov edx, [ebp+8]
	push eax
ptl:
	mov [eax], dl
	inc eax
	loop ptl
	
	mov [eax], byte ptr 0
	pop eax

	pop ebp
	ret
_spacje ENDP
_XYZ PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi

	mov esi, [ebp+8]		;adres tablicy floatów
	mov ecx, [ebp+12]		;n
	mov eax, ecx
	mov ebx, 4
	mul ebx
	mov ecx, eax
	push ecx
	call _malloc			;eax=>adres nowej tablicy
	add esp, 4

	push eax
	mov ecx, [ebp+12]	
ptl:
	fld dword ptr x
	fld dword ptr [esi]
	fmul
	fld dword ptr y
	fld dword ptr [esi+4]
	fmul
	fsub
	fld dword ptr zet
	fld dword ptr [esi+8]
	fmul
	fsub
	fstp dword ptr [eax]
	add eax, 4
	add esi, 12
	loop ptl

	pop eax

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_XYZ ENDP
_ciag PROC
	push ebp
	mov ebp, esp

	mov ecx, [ebp+8]		;ecx=>adres liczby
	mov ebx, [ecx]			;liczba

	cmp ebx, 1
	je zwroc_5
	cmp ebx, 2
	je zwroc_6
	sub ebx, 1
	sub esp, 4
	mov [esp], ebx
	push esp
	call _ciag
	pop esp
	mov ebx, [esp]
	add esp, 4
	add ebx, 1
	mov zmienna1, ebx
	fld dword ptr trzy
	fxch
	fsub
	fild dword ptr zmienna1
	fdiv
	jmp dalej

zwroc_6:
	fld qword ptr szesc
	jmp dalej
zwroc_5:
	fld qword ptr piec
dalej:
	pop ebp
	ret
_ciag ENDP
_podziel PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp+8]		;ebx=>liczba typu float
	rol ebx, 9				;bl=>wyk³adnik
	sub bl, 4
	ror ebx, 9
	
	push ebx
	fld dword ptr [esp]
	pop ebx

	pop ebx
	pop ebp
	ret
_podziel ENDP
_wyswietl PROC
	push ebp
	mov ebp, esp
	pusha

	mov esi, [ebp+8]		;adres do tablicy char
	mov ecx, 0
spr_ile_znakow:
	cmp byte ptr [esi], 0
	je koniec_znakow
	inc ecx
	inc esi
	jmp spr_ile_znakow

koniec_znakow:
	mov eax, ecx
	mov ebx, 2
	mul ebx					;eax=>liczba znaków po dodaniu spacji

	add eax, 1				;dodanie jednego bajtu na znak konca 
	sub esp, eax			;zrobienie miejsca na stosie
	mov edi, esp
	mov esi, [ebp+8]
ptl:
	mov bl, [esi]
	mov [edi], bl
	mov byte ptr [edi+1], 20h
	add edi, 2
	inc esi
	loop ptl

	mov byte ptr [edi], 0	;dodanie znaku koñca ci¹gu znaków
	mov edi, esp

	push 0
	push edi
	push edi
	push 0
	call _MessageBoxA@16
	add esp, eax

	push 0
	call _ExitProcess@4

	popa
	pop ebp
	ret
_wyswietl ENDP
_float2MIESZ PROC
	push ebp
	mov ebp, esp
	pusha

	mov esi, [ebp+8]		;esi=>adres liczby float
	mov ebx, [esi]			;ebx=>liczba float
	mov edx, 0

	rol ebx, 9				
	mov dl, bl
	sub dl, 127				;dl=>wyk³adnik
	mov wykladnik, dl		
	ror ebx, 9
	and ebx, 007fffffh		;wyró¿niona mantysa
	bts ebx, 23				;ustawiona niejawna jedynka
	
	mov ecx, 23
	sub cl, dl				;cl=>to, o ile musimy przesun¹æ w prawo
	shr ebx, cl
	mov edx, ebx			;edx=>czêœæ ca³kowita liczby

	mov ebx, [esi]
	and ebx, 007fffffh
	shl ebx, 9
	mov cl, wykladnik
	shl ebx, cl		;ebx=>wyró¿niona czêœæ u³amkowa
	mov eax, ebx

	popa
	pop ebp
	ret
_float2MIESZ ENDP
_druk_szeroki PROC
	push ebp
	mov ebp, esp
	pusha

	mov ecx, [ebp+12]		;ecx=>liczba elementów
	mov esi, [ebp+8]		;esi=>adres tablicy

	mov eax, ecx
	mov ebx, 2
	mul ebx					;w eax mamy liczbê bajtów z uwzglêdnionymi spacjami

	add eax, 2
	sub esp, eax
	mov edi, esp			;edi=>adres lokacji pamiêci dla danych lokalnych

ptl:
	mov dl, [esi]
	mov [edi], dl
	mov byte ptr [edi+1], 20h
	inc esi
	add edi, 2
	loop ptl

	mov byte ptr [edi], 0	;uwzglêdnienie bajtu 0
	mov edi, esp

	push eax
	push edi
	push 1
	call __write
	add esp, 12
	add esp, eax

	popa
	pop ebp
	ret
_druk_szeroki ENDP
_szereg PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	mov ecx, [ebp+8]		;liczba elementów

	cmp ecx, 1
	je zwroc_pol
	dec ecx
	push ecx
	call _szereg
	pop ecx
	inc ecx
	inc ecx
	
	mov elem, ecx
	fld1
	fild dword ptr elem
	fdiv

	fadd
	jmp koniec

zwroc_pol:
	fld1
	fld dword ptr dwa
	fdiv

koniec:
	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_szereg ENDP
;printowanie w main nie dzia³a, ale sama konwersja jest git
_float_to_half PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	mov ebx, [ebp+8]			;ebx=>liczba typu float
	mov eax, 0
	mov edx, 0

	rol ebx, 9					;bl=>wykladnik
	mov dl, bl
	sub dl, 127					;wyk³adnik z float
	add dl, 15					;wyk³adnik dla formatu binary16
	mov al, dl
	shl ax, 10					;wyk³adnik na swoim miejscu
	ror ebx, 9
	bt ebx, 31
	jc ujemna
	btr ax, 15
ujemna:
	bts ax, 15					;ax=>wyk³adnik plus znak na swoim miejscu

	and ebx, 007fffffh			;wy³uskana mantysa
	shr ebx, 13
	or ax, bx					;w ax mamy wynik

	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_float_to_half ENDP
;nie dzia³a w pe³ni
_float_razy_float PROC
	push ebp
	mov ebp, esp
	pusha

	mov eax, [ebp+12]		;eax=>b
	mov ebx, [ebp+8]		;ebx=>a

	rcr eax, 23				;al=>przesuniêty wyk³adnik
	sub al, 127				;wyk³adnik
	rcr ebx, 23
	sub bl, 127				;bl=>wyk³adnik

	mov ecx, 0
	add cl, al
	add cl, bl				;dl=>suma wyk³adników
	add cl, 127
	shl ecx, 23				;w poprawnym miejscu znajduje siê wyk³adnik
	
	rcl eax, 23
	rcl ebx, 23
	and eax, 007fffffh
	and ebx, 007fffffh
	mul ebx					;eax=>iloczyn mantys

	or ecx, eax
	mov frazyf, ecx
	fld dword ptr frazyf

	popa
	pop ebp
	ret
_float_razy_float ENDP
_MIESZ2float PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, 0				;tu bêdzie zapisywana liczba w formacie float
	mov eax, [ebp+8]
	mov ecx, 31				;licznik który sprawdza coraz m³odsze bity

ptl:
	bt eax, ecx
	jc znaleziona_najstarsza_jedynka
	dec ecx
	jmp ptl

znaleziona_najstarsza_jedynka:
	push ecx
	sub ecx, 8				;w ecx mamy wyk³adnik
	add ecx, 127			;w ecx wyk³adnik po normalizacji

	mov ebx, ecx
	shl ebx, 23				;w ebx mamy ju¿ bit znaku i wyk³adnik
	pop ecx
	mov edx, 32
	sub edx, ecx
	mov ecx, edx
	shl eax, cl
	shr eax, 9
	or ebx, eax

	mov m2f, ebx
	fld dword ptr m2f

	pop ebx
	pop ebp
	ret
_MIESZ2float ENDP
_obj_stozka_sc PROC
	push ebp
	mov ebp, esp

	finit
	fld dword ptr [ebp+8]		;za³adownie r
	fld dword ptr [ebp+8]
	fmul
	fld dword ptr [ebp+12]		;za³¹downie R
	fld dword ptr [ebp+12]
	fmul
	fadd
	fld dword ptr [ebp+12]
	fld dword ptr [ebp+8]
	fmul
	fadd
	fld dword ptr [ebp+16]
	fmul
	fldpi
	fld dword ptr trzy
	fdiv
	fmul

	pop ebp
	ret
_obj_stozka_sc ENDP
_NWD PROC
	push ebp
	mov ebp, esp

	mov edx, [ebp+8]

	cmp edx, [ebp+12]
	je rowne
	cmp edx, [ebp+12]
	ja wieksze_a
	push edx
	sub dword ptr [ebp+12], edx
	push dword ptr [ebp+12]
	call _NWD
	add esp, 8
	jmp koniec
wieksze_a:
	sub edx, [ebp+12]
	push edx
	push dword ptr [ebp+12]
	call _NWD
	add esp, 8
	jmp koniec
rowne:
	mov eax, edx
koniec:
	pop ebp
	ret
_NWD ENDP
END