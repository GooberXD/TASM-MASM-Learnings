; Filename: EXER35.ASM
; Date: October 2, 2025
; Create a calculator program to perform the actual math
; operations and display the results. You may use any
; background color. See sample runs below.
; After the user chooses an item from the main menu and
; inputs the numbers, the program performs the operation and
; displays the result, the program does the following:
; 1) Clear the screen (look for the code on how to clear the
; screen.
; 2) Displays the main menu and waits for the user to choose
; an operation.
; 3) The program will end when the user chooses Exit

.model small
.stack 100h
.data
    ; --- Program Info ---
    progTitle   db "THE CALCULATOR$"
    createdBy   db "Created by: GooberXD$" 
    dateToday   db "Date: October 2, 2025$"    
    
    ; --- Main Menu ---
    mainMenuHdr db "Main Menu$"
    menuAdd     db "a - Addition$"
    menuSub     db "s - Subtraction$"
    menuMul     db "m - Multiplication$"
    menuDiv     db "d - Division$"
    menuExit    db "e - Exit$"
    choicePrompt db "Enter your choice: $"
    
    
    ; Addition
    addTitle    db "Addition$"
    promptAdd1  db "Enter first addend: $" 
    promptAdd2  db "Enter second addend: $" 
    msgAdd1     db "First addend is: $"
    msgAdd2     db "Second addend is: $"
    msgSum      db "Sum: $"

    ; Subtraction
    subTitle    db "Subtraction$"
    promptMinuend db "Enter minuend: $" 
    promptSubtrahend db "Enter subtrahend: $" 
    msgMinuend  db "Minuend is: $"
    msgSubtrahend db "Subtrahend is: $"
    msgDiff     db "Difference: $"

    ; Multiplication
    mulTitle    db "Multiplication$"
    promptMulticand db "Enter multiplicand: $" 
    promptMultiplier db "Enter multiplier: $" 
    msgMulticand db "Multicand is: $"
    msgMultiplier db "Multiplier is: $"
    msgProduct  db "Product: $"

    ; Division
    divTitle    db "Division$"
    promptDividend db "Enter dividend: $" 
    promptDivisor db "Enter divisor: $"  
    msgDividend db "Dividend is: $"
    msgDivisor  db "Divisor is: $"
    msgQuotient db "Quotient: $"
    msgRemainder db "Remainder: $" 
    msgDivByZero db "Error: Division by zero!$"

    ; --- Common Messages ---
    pressEnter  db "Press Enter to continue.$"
    exitMessage db "Exit Program$"
    
    ; --- Variables ---
    num1        db ? ; First number input
    num2        db ? ; Second number input
    
    ; For arithmetic results
    sum_result  db ?
    diff_result db ?
    prod_result db ?
    quotient    db ? ; Quotient of operation
    remainder   db ? ; Remainder of operation
    


.code
main proc
    ; Initialize data segment
    mov ax, @data
    mov ds, ax
    
    call ClearScreenAndSetDefaultColor ; Clear screen and set default text color

main_menu_loop:
    call DisplayHeader
    call DisplayMainMenu
    
    ; Get user choice
    mov ah, 9
    lea dx, choicePrompt
    int 21h
    mov ah, 1 ; Read character
    int 21h
    mov bl, al ; Store choice in BL

    ; Newline after choice input
    call NewLine
    
; Process choice 
    cmp bl, 'a'
    je  doAddition
    
    cmp bl, 's'
    je  doSubtraction
    
    cmp bl, 'm'
    je  doMultiplication
    
    cmp bl, 'd'
    je  doDivision_long_jump  ; Jump to an intermediate JMP instruction
    
    cmp bl, 'e'
    je  doExit_long_jump      ; Jump to an intermediate JMP instruction
    
invalid_choice:    
    ; If invalid choice, just loop again
    jmp main_menu_loop

; Intermediate long jumps to handle targets that are too far for JE
doDivision_long_jump:
    jmp doDivision

doExit_long_jump:
    jmp doExit

doAddition:
    call ClearScreenAndSetDefaultColor ; Clear screen
    call SetYellowColorS                ; Set color for Addition title
    mov ah, 9
    lea dx, addTitle
    int 21h
    call ResetDefaultColor             ; Reset color after printing title
    call NewLine
    call NewLine
    
    call GetNumbersAddition             ; Get two numbers for addition
    mov al, num1
    add al, num2
    mov sum_result, al                  ; Store in sum_result
    
    call DisplayOperandsAndResultAddition ; Display numbers and sum
    jmp continueProgram

