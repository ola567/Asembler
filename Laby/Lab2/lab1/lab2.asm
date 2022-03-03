;1. Napisz program w asemblerze, który przekoduje tekst znajduj¹cy siê w buforze i zawieraj¹cy znaki kodowane w ASCII 
;z podstawowego alfabetu + ma³e polskie litery zapisane w kodowaniu iso 8859-2 na odpowiedni napis zakodowany w UTF-16.
;Wyœwietl napis docelowy z wykorzystaniem funkcji MessageBoxW.
;
;2. Zmodyfikuj program z zadania 1, w taki sposób, aby dokona³ kompresji ³añcucha. Wszystkie wyst¹pienia pod³añcucha 
;'a³a' w ³añcuchu Ÿród³owym maj¹ zostaæ zast¹pione znakiem flagi U+2691 w ³añcuchu docelowym.

.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC 
extern __write : PROC ; (dwa znaki podkreœlenia)
extern __read : PROC ; (dwa znaki podkreœlenia)

public _main

.data
tekst_pocz			db 10, 'Prosze napisac jakis tekst '
					db 'i nacisnac Enter', 10
koniec_t			db ?
magazyn				db 80 dup (?)
nowa_linia			db 10
liczba_znakow		dd ?
ascii				db 'Ala','a', 0B3h, 'al', 0
					dw 0, 0
wynik				db 40 dup (0)
tytul				dw 'T','y','t','u','l'
					dw 0,0


.code
_main PROC

 mov eax, offset ascii
 mov ecx, 0

petla1: 
 mov bl, [eax]

 cmp bl, 177	;¹
 je zmiana_a

 cmp bl, 234
 je zmiana_e	;ê
 
 cmp bl, 230
 je zmiana_c	;æ

 cmp bl, 179	;³
 je zmiana_l

 cmp bl, 241
 je zmiana_n

 cmp bl, 243
 je zmiana_o

 cmp bl, 182
 je zmiana_s
 
 cmp bl, 188
 je zmiana_z

 cmp bl, 191
 je zmiana_z2

 mov [wynik+ecx],bl
 add ecx, 2
 jmp dalej

jestl:
 add eax, 1
 mov bl, [eax]
 cmp bl, 0B3h
 je jestdrugiea
 sub eax, 1
 mov bl, [eax]
 mov [wynik+ecx], bl
 add ecx, 2
 jmp dalej

jestdrugiea:
 add eax, 1
 mov bl, [eax]
 cmp bl, 'a'
 je flaga
 sub eax, 2
 mov bl, [eax]
 mov [wynik+ecx], bl
 add ecx, 2
 jmp dalej

flaga:
 mov [wynik+ecx],91h
 inc ecx
 mov [wynik+ecx], 26h
 inc ecx
 jmp dalej

zmiana_a:
 mov [wynik+ecx], 05H
 inc ecx
 mov [wynik+ecx], 01H
 inc ecx
 jmp dalej
 
zmiana_e:
 mov [wynik+ecx], 19H
 inc ecx
 mov [wynik+ecx], 01H
 inc ecx
 jmp dalej

zmiana_c:
 mov [wynik+ecx], 07H
 inc ecx
 mov [wynik+ecx], 01H
 inc ecx
 jmp dalej

zmiana_l:
 mov [wynik+ecx], 42H
 inc ecx
 mov [wynik+ecx], 01H
 inc eax
 jmp dalej

zmiana_n:
 mov [wynik+ecx], 44H
 inc ecx
 mov [wynik+ecx], 01H
 inc eax
 jmp dalej

zmiana_o:
 mov [wynik+ecx], 0F3H
 inc ecx
 mov [wynik+ecx], 01H
 inc eax
 jmp dalej

zmiana_s:
 mov [wynik+ecx], 5BH
 inc ecx
 mov [wynik+ecx], 01H
 inc eax
 jmp dalej

zmiana_z:
 mov [wynik+ecx], 7AH
 inc ecx
 mov [wynik+ecx], 01H
 inc eax
 jmp dalej

zmiana_z2:
 mov [wynik+ecx], 7CH
 inc ecx
 mov [wynik+ecx], 01H
 inc eax
 jmp dalej

dalej: 
 add eax, 1
 cmp ecx, 16
 jnz petla1

koniec:
 push 0
 push offset tytul
 push offset wynik
 push 0
 call _MessageBoxW@16
 
 push 0
 call _ExitProcess@4 ; zakoñczenie programu
_main ENDP
END
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
comment
.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC 
extern __write : PROC ; (dwa znaki podkreœlenia)
extern __read : PROC ; (dwa znaki podkreœlenia)

public _main

.data
tekst_pocz			db 10, 'Prosze napisac jakis tekst '
					db 'i nacisnac Enter', 10
koniec_t			db ?
magazyn				db 80 dup (?)
nowa_linia			db 10
liczba_znakow		dd ?
ascii				db 'Ala', ' ', 0B1h,0EAh,'a','e', 0
					dw 0, 0
