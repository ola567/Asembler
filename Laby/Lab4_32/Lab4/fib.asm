.686
.model flat

public _fib

.code
_fib PROC

    push ebp
    mov  ebp, esp

    sub  esp, 4           ;robimy tak, ¿eby siê wszystko zgadza³o z tym movem eax i te¿ po to, aby potem by³ó miejsce do wpisania parametru 
    mov  eax, [ebp+8]     ;parametr n
    cmp  eax, 1
    jbe koniec 
    cmp eax, 47
    ja zakoncz
    dec  eax              ;parametr n-1
    push eax              
    call _fib
    mov  [ebp-4], eax
    dec  dword ptr [esp]  ;parametr n-2
    call _fib
    add  esp,4            
    add  eax, [ebp-4]
    jmp koniec
zakoncz:
    mov eax, -1
koniec:
    mov  esp, ebp
    pop  ebp
    ret
_fib ENDP
END