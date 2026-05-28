extern choice0
extern choice1

section .data
    intro db "Fire: Short Story [ASM_x86_64]", 10;the message for the introduction
    intro_len equ $ - intro ;length of the introduction

    extra_message db "I am learning Assembly x86_64 for Linux Kernel.", 10, 10 ;the extra information
    exmess_len equ $ - extra_message ;the length of the extra message

    choices db "1. Put out the fire | 2. Watch it happen ...", 10 ;the choices
    choices_len equ $ - choices ;length of the choices

    input db "INPUT: " ;the input zone
    input_len equ $ - input ;the length of input

    msg db "You attempt to put out the fire, it swollows everything...", 10 ;the message for choice 1
    msg_len equ $ - msg ;the length of the message

    msg2 db "You and your friends sit down, opening bottles of alcohol.. Drinking, accepting your fate...", 10 ;the message for choice 1
    msg2_len equ $ - msg2 ;the length of the message

    error db "INVALID ...", 10, 10 ;error message
    error_len equ $ - error ;the length of input


section .bss
    buffer resb 16 ;reserve 3 bytes for input


section .text
    global _start ;the start point


_start:
;---PRINT 1---
    mov rax, 1 ;sys_write
    mov rdi, 1 ;stdout
    mov rsi, intro ;the message to print
    mov rdx, intro_len ;the length of the first print
    syscall ;invoke the kernel
;---PRINT 2---
    mov rax, 1 ;sys_write
    mov rdi, 1 ;stdout
    mov rsi, extra_message ;the message to print
    mov rsi, exmess_len ;the length of the second print
    syscall ;invoke the kernel
;---PRINT 3---
    loop_start:
        mov rax, 1 ;sys_write
        mov rdi, 1 ;stdout
        mov rsi, choices ;prints the choices
        mov rdx, choices_len ;length of the choices
        syscall ;invoke the kernel
;---PRINT 4 [INPUT PROMPT]---
        mov rax, 1 ;sys_write
        mov rdi, 1 ;stdout
        mov rsi, input ;prints the prompt
        mov rdx, input_len ;length of input
        syscall ;invoke the kernel
;---TAKE INPUT HERE---
        mov rax, 0 ;sys_read
        mov rdi, 0 ;stdin
        mov rsi, buffer ;takes in the input
        mov rdx, 16 ;max bytes to read
        syscall ;invoke the kernel
        lea rsi, [buffer] ;transfers the data in buffer to rsi
        mov al, [rsi] ;reads only the first byte

        cmp al, '1' ;compare input with option1
        je option1 ;jump to the option1 block

        cmp al, '2' ;compare input with option2
        je option2 ;jump to option1 block

        jmp invalid ;fallback


;---option 1---
        option1:
            mov rax, 1 ;sys_write
            mov rdi, 1 ;stdout
            mov rsi, msg ;prints the message
            mov rdx, msg_len ;length of the message
            syscall ;invoke the kernel

            jmp finish ;jumps to the finish block to exit
        

        option2:
            mov rax, 1 ;sys_write
            mov rdi, 1 ;stdout
            mov rsi, msg2 ;prints the message
            mov rdx, msg2_len ;length of the message
            syscall ;invoke the kernel

            jmp finish ;jumps to the finish block to exit


        invalid:
            mov rax, 1 ;sys_write
            mov rdi, 1 ;stdout
            mov rsi, error ;prints the error message
            mov rdx, error_len ;length of the error message
            syscall ;invokes the kernel

            jmp loop_start ;jumps back to the start of the loop

        
        finish:
            mov rax, 60 ;sys_exit
            xor rdi, rdi ;return 0
            syscall; invoke the kernel
