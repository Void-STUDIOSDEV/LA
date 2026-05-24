section .bss ;uninitalised memory section
	buf1 resb 32 ;reserves 32 bytes for first input
	buf2 resb 32 ;reserves 32 bytes for second input
	
section .data	
	greet db "YOU WROTE: " ;prints out the second input the user did
	greet_len equ $ - greet
	
section .text ;actual code lives here!
	global _start ;a "start here!" sign
	

_start: ;code execution beginds here
	;---START OF FIRST INPUT---
	mov rax, 0 ;sys_read (read from a file descriptor)
	mov rdi, 0 ;first argument. File descriptor 0 = stdin (keyboard)
	mov rsi, buf1 ;second argument. pointer to the buffer where the input will be stored
	mov rdx, 32 ;third argument. Max number of bytes to read
	syscall ;invoke the kernel to perform read
	mov rbx, rax ;save number of bytes read
	;---END OF FIRST INPUT
	
	;---START OF PRINT ONE---
	mov rax, 1 ;syscall number 1 = sys_write (write to a file descriptor)
	mov rdi, 1 ;first argument. file descriptor 1 = stdout (terminal)
	mov rsi, greet ;second argument. pointer to data to write (what we read)
	mov rdx, greet_len
	syscall ;invokes the kernel to perform the write
	
	;THIS PRINTS THE ACTUAL RESULTS
	mov rax, 1 ;syscall number 1 = sys_write (write to a file descriptor)
	mov rdi, 1 ;file descriptor 1 = stdout (terminal)
	mov rsi, buf1
	mov rdx, rbx ;prints out what was typed
	syscall ;invokes the kernel to perform the write
	;---END OF PRINT ONE---
	
	;---START OF SECOND INPUT---
	mov rax, 0 ;syscall number 0 = sys_read again
	mov rdi, 0 ;stdin again
	mov rsi, buf2 ; pointer to the buffer where the second input will be stored
	mov rdx, 32 ;max number of bytes to read
	syscall ;invokes the kernel to perform read
	mov rcx, rax ;save second input length
	;---END OF SECOND INPUT---
	
	;---START OF PRINT TWO---
	mov rax, 1 ;sys_write again
	mov rdi, 1 ;stdout again
	mov rsi, greet ;pointer to data to write
	mov rdx, greet_len
	syscall ;invokes the kernel to perfir the write
	
	;THIS PRINTS THE ACTUAL RESULTS
	mov rax, 1 ;syscall number 1 = sys_write (write to a file descriptor)
	mov rdi, 1 ;file descriptor 1 =stdout (terminal)
	mov rsi, buf2
	mov rdx, rbx ;prints out what was typed
	syscall ;invokes the kernel to perform the write
	;---END OF PRINT TWO---
	
	;---EXIT---
	mov rax, 60 ;sys_exit
	xor rdi, rdi ;exit code 0
	syscall
