;;Zadanie 2.3;;
;.686
;.model flat
;
;extern _MessageBoxW@16 : PROC
;extern _MessageBoxA@16 : PROC
;extern _ExitProcess@4 : PROC
;
;public _main
;
;.data
;	tytul dw 'Z','n','a','k','i', 0
;	tresc dw 'T','o',' ', 'j','e','s','t',' ','k','o','t',' ', 0D83Dh, 0DC08h
;		  dw 'a',' ','t','o',' ','m','y','s','z', ' '
;		  dw 0D83Dh, 0DC01h
;		  dw 0,0
;.code
;
;_main PROC
;
;	push 0
;	push offset tytul
;	push offset tresc
;	push 0
;	call _MessageBoxW@16
;	push 0
;	call _ExitProcess@4
;
;_main ENDP
;END