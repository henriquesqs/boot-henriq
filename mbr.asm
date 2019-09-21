	;; mbr.asm - A simple x86 bootloader example.
	;;
	;; In worship to the seven hacker gods and for the honor 
	;; of source code realm, we hereby humbly offer our sacred 
	;; "Hello World" sacrifice. May our code remain bugless.

	org 0x7c00		; Our load address

	
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
	mov al, [here + bx]	
	int 0x10
	cmp al, 0x0
	je end
	add bx, 0x1		
	jmp loop

end:				; Jump forever (same as jmp end)
	jmp $

here:				; C-like NULL terminated string

	db 'Welcome to the most powerful x86 calculator. So powerful that it only does factorial :P', 0xd, 0xa, 0x0
	
	times 510 - ($-$$) db 0	; Pad with zeros
	dw 0xaa55		; Boot signature

.DATA

# Define the messages of our program
input_lbl:       DB   "Number: ", 0 					
bad_input_lbl:   DB   "Number must be positive!", 0
result_lbl:      DB   "Total: ", 0

# Will receive the user 'input' and show the 'result'
input:    DD   0
result:   DD   0