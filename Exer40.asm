; Filename: EXER40.ASM
; Date: October 10, 2025
; Repeatedly display an ATM main menu until the user
; presses “e” for Exit. Pressing a valid letter from
; the main menu will display the name of the ATM
; operation. Display INVALID INPUT! if wrong choice.

.model small
.stack 100h
.data

; Menu strings
menuStr db  13,10,'CIT-U ATM',13,10
         db  'a. Balance Inquiry',13,10
         db  'b. Deposit',13,10
         db  'c. Withdrawal',13,10
         db  'd. Bills Payment',13,10
         db  'e. Exit',13,10
         db  'Enter choice: $',13,10

crlf    db  13,10,'$' 

; Action strings
strBal  db  13,10,'Balance Inquiry',13,10,'$'
strDep  db  13,10,'Deposit ',13,10,'$'
strWith db  13,10,'Withdrawal ',13,10,'$'
strBill db  13,10,'Bills Payment ',13,10,'$'
strInv  db  13,10,'INVALID INPUT! ',13,10,'$'
strExit db  13,10,'Exit. Thank you!',13,10,'$'

userInput db ? ; Declares a byte variable to store the character

.code
start:
    mov ax,@data
    mov ds,ax

main_loop:
    ; Display menu
    lea dx,menuStr
    mov ah,09h
    int 21h

    ; --- Get single character input ---
    mov ah,01h
    int 21h        ; AL = ASCII character (e.g., '1' = 31h)

    ; --- IMMEDIATELY STORE AL TO MEMORY ---
    mov userInput, al ; Store the character AL received into userInput



    ; --- Retrieve from memory and Process Input ---
    mov al, userInput ; Load the character back into AL from memory

    cmp al,'a'
    je do_balance
    cmp al,'b'
    je do_deposit
    cmp al,'c'
    je do_withdrawal
    cmp al,'d'
    je do_bills
    cmp al,'e'
    je do_exit

    ; If none of the above, it's an invalid input
    lea dx,strInv
    mov ah,09h
    int 21h
    jmp main_loop

; --- Subroutines for each menu choice ---
do_balance:
    lea dx,strBal
    mov ah,09h
    int 21h
    jmp main_loop

do_deposit:
    lea dx,strDep
    mov ah,09h
    int 21h
    jmp main_loop

do_withdrawal:
    lea dx,strWith
    mov ah,09h
    int 21h
    jmp main_loop

do_bills:
    lea dx,strBill
    mov ah,09h
    int 21h
    jmp main_loop

do_exit:
    lea dx,strExit
    mov ah,09h
    int 21h

    ; Terminate program
    mov ah,4Ch
    mov al,0
    int 21h

end start