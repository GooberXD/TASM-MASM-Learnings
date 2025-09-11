; Filename: EXER22.ASM
; Date: 9/11/2025

; Create a program that asks user to input a character. Determine if 
; character is letter A and display message “Yes, you have entered 
; letter A.” If not, display “No, you have not entered letter A. You 
; entered character _.”
; Expected output:

.MODEL small
.STACK 100h
.DATA
    char    db ?                     ; to store input character

    prompt  db 'Enter a character: $'
    msgYes  db 13,10, 'Yes, you have entered letter A.', 13,10, '$'
    msgNo   db 13,10, 'No, you have not entered letter A. You entered character ', '$'

    newline db 13, 10, '$'
.CODE
ProgramStart:
    mov ax, @data
    mov ds, ax

    ; Print prompt
    mov ah, 09h
    mov dx, OFFSET prompt
    int 21h

    ; Read character
    mov ah, 01h
    int 21h
    mov char, al                      ; save entered character

    ; Check if character is 'A' or 'a'
    cmp al, 'A'
    je PrintYes
    cmp al, 'a'
    je PrintYes

    ; If not 'A' or 'a', print No message and the character
PrintNo:
    mov ah, 09h
    mov dx, OFFSET msgNo
    int 21h

    ; Print the character entered
    mov dl, char
    mov ah, 02h
    int 21h

    ; Print newline
    mov ah, 09h
    mov dx, OFFSET newline
    int 21h

    jmp ExitProgram

PrintYes:
    mov ah, 09h
    mov dx, OFFSET msgYes
    int 21h

ExitProgram:
    mov ah, 4Ch
    int 21h
END ProgramStart

