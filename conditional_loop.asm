section .data
	msg db "LOOP", 10 ;prits string with newline (ASCII CODE 10 = \n)
	len equ $ -msg ;a trick to make the assembler automatically calculate the length
	
	
section .text
	global _start
	
	
_start:
	mov r12, 5 ;set the loop counter to 5 with r12 preserving it
	
	
	loop_start:
		mov rax, 1 ;syscall for sys_write
		mov rdi, 1 ;stdout
		mov rsi, msg ;pointer to the string
		mov rdx, len ;length of the string
		syscall ;invole the kernel to print
		
		dec r12 ;simplified: i--
		jnz loop_start ;jump back to start if i < 0
		
		mov rax, 60 ;sys_exit
		xor rdi, rdi ;exit code 0
		syscall
