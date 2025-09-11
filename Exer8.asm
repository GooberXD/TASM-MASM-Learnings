; Filename: Exer8.asm
; Displaying characters:

; display colored patterns (big cross)
; using just spaces
; Date: August 28, 2025

.model small
.stack 100h

.data

.code
start:

    mov ah,09h
    mov bl,11h
    mov cx,8
    int 10h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,0Ah ; NEWLINE
    mov dl,cl
    int 21h
 
    mov ah,09h
    mov bl,11h
    mov cx,3
    int 10h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,09h
    mov bl,4Eh
    mov cx,2
    int 10h
    
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h


    

    mov ah,09h
    mov bl,00h ; AVOID BLEEDING
    mov cx,100
    int 10h

    mov ah,02h
    mov cl,0Ah ; NEWLINE
    mov dl,cl
    int 21h

    mov ah,09h
    mov bl,11h 
    mov cx,1
    int 10h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,09h
    mov bl,44h 
    mov cx,6
    int 10h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,09h
    mov bl,11h 
    mov cx,1
    int 10h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,09h
    mov bl,00h ; AVOID BLEEDING
    mov cx,100
    int 10h

    mov ah,02h
    mov cl,0Ah ; NEWLINE
    mov dl,cl
    int 21h

    

    mov ah,09h
    mov bl,11h
    mov cx,3
    int 10h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,09h
    mov bl,4Eh
    mov cx,2
    int 10h
    
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,09h
    mov bl,00h ; AVOID BLEEDING
    mov cx,100
    int 10h

    mov ah,02h
    mov cl,0Ah ; NEWLINE
    mov dl,cl
    int 21h

    mov ah,09h
    mov bl,11h
    mov cx,8
    int 10h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl," "
    mov dl,cl
    int 21h

    mov ah,09h
    mov bl,00h ; AVOID BLEEDING
    mov cx,100
    int 10h

    mov ah,02h
    mov cl,0Ah ; NEWLINE
    mov dl,cl
    int 21h
    mov ah,09h

    mov bl,00h ; AVOID BLEEDING
    mov cx,100
    int 10h

int 27h
end start