wynik				db 40 dup (0)
tytul				dw 'T','y','t','u','l'
					dw 0,0


.code
_main PROC

 mov eax, offset ascii
 mov ecx, 0

petla1: 
 mov bl, [eax]

 cmp bl, 'a'
 je por1

 cmp bl, 177	;¹
 je zmiana_a

 cmp bl, 234
 je zmiana_e	;ê
 
 cmp bl, 230
 je zmiana_c	;æ

 cmp bl, 179	;³
 je zmiana_l

 cmp bl, 241
 je zmiana_n

 cmp bl, 243
 je zmiana_o

 cmp bl, 182
 je zmiana_s
 
 cmp bl, 188
 je zmiana_z

 cmp bl, 191
 je zmiana_z2

 mov [wynik+ecx],bl
 add ecx, 2
 jmp dalej

j

zmiana_a:
 mov [wynik+ecx], 05H
 inc ecx
 mov [wynik+ecx], 01H
 inc ecx
 jmp dalej
 
zmiana_e:
 mov [wynik+ecx], 19H
 inc ecx
 mov [wynik+ecx], 01H
 inc ecx
 jmp dalej

zmiana_c:
 mov [wynik+ecx], 07H
 inc ecx
 mov [wynik+ecx], 01H
 inc ecx
 jmp dalej

zmiana_l:
 mov [wynik+ecx], 42H
 inc ecx
 mov [wynik+ecx], 01H
 inc eax
 jmp dalej

zmiana_n:
 mov [wynik+ecx], 44H
 inc ecx
 mov [wynik+ecx], 01H
 inc eax
 jmp dalej

zmiana_o:
 mov [wynik+ecx], 0F3H
 inc ecx
 mov [wynik+ecx], 01H
 inc eax
 jmp dalej

zmiana_s:
 mov [wynik+ecx], 5BH
 inc ecx
 mov [wynik+ecx], 01H
 inc eax
 jmp dalej

zmiana_z:
 mov [wynik+ecx], 7AH
 inc ecx
 mov [wynik+ecx], 01H
 inc eax
 jmp dalej

zmiana_z2:
 mov [wynik+ecx], 7CH
 inc ecx
 mov [wynik+ecx], 01H
 inc eax
 jmp dalej

dalej: 
 add eax, 1
 cmp ecx, 16
 jnz petla1

koniec:
 push 0
 push offset tytul
 push offset wynik
 push 0
 call _MessageBoxW@16
 
 push 0
 call _ExitProcess@4 ; zakoñczenie programu
_main ENDP
END

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC 
extern __write : PROC ; (dwa znaki podkreœlenia)
extern __read : PROC ; (dwa znaki podkreœlenia)

public _main

.data
tekst_pocz			db 10, 'Prosze napisac jakis tekst '
					db 'i nacisnac Enter', 10
koniec_t			db ?
magazyn				db 80 dup (?)
nowa_linia			db 10
liczba_znakow		dd ?
utf16				dw 'A','l','a',' ','m','a',' ','k','o','t','a',' '
					dw 0, 0
wynik				db 40 dup (0)
tytul				dw 'T','y','t','u','l'
					dw 0,0


.code
_main PROC

 mov eax, offset utf16
 add eax, 14
 mov ecx, 0

petla1: 
 mov bl, [eax]
 mov [wynik+ecx], bl
 add eax, 2
 add ecx, 2
 cmp ecx, 10
 jnz petla1

 sub eax, 16
petla2: 
 mov bl, [eax]
 mov [wynik+ecx], bl
 add eax, 2
 add ecx, 2
 cmp ecx, 16
 jnz petla2

 sub eax, 14
petla3: 
 mov bl, [eax]
 mov [wynik+ecx], bl
 add eax, 2
 add ecx, 2
 cmp ecx, 22
 jnz petla3

 mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
 push ecx
 push OFFSET tekst_pocz 
 push 1 
 call __write 
 add esp, 12 

 push 80 
 push OFFSET magazyn
 push 0
 call __read 
 add esp, 12

 mov liczba_znakow, eax
 mov ecx, eax
 mov ebx, 0
ptl: 
 mov dl, magazyn[ebx]

 cmp dl,108
 jb szyfrCezara
 cmp dl, 108
 ja szyfrCezara2

szyfrCezara:
 add dl, 17
 mov magazyn[ebx], dl
 jmp dalej

szyfrCezara2:
 mov al, 125
 sub al, dl
 mov dl, 17
 sub dl, al
 mov al, 32
 add al, dl
 mov magazyn[ebx], al

dalej: 
 inc ebx
 dec ecx
 jnz ptl

 push liczba_znakow
 push OFFSET magazyn
 push 1
 call __write
 add esp, 12

 push 0
 push offset tytul
 push offset wynik
 push 0
 call _MessageBoxW@16
 
 push 0
 call _ExitProcess@4 ; zakoñczenie programu
_main ENDP
END


