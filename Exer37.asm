; Filename: EXER37.ASM
; Date: October 9, 2025
; Using a loop, horizontally display the numbers 1 to
; 20, with space between each number

.model small
.stack 100h
.data
.code

main PROC
    mov ax, @data
    mov ds, ax

    mov cl, 1          ; start from 1

print_loop:
    cmp cl, 21
    jge done

    ; --- Print number ---
    cmp cl, 10
    jb one_digit

    cmp cl, 20
    je print_20

    ; --- Handle 10–19 ---
    mov dl, '1'
    mov ah, 02h
    int 21h

    mov al, cl
    sub al, 10         ; get ones digit (0–9)
    add al, '0'        ; convert to ASCII
    mov dl, al
    mov ah, 02h
    int 21h
    jmp after_print

print_20:
    mov dl, '2'
    mov ah, 02h
    int 21h
    mov dl, '0'
    mov ah, 02h
    int 21h
    jmp after_print

one_digit:
    mov al, cl
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

after_print:
    cmp cl, 20
    je no_space
    mov dl, ' '
    mov ah, 02h
    int 21h

no_space:
    inc cl
    jmp print_loop

done:
    mov dl, 13
    mov ah, 02h
    int 21h
    mov dl, 10
    mov ah, 02h
    int 21h

    mov ax, 4C00h
    int 21h

main ENDP
END main
