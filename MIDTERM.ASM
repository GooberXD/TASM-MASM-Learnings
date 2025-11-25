.model small
.stack 100h
.data

; --- NEW: Pre-menu strings ---
preMenuStr db  13,10,'  CIT-U BANK',13,10
           db  '  Automatic Teller Machine',13,10
           db  '  Copyright 2025',13,10
           db  '  Programmer: GooberXD',13,10,13,10
           db  '  Welcome!',13,10
           db  13,10, '  Please insert your card.',13,10
           db  '  Enter your PIN: $'

pinPrompt  db  '  Enter your PIN: $' ; For retries

wrongPinStr db 13,10, '  WRONG PIN!',13,10,'$'

correctPIN db "1234" ; The correct PIN

; --- MODIFIED: Buffer for buffered input (DOS AH=0Ah) ---
; Max chars + actual chars + 4 for PIN + 1 for CR (Enter) + 1 for NULL terminator
pinBuffer  db  5       ; Max 4 chars for PIN + 1 for CR (Enter key)
           db  ?       ; Actual number of characters read
enteredPIN db  5 dup (?) ; Buffer to store entered PIN (4 digits + CR)

; --- NEW: Buffer for Y/N input ---
ynBuffer   db  2       ; Max 1 char for Y/N + 1 for CR (Enter key)
           db  ?       ; Actual number of characters read
enteredYN  db  2 dup (?) ; Buffer to store Y/N (1 char + CR)


; Menu strings (existing)
menuStr db  13,10,'  CIT-U BANK',13,10
           db  '  Automatic Teller Machine',13,10
           db  '  Copyright 2025',13,10
           db  '  Programmer: GooberXD',13,10,13,10
           db  '  Welcome!',13,10
           db  13,10, '  Main Menu:',13,10

         db  '  1 Balance Inquiry',13,10
         db  '  2 Deposit',13,10
         db  '  3 Withdraw',13,10
         db  '  4 Pay Bills',13,10
         db  '  5 Exit',13,10
         db  '  Enter choice: $',13,10

crlf    db  13,10,'$'

; Action strings (existing)
strBal  db  13,10,'  BALANCE INQUIRY',13,10,'$'
strDep  db  13,10,'  DEPOSIT ',13,10,'$'
strWith db  13,10,'  WITHDRAW ',13,10,'$'
strBill db  13,10,'  PAY BILLS ',13,10,'$'
strInv  db  13,10,'  WRONG CHOICE! ',13,10,'$'

EXIT db 13,10,'  EXIT ',13,10,'$'

strExit db  13,10,'  Please get your card. Thank You.',13,10,'$'
strCont db  13,10,'  Continue? (Y/N): $'

