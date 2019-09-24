	;; Copyright (c) 2019 - Henrique de S. Q. dos Santos <henriquesqs@usp.br>, Victor M. Gonzaga <machado.prx@usp.br>
	;;
	;; This is free software and distributed under GNU GPL vr.3. Please 
	;; refer to the companion file LICENSING or to the online documentation
	;; at https://www.gnu.org/licenses/gpl-3.0.txt for further information.

	[org 0x7c00]		; Our load address

	[bits 16]			; set 16-bit code mode

	xor ax, ax
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ah, 0xe		; Configure BIOS teletype mode
	mov bx, 0		; May be 0 because org directive.

	jmp main

; #######################################
; ##       STRINGS AND VARIABLES       ##
; #######################################

	welcome_msg:			db "Welcome to our program. Hit 'enter' or 'space' and see what happens.", 0xd, 0xa, 0x0	
	input_msg:			db "Please, input a number: ", 0x0 
	readNumber_msg:		db "Ok, we're going to calculte the factorial of ", 0x0
	result_msg:			db "The result is: ", 0xd, 0xa, 0x0 
	blank:				db 0xa, 0x0

; #######################################
; ##              START                ##
; #######################################

	main:
		
		mov si, blank			; Load blank into SI
		call printString		; Calls sub routine printString

		mov si, welcome_msg		; Load welcome_msg into SI
		call printString		; Calls sub routine printString

		mov ah, 00h				; read hitted button
		int 16h

		cmp al, 0xD				; checks if user hitted 'enter'
		je clearScreen1			; jump to clearScreen1 if true

		; add al, 0xD				; adds the subtracted value
		cmp al, 20d			; checks if user hitted 'space'
		je clearScreen2			; jump to clearScreen2 if true

		jmp end					; if user hitted something else, end program

		; mov ah, 06h				; Clear screen up
		; int 10h

		jmp main

; #######################################
; ##           PRINT STRING            ##
; #######################################
	
	printString:	

		mov ah, 14		; int 10h 'print char' function

		.loop:

			lodsb			; Load a byte from string in SI into AL and then increase SI.
			cmp al, 0		; Checkes wheter AL contains a null-terminating char
			je .done		; If char is zero, end of string
			int 10h			; Otherwise, calls int 10h (BIOS video service) and print it
			jmp .loop

		.done:

			ret

; #######################################
; ##           PRINT SCREEN1           ##
; #######################################

	clearScreen1:

		mov dx, 0 ; Set cursor to top left-most corner of screen
		mov bh, 0
		mov ah, 0x2
		int 0x10
		mov cx, 2000 ; print 2000 chars
		mov bh, 0
		mov bl, 0x21 ; green bg/blue fg
		mov al, 0x20 ; blank char
		mov ah, 0x9
		int 0x10
		ret

; #######################################
; ##           PRINT SCREEN2           ##
; #######################################

	clearScreen2:

		mov AH, 06h    ; Scroll up function
		xor al, al     ; Clear entire screen
		xor cx, cx     ; Upper left corner CH=row, CL=column
		mov dx, 184FH  ; lower right corner DH=row, DL=column 
		mov bh, 1Eh    ; YellowOnBlue
		int 10H
		ret

	end:

	times 510 - ($-$$) db 0			; Complete with zeros
	dw 0xaa55				; Boot signature