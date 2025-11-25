; Filename: EXER39.ASM
; Date: October 9, 2025
; Repeatedly ask user to input a single digit whole
; number until the number entered is a zero. Display
; “Thank you.” When the number entered is zero

.model small
.stack 100h
.data
prompt      db 'Enter a single digit number: $'
thanks_msg  db 13,10, 'Thank you.$'
.code

main PROC
    mov ax, @data
    mov ds, ax

repeat_input:
    ; Show prompt
    mov ah, 09h
    lea dx, prompt
    int 21h

    ; Get one character input
    mov ah, 01h
    int 21h
    sub al, '0'         ; Convert to number

    cmp al, 0
    je thank_you        ; Exit if 0 entered

    ; Print newline
    mov dl, 13
    mov ah, 02h
    int 21h
    mov dl, 10
    mov ah, 02h
    int 21h

    jmp repeat_input

thank_you:
    mov ah, 09h
    lea dx, thanks_msg
    int 21h

    mov ax, 4C00h
    int 21h

main ENDP
END main