; userInput db ? ; Declares a byte variable to store the character (no longer needed for main menu choice,
;                ; as we'll use a temporary register for that, but will keep for Y/N in a temp way)
; Let's just use a register for the main menu choice, or a dedicated buffer if we want ENTER for that too.
; For Y/N, we'll extract directly from ynBuffer.


.code
start:
    ; Set video mode and clear screen initially
    mov ah, 00h
    mov al, 03h
    int 10h

    ; Set initial screen colors: Red Background, Bright Yellow Text
    call SetScreenColors

    mov ax,@data
    mov ds,ax

; --- PIN Authentication Loop ---
pin_loop:
    ; Clear screen for the pre-menu with desired colors
    mov ah, 00h
    mov al, 03h
    int 10h
    call SetScreenColors

    lea dx,preMenuStr ; Display pre-menu and PIN prompt
    mov ah,09h
    int 21h

    ; Get PIN using buffered input (AH=0Ah)
    lea dx,pinBuffer    ; DX points to the buffer structure
    mov ah,0Ah          ; DOS buffered input function
    int 21h             ; User types, presses Enter. Input is stored in pinBuffer+2 onwards

    ; Check if exactly 4 digits were entered (plus the Enter key)
    mov bl, byte ptr [pinBuffer + 1] ; Get actual length
    cmp bl, 4                        ; Check if 4 characters were entered before Enter
    jne wrong_pin_length             ; If not 4, it's a wrong PIN (e.g., "123" or "12345")

    ; Compare entered PIN with correct PIN
    lea si,correctPIN   ; Pointer to correct PIN
    lea di,[pinBuffer + 2] ; Pointer to the actual start of entered digits in buffer
    mov cx,4            ; Compare 4 characters

    xor ax,ax           ; Clear AX for comparison
    mov al,byte ptr [di] ; Get first character of entered PIN
    cmp al,byte ptr [si] ; Compare with first character of correct PIN
    jne wrong_pin       ; If not equal, PIN is wrong

    inc si              ; Move to next byte of correct PIN
    inc di              ; Move to next byte of entered PIN
    mov al,byte ptr [di]
    cmp al,byte ptr [si]
    jne wrong_pin

    inc si
    inc di
    mov al,byte ptr [di]
    cmp al,byte ptr [si]
    jne wrong_pin

    inc si
    inc di
    mov al,byte ptr [di]
    cmp al,byte ptr [si]
    jne wrong_pin

    ; If all 4 characters matched, PIN is correct, proceed to main menu
    jmp main_loop

wrong_pin_length:
    ; Handle case where not 4 digits were entered (e.g., "123" or "12345")
    lea dx,wrongPinStr  ; Display "WRONG PIN!"
    mov ah,09h
    int 21h
    mov ah,01h ; Wait for key press before re-looping
    int 21h
    jmp pin_loop        ; Go back to the start of the PIN authentication loop

wrong_pin:
    lea dx,wrongPinStr  ; Display "WRONG PIN!"
    mov ah,09h
    int 21h
    mov ah,01h ; Wait for key press before re-looping
    int 21h
    jmp pin_loop        ; Go back to the start of the PIN authentication loop


; --- Existing Main Menu Loop ---
main_loop:
    mov ah, 00h
    mov al, 03h
    int 10h
    ; Clear screen again before displaying menu each time, with desired colors
    call SetScreenColors


    ; Display menu
    lea dx,menuStr
    mov ah,09h
    int 21h

    ; --- Get single character input for menu choice (still direct, no Enter) ---
    ; If you want ENTER for menu choice too, uncomment and adapt like Y/N input
    mov ah,01h
    int 21h        ; AL = ASCII character (e.g., '1' = 31h)
    ; Store in BL for temporary use for menu choice
    mov bl, al
    call print_crlf ; Print a new line after user input

    ; --- Process Input from BL ---
    mov al, bl ; Load the character back into AL from BL

    cmp al,'1'
    je do_balance
    cmp al,'2'
    je do_deposit
    cmp al,'3'
    je do_withdrawal
    cmp al,'4'
    je do_bills

    ; --- FIX for "Relative jump out of range" for do_exit ---
    cmp al,'5'
    jne check_invalid_input_menu ; If AL is NOT '5', skip to check for invalid input
    jmp do_exit                  ; If AL IS '5', jump unconditionally to do_exit

check_invalid_input_menu:        ; This label serves as the jump target
    ; If none of the above, it's an invalid input

    lea dx,strInv
    mov ah,09h
    int 21h
    jmp ask_continue

; --- Subroutines for each menu choice ---
do_balance:
    lea dx,strBal
    mov ah,09h
    int 21h
    jmp ask_continue

do_deposit:
    lea dx,strDep
    mov ah,09h
    int 21h
    jmp ask_continue

do_withdrawal:
    lea dx,strWith
    mov ah,09h
    int 21h
    jmp ask_continue

do_bills:
    lea dx,strBill
    mov ah,09h
    int 21h
    ; No JMP needed here, falls through to ask_continue as intended

ask_continue:
    lea dx,strCont  ; Display "Continue? (Y/N): "
    mov ah,09h
    int 21h

    ; --- MODIFIED: Get Y/N input using buffered input (AH=0Ah) ---
    lea dx,ynBuffer     ; DX points to the Y/N buffer
    mov ah,0Ah          ; DOS buffered input function
    int 21h             ; User types, presses Enter. Input is stored.

    ; Get the actual character from the buffer (it's at ynBuffer + 2)
    ; And store it in AL for comparison
    mov al, byte ptr [ynBuffer + 2]

    ; Check if exactly 1 char was entered (plus the Enter key)
    mov bl, byte ptr [ynBuffer + 1] ; Get actual length
    cmp bl, 1                       ; Should be 1 char (Y or N)
    jne invalid_yn_input            ; If not 1, treat as invalid

    ; Convert input to uppercase if it's a lowercase letter
    cmp al, 'a'     ; Is it 'a' or greater?
    jb  check_Y     ; If below 'a' (not a letter), skip conversion
    cmp al, 'z'     ; Is it 'z' or less?
    ja  check_Y     ; If above 'z' (not a letter), skip conversion
    sub al, 20h     ; If it's a lowercase letter, convert to uppercase (ASCII 'a' - 20h = 'A')

check_Y:
    cmp al,'Y'
    je handle_Y_pressed ; Jump to loop

    cmp al,'N'          ; Check for 'N' explicitly
    je do_exit          ; If 'N', exit

invalid_yn_input:
    ; If not 'Y', 'N', or not a single character, treat as exit
    jmp do_exit             ; Unconditional JMP to exit for any other input

handle_Y_pressed:
    jmp main_loop

; handle_N_pressed is removed, jumps directly to do_exit

print_crlf:
    lea dx,crlf
    mov ah,09h
    int 21h
    ret

; --- NEW: Subroutine to set screen colors (Red Background, Bright Yellow Text) ---
SetScreenColors:
    mov ah, 06h      ; Scroll Up function
    mov al, 00h      ; Scroll 0 lines (clears entire window)
    mov bh, 4Eh      ; BH = Attribute (Red Background, Bright Yellow Foreground)
                     ;    4 = Red Background (binary 0100 0000)
                     ;    E = Bright Yellow Foreground (binary 0000 1110)
                     ;    Combined: 0100 1110b = 4Eh
    mov cx, 0000h    ; CH = Row top, CL = Col left (start at 0,0)
    mov dx, 184Fh    ; DH = Row bottom (24), DL = Col right (79) for 80x25 screen
    int 10h          ; Execute scroll/clear
    ret

PrintHexByte:
    push ax
    push bx
    push cx
    push dx

    mov ah, 02h    ; DOS function to display character
    mov bl, al     ; Copy AL to BL to preserve it

    ; Print high nibble
    shr al, 4      ; Shift high 4 bits to low 4 bits
    call PrintHexDigit

    ; Print low nibble
    mov al, bl     ; Restore original AL (now in BL)
    call PrintHexDigit

    pop dx
    pop cx
    pop bx
    pop ax
    ret

PrintHexDigit:
    cmp al, 0Ah    ; Is it 0-9 or A-F?
    jl Add0        ; If less than 10, just add '0'
    add al, 07h    ; If A-F, add 7 (to get from 9 to A ASCII values)
Add0:
    add al, 30h    ; Add '0' to convert nibble to ASCII hex character
    int 21h        ; Display character
    ret


do_exit:

    lea dx,EXIT
    mov ah,09h
    int 21h

    lea dx,strExit
    mov ah,09h
    int 21h

    ; Terminate program
    mov ah,4Ch
    mov al,0
    int 21h

end start