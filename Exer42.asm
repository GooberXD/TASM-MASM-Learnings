; Filename: EXER42.ASM
; Date: October 10, 2025
; Input and display a 5-digit number

.MODEL SMALL
.STACK 100h

.DATA

msg1        db 0dh,0ah,'Enter exactly 5 digits: $'
msg2        db 0dh,0ah,'You entered: $'            
msgTooLong  db 0dh,0ah,'Warning: Only the first 5 digits were used.',0dh,0ah,'$'
newLine     db 0dh,0ah,'$'

inputBuffer db 6        ; Max characters for 5 digits + carriage return (CR)
            db ?        ; Actual number of chars read (DOS fills this)
            db 6 dup (?) ; Buffer for 5 digits + CR (inputBuffer[2] onwards)


.CODE
main PROC
    mov ax, @data       ; Load the address of the data segment
    mov ds, ax          ; Copy it into DS so we can access data variables

    mov ah, 09h         ; DOS function 09h = display string
    lea dx, msg1        ; Load effective address of msg1 into DX
    int 21h             ; Call DOS interrupt to print message


    lea dx, inputBuffer ; DX points to the buffer structure
    mov ah, 0Ah         ; DOS function 0Ah = buffered input
    int 21h             ; Read string

    mov ah, 09h         ; DOS print string function
    lea dx, msg2        ; Load address of msg2
    int 21h             ; Display it

    mov cl, byte ptr [inputBuffer + 1] ; CL = actual count of digits entered

    ; Cap the count at 5 digits, even if the user typed more (due to max buffer size 5)
    cmp cl, 5
    jbe check_buffer_limit ; If <= 5, use CL as is
    mov cl, 5              ; If > 5, cap at 5
    

check_buffer_limit:
    ; No warning, proceed to display

display_digits_loop:
    mov ch, 0           ; Clear CH for LOOP instruction (CX is the counter)
    mov si, offset inputBuffer + 2 ; SI points to the first character in the buffer

    cmp cx, 0           ; Check if any digits were entered
    je end_display_loop ; If 0 digits, skip loop

display_char:
    mov dl, byte ptr [si] ; Load current digit (ASCII) into DL
    mov ah, 02h         ; DOS function 02h = display one character
    int 21h             ; Print DL to the screen
    inc si              ; Move to next character in the buffer
    loop display_char   ; Decrement CX and repeat until CX = 0

end_display_loop:
    ; Print a final newline for neatness
    lea dx, newLine
    mov ah, 09h
    int 21h


    mov ah, 4Ch         
    int 21h             
main ENDP
END main