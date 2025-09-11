; Filename: EXER21.ASM
; Date: 9/11/2025
; Create a program that asks the user to input 3 characters. Then 
; display each character on its own line.

.MODEL small
.STACK 200h
.DATA
    firstChar  db ?
    secondChar db ?
    thirdChar  db ?

    newline    db 13,10,'$'

    prompt1    db 'Enter first character: $'
    prompt2    db 'Enter second character: $'
    prompt3    db 'Enter third character: $'

    output1    db 'The first character is ', '$'
    output2    db 'The second character is ', '$'
    output3    db 'The third character is ', '$'
.CODE

Main:
    ; Initialize data segment
    mov ax, @data
    mov ds, ax

    ; Prompt 1
    mov ah, 09h
    mov dx, OFFSET prompt1
    int 21h

    mov ah, 01h
    int 21h
    mov firstChar, al

    ; Newline
    mov ah, 09h
    mov dx, OFFSET newline
    int 21h

    ; Prompt 2
    mov ah, 09h
    mov dx, OFFSET prompt2
    int 21h

    mov ah, 01h
    int 21h
    mov secondChar, al

    ; Newline
    mov ah, 09h
    mov dx, OFFSET newline
    int 21h

    ; Prompt 3
    mov ah, 09h
    mov dx, OFFSET prompt3
    int 21h

    mov ah, 01h
    int 21h
    mov thirdChar, al

    ; Newline
    mov ah, 09h
    mov dx, OFFSET newline
    int 21h

    ; Display output 1
    mov ah, 09h
    mov dx, OFFSET output1
    int 21h

    mov dl, firstChar
    mov ah, 02h
    int 21h

    ; Newline
    mov ah, 09h
    mov dx, OFFSET newline
    int 21h

    ; Display output 2
    mov ah, 09h
    mov dx, OFFSET output2
    int 21h

    mov dl, secondChar
    mov ah, 02h
    int 21h

    ; Newline
    mov ah, 09h
    mov dx, OFFSET newline
    int 21h

    ; Display output 3
    mov ah, 09h
    mov dx, OFFSET output3
    int 21h

    mov dl, thirdChar
    mov ah, 02h
    int 21h

    ; Newline
    mov ah, 09h
    mov dx, OFFSET newline
    int 21h

    ; Exit program
    mov ax, 4C00h
    int 21h

END Main
