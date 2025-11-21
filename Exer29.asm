; Filename: EXER29.ASM
; Date: October 2, 2025
; Description: This assembly language program will input two
; single-digit numbers, subtract the two numbers,
; and display the difference of the two numbers.

.model small
.stack 100h

.data
    num1 db ?
    num2 db ?
    difference db ?           ; this will hold the binary difference

    msg1 db 'Enter first number: $'
    msg2 db 0dh, 0ah, 'Enter second number: $'
    msg3 db 0dh, 0ah, 'The difference is: $'
    msg_error db 0dh, 0ah, 'Error: Result is negative or not a single digit!$'

.code
main proc
    ; initialize data segment
    mov ax, @data
    mov ds, ax

    ; --- input first number ---
    lea dx, msg1        ; load address of msg1 into dx
    mov ah, 09h         ; dos function: display string
    int 21h             ; call dos interrupt

    mov ah, 01h         ; dos function: read character from keyboard
    int 21h             ; call dos interrupt (input char in al)
    sub al, '0'         ; convert ascii digit to binary
    mov num1, al        ; store binary number in num1

    ; --- input second number ---
    lea dx, msg2        ; load address of msg2 into dx
    mov ah, 09h         ; dos function: display string
    int 21h             ; call dos interrupt

    mov ah, 01h         ; dos function: read character from keyboard
    int 21h             ; call dos interrupt (input char in al)
    sub al, '0'         ; convert ascii digit to binary
    mov num2, al        ; store binary number in num2

    ; --- calculate difference ---
    mov al, num1        ; move first number into al
    cmp al, num2        ; compare num1 with num2
    jl  display_error   ; if num1 < num2, jump to error (since we're doing num1 - num2)

    sub al, num2        ; subtract second number from al (al now holds the binary difference)
    mov difference, al  ; store the binary difference in 'difference' variable

    ; --- display result ---
    lea dx, msg3        ; load address of msg3 into dx
    mov ah, 09h         ; dos function: display string
    int 21h             ; call dos interrupt

    ; convert difference to ascii for display
    add difference, '0' ; convert binary difference back to ascii digit
    
    mov dl, difference  ; move the ascii difference into dl
    mov ah, 02h         ; dos function: display character
    int 21h             ; call dos interrupt

    jmp exit_program    ; jump to exit program

display_error:
    lea dx, msg_error   ; load address of error message
    mov ah, 09h         ; dos function: display string
    int 21h             ; call dos interrupt

exit_program:
    ; --- exit program ---
    mov ax, 4c00h       ; set ah=4ch (exit program), al=00h (return code)
    int 21h             ; call dos interrupt
main endp
end main
