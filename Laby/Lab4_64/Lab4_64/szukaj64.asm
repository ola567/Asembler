public szukaj64_max

.code
szukaj64_max PROC
	push rbx				;przechowanie rejestr�w
	push rsi

	mov rbx, rcx			; adres tablicy
	mov rcx, rdx			; liczba element�w tablicy
	mov rsi, 0				; indeks bie��cy w tablicy
	; w rejestrze RAX przechowywany b�dzie najwi�kszy dotychczas
	; znaleziony element tablicy - na razie przyjmujemy, �e jest
	; to pierwszy element tablicy
	mov rax, [rbx + rsi*8]
	;zmniejszenie o 1 liczby obieg�w p�tli, bo ilo�� por�wna�
	;jest mniejsza o 1 od ilo�ci element�w tablicy
	dec rcx

ptl: 
	inc rsi					; inkrementacja indeksu, por�wnanie najwi�kszego, dotychczas znalezionego elementu
	cmp rax, [rbx + rsi*8]	; tablicy z elementem bie��cym
	jge dalej
	mov rax, [rbx+rsi*8]

dalej: 
	loop ptl 

	pop rsi
	pop rbx
	ret
szukaj64_max ENDP
END