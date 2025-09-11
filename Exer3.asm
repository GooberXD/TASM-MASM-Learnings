; Exer3.asm
; Dsiplay numbers
; August 14, 2025

.model small ; command/directive to use small memory model
.code ; section that contains executable code
.stack 100 ; defines the size of program's stack
start: ;start of program

    mov ah, 02h 
    mov cl, 31h ;from 1
    mov dl,cl 
    int 21h ;interrupts for input / output

    mov ah, 02h
    mov cl, 20h ;this one is space
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 32h ; 2
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 20h
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 33h ; 3
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 20h
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl, 34h ; 4
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl, 20h
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl, 35h ; 5
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl, 20h
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl, 36h ; 6
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 20h
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 37h ; 7
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl,20h
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl,38h ; 8
    mov dl,cl
    int 21h
    
    mov ah, 02h
    mov cl, 20h
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 39h ;39h is number 9
    mov dl,cl
    int 21h








int 27h ;this does the termination of program like return 0
end start ;ends program