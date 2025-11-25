; Filename: EXER36.ASM
; Date: October 9, 2025
; Using a loop, vertically display the numbers 1 to 10.

.model small
.stack 100h
.data
    num db 1
    newline db 13,10,'$'
.code
main proc
    mov ax, @data
    mov ds, ax

start_loop:
    mov al, num
    cmp al, 10
    jne single_digit

;---------------------------
; Print 10 (special case)
;---------------------------
    mov dl, '1'
    mov ah, 02h
    int 21h

    mov dl, '0'
    mov ah, 02h
    int 21h
    jmp print_newline

single_digit:

    add al, 30h       ; convert to ASCII
    mov dl, al
    mov ah, 02h
    int 21h

print_newline:
    mov ah, 09h
    lea dx, newline
    int 21h

    inc num
    cmp num, 11
    jne start_loop

    mov ah, 4Ch
    int 21h
main endp
end main
