section .bss
    buffer resb 32 ;reserves 32 bytes for the first input
    buffer2 resb 32 ;reserves 32 bytes for the second input

section .data
    intro db "Fire: Short Story", 10, "I am new to and learning ASM x86_64!", 10 ;the intro message
    intro_len equ $ - intro ;the length of the message

    options db "1. Put out the fire | 2. Watch it burn everything", 10 ;the options message
    options_len equ $ - options ;the length of the options

    prompt db "INPUT: " ;the input prompt
    prompt_len equ $ - prompt ;length of the input prompt

    outcome1 db "You put out the fire...", 10, 10 ;outcome 1
    outcome1_len equ $ - outcome1 ;length of outcome 1

    options2 db "1. Clean up the mess | 2. Leave with everyone", 10 ;the options message
    options2_len equ $ - options2 ;length of options message

    outcome2 db "The fire burns everything....", 10, 10 ;outcome 2
    outcome2_len equ $ - outcome2 ;length of outcome 2

    prompt2 db "SECOND INPUT: " ;second input prompt
    prompt2_len equ $ - prompt2 ;length of the second prompt

    outcome15 db "You clean up the mess, everyone else leaves you there..", 10, 10 ;the outcome message for option 1/1
    outcome15_len equ $ - outcome15 ;length of the outcome

    outcome25 db "You leave with everyone... Later at the house, you recieve a fine for garbage at the campsite...", 10 ;the outcome 2
    outcome25_len equ $ - outcome25 ;length of the outcome

    invalid_msg db "INVALID.", 10 ;invalid message
    invalid_len equ $ - invalid_msg ;length of invalid message

section .text
    global _start ;global start point

_start:
    loop_start:
;---THE INTRODUCTION---
        mov rax, 1 ;sys_write
        mov rdi, 1 ;stdout
        mov rsi, intro ;pointer to the message
        mov rdx, intro_len ;length of the message
        syscall ;invoke the kernel
;---THE OPTIONS----
        mov rax, 1 ;syswrite
        mov rdi, 1 ;stdout
        mov rsi, options ;pointer to the options message
        mov rdx, options_len ;length of options
        syscall ;invoke the kernel
;---PRINT THE PROMPT---
        mov rax, 1 ;syswrite
        mov rdi, 1 ;stdout
        mov rsi, prompt ;pointer to the prompt messae
        mov rdx, prompt_len ;length of the prompt
        syscall ;invoke the kerne;
;---TAKE INPUT---
        mov rax, 0 ;sysread
        mov rdi, 0 ;stdin
        mov rsi, buffer ;takes in input
        mov rdx, 16 ;max bytes to read
        syscall; invoke the kernel
        lea rsi, [buffer] ;transfers data of buffer to rsi
        mov al, [rsi] ;reads only the first byte

        cmp al, '1' ;jump to 1 if user input is '1'
        je choice1 ;jump to choice 1

        cmp al, '2' ;jump to 2 if user input is '2'
        je choice2 ;jump to choice 2

        jmp invalid ;jumps to invalid


;---OPTION 1---
    choice1:
        mov rax, 1 ;syswrite
        mov rdi, 1 ;stdout
        mov rsi, outcome1 ;the outcome
        mov rdx, outcome1_len ;the length of the outcome
        syscall ;invoke the kernel
        mov rax, 1 ;syswrite
        mov rdi, 1 ;stdout
        mov rsi, options2 ;the options
        mov rdx, options2_len ;the length of the options
        syscall ;invoke the kernel
    ;---PRINT PROMPT---
        mov rax, 1 ;syswrite
        mov rdi, 1 ;stdout
        mov rsi, prompt2 ;prints the second prompt
        mov rdx, prompt2_len ;the length of the second options
        syscall ;invoke the kernel
    ;---INPUT FOR SECOND CHOICE---
        mov rax, 0 ;sysread
        mov rdi, 0 ;stdin
        mov rsi, buffer2
        mov rdx, 16 ;max bytes to read
        syscall ;read the input
        lea rsi, [buffer2] ;move data of buff2 to rsi
        mov al, [rsi] ;reads only the first prompt

        cmp al, '1' ;compares to the second input
        je schoice ;first choice

        cmp al, '2' ;compares to the second input
        je schoice2 ;second choice

        jmp invalid

    choice2:
        mov rax, 1 ;syswrite
        mov rdi, 1 ;stdout
        mov rsi, outcome25 ;the outcome
        mov rdx, outcome25_len ;the length of the outcome
        syscall ;invoke the kernel

        jmp done

    schoice:
        mov rax, 1 ;syswrite
        mov rdi, 1 ;stdout
        mov rsi, outcome15 ;the outcome
        mov rdx, outcome15_len ;the length of the outcome
        syscall ;invoke the kernel

        jmp done

    schoice2:
        mov rax, 1 ;syswrite
        mov rdi, 1 ;stdout
        mov rsi, outcome25 ;the outcome
        mov rdx, outcome25_len ;tje length of the outcome
        syscall ;invoke the kernel

        jmp done

    invalid:
        mov rax, 1 ;syswrite
        mov rdi, 1 ;stdout
        mov rsi, invalid_msg ;pointer to the invalid message
        mov rdx, invalid_len ;length of the message
        syscall

    done:
        mov rax, 60 ;sysexit
        xor rdi, rdi ;return 0;
        syscall
