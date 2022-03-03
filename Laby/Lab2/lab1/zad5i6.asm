;;Zadanie 2.5 i 2.6;;
.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern _MessageBoxW@16 : PROC
extern __write : PROC ; (dwa znaki podkreúlenia)
extern __read : PROC ; (dwa znaki podkreúlenia)
public _main
.data
tekst_pocz		db 10, 'Prosze napisac jakis tekst '
				db 'i nacisnac Enter', 10
koniec_t		db ?
magazyn			db 80 dup (?)
nowa_linia		db 10
liczba_znakow	dd ?
tytul			db 'Zadanie 2.6', 0
tytul_do_UC		dw 'Z','a','d','2','.','7'
				dw 0,0
magazyn_UC		db 160

.code
_main PROC
; wyúwietlenie tekstu informacyjnego
; liczba znakÛw tekstu
 mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
 push ecx
 push OFFSET tekst_pocz ; adres tekstu
 push 1
 call __write 
 add esp, 12 
 push 80 ; maksymalna liczba znakÛw
 push OFFSET magazyn
 push 0
 call __read 
 add esp, 12 
 mov liczba_znakow, eax
 mov ecx, eax
 mov ebx, 0

ptl:
mov dl, magazyn[ebx]

cmp dl, 165 ; π
je dalej2
cmp dl, 164 ; •
je dodaj1
cmp dl, 169 ; Í
je dodaj_33
cmp dl, 168 ;  
je dodaj_34
cmp dl, 228 ; Ò
je odejmij_19
cmp dl, 227 ; —
je odejmij_18
cmp dl, 152 ; ú
je odejmij_12
cmp dl, 151 ; å
je odejmij_11
cmp dl, 190 ; ø
je odejmij_15
cmp dl, 189 ; Ø
je odejmij_14
cmp dl, 134 ; Ê
je dodaj_64
cmp dl, 143 ; ∆
je dodaj_55
cmp dl, 136 ; ≥
je dodaj_27
cmp dl, 157 ; £
je dodaj_6
cmp dl, 162 ; Û
je dodaj_49
cmp dl, 224 ; ”
je odejmij_13
cmp dl, 171 ; ü
je odejmij_28 
cmp dl, 141 ; è
je dodaj2

 cmp dl, 'a'
 jb dalej 
 cmp dl, 'z'
 ja dalej 
 sub dl, 20H 
 jmp dalej2

 odejmij_14:
 sub dl, 14
 jmp dalej2

 dodaj_55:
 add dl, 55
 jmp dalej2

 dodaj_6:
 add dl, 6
 jmp dalej2

 odejmij_13:
 sub dl, 13
 jmp dalej2

 dodaj2:
 add dl, 2
 jmp dalej2

 odejmij_11:
 sub dl, 11
 jmp dalej2

 odejmij_18:
 sub dl, 18
 jmp dalej2

 dodaj_34:
 add dl, 34
 jmp dalej2

 dodaj1:
 add dl, 1
 jmp dalej2

 odejmij_12:
 sub dl, 12
 jmp dalej2

 odejmij_19:
 sub dl, 19
 jmp dalej2

 dodaj_33:
 add dl, 33
 jmp dalej2

 odejmij_15:
 sub dl, 15
 jmp dalej2

 dodaj_64:
 add dl, 64
 jmp dalej2

 dodaj_27:
 add dl, 27
 jmp dalej2

 dodaj_49:
 add dl, 49
 jmp dalej2

 odejmij_28:
 sub dl, 28
 jmp dalej2
 
dalej2:
mov magazyn[ebx], dl
jmp dalej

dalej: 
inc ebx
dec ecx
jnz ptl

push 0
push offset tytul
push offset magazyn
push 0
call _MessageBoxA@16

_main ENDP
END