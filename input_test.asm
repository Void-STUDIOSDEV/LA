section .data
	prompt db "Enter your name: " ;asks the user for input. Takes in input.
	prompt_len equ $ - prompt
	
	greet db "Hello, " ;prints out a greet for the user, including the name
	greet_len equ $ - greet
	

section .bss ;this section is for variables that change. Reserved for empty spots that the program will fill later
	buffer resb 20 ;reserves 20 bytes for user input
	

section .text ;the start of the actual code
	global _start ;a "start here" sign
	
	
_start:
	;STEP 1: Print prompt (1, prompt, prompt_len)
	mov rax, 1 ;syswrite
	mov rdi, 1 ;stdout
	mov rsi, prompt ;pointer to "Enter your name" prompt
	mov rdx, prompt_len ;length of prompt
	syscall
	
	
	;STEP 2: Read input (0, buffer, 16)
	mov rax, 0 ;sys_read (FORM #0)
	mov rdi, 0 ;file descriptor 0 (stdin/keyboard)
	mov rsi, buffer ;pointer to our empty "warehouse" space
	mov rdx, 16 ;max number of bytes to read
	syscall
	;save the number of bytes actually typed (returned to RAX) into R12
	
	
	;STEP 3: Print greeting (1, buffer, r12)
	mov r12, rax
	mov rax, 1 ;sys_write
	mov rdi, 1 ;stdout
	mov rsi, greet ;pointer to the bytes the user typed
	mov rdx, greet_len ;use the exact length I saved in R12
	syscall
	
	;STEP 4: Print the typed name
	mov rax, 1
	mov rdi, 1
	mov rsi, buffer
	mov rdx, r12
	syscall
	
	;STEP 4: Exit the program (0)
	mov rax, 60 ;sys_exit
	xor rdi, rdi ;exit code 0
	syscall
