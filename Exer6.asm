; Filename: Exer6.asm
; Displaying characters:

; 0 1 2 3 4 5 6 7 8 9
; ! * # $ % ^ & * ( )
; - _ + = { } [ ] < ?

; Date: August 25, 2025

.model small
.stack 100

.data
zeroToTen DB '0 1 2 3 4 5 6 7 8 9', 13, 10, '$'
symbolsOne DB '! * # % ^ & * ( )', 13, 10, '$'
symbolsTwo DB ' - _ + = { } [ ] < ?', 13, 10, '$'

.code
main PROC
    ; initializes data
    mov ax, @data
    mov ds, ax

    ; prints zeros to ten

    mov dx, OFFSET zeroToTen
    mov ah, 09h
    int 21h

    ;prints symbol one

    mov dx, OFFSET symbolsOne
    mov ah, 09h
    int 21h

    ;prints the dollar sign

    mov ah, 02h
    mov dl, '$'
    int 21h

    ;prints the second symbol 

    mov dx, OFFSET symbolsTwo
    mov ah, 09h
    int 21h

    mov ah, 4Ch
    int 21h

int 27h
end main
