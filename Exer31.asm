; Filename: EXER31.ASM
; Date: October 2, 2025
; Description: This assembly language program will input two
; single-digit numbers, divide the two numbers,
; and display the quotient of the two numbers.

.model small
.stack 100h

.data
msg1 db 'Enter first number (0-9): $'
msg2 db 0dh, 0ah, 'Enter second number (1-9): $' ; Second number cannot be zero
resultMsg db 0dh, 0ah, 'The quotient is: $'
num1 db ?
num2 db ?
quotient_byte db ? ; Store the quotient as a byte

.code
start:
    ; Set up the data segment
    mov ax, @data
    mov ds, ax

    ; Prompt for the first number
    mov ah, 09h
    lea dx, msg1
    int 21h

    ; Read first number
    call read_number
    mov num1, al

    ; Prompt for the second number
    mov ah, 09h
    lea dx, msg2
    int 21h

    ; Read second number
    call read_number
    mov num2, al

    ; --- Division ---
    mov al, num1      ; Load first number into AL (dividend)
    xor ah, ah        
    mov bl, num2      ; Load second number into BL (divisor)

    div bl            ; Divide AX by BL.


    mov quotient_byte, al ; Store the quotient

    ; Display the result message
    mov ah, 09h
    lea dx, resultMsg
    int 21h

    ; Print the quotient
    ; We need to move the byte quotient into AX for print_ax_decimal
    xor ah, ah        ; Clear AH
    mov al, quotient_byte ; Move quotient into AL
    call print_ax_decimal

    ; Exit program
    mov ax, 4C00h
    int 21h

;--------------------------------------------
; Subroutines
;--------------------------------------------

; Read a single-digit number (0-9) from keyboard
read_number proc
    mov ah, 01h       ; DOS: Read char from stdin
    int 21h
    sub al, '0'       ; Convert ASCII -> integer
    ret
read_number endp

print_ax_decimal proc
    xor cx, cx        ; CX will count the number of digits
    mov bx, 10        ; Divisor for decimal conversion

convert_loop:
    xor dx, dx        ; Clear DX for division (DX:AX / BX)
    div bx            ; AX = AX / BX, DX = AX % BX
    push dx           ; Push the remainder (digit) onto stack
    inc cx            ; Increment digit count
    cmp ax, 0         ; If quotient is 0, we're done dividing
    jnz convert_loop

print_loop:
    pop dx            ; Pop a digit from stack
    add dl, '0'       ; Convert digit to ASCII
    mov ah, 02h       ; DOS: Display character in DL
    int 21h
    loop print_loop   ; Repeat for all digits in CX
    ret
print_ax_decimal endp

end start