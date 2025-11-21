; Filename: EXER34.ASM
; Date: October 2, 2025
; Make a program to input two integers. Compare the two
; integers. Display which one is smaller and bigger of the
; two integers.

.model small
.stack 100h
.data
    prompt1 db "Enter 1st number: $"
    prompt2 db "Enter 2nd number: $"
    msgBigger db "The bigger number is: $"
    msgSmaller db "The smaller number is: $"
    msgEqual db "Both numbers are equal.$"  ; extra if both same
    
.code
main proc
    ; Initialize data segment
    mov ax, @data
    mov ds, ax

    
    mov ah, 9
    lea dx, prompt1
    int 21h
    ; Input a single digit character
    mov ah, 1
    int 21h
    sub al, '0' ; Convert ASCII digit to integer
    mov bl, al  ; Store the first number in BL

    ; Newline
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h

    
    mov ah, 9
    lea dx, prompt2
    int 21h
    ; Input a single digit character
    mov ah, 1
    int 21h
    sub al, '0' ; Convert ASCII digit to integer
    mov cl, al  ; Store the second number in CL

    ; Newline
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h

    ; --- Compare Numbers ---
    cmp bl, cl
    je  numbersEqual  ; If equal, jump
    jl  firstIsSmaller ; If BL < CL, first is smaller
    jg  firstIsBigger  ; If BL > CL, first is bigger

numbersEqual:
    mov ah, 9
    lea dx, msgEqual
    int 21h
    jmp exit

firstIsSmaller:
    ; Display "The smaller number is: "
    mov ah, 9
    lea dx, msgSmaller
    int 21h
    ; Display the value of the first number
    mov ah, 2
    add bl, '0' ; Convert integer back to ASCII for display
    mov dl, bl
    int 21h
    
    ; Newline
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h

    ; Display "The bigger number is: "
    mov ah, 9
    lea dx, msgBigger
    int 21h
    ; Display the value of the second number
    mov ah, 2
    add cl, '0' ; Convert integer back to ASCII for display
    mov dl, cl
    int 21h
    jmp exit

firstIsBigger:
    ; Display "The smaller number is: "
    mov ah, 9
    lea dx, msgSmaller
    int 21h
    ; Display the value of the second number
    mov ah, 2
    add cl, '0' ; Convert integer back to ASCII for display
    mov dl, cl
    int 21h

    ; Newline
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h

    ; Display "The bigger number is: "
    mov ah, 9
    lea dx, msgBigger
    int 21h
    ; Display the value of the first number
    mov ah, 2
    add bl, '0' ; Convert integer back to ASCII for display
    mov dl, bl
    int 21h
    jmp exit

exit:
    ; Newline before exit for better console output
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h

    ; Exit program
    mov ah, 4ch
    int 21h
main endp
end main