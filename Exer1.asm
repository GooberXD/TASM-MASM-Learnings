; Exer1.asm
; Dsiplay single chars, numbers and symbols
; August 14, 2025

.model small ; command/directive to use small memory model
.code ; section that contains executable code
.stack 100 ; defines the size of program's stack
start: ;start of program

    mov ah, 02h ;set ah to display char
    mov cl, 41h ;41h is capital A
    mov dl,cl ;copies 8bit value in cl to dl
    int 21h ;interrupts for input / output

    mov dl, 'X'
    int 21h



int 27h ;this does the termination of program like return 0
end start ;ends program