; Filename: Exer9.asm
; Displaying characters:

; display emojis and blinking characters
; (blinking red heart) See sample code below.
; Date: August 28, 2025

.model small
.stack 100h

.data

.code
start:
    .model small
.stack 100h

.data

.code
start:

    mov ah,09h
    mov bl,0eh
    mov cx,8
    int 10h
 
    mov ah,02h
    mov cl,"I"
    mov dl,cl
    int 21h
    
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,09h
    mov bl,84h ;8 DOES BLINK, 4 RED COLOR FOR HEART, 1 BLUE
    mov cx,1
    int 10h

    mov ah,2
    mov dl,03h ; 03=heart
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl,"U"
    mov dl,cl
    int 21h
    

int 27h
end start

