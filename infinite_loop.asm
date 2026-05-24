section .data ;nickanmed "The warehouse" by me.
	msg db "LOOP WORKS", 10 ;simple message string with newline (ASCII CODE 10 = \n) 
	;"db" means "define bytes"
	len equ $ - msg ;a "trick" to make the assembler automatically calculate the exact number of characters


section .text ;the beginning of the actual logic itself
	global _start ;basically a big "Start here!" sign


_start:
loop_start: ;pretty self-explainatory
		mov rax, 1 ;syscall: write
		mov rdi, 1 ; stdout
		mov rsi, msg ;pointer to the string
		mov rdx, len ;length of the string
		syscall ;invoke the kernel to write it
		jmp loop_start ;the CPU requires this to return to the start of the loop so it actually loops
