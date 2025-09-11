; Filename: Exer7.asm
; Displaying characters:

; display with different foreground and background colors

; College
; of
; Computer
; Studies

; Date: August 28, 2025


.model small
.code
.stack 100
start:
 
    mov ah,09h
    mov bl,0Eh
    mov cx,7
    int 10h
 
    mov ah,02h
    mov cl,"C"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"o"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"l"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"l"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"e"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"g"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"e"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
 
    mov ah,09h
    mov bl,4Eh
    mov cx,2
    int 10h
 
    mov ah,02h
    mov cl,"O"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"f"
    mov dl,cl
    int 21h
 
    mov ah,09h
    mov bl,00h ; AVOID BLEEDING
    mov cx,100
    int 10h
 
    mov ah,02h
    mov cl,0Ah ; NEW LINE
    mov dl,cl
    int 21h
 
    mov ah,09h
    mov bl,14h ; BLUE BG RED FG
    mov cx,8
    int 10h
 
    mov ah,02h
    mov cl,"C"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"o"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"m"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"p"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"u"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"t"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"e"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"r"
    mov dl,cl
    int 21h
 
    mov ah,09h
    mov bl,00h ; AVOID BLEEDING
    mov cx,100
    int 10h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
 
    mov ah,09h
    mov bl,0Fh ; BLACK BG WHITE FG
    mov cx,7
    int 10h
 
    mov ah,02h
    mov cl,"S"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"t"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"u"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"d"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"i"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"e"
    mov dl,cl
    int 21h
 
    mov ah,02h
    mov cl,"s"
    mov dl,cl
    int 21h
   
    mov ah,09h
    mov bl,00h
    mov cx,100
    int 10h

int 27h
end start