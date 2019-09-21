	;; mbr.asm - A simple x86 bootloader example.
	;;
	;; In worship to the seven hacker gods and for the honor 
	;; of source code realm, we hereby humbly offer our sacred 
	;; "Hello World" sacrifice. May our code remain bugless.

	org 0x7c00		; Our load address

	bits 16			; set 16-bit code mode

	%define  SYS_EXIT   1
	%define  SYS_READ   3
	%define  SYS_WRITE  4
	
	%define  STDIN      0
	%define  STDOUT     1
	%define  STDERR     2

	;; Ensure segment:offset values are ok after program is loaded 
 
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	jmp init

init:	
	mov ah, 0xe		; Configure BIOS teletype mode

	mov bx, 0		; May be 0 because org directive.

loop:				; Write a 0x0-terminated ascii string

	mov al, [here + bx]	; 'Hello' offset
	int 0x10		; call BIOS video interrupt
	cmp al, 0x0
	je end
	add bx, 0x1		; Point to the next character
	jmp loop		; Repeat until we find a 0x0

end:				; Jump forever (same as jmp end)
	jmp $

here:				; C-like NULL terminated string
	
	;; Start messages

	db "", 0xd, 0xa
	db "================================================", 0xd, 0xa
	db "Welcome to the most powerful x86 factorial calculator.", 0xd, 0xa
	db "Please, read this before using the program: ", 0xd, 0xa
	db "", 0xd, 0xa
	db "1. Please, don't input negative numbers", 0xd, 0xa
	db "2. Please, don't enter an invalid input such as letters etc", 0xd, 0xa
	db "", 0xd, 0xa
	db "We're not going to check neither of these issues. Enjoy!", 0xd, 0xa
	db "================================================", 0xd, 0xa
	db "", 0xd, 0xa
	
	;; Start of our program

	db "Please, enter a number to calculate its factorial: "

	; mov ah, 13h    ; function number = 13h : Write String
	; mov al, welcome_msg     ; AL = code of string to display
	; int 10h        ; call INT 10h, BIOS video service

	times 510 - ($-$$) db 0		; Complete with zeros
	dw 0xaa55					; Boot signature

	welcome_msg: db "workssssssss", 0xd, 0xa
	
; 	call quit

; ; Exit program and restore resources
; quit:
;     mov     bx, 0
;     mov     ax, 1
;     int     80h
;     ret