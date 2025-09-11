; Exer2.asm
; Dsiplay single chars
; August 14, 2025

.model small ; command/directive to use small memory model
.code ; section that contains executable code
.stack 100 ; defines the size of program's stack
start: ;start of program

    mov ah, 02h ;set ah to display char
    mov cl, 41h ;41h is capital A
    mov dl,cl ;copies 8bit value in cl to dl
    int 21h ;interrupts for input / output

    mov ah, 02h
    mov cl, 42h ; B
    mov dl, cl
    int 21h

    mov ah, 02h
    mov cl, 43h ; C
    mov dl, cl
    int 21h

    mov ah, 02h
    mov cl, 44h ; D
    mov dl, cl
    int 21h

    mov ah, 02h
    mov cl, 45h ; E
    mov dl, cl
    int 21h

    mov ah, 02h
    mov cl, 46h ; F
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 47h ; G
    mov dl, cl
    int 21h

    mov ah, 02h
    mov cl, 48h ; H
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 49h ; I
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl,4Ah ; J
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl,4Bh ; K
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl,4Ch ; L
    mov dl, cl
    int 21h

    mov ah, 02h
    mov cl,4Dh ; M
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 4Eh ; N
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 4Fh ; O
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 50h ; P
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 51h ; Q
    mov dl, cl
    int 21h
    
    mov ah, 02h
    mov cl, 52h ; R
    mov dl, cl
    int 21h

    mov ah, 02h
    mov cl, 53h ; S
    mov dl, cl
    int 21h

    mov ah, 02h
    mov cl, 54h ; T
    mov dl, cl
    int 21h

    mov ah, 02h
    mov cl, 55h ; U
    mov dl, cl
    int 21h

    mov ah, 02h
    mov cl, 56h ; V
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 57h ; V 
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 58h ; X
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 59h ; Y
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 5Ah ; Z
    mov dl,cl
    int 21h

 
int 27h ;this does the termination of program like return 0
end start ;ends program