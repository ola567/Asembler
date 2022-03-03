; wczytywanie i wyúwietlanie tekstu wielkimi literami
; (inne znaki siÍ nie zmieniajπ)
.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
extern __write : PROC ; (dwa znaki podkreúlenia)
extern __read : PROC ; (dwa znaki podkreúlenia)
public _main
.data

tekst_pocz  db 10, 'Prosze napisac jakis tekst '
            db 'i nacisnac Enter', 10
koniec_t    db ?
tekst_pocz2 dw 'N','a','p','i','s', 0
magazyn     db 80 dup (?)
magazyn2    db 160 
nowa_linia  db 10
liczba_znakow dd ?

.code
_main PROC
; wyúwietlenie tekstu informacyjnego
; liczba znakÛw tekstu
 mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
 push ecx
 push OFFSET tekst_pocz ; adres tekstu
 push 1 ; nr urzπdzenia (tu: ekran - nr 1)
 call __write ; wyúwietlenie tekstu poczπtkowego
 add esp, 12 ; usuniecie parametrÛw ze stosu
; czytanie wiersza z klawiatury
 push 80 ; maksymalna liczba znakÛw
 push OFFSET magazyn
 push 0 ; nr urzπdzenia (tu: klawiatura - nr 0)
 call __read ; czytanie znakÛw z klawiatury
 add esp, 12 ; usuniecie parametrÛw ze stosu
; kody ASCII napisanego tekstu zosta≥y wprowadzone
; do obszaru 'magazyn'
; funkcja read wpisuje do rejestru EAX liczbÍ
; wprowadzonych znakÛw
 mov liczba_znakow, eax
; rejestr ECX pe≥ni rolÍ licznika obiegÛw pÍtli
 mov ecx, eax
 mov ebx, 0 ; indeks poczπtkowy
 mov eax, 0 ; indeks w nowej tablicy magazyn2
ptl: 
mov dl, magazyn[ebx] ; pobranie kolejnego znaku


 cmp dl, 165 ; π
 je zmiana_a

  cmp dl, 164 ; •
 je zmiana_a2

  cmp dl, 134 ; Ê
 je zmiana_c 

  cmp dl, 143 ; ∆
 je zmiana_c2

  cmp dl, 169 ; Í
 je zmiana_e

  cmp dl, 168 ;  
 je zmiana_e2

   cmp dl, 136 ; ≥
 je zmiana_l

   cmp dl, 157 ; £
 je zmiana_l2

   cmp dl, 228 ; Ò
 je zmiana_n

   cmp dl, 227 ; —
 je zmiana_n2

   cmp dl, 162 ; Û
 je zmiana_o

   cmp dl, 224 ; ”
 je zmiana_o2

    cmp dl, 152 ; ú
 je zmiana_s

    cmp dl, 151 ; å
 je zmiana_s2

    cmp dl, 171 ; ü
 je zmiana_z

    cmp dl, 141 ; è
 je zmiana_z1

    cmp dl, 190 ; ø
 je zmiana_z2

    cmp dl, 189 ; Ø
 je zmiana_z3

 jmp dalej

 zmiana_a:
 mov magazyn2[eax], 05H
 inc eax
 mov magazyn2[eax], 01H
 inc eax
 jmp dalej2
 
 zmiana_a2:
 mov magazyn2[eax], 04H
 inc eax
 mov magazyn2[eax], 01H
 inc eax
 jmp dalej2

  zmiana_c:
 mov magazyn2[eax], 07H
 inc eax
 mov magazyn2[eax], 01H
 inc eax
 jmp dalej2

  zmiana_c2:
 mov magazyn2[eax], 06H
 inc eax
 mov magazyn2[eax], 01H
 inc eax
 jmp dalej2

  zmiana_e:
 mov magazyn2[eax], 19H
 inc eax
 mov magazyn2[eax], 01H
 inc eax
 jmp dalej2

  zmiana_e2:
 mov magazyn2[eax], 18H
 inc eax
 mov magazyn2[eax], 01H
 inc eax
 jmp dalej2

  zmiana_l:
 mov magazyn2[eax], 42H
 inc eax
 mov magazyn2[eax], 01H
 inc eax
 jmp dalej2

  zmiana_l2:
 mov magazyn2[eax], 41H
 inc eax
 mov magazyn2[eax], 01H
 inc eax
 jmp dalej2

  zmiana_n:
 mov magazyn2[eax], 44H
 inc eax
 mov magazyn2[eax], 01H
 inc eax
 jmp dalej2

  zmiana_n2:
 mov magazyn2[eax], 43H
 inc eax
 mov magazyn2[eax], 01H
 inc eax
 jmp dalej2

  zmiana_o:
 mov magazyn2[eax], 0F3H
 inc eax
 mov magazyn2[eax], 00H
 inc eax
 jmp dalej2

  zmiana_o2:
 mov magazyn2[eax], 0D3H
 inc eax
 mov magazyn2[eax], 00H
 inc eax
 jmp dalej2

  zmiana_s:
 mov magazyn2[eax], 5BH
 inc eax
 mov magazyn2[eax], 01H
 inc eax
 jmp dalej2

  zmiana_s2:
 mov magazyn2[eax], 5AH
 inc eax
 mov magazyn2[eax], 01H
 inc eax
 jmp dalej2

  zmiana_z:
 mov magazyn2[eax], 7AH
 inc eax
 mov magazyn2[eax], 01H
 inc eax
 jmp dalej2

  zmiana_z1:
 mov magazyn2[eax], 79H
 inc eax
 mov magazyn2[eax], 01H
 inc eax
 jmp dalej2

  zmiana_z2:
 mov magazyn2[eax], 7CH
 inc eax
 mov magazyn2[eax], 01H
 inc eax
 jmp dalej2

   zmiana_z3:
 mov magazyn2[eax], 7BH
 inc eax
 mov magazyn2[eax], 01H
 inc eax
 jmp dalej2

dalej: 
 mov magazyn2[eax], dl
 inc eax;
 mov magazyn2[eax], 00H
 inc eax

 dalej2:
 inc ebx ; inkrementacja indeksu
 dec ecx
 jnz ptl 

 push 0 ; sta≥a MB_OK
 push OFFSET tekst_pocz2
 push OFFSET magazyn2
 push 0 ; NULL
 call _MessageBoxW@16
 
 add esp, 12 ; usuniecie parametrÛw ze stosu
 push 0
 call _ExitProcess@4 ; zakoÒczenie programu
_main ENDP
END
