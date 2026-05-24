section .data ;I call this the warehouse
	msg db "HELLO, WORLD", 10 ;message string with newline (10), "10" is thr ASCII code for \n [newline]
	; "db" means "define bytes"
	
	len equ $ - msg ;lenth of the message
	; a "trick" to make the assembler to automatically calculate the exact number of characters
	
	
section .text ;where the actual code starts
	global _start ;Entry point for the linker. The label, a "start here" for the assembler
	
_start:
	; syscall: write(1, msg, len)
	mov rax, 1
	mov rdi, 1 ;file descriptor 1 (stdout)
	mov rsi, msg ;pointer to the string
	mov rdx, len ;length of the string
	syscall ;invoke the kernel
	
	; syscall: exit(0)
	mov rax, 60 ;syscall number for sys_exit
	xor rdi, rdi ;exit status 0 (faster than mov rdi, 0)
	syscall
