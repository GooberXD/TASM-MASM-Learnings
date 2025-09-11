; Filename: Exer5.asm
; Displaying characters:

; abcdefghijklmnopqrstuvwxyz
; A B C D E F G H I J K L M N O P Q R S T U V W X Y Z

; Date: August 25, 2025

.model small
.stack 100

.data
lowercase DB 'abcdefghijklmnopqrstuvwxyz', 13, 10, '$'
uppercase DB 'A B C D E F G H I J K L M N O P Q R S T U V W X Y Z', 13, 10, '$'

.code
main PROC
    ; initialize DS
    mov ax, @data
    mov ds, ax

    ; print lowercase letters
    mov dx, OFFSET lowercase
    mov ah, 09h
    int 21h

    ; print uppercase letters with spaces
    mov dx, OFFSET uppercase
    mov ah, 09h
    int 21h

    ; exit program
    mov ah, 4Ch
    int 21h

int 27h
end main