doSubtraction:
    call ClearScreenAndSetDefaultColor ; Clear screen
    call SetGreenColorS                 ; Set color for Subtraction title
    mov ah, 9
    lea dx, subTitle
    int 21h
    call ResetDefaultColor             ; Reset color after printing title
    call NewLine
    call NewLine
    
    call GetNumbersSubtraction          ; Get two numbers for subtraction
    mov al, num1
    sub al, num2
    mov diff_result, al                 ; Store in diff_result
    
    call DisplayOperandsAndResultSubtraction ; Display numbers and difference
    jmp continueProgram

doMultiplication:
    call ClearScreenAndSetDefaultColor ; Clear screen
    call SetCyanColorS                  ; Set color for Multiplication title
    mov ah, 9
    lea dx, mulTitle
    int 21h
    call ResetDefaultColor             ; Reset color after printing title
    call NewLine
    call NewLine
    
    call GetNumbersMultiplication       ; Get two numbers for multiplication
    mov al, num1
    mov bl, num2
    mul bl                             ; AL = AL * BL (Product in AX, but we only need AL for single digits)
    mov prod_result, al                 ; Store in prod_result (assuming product fits in byte)
    
    call DisplayOperandsAndResultMultiplication ; Display numbers and product
    jmp continueProgram

doDivision:
    call ClearScreenAndSetDefaultColor ; Clear screen
    call SetMagentaColorS               ; Set color for Division title
    mov ah, 9
    lea dx, divTitle
    int 21h
    call ResetDefaultColor             ; Reset color after printing title
    call NewLine
    call NewLine
    
    call GetNumbersDivision             ; Get two numbers for division

    ; Check for division by zero
    cmp num2, 0
    je  divisionByZeroError

    mov al, num1      ; Load dividend into AL
    xor ah, ah        ; Clear AH, so AX = num1 (important for 8-bit division)
    mov bl, num2      ; Load divisor into BL
    div bl            ; AX / BL. Quotient in AL, Remainder in AH.
    
    mov quotient, al  ; Store quotient
    mov remainder, ah ; Store remainder
    
    call DisplayOperandsAndResultDivision ; Display numbers, quotient, and remainder
    jmp continueProgram

divisionByZeroError:
    call NewLine
    call SetRedColorS                   ; Set red color for error message
    mov ah, 9
    lea dx, msgDivByZero
    int 21h
    call ResetDefaultColor             ; Reset color
    jmp continueProgram

continueProgram:
    call ResetDefaultColor      ; Reset color to default before "Press Enter"
    call NewLine
    call NewLine
    mov ah, 9
    lea dx, pressEnter
    int 21h
    mov ah, 1 ; Wait for any key press (Enter in this case)
    int 21h
    
    jmp ClearScreenAndLoop

doExit:
    call ClearScreenAndSetDefaultColor ; Clear screen
    call SetGreyColorS           ; Set color for Exit message
    mov ah, 9
    lea dx, exitMessage
    int 21h
    call ResetDefaultColor      ; Reset color
    call NewLine
    call NewLine
    mov ah, 9
    lea dx, pressEnter
    int 21h
    mov ah, 1
    int 21h
    jmp exit_program ; Proceed to actual program exit

ClearScreenAndLoop:
    call ClearScreenAndSetDefaultColor ; Clear screen and set default color
    jmp main_menu_loop

exit_program:
    ; Exit program
    mov ah, 4ch
    int 21h
main endp

; --- Subroutines ---

; Clears the screen and sets default text color (light gray on black, 07h)
ClearScreenAndSetDefaultColor proc
    mov ah, 06h ; Scroll window up function
    mov al, 00h ; Scroll entire window (all rows)
    mov ch, 00h ; Row 0
    mov cl, 00h ; Col 0
    mov dh, 24h ; Row 24 (max row)
    mov dl, 79h ; Col 79 (max col)
    mov bh, 07h ; Attribute: Light Gray (Foreground) on Black (Background)
    int 10h
    
    ; Set cursor to top-left corner
    mov ah, 02h
    mov bh, 00h ; Page number 0
    mov dh, 00h ; Row 0
    mov dl, 00h ; Col 0
    int 10h
    ret
ClearScreenAndSetDefaultColor endp

; Sets text color attribute for subsequent string prints via INT 21h/AH=09h
; This works by using INT 10h/AH=09h to print a space with the desired attribute.
; This sets the *current* attribute for the console for subsequent prints.
SetColor proc
    ; Input: BH = display page (0), BL = attribute byte
    ; This procedure is generic. Specific color procedures will set BL.
    
    ; Save registers that will be modified by this procedure or INT 10h calls
    push ax
    push bx
    push cx
    push dx
    
    ; Save current cursor position and attribute (we'll only need DH, DL)
    mov ah, 03h ; Get cursor position and size
    mov bh, 00h ; Display page 0
    int 10h     
    push dx     ; Save DH, DL (row, col) - CX is not strictly needed for position

    ; Set cursor to a temporary location to print the attribute-changing space
    ; We'll use (0,79) which is the very last character position on the first line.
    ; This ensures we don't accidentally overwrite useful text.
    mov ah, 02h
    mov bh, 00h ; Page 0
    mov dh, 00h ; Row 0
    mov dl, 79h ; Col 79 
    int 10h

    mov ah, 09h ; Write character and attribute
    mov al, 20h ; Character to write (space)
    mov bh, 00h ; Display page 0
    mov cx, 1   ; Number of times to write
    ; BL already contains the attribute passed by the specific color routines (e.g., SetYellowColor)
    int 10h
    
    ; Restore original cursor position
    pop dx      ; Restore DH, DL (row, col)
    mov ah, 02h ; Set cursor position
    mov bh, 00h ; Display page 0
    int 10h
    
    ; Restore registers
    pop dx
    pop cx
    pop bx
    pop ax
    ret
SetColor endp

; Specific color setters
SetYellowColor proc
    mov ax, 1003h
    mov bl, 0
    int 10h

    mov ah, 9            
    mov bl, 0E0h    
    mov bh, 0       
    mov cx, 12
    int 10h
    call SetColor
    ret
SetYellowColor endp

SetGreenColor proc
    mov ax, 1003h
    mov bl, 0
    int 10h

    mov ah, 9            
    mov bl, 20h       ; green on black
    mov bh, 0       
    mov cx, 15
    int 10h
    call SetColor
    ret
SetGreenColor endp

SetCyanColor proc
    mov ax, 1003h
    mov bl, 0
    int 10h

    mov ah, 9            
    mov bl, 30h       ; cyan on black
    mov bh, 0       
    mov cx, 18
    int 10h
    call SetColor
    ret
SetCyanColor endp

SetMagentaColor proc
    mov ax, 1003h
    mov bl, 0
    int 10h

    mov ah, 9            
    mov bl, 50h       ; purple  on black
    mov bh, 0       
    mov cx, 12
    int 10h
    call SetColor
    ret
SetMagentaColor endp

SetRedColor proc
    mov ax, 1003h
    mov bl, 0
    int 10h

    mov ah, 9            
    mov bl, 40h       ; red  on black
    mov bh, 0       
    mov cx, 12
    int 10h
    call SetColor
    ret
SetRedColor endp

SetGreyColor proc
    mov ax, 1003h
    mov bl, 0
    int 10h

    mov ah, 9            
    mov bl, 70h       ; grey  on black
    mov bh, 0       
    mov cx, 8
    int 10h
    call SetColor
    ret
SetGreyColor endp



; Specific color setters sum (used for titles)
SetYellowColorS proc
    mov ax, 1003h
    mov bl, 0
    int 10h

    mov ah, 9            
    mov bl, 0E0h    
    mov bh, 0       
    mov cx, 8
    int 10h
    call SetColor
    ret
SetYellowColorS endp

SetGreenColorS proc
    mov ax, 1003h
    mov bl, 0
    int 10h

    mov ah, 9            
    mov bl, 20h       ; green on black
    mov bh, 0       
    mov cx, 11
    int 10h
    call SetColor
    ret
SetGreenColorS endp

SetCyanColorS proc
    mov ax, 1003h
    mov bl, 0
    int 10h

    mov ah, 9            
    mov bl, 30h       ; cyan on black
    mov bh, 0       
    mov cx, 14
    int 10h
    call SetColor
    ret
SetCyanColorS endp

SetMagentaColorS proc
    mov ax, 1003h
    mov bl, 0
    int 10h

    mov ah, 9            
    mov bl, 50h       ; purple  on black
    mov bh, 0       
    mov cx, 8
    int 10h
    call SetColor
    ret
SetMagentaColorS endp

SetRedColorS proc
    mov ax, 1003h
    mov bl, 0
    int 10h

    mov ah, 9            
    mov bl, 40h       ; red  on black
    mov bh, 0       
    mov cx, 12
    int 10h
    call SetColor
    ret
SetRedColorS endp

SetGreyColorS proc
    mov ax, 1003h
    mov bl, 0
    int 10h

    mov ah, 9            
    mov bl, 70h       ; grey  on black
    mov bh, 0       
    mov cx, 12
    int 10h
    call SetColor
    ret
SetGreyColorS endp


ResetDefaultColor proc
    mov bl, 07h ; Light Gray on Black (Default)
    call SetColor
    ret
ResetDefaultColor endp

; Displays the program header (title, author, date)
DisplayHeader proc
    call ResetDefaultColor ; Ensure header is default color
    mov ah, 9
    lea dx, progTitle
    int 21h
    call NewLine
    mov ah, 9
    lea dx, createdBy
    int 21h
    call NewLine
    mov ah, 9
    lea dx, dateToday
    int 21h
    call NewLine
    call NewLine
    ret
DisplayHeader endp

; Displays the main menu options with specified colors
DisplayMainMenu proc
    call ResetDefaultColor ; Ensure header is default color
    mov ah, 9
    lea dx, mainMenuHdr
    int 21h
    call NewLine

    call SetYellowColor
    mov ah, 9
    lea dx, menuAdd
    int 21h
    call ResetDefaultColor ; Reset after each colored line
    call NewLine

    call SetGreenColor
    mov ah, 9
    lea dx, menuSub
    int 21h
    call ResetDefaultColor ; Reset after each colored line
    call NewLine

    call SetCyanColor
    mov ah, 9
    lea dx, menuMul
    int 21h
    call ResetDefaultColor ; Reset after each colored line
    call NewLine

    call SetMagentaColor
    mov ah, 9
    lea dx, menuDiv
    int 21h
    call ResetDefaultColor ; Reset after each colored line
    call NewLine

    call SetGreyColor
    mov ah, 9
    lea dx, menuExit
    int 21h
    call ResetDefaultColor ; Reset after each colored line
    call NewLine
    call NewLine
    call ResetDefaultColor ; Reset color for choice prompt (redundant but safe)
    ret
DisplayMainMenu endp

; --- Input Functions (separated for clarity and specific prompts) ---

GetNumbersAddition proc
    call ResetDefaultColor
    mov ah, 9
    lea dx, promptAdd1
    int 21h
    mov ah, 1
    int 21h
    sub al, '0'
    mov num1, al
    call NewLine

    mov ah, 9
    lea dx, promptAdd2
    int 21h
    mov ah, 1
    int 21h
    sub al, '0'
    mov num2, al
    call NewLine
    ret
GetNumbersAddition endp

GetNumbersSubtraction proc
    call ResetDefaultColor
    mov ah, 9
    lea dx, promptMinuend
    int 21h
    mov ah, 1
    int 21h
    sub al, '0'
    mov num1, al
    call NewLine

    mov ah, 9
    lea dx, promptSubtrahend
    int 21h
    mov ah, 1
    int 21h
    sub al, '0'
    mov num2, al
    call NewLine
    ret
GetNumbersSubtraction endp

GetNumbersMultiplication proc
    call ResetDefaultColor
    mov ah, 9
    lea dx, promptMulticand
    int 21h
    mov ah, 1
    int 21h
    sub al, '0'
    mov num1, al
    call NewLine

    mov ah, 9
    lea dx, promptMultiplier
    int 21h
    mov ah, 1
    int 21h
    sub al, '0'
    mov num2, al
    call NewLine
    ret
GetNumbersMultiplication endp

GetNumbersDivision proc
    call ResetDefaultColor
    mov ah, 9
    lea dx, promptDividend
    int 21h
    mov ah, 1
    int 21h
    sub al, '0'
    mov num1, al
    call NewLine

    mov ah, 9
    lea dx, promptDivisor
    int 21h
    mov ah, 1
    int 21h
    sub al, '0'
    mov num2, al
    call NewLine
    ret
GetNumbersDivision endp

; --- Display Result Functions (separated for specific messages) ---

DisplayOperandsAndResultAddition proc
    call NewLine
    call ResetDefaultColor
    mov ah, 9
    lea dx, msgAdd1
    int 21h
    mov al, num1
    call PrintNumber
    call NewLine

    mov ah, 9
    lea dx, msgAdd2
    int 21h
    mov al, num2
    call PrintNumber
    call NewLine

    mov ah, 9
    lea dx, msgSum
    int 21h
    mov al, sum_result ; Use specific result variable
    call PrintNumber
    call NewLine
    ret
DisplayOperandsAndResultAddition endp

DisplayOperandsAndResultSubtraction proc
    call NewLine
    call ResetDefaultColor
    mov ah, 9
    lea dx, msgMinuend
    int 21h
    mov al, num1
    call PrintNumber
    call NewLine

    mov ah, 9
    lea dx, msgSubtrahend
    int 21h
    mov al, num2
    call PrintNumber
    call NewLine

    mov ah, 9
    lea dx, msgDiff
    int 21h
    mov al, diff_result ; Use specific result variable
    call PrintNumber
    call NewLine
    ret
DisplayOperandsAndResultSubtraction endp

DisplayOperandsAndResultMultiplication proc
    call NewLine
    call ResetDefaultColor
    mov ah, 9
    lea dx, msgMulticand
    int 21h
    mov al, num1
    call PrintNumber
    call NewLine

    mov ah, 9
    lea dx, msgMultiplier
    int 21h
    mov al, num2
    call PrintNumber
    call NewLine

    mov ah, 9
    lea dx, msgProduct
    int 21h
    mov al, prod_result ; Use specific result variable
    call PrintNumber
    call NewLine
    ret
DisplayOperandsAndResultMultiplication endp

DisplayOperandsAndResultDivision proc
    call NewLine
    call ResetDefaultColor
    mov ah, 9
    lea dx, msgDividend
    int 21h
    mov al, num1
    call PrintNumber
    call NewLine

    mov ah, 9
    lea dx, msgDivisor
    int 21h
    mov al, num2
    call PrintNumber
    call NewLine

    mov ah, 9
    lea dx, msgQuotient
    int 21h
    mov al, quotient ; Use specific quotient variable
    call PrintNumber
    call NewLine

    mov ah, 9
    lea dx, msgRemainder ; Display remainder
    int 21h
    mov al, remainder    ; Use specific remainder variable
    call PrintNumber
    call NewLine
    ret
DisplayOperandsAndResultDivision endp


; Prints a number (in AL) to the console
; Handles numbers from 0 to 255.
PrintNumber proc
    mov bl, 10      ; Divisor for decimal conversion
    mov cx, 0       ; Counter for digits
    mov dx, 0       ; Clear DX for the stack push/pop
    
    cmp al, 0
    jnz pn_not_zero
    mov dl, '0'     ; If number is 0, just print '0'
    mov ah, 2
    int 21h
    jmp pn_done
pn_not_zero:
    ; Handle numbers 1-255
    ; Save AL and BL (which is 10) for later
    push ax 
    push bx
    
    ; Convert to ASCII digits in reverse order
pn_loop:
    mov ah, 0       ; Clear AH for DIV
    div bl          ; AL = AL / BL (quotient), AH = AL % BL (remainder)
    push ax         ; Push AX onto stack (AL contains quotient, AH contains remainder/digit)
    inc cx          ; Increment digit count
    cmp al, 0       ; Is quotient zero?
    jnz pn_loop     ; If not, continue
    
    ; Pop digits and print
pn_print_loop:
    pop ax          ; Pop AX from stack. The digit is in AH.
    mov dl, ah      ; Get the digit (from AH)
    add dl, '0'     ; Convert to ASCII
    mov ah, 2
    int 21h
    loop pn_print_loop ; Decrement CX and loop if CX > 0

    pop bx          ; Restore original BL (10)
    pop ax          ; Restore original AL (initial number)
pn_done:
    ret
PrintNumber endp

; Prints a newline character sequence (CR+LF)
NewLine proc
    mov ah, 2
    mov dl, 0dh ; Carriage Return
    int 21h
    mov dl, 0ah ; Line Feed
    int 21h
    ret
NewLine endp

end main