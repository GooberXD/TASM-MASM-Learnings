; Filename: EXER32.ASM
; Date: October 2, 2025
; Create a program that inputs a character. If the character
; is the capital letter A, display message “You entered A.”,
; else display “You entered not A.”

.model small
.stack 100h
.data
    msg1 db 'Enter a letter: $'
    msgA db 0dh, 0ah, "You entered A.$"
    msgNotA db 0dh, 0ah, "You entered not A.$"
.code
main proc
    ; Initialize data segment
    mov ax, @data
    mov ds, ax

    mov ah, 09h
    lea dx, msg1
    int 21h

    ; Input a character
    mov ah, 1
    int 21h
    mov bl, al ; Store the input character in BL

    ; Compare with 'A'
    cmp bl, 'A'
    je displayA ; If equal, jump to displayA

    ; If not 'A', display "You entered not A."
    mov ah, 9
    lea dx, msgNotA
    int 21h
    jmp exit

displayA:
    ; Display "You entered A."
    mov ah, 9
    lea dx, msgA
    int 21h

exit:
    ; Exit program
    mov ah, 4ch
    int 21h
main endp
end main