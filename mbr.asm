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

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;; Define messages and variables of our program ;;;;;;;

	welcome_msg:		db "Welcome to our x86 factorial calculator.", 0xd, 0xa, 0x0	
	input_msg:			db "Please, input a number: "
	result_msg:			db "The result is: "
	blank: 				db "", 0xd, 0xa

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	main:

		mov bx, welcome_msg
		call printString

		call readInput

		call factorial

	readInput:
		ret

	printString:
		ret

	factorial:
		ret

	times 510 - ($-$$) db 0			; Complete with zeros
	dw 0xaa55						; Boot signature