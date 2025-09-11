; Filename: EXER20.ASM
; Date: 9/11/2025
; Description: This assembly language program will get string input and
; display the reverse of the string.

.MODEL small
.STACK 100h
.DATA
MAXIMUM_STRING_LENGTH EQU 1000
StringInput DB MAXIMUM_STRING_LENGTH DUP (?)
InputPrompt DB 'Enter text: $'
.CODE
ProgramStart:
    mov ax,@data
    mov ds,ax          ; set DS to point to data segment

    ; print prompt
    mov dx,OFFSET InputPrompt
    mov ah,9
    int 21h

    ; read string from stdin
    mov ah,3fh         ; DOS read from handle function
    mov bx,0           ; standard input handle
    mov cx,MAXIMUM_STRING_LENGTH ; max chars to read
    mov dx,OFFSET StringInput    ; buffer for string
    int 21h

    ; check if any character read
    and ax,ax
    jz Done            ; if zero, done

    mov cx,ax          ; number of bytes read

    ; reverse the string in place
    mov si, OFFSET StringInput  ; start pointer
    add si, cx
    dec si              ; point to last character in string

    mov di, OFFSET StringInput  ; start pointer (beginning)

ReverseLoop:
    cmp di, si          ; if start >= end, done
    jge ReverseDone

    ; swap [di] and [si]
    mov al, [di]
    mov bl, [si]
    mov [di], bl
    mov [si], al

    inc di
    dec si
    jmp ReverseLoop

ReverseDone:
    ; print reversed string
    mov ah,40h          ; DOS write to handle
    mov bx,1            ; standard output handle
    mov dx,OFFSET StringInput
    int 21h

Done:
    mov ah,4ch          ; DOS terminate program function
    int 21h

END ProgramStart


