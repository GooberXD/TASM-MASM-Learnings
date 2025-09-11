; Filename: EXER25.ASM
; Date: 9/11/2025

; Create an Automated Teller Machine (ATM) main menu screen. Ask the 
; user to input a number corresponding to an item in the main menu. 
; Print back the number input by user and the corresponding 
; transaction.
; Expected Output
; Cebu Institute of Technology – University
; Automated Teller Machine
; Main Menu
; 1 Balance Inquiry
; 2 Withdrawal
; 3 Deposit
; 4 Transfer
; 5 Bills Payment
; 6 Change Pin
; 7 Exit
; Enter number of your choice: 1
; You have chosen 1 Balance Inquiry.
; Thank you for banking with us!
; Copyright 2024
; Programmer: YOUR FULL NAME HERE

.MODEL small
.STACK 100h
.DATA
    title1        db 'Cebu Institute of Technology - University', 13,10, '$'
    title2        db 'Automated Teller Machine', 13,10, '$'
    menu          db 'Main Menu', 13,10, '$'
    option1       db '1 Balance Inquiry', 13,10, '$'
    option2       db '2 Withdrawal', 13,10, '$'
    option3       db '3 Deposit', 13,10, '$'
    option4       db '4 Transfer', 13,10, '$'
    option5       db '5 Bills Payment', 13,10, '$'
    option6       db '6 Change Pin', 13,10, '$'
    option7       db '7 Exit', 13,10, '$'
    prompt        db 'Enter number of your choice: $'

    youHaveChosen db 'You have chosen ', '$'
    balanceInquiry db 'Balance Inquiry.', '$'
    withdrawal     db 'Withdrawal.', '$'
    deposit       db 'Deposit.', '$'
    transfer      db 'Transfer.', '$'
    billsPayment  db 'Bills Payment.', '$'
    changePin     db 'Change Pin.', '$'
    exitMsg       db 'Exit.', '$'
    invalidChoiceMsg db 'Invalid choice.', 13,10, '$'

    newline       db 13,10, '$'

    msg_thanks    db 'Thank you for banking with us!', 13,10, '$'
    copyright     db 'Copyright 2024', 13,10, '$'
    programmer    db 'Programmer: GooberXD', 13,10, '$'

    choice        db ?      ; To store user's choice input

.CODE
ProgramStart:
    mov ax, @data
    mov ds, ax

    ; Print titles and menu options
    mov ah, 09h

    mov dx, OFFSET title1
    int 21h
    mov dx, OFFSET title2
    int 21h
    mov dx, OFFSET menu
    int 21h

    mov dx, OFFSET option1
    int 21h
    mov dx, OFFSET option2
    int 21h
    mov dx, OFFSET option3
    int 21h
    mov dx, OFFSET option4
    int 21h
    mov dx, OFFSET option5
    int 21h
    mov dx, OFFSET option6
    int 21h
    mov dx, OFFSET option7
    int 21h

    ; Print prompt
    mov dx, OFFSET prompt
    int 21h

    ; Read character input
    mov ah, 01h
    int 21h
    mov choice, al          ; store input

    ; Print newline
    mov ah, 09h
    mov dx, OFFSET newline
    int 21h

    ; Print "You have chosen "
    mov dx, OFFSET youHaveChosen
    mov ah, 09h
    int 21h

    ; Print the choice number
    mov dl, choice
    mov ah, 02h
    int 21h

    ; Print space
    mov dl, ' '
    mov ah, 02h
    int 21h

    ; Convert ASCII digit to number 1-7
    mov al, choice
    sub al, '0'           ; Convert char to numeric 1-7
    cmp al, 1
    jb InvalidChoice
    cmp al, 7
    ja InvalidChoice

    mov bl, al            ; store choice number

    ; Jump table using chain of conditional jumps + near unconditional jumps
    cmp bl, 1
    jne check2
    jmp PrintBalanceInquiry

check2:
    cmp bl, 2
    jne check3
    jmp PrintWithdrawal

check3:
    cmp bl, 3
    jne check4
    jmp PrintDeposit

check4:
    cmp bl, 4
    jne check5
    jmp PrintTransfer

check5:
    cmp bl, 5
    jne check6
    jmp PrintBillsPayment

check6:
    cmp bl, 6
    jne check7
    jmp PrintChangePin

check7:
    cmp bl, 7
    jne InvalidChoice
    jmp PrintExit

; Invalid choice handler
InvalidChoice:
    mov dx, OFFSET invalidChoiceMsg
    mov ah, 09h
    int 21h
    jmp EndProgram

; Print routines for each choice
PrintBalanceInquiry:
    mov dx, OFFSET balanceInquiry
    jmp PrintChoiceDesc

PrintWithdrawal:
    mov dx, OFFSET withdrawal
    jmp PrintChoiceDesc

PrintDeposit:
    mov dx, OFFSET deposit
    jmp PrintChoiceDesc

PrintTransfer:
    mov dx, OFFSET transfer
    jmp PrintChoiceDesc

PrintBillsPayment:
    mov dx, OFFSET billsPayment
    jmp PrintChoiceDesc

PrintChangePin:
    mov dx, OFFSET changePin
    jmp PrintChoiceDesc

PrintExit:
    mov dx, OFFSET exitMsg
    jmp PrintChoiceDesc

PrintChoiceDesc:
    mov ah, 09h
    int 21h

    ; Print newline AFTER the full phrase
    mov dx, OFFSET newline
    mov ah, 09h
    int 21h
    mov dx, OFFSET newline
    mov ah, 09h
    int 21h

    ; Print thank you message
    mov dx, OFFSET msg_thanks
    int 21h

    ; Print copyright
    mov dx, OFFSET copyright
    int 21h

    ; Print programmer info
    mov dx, OFFSET programmer
    int 21h

EndProgram:
    mov ah, 4Ch
    int 21h

END ProgramStart

