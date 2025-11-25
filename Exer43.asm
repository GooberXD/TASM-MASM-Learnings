; Filename: EXER43.ASM
; Date: October 10, 2025
; Create and call a function for each item in the main menu.

.MODEL SMALL
.STACK 100h
.DATA
menuTitle db 0Dh,0Ah,0Dh,0Ah, 'Greetings',0Dh,0Ah, \
            'Main Menu',0Dh,0Ah, \
            '1. Good Morning',0Dh,0Ah, \
            '2. Good Afternoon',0Dh,0Ah, \
            '3. Good Evening',0Dh,0Ah, \
            '4. Exit Program',0Dh,0Ah, \
            'Enter choice: $'
msgMorning db 0Dh,0Ah, 'Good Morning!$' ,0Dh,0Ah, 
msgAfternoon db 0Dh,0Ah, 'Good Afternoon!$' ,0Dh,0Ah,
msgEvening db 0Dh,0Ah, 'Good Evening!$' ,0Dh,0Ah,
msgInvalid db 0Dh,0Ah, 'Invalid choice. Please try again.$' ,0Dh,0Ah,
msgExit db 0Dh,0Ah, 'Thank you! Program will now exit.$' ,0Dh,0Ah,

.CODE
MAIN PROC
    mov ax, @data
    mov ds, ax

MainMenu:
    ; Display menu
    mov ah, 09h
    lea dx, menuTitle
    int 21h

    ; Get user input
    mov ah, 01h
    int 21h
    mov bl, al ; Store character input in BL

    ; Print new line after input
    mov ah, 02h
    mov dl, 0Dh ; Carriage return
    int 21h
    mov dl, 0Ah ; Line feed
    int 21h

    ; Compare input and jump to appropriate routine
    cmp bl, '1'
    je CallMorning
    cmp bl, '2'
    je CallAfternoon
    cmp bl, '3'
    je CallEvening
    cmp bl, '4'
    je CallExit
    jmp InvalidChoice ; If not 1-4, invalid

CallMorning:
    call GoodMorning
    jmp MainMenu
CallAfternoon:
    call GoodAfternoon
    jmp MainMenu
CallEvening:
    call GoodEvening
    jmp MainMenu
CallExit:
    call ExitProgram
InvalidChoice:
    call InvalidMsg
    jmp MainMenu
MAIN ENDP

GoodMorning PROC
    mov ah, 09h
    lea dx, msgMorning
    int 21h
    ret
GoodMorning ENDP

GoodAfternoon PROC
    mov ah, 09h
    lea dx, msgAfternoon
    int 21h
    ret
GoodAfternoon ENDP

GoodEvening PROC
    mov ah, 09h
    lea dx, msgEvening
    int 21h
    ret
GoodEvening ENDP

InvalidMsg PROC
    mov ah, 09h
    lea dx, msgInvalid
    int 21h
    ret
InvalidMsg ENDP

ExitProgram PROC
    mov ah, 09h
    lea dx, msgExit
    int 21h
    mov ah, 4Ch
    mov al, 00h
    int 21h
ExitProgram ENDP

END MAIN