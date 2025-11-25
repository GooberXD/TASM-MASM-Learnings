; Filename: EXER38.ASM
; Date: October 9, 2025
; Ask user to input a number from 1 to 8. Display
; error message if number entered is less than 1 or
; greater than 8. If input is correct, horizontally
; display the numbers, with space between each
; number, from 1 to the number entered by user.

.model small
.stack 100h
.data
prompt      db 'Enter a number from 1 to 8: $'
error_msg   db 13,10,'Error: Number out of range!',13,10,'$'
.code

main PROC
    mov ax, @data
    mov ds, ax

ask_input:
    ; --- Display prompt ---
    mov ah, 09h
    lea dx, prompt
    int 21h

    ; --- Get user input (one digit) ---
    mov ah, 01h        ; read char from keyboard
    int 21h             ; AL = ASCII input
    sub al, '0'         ; convert to numeric

    ; --- Validate input (1–8) ---
    cmp al, 1
    jb show_error       ; <1
    cmp al, 8
    ja show_error       ; >8

    mov bl, al          ; store valid number in BL

    ; --- Print newline before numbers ---
    mov dl, 13
    mov ah, 02h
    int 21h
    mov dl, 10
    mov ah, 02h
    int 21h

    ; --- Display numbers 1..BL ---
    mov cl, 1

print_loop:
    cmp cl, bl
    jg done             ; exit when done

    mov al, cl
    add al, '0'         ; convert to ASCII
    mov dl, al
    mov ah, 02h
    int 21h

    cmp cl, bl
    je no_space
    mov dl, ' '
    mov ah, 02h
    int 21h

no_space:
    inc cl
    jmp print_loop

done:
    ; print newline at the end
    mov dl, 13
    mov ah, 02h
    int 21h
    mov dl, 10
    mov ah, 02h
    int 21h

    ; return to DOS
    mov ax, 4C00h
    int 21h

show_error:
    mov ah, 09h
    lea dx, error_msg
    int 21h
    jmp ask_input       ; ask again

main ENDP
END main
