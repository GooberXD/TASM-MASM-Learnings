; Filename: EXER27.ASM
; Date: October 2, 2025
; Description: This assembly language program will get 3 string inputs and
; display back the 3 strings on separate lines.

.model small
.stack 100h

.data
    inputbuffer1 db 51, ?, 51 dup('$') ; max 50 chars + cr + null
    inputbuffer2 db 51, ?, 51 dup('$')
    inputbuffer3 db 51, ?, 51 dup('$')

    promptstring1 db 'Enter first string: $'
    promptstring2 db 'Enter second string: $'
    promptstring3 db 'Enter third string: $'

    outputmessage1 db 'You entered first string: $'
    outputmessage2 db 'You entered second string: $'
    outputmessage3 db 'You entered third string: $'

    newline db 0ah, 0dh, '$' ; newline character for dos

.code
main proc
    ; initialize data segment
    mov ax, @data
    mov ds, ax

    ; --- get first string ---
    lea dx, promptstring1
    mov ah, 09h
    int 21h

    lea dx, inputbuffer1
    mov ah, 0ah
    int 21h

    ; --- get second string ---
    lea dx, newline
    mov ah, 09h
    int 21h

    lea dx, promptstring2
    mov ah, 09h
    int 21h

    lea dx, inputbuffer2
    mov ah, 0ah
    int 21h

    ; --- get third string ---
    lea dx, newline
    mov ah, 09h
    int 21h

    lea dx, promptstring3
    mov ah, 09h
    int 21h

    lea dx, inputbuffer3
    mov ah, 0ah
    int 21h

    ; --- display strings ---

    ; newline before displaying results
    lea dx, newline
    mov ah, 09h
    int 21h

    ; display first output message
    lea dx, outputmessage1
    mov ah, 09h
    int 21h

    ; display first string
    lea dx, inputbuffer1 + 2 ; point to the actual string data
    mov ah, 09h
    int 21h

    ; newline after first string
    lea dx, newline
    mov ah, 09h
    int 21h

    ; display second output message
    lea dx, outputmessage2
    mov ah, 09h
    int 21h

    ; display second string
    lea dx, inputbuffer2 + 2
    mov ah, 09h
    int 21h

    ; newline after second string
    lea dx, newline
    mov ah, 09h
    int 21h

    ; display third output message
    lea dx, outputmessage3
    mov ah, 09h
    int 21h

    ; display third string
    lea dx, inputbuffer3 + 2
    mov ah, 09h
    int 21h

    ; newline after third string
    lea dx, newline
    mov ah, 09h
    int 21h

    ; exit program
    mov ah, 4ch
    int 21h
main endp
end main