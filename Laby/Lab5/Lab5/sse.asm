.686
.XMM ; zezwolenie na asemblacjê rozkazów grupy SSE
.model flat

public _dodaj_SSE, _pierwiastek_SSE, _odwrotnosc_SSE, _suma, _int2float
public _pm_jeden, _dodawanie_SSE, _szybki_max, _mul_at_once, _dziel

.data
liczby		dd 4 dup (-1.0)

obszar dd 4 dup (1)

ALIGN 16
tabl_A dd 1.0, 2.0, 3.0, 4.0
tabl_B dd 2.0, 3.0, 4.0, 5.0
liczba db 1
tabl_C dd 3.0, 4.0, 5.0, 6.0

dwa dd 2.0
trzy dd 3.0
zero dd 128 dup (0)

.code
_dziel PROC
	push ebp
	mov ebp, esp

	push esi
	push edi
	push ebx

	mov esi, [ebp+8]
	mov ecx, [ebp+12]	;licznik pêtli 
	mov edi, [ebp+16]
	mov eax, 0
ptl1:
	mov [obszar+eax], dword ptr edi
	add eax, 4
	cmp eax, 16
	jnz ptl1

	movups xmm3, obszar
ptl:
	movups xmm0, [esi]
	divps xmm0, xmm3
	movups [esi], xmm0
	add esi, 16
	loop ptl

	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_dziel ENDP
_mul_at_once PROC
	push ebp
	mov ebp, esp

	push ebx
	push esi
	push edi

	pmulld xmm0, xmm1

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret 
_mul_at_once ENDP
_szybki_max PROC
	push ebp
	mov ebp,esp

	push ebx
	push esi
	push edi

	mov esi, [ebp+8]	;tablica t1
	mov edi, [ebp+12]	;tablica t2
	mov ebx, [ebp+16]	;tablica wynikowa
	mov ecx, [ebp+20]

ptl:
	movups xmm5, [esi]
    movups xmm6, [edi]
	pmaxsd xmm5, xmm6
	movups [ebx], xmm5
	add esi, 16
	add edi, 16
	add ebx, 16
	sub ecx, 4
	jnz ptl

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_szybki_max ENDP
_dodawanie_SSE PROC
	push ebp
	mov ebp, esp

	mov eax, [ebp+8]

	movaps xmm2, tabl_A
	movaps xmm3, tabl_B
	movups xmm4, tabl_C
	addps xmm2, xmm3
	addps xmm2, xmm4
	movups [eax], xmm2

	pop ebp
	ret
_dodawanie_SSE ENDP

_pm_jeden PROC
	push ebp
	mov ebp,esp

	push ebx
	push esi
	push edi

	mov esi, [ebp+8]	;tablica a
	movups xmm3, [esi]
	movups xmm5, liczby
	addsubps xmm3, xmm5
	movups [esi], xmm3

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_pm_jeden ENDP
_int2float PROC
	push ebp
	mov ebp,esp

	push ebx
	push esi
	push edi

	mov esi, [ebp+8]	;tablica a
	mov edi, [ebp+12]	;tablica wynikowa flaot

	cvtpi2ps xmm5, qword PTR [esi]	
	movups [edi], xmm5

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_int2float ENDP
_suma PROC
	push ebp
	mov ebp,esp

	push ebx
	push esi
	push edi

	mov esi, [ebp+8]	;tablica a
	mov edi, [ebp+12]	;tablica b
	mov ebx, [ebp+16]	;tablica wynikowa

	movups xmm5, [esi]
    movups xmm6, [edi]
	paddsb xmm5, xmm6
	movups [ebx], xmm5

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_suma ENDP
_dodaj_SSE PROC
	 push ebp
	 mov ebp, esp

	 push ebx
	 push esi
	 push edi

	 mov esi, [ebp+8]			; adres pierwszej tablicy
	 mov edi, [ebp+12]			; adres drugiej tablicy
	 mov ebx, [ebp+16]			; adres tablicy wynikowej
	; ³adowanie do rejestru xmm5 czterech liczb zmiennoprzecin-
	; kowych 32-bitowych - liczby zostaj¹ pobrane z tablicy,
	; której adres poczatkowy podany jest w rejestrze ESI
	; interpretacja mnemonika "movups" :
	; mov - operacja przes³ania,
	; u - unaligned (adres obszaru nie jest podzielny przez 16),
	; p - packed (do rejestru ³adowane s¹ od razu cztery liczby),
	; s - short (inaczej float, liczby zmiennoprzecinkowe
	; 32-bitowe)
	 movups xmm5, [esi]
	 movups xmm6, [edi]
	; sumowanie czterech liczb zmiennoprzecinkowych zawartych
	; w rejestrach xmm5 i xmm6
	 addps xmm5, xmm6
	 ; zapisanie wyniku sumowania w tablicy w pamiêci
	 movups [ebx], xmm5

	 pop edi
	 pop esi
	 pop ebx
	 pop ebp
	 ret
	_dodaj_SSE ENDP
;=========================================================
_pierwiastek_SSE PROC
	 push ebp
	 mov ebp, esp
	 push ebx
	 push esi
	 mov esi, [ebp+8] ; adres pierwszej tablicy
	 mov ebx, [ebp+12] ; adres tablicy wynikowej
	; ³adowanie do rejestru xmm5 czterech liczb zmiennoprzecin-
	; kowych 32-bitowych - liczby zostaj¹ pobrane z tablicy,
	; której adres pocz¹tkowy podany jest w rejestrze ESI
	; mnemonik "movups": zob. komentarz podany w funkcji dodaj_SSE
	 movups xmm6, [esi]
	; obliczanie pierwiastka z czterech liczb zmiennoprzecinkowych
	; znajduj¹cych sie w rejestrze xmm6
	; - wynik wpisywany jest do xmm5
	 sqrtps xmm5, xmm6

	; zapisanie wyniku sumowania w tablicy w pamiêci
	 movups [ebx], xmm5
	 pop esi
	 pop ebx
	 pop ebp
	 ret
	_pierwiastek_SSE ENDP
	;=========================================================
	; rozkaz RCPPS wykonuje obliczenia na 12-bitowej mantysie
	; (a nie na typowej 24-bitowej) - obliczenia wykonywane s¹
	; szybciej, ale s¹ mniej dok³adne
_odwrotnosc_SSE PROC
	 push ebp
	 mov ebp, esp
	 push ebx
	 push esi
	 mov esi, [ebp+8] ; adres pierwszej tablicy
	 mov ebx, [ebp+12] ; adres tablicy wynikowej
	; ladowanie do rejestru xmm5 czterech liczb zmiennoprzecin-
	; kowych 32-bitowych - liczby zostaj¹ pobrane z tablicy,
	; której adres poczatkowy podany jest w rejestrze ESI
	; mnemonik "movups": zob. komentarz podany w funkcji dodaj_SSE
	 movups xmm5, [esi]
	; obliczanie odwrotnoœci czterech liczb zmiennoprzecinkowych
	; znajduj¹cych siê w rejestrze xmm6
	; - wynik wpisywany jest do xmm5
	 rcpps xmm5, xmm6

	; zapisanie wyniku sumowania w tablicy w pamieci
	 movups [ebx], xmm5
	 pop esi
	 pop ebx
	 pop ebp
	 ret
_odwrotnosc_SSE ENDP
END
