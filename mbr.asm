	;; mbr.asm - A simple x86 bootloader example.
	;;
	;; In worship to the seven hacker gods and for the honor 
	;; of source code realm, we hereby humbly offer our sacred 
	;; "Hello World" sacrifice. May our code remain bugless.

	org 0x7c00		; Our load address

	bits 16			; set 16-bit code mode

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

	db 'Welcome to the most powerful x86 calculator.', 0xd, 0xa, 0x0
	
	times 510 - ($-$$) db 0	; Complete with zeros
	dw 0xaa55				; Boot signature