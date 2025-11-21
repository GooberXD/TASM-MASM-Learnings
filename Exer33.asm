; Filename: EXER33.ASM
; Date: October 2, 2025
; Create a program that inputs a number. Display the
; following messages depending on the value of the number
; entered:
; “The number is equal to 5.”
; “The number is less than 5.”
; “The number is greater than 5.”

.model small
.stack 100h
.data
    prompt db "Enter a number: $"
    msgEqual db 0dh, 0ah, "The number is equal to 5.$"
    msgLess db 0dh, 0ah, "The number is less than 5.$"
    msgGreater db 0dh, 0ah, "The number is greater than 5.$"
    
.code
main proc
    ; Initialize data segment
    mov ax, @data
    mov ds, ax

    ; Display prompt
    mov ah, 9
    lea dx, prompt
    int 21h

    ; Input a single digit character
    mov ah, 1
    int 21h
    sub al, '0' ; Convert ASCII digit to integer
    mov bl, al  ; Store the number in BL

    ; Compare the number with 5
    cmp bl, 5
    je  isEqual
    jl  isLess
    jg  isGreater

isEqual:
    mov ah, 9
    lea dx, msgEqual
    int 21h
    jmp exit

isLess:
    mov ah, 9
    lea dx, msgLess
    int 21h
    jmp exit

isGreater:
    mov ah, 9
    lea dx, msgGreater
    int 21h
    jmp exit

exit:
    ; Exit program
    mov ah, 4ch
    int 21h
main endp
end main