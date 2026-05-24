section .data
	msg db "CHOOSE 1 OR 2 [3 TO EXIT]", 10 ;listing choices
	msg_len equ $ - msg ;automatically checks length
	
	smsg db "INPUT: " ;input prompt
	smsg_len equ $ - smsg ;automatically checks length
	
	out1 db "YOU PRESSED: 1", 10, 10 ;prints for output 1
	out1_len equ $ - out1 ;automatically checks length
	
	out2 db "YOU PRESSED: 2", 10, 10 ;prints for output 2
	out2_len equ $ - out2 ;automatically checks length
	
	err db "INVALID INPUT.", 10, 10 ;prints for error
	err_len equ $ - err ;automatically checks length
	
	
section .bss
	input resb 2 ;input buffer (allows input for one charcter plus an exra safety)
	

section .text ;entry point for the program
	global _start ;a sign saying "START HERE!"
	

_start:
	loop_start:
	;---PRINTS FOR INPUT AND CHOICE
		mov rax, 1 ;sys_write
		mov rdi, 1 ;stdout
		mov rsi, msg ;pointer for message
		mov rdx, msg_len ;length for message
		syscall ;execute write
		
		mov rax, 1 ;sys_write
		mov rdi, 1 ;stdout
		mov rsi, smsg ;pointer to prompt
		mov rdx, smsg_len ; length of prompt
		syscall ;execute write again
	;---END FOR INPUT AND CHOICE PRINTS---
	
	;---START OF INPUT---
		mov rax, 0 ;sys_read
		mov rdi, 0 ;stdin
		mov rsi, input ;buffer for input
		mov rdx, 2 ;read 1 byte (the extra byte is safety)
		syscall ;execute the read
		
		mov al, [input] ;reads only the first char. al takes one byte from input and store it in itself
		
		cmp al, '1' ;compare al [aka input's first character] with "1"
		je option1 ;jump to block "option1"
		
		cmp al, '2' ;compare al [aka input's first character] with "2"
		je option2
		
		cmp al, '3' ;compare al [aka input's first character] with "3"
		je option3
		
		jmp invalid ;the fallback
	;---END OF INPUT---
	
	;---OPTION 1 ["1"]---
	option1:
		mov rax, 1 ;sys_write
		mov rdi, 1 ;stdout
		lea rsi, [rel out1] ;prints the message for "1"
		mov rdx, out1_len ;length of the message for "1"
		syscall ;write
		
		jmp loop_start ;jump back to the start of the loop
	;---END OF OPTION 1---
	
	;---OPTION 2 ["2"]---
	option2:
		mov rax, 1 ;sys_write
		mov rdi, 1 ;stdout
		lea rsi, [rel out2] ;prints the message for "2"
		mov rdx, out2_len ;length of the message for "2"
		syscall ;write
		
		jmp loop_start ;jump back to the start of the loop
	;---END OF OPTION 2---
	
	;---OPTION 3 ["3"]
	option3:
		mov rax, 60 ;sys_exit
		xor rdi, rdi ;return 0
		syscall
	;---EMD OF OPTION 3---
	
	;---FALLBACK---
	invalid:
		mov rax, 1 ;sys_write
		mov rdi, 1 ;stdout
		mov rsi, err ;prints the message for invalid input
		mov rdx, err_len ;length of the message for invalid input
		syscall ;write
		
		jmp loop_start ;jump back to the start of the loop
		
