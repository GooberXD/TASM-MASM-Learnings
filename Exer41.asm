; Filename: EXER41.ASM
; Date: October 10, 2025
; Input two 2-digit numbers and add the two numbers.

.model small
.stack 100h

.data
msg         db  0dh,0ah,"Enter first number: $"
msg1        db  0dh,0ah,"Enter second number: $"
result_txt  db  0dh,0ah,"The Result is: $"
newLine     db  0dh,0ah,'$'

resultBuffer db '   $' 

.code
start:
    mov ax, @data
    mov ds, ax

    ; --- Get First Number (2 digits) ---
    mov dx, offset msg
    mov ah, 09h
    int 21h

    ; Accept 10's place of the first number
    mov ah, 01h
    int 21h
    sub al, 30h
    mov bl, al

    mov al, bl          ; Move tens_digit to AL for MUL
    mov cl, 10
    mul cl              ; AL = tens_digit * 10
    mov bl, al          ; BL now holds (tens_digit * 10)

    ; Accept unit's place of the first number
    mov ah, 01h
    int 21h
    sub al, 30h
    add bl, al          ; BL = first 2-digit number

    ; --- Get Second Number (2 digits) ---
    mov dx, offset msg1
    mov ah, 09h
    int 21h

    ; Accept 10's place of the second number
    mov ah, 01h
    int 21h
    sub al, 30h
    mov cl, al

    mov al, cl          ; Move tens_digit to AL for MUL
    mov bh, 10
    mul bh              ; AL = tens_digit * 10
    mov cl, al          ; CL now holds (tens_digit * 10)

    ; Accept unit's place of the second number
    mov ah, 01h
    int 21h
    sub al, 30h
    add cl, al          ; CL = second 2-digit number

    ; --- Add the two numbers ---
    mov al, bl         
    add al, cl         
    mov bl, al          
    mov dx, offset result_txt
    mov ah, 09h
    int 21h

    mov al, bl          ; Pass sum in AL to conversion procedure
    call DecimalToAscii ; Convert AL to ASCII string in resultBuffer

    mov dx, offset resultBuffer
    mov ah, 09h
    int 21h

    mov dx, offset newLine
    mov ah, 09h
    int 21h

    mov ah, 4ch
    int 21h

DecimalToAscii proc
    push ax
    push bx
    push cx
    push dx
    push di

    mov cx, 0           ; Counter for number of digits
    mov bx, 10          ; Divisor

    cmp al, 0
    jne not_zero_val
    mov byte ptr [resultBuffer + 2], '0' ; Place '0' in the units position
    mov byte ptr [resultBuffer + 1], ' ' ; Pad with spaces
    mov byte ptr [resultBuffer], ' '
    jmp end_conversion_process

not_zero_val:
    ; Clear resultBuffer with spaces
    mov byte ptr [resultBuffer], ' '
    mov byte ptr [resultBuffer + 1], ' '
    mov byte ptr [resultBuffer + 2], ' '
    mov byte ptr [resultBuffer + 3], '$'

    mov di, offset resultBuffer + 2 
divide_loop:
    mov ah, 0           ; Clear AH for DIV (AX = AL / BL)
    div bl              ; AL = AL / 10 (quotient), AH = AL % 10 (remainder)
    add ah, '0'         ; Convert remainder to ASCII digit
    mov byte ptr [di], ah ; Store digit in buffer
    dec di            
    cmp al, 0          
    jnz divide_loop

end_conversion_process:
    mov byte ptr [resultBuffer + 3], '$' ; Ensure '$' terminator is correct

    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
DecimalToAscii endp

end start