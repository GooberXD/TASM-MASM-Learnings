; Filename: EXER23.ASM
; Date: 9/11/2025

; Create a program that asks for your first name, middle name, and 
; family name. Then display “Hello, FIRST NAME MIDDLE NAME FAMILY 
; NAME!”.
; Expected output:
; REGISTRATION FORM
; Enter First Name: Jose
; Enter Middle Name: Protacio
; Enter Family Name: Rizal
; Hello, Jose Protacio Rizal!

.MODEL small
.STACK 100h
.DATA
    MAXLEN EQU 50
    bufferSize EQU MAXLEN + 2 ; for CR and LF

    regFormMsg   db 'REGISTRATION FORM', 13,10, '$'

    promptFirst  db 'Enter First Name: $'
    promptMiddle db 'Enter Middle Name: $'
    promptFamily db 'Enter Family Name: $'

    helloMsg     db 'Hello, $'
    space        db ' $'

    firstName    db bufferSize dup (?)
    middleName   db bufferSize dup (?)
    familyName   db bufferSize dup (?)

.CODE
ProgramStart:
    mov ax, @data
    mov ds, ax

    ; Print registration form title
    mov ah, 09h
    mov dx, OFFSET regFormMsg
    int 21h

    ; Read First Name
    mov dx, OFFSET promptFirst
    call PrintString
    mov dx, OFFSET firstName
    mov cx, MAXLEN
    call ReadString

    ; Read Middle Name
    mov dx, OFFSET promptMiddle
    call PrintString
    mov dx, OFFSET middleName
    mov cx, MAXLEN
    call ReadString

    ; Read Family Name
    mov dx, OFFSET promptFamily
    call PrintString
    mov dx, OFFSET familyName
    mov cx, MAXLEN
    call ReadString

    ; Print Hello, First Middle Family!
    mov dx, OFFSET helloMsg
    call PrintString

    mov dx, OFFSET firstName
    call PrintStringClean

    mov dx, OFFSET space
    call PrintString

    mov dx, OFFSET middleName
    call PrintStringClean

    mov dx, OFFSET space
    call PrintString

    mov dx, OFFSET familyName
    call PrintStringClean

    mov dl, '!'
    mov ah, 02h
    int 21h

    ; Newline after greeting
    mov dl, 13
    mov ah, 02h
    int 21h
    mov dl, 10
    mov ah, 02h
    int 21h

    ; Exit
    mov ah, 4Ch
    int 21h

;----------------------------
; Subroutine: PrintString
; Prints $-terminated string at DS:DX
PrintString PROC
    mov ah, 09h
    int 21h
    ret
PrintString ENDP

;----------------------------
; Subroutine: ReadString
; Reads string from standard input to DS:DX buffer
; CX = max number of characters to read (excluding CR,LF)
; Buffer will be filled with chars and then CR and LF at the end.
; This subroutine strips CR and LF by replacing them with '$'
ReadString PROC
    push ax
    push bx
    push cx
    push dx

    mov ah, 3Fh       ; DOS read from handle function
    mov bx, 0         ; stdin
    int 21h

    ; AX = number of bytes read (including CR LF)
    ; Replace CR (13) and LF (10) with '$'
    mov si, dx        ; start of buffer
    mov cx, ax        ; length read

    dec cx            ; CR is second last character
    mov al, '$'

    ; Replace CR with '$'
    mov di, si
    add di, cx
    mov [di], al

    dec di            ; LF is last character
    mov [di], al

    pop dx
    pop cx
    pop bx
    pop ax
    ret
ReadString ENDP

;----------------------------
; Subroutine: PrintStringClean
; Prints string until '$' is found (clean string with no CR/LF)
PrintStringClean PROC
    mov ah, 09h
    int 21h
    ret
PrintStringClean ENDP

END ProgramStart
