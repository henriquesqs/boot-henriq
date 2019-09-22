	org 0x7c00		; Our load address

	bits 16			; set 16-bit code mode

	%define  SYS_EXIT   1
	%define  SYS_READ   3
	%define  SYS_WRITE  4
	
	%define  STDIN      0
	%define  STDOUT     1
	%define  STDERR     2

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

	welcome_msg:			db "Welcome to our x86 factorial calculator.", 0xd, 0xa, 0x0	
	input_msg:			db "Please, input a number: ", 0x0 
	result_msg:			db "The result is: ", 0xd, 0xa, 0x0 
	blank:				db 0xa

; #######################################
; ##              START                ##
; #######################################

	main:

		mov si, blank			; load blank into SI
		call printString		; calls sub routine printString

		mov si, welcome_msg		; load welcome_msg into SI
		call printString		; calls sub routine printString

		mov si, input_msg		; load input_msg into SI
		call printString		; calls sub routine printString

		; call readInput		; calls sub routine readInput

		ret

; #######################################
; ##           PRINT STRING            ##
; #######################################
	
	printString:

		mov ah, 14 				; Display character code
		mov bh, STDIN

		.loop:
			
			lodsb 				; Load a byte from SI into AL and then increase SI.

			cmp al, 0 			; checkes wheter AL contains a null-terminating char and stop print
			je .done

			int 10h 			; call int 10h, BIOS video service

			jmp .loop

		.done:
			ret ;				 Return control to the caller.

; #######################################
; ##            READ INPUT             ##
; #######################################
	
	; readInput:


	times 510 - ($-$$) db 0			; Complete with zeros
	dw 0xaa55				; Boot signature