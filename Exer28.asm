; Filename: EXER28.ASM
; Date: October 2, 2025
; Description: This assembly language program will input
; two single-digit numbers, add the two numbers,
; and display the sum of the two numbers.

.model small
.stack 100h

.data
    num1 db ?
    num2 db ?
    sum db ?              ; this will hold the binary sum
    
    msg1 db 'Enter first number (0-9): $'
    msg2 db 0dh, 0ah, 'Enter second number (0-9): $'
    msg3 db 0dh, 0ah, 'The sum is: $'

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
    sub al, '0'         ; convert ascii digit to binary (e.g., '5' (35h) - '0' (30h) = 5)
    mov num1, al        ; store binary number in num1

    ; --- input second number ---
    lea dx, msg2        ; load address of msg2 into dx
    mov ah, 09h         ; dos function: display string
    int 21h             ; call dos interrupt

    mov ah, 01h         ; dos function: read character from keyboard
    int 21h             ; call dos interrupt (input char in al)
    sub al, '0'         ; convert ascii digit to binary
    mov num2, al        ; store binary number in num2

    ; --- calculate sum ---
    mov al, num1        ; move first number into al
    add al, num2        ; add second number to al (al now holds the binary sum)
    mov sum, al         ; store the binary sum in 'sum' variable

    ; --- display result ---
    lea dx, msg3        ; load address of msg3 into dx
    mov ah, 09h         ; dos function: display string
    int 21h             ; call dos interrupt

    ; convert sum to ascii for display
    add sum, '0'        ; convert binary sum back to ascii digit (e.g., 5 + '0' = '5' (35h))
    
    mov dl, sum         ; move the ascii sum into dl (for ah=02h)
    mov ah, 02h         ; dos function: display character
    int 21h             ; call dos interrupt

    ; --- exit program ---
    mov ax, 4c00h       ; set ah=4ch (exit program), al=00h (return code)
    int 21h             ; call dos interrupt
main endp
end main