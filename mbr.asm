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
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; welcome_msg 			db "Welcome to the most powerful x86 factorial calculator.", 0xd, 0xa	
	; welcome_msg_len		equ $ - welcome_msg

	; input_msg				db "Please, input a number: "
	; input_msg_len 		equ $ - input_msg

	; result_msg			db "The result is: "
	; result_msg_len		equ $ - result_msg
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	;; Start messages

	db "", 0xd, 0xa
	db "================================================", 0xd, 0xa
	db "Welcome to our x86 factorial calculator.", 0xd, 0xa
	db "Please, don't try to test this calculator (it certainly will fail). Enjoy!", 0xd, 0xa
	db "================================================", 0xd, 0xa
	db "", 0xd, 0xa
	
	;; Start of our program

	db "Please, enter a number to calculate its factorial: "

	; mov	edx,result_msg_len    		; message length
	; mov	ecx,result_msg	    		; message to write
	; mov	ebx,STDOUT		       		; file descriptor (stdout)
	; mov	eax,SYS_WRITE     	  		; system call number (sys_write)
	; int	0x80        				; call kernel

	times 510 - ($-$$) db 0			; Complete with zeros
	dw 0xaa55						; Boot signature





















; 	call quit

; ; Exit program and restore resources
; quit:
;     mov     bx, 0
;     mov     ax, 1
;     int     80h
;     ret