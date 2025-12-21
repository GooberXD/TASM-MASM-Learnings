; Filename: EXAM2.ASM
; Hands-on Exam 2
; Date: September 25, 2025

; Perform next the Hands-on Exam 2 - Thursday, September 25, 2025
; INSTRUCTIONS:
; Create an Assembly Language program to execute the sample display below.
; Take note that you have to input the Full Name, Birthday, Gender, Email Address, and Password.
; Then display all the input data in a table form summary for the user to review.
; The program must only accept 1 or 2 to display either a BLUE TABLE or RED TABLE.
; Display INVALID INPUT! to the user if the user inputs not 1 or 2.
; 50 points. Rubric: Correct Input = 25 points + Correct Output (text, table, colors, etc) = 25 points.
; Deadline: 5 minutes before dismissal. This assignment posting will automatically close at dismissal time.
; Once everything is ok with your program, get two screenshots of your running program: one screen shot for blue table, one screen shot for red table, and one screenshot of the error input message.
; Save the screenshots as EXAM2_RUN1.PNG, EXAM2_RUN2.PNG, and EXAM2_ERROR.PNG respectively.
; Save your source code (as EXAM2.ASM) and screenshot PNG file to your OneDrive or Google Drive folder.
; Attach here the URL link to your OneDrive or Google Drive folder.
; Don't forget to TURN IN once you're done.
; You may go once you are done.

.model small
.stack 200h
.data

    

    colorChangeMsg db 'How do you like to display the summary table? $'
    colorChangeMsg1 db '1 - Blue Background $'
    colorChangeMsg2 db '2 - Red Background $'
    colorChangeMsg3 db 'Enter your choice: $'

    fishbookMsg db 'FISHBOOK ACCOUNT REGISTRATION $'
    enterMsg db 'Enter $'
    fullNameMsg db 'Full Name: $'
    birthdayMsg db 'Birthday: $'
    genderMsg db 'Gender: $'
    emailMsg db 'Email Address: $'
    passwordMsg db 'Password: $'

    review db 'Please review account registration details below:$'
    submit db 'SUBMIT$'
    cancel db 'CANCEL$'
    edit db 'EDIT$'
    invalidInp db 'INVALID INPUT!$'

    newline db 13, 10, '$'
    space db ' $'

    ;Border
    topborder db 218, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 194, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 191, '$'
    botborder db 192, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 193, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 217, '$'
    betweenborder db 195, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 197, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 180, '$'
    

    ;inp
    MAX EQU 38
    nameInput db MAX DUP (0)
    birthday db MAX DUP (0)
    gender db MAX DUP (0)
    email db MAX DUP (0)
    password db MAX DUP (0)
    colorChoice db ? 


    l1 dw 0
    l2 dw 0
    l3 dw 0
    l4 dw 0
    l5 dw 0

.code
start: 

     ; Set video mode to text mode 3 (80x25, 16 colors)
    mov ah, 0
    mov al, 3
    int 10h

    mov ax, @data
    mov ds, ax

    ; Display Header
    mov ah, 9
    mov dx, offset fishbookMsg
    int 21h 
    mov dx, offset newline
    int 21h
    mov dx, offset newline
    int 21h

    ; Enter Name
    mov ah, 9
    mov dx, offset enterMsg
    int 21h
    mov dx, offset fullNameMsg
    int 21h

    mov ah, 3Fh
    mov bx, 0
    mov cx, MAX
    mov dx, offset nameInput
    int 21h
    mov l1, ax
    call TrimCRLFName
    call PadName

    ; Enter Birthday
    mov ah, 9
    mov dx, offset enterMsg
    int 21h
    mov dx, offset birthdayMsg
    int 21h

    mov ah, 3Fh
    mov bx, 0
    mov cx, MAX
    mov dx, offset birthday
    int 21h
    mov l2, ax
    call TrimCRLFBirthday
    call PadBirthday

    ; Enter Gender
    mov ah, 9
    mov dx, offset enterMsg
    int 21h
    mov dx, offset genderMsg
    int 21h

    mov ah, 3Fh
    mov bx, 0
    mov cx, MAX
    mov dx, offset gender
    int 21h
    mov l3, ax
    call TrimCRLFGender
    call PadGender

    ; Enter Email
    mov ah, 9
    mov dx, offset enterMsg
    int 21h
    mov dx, offset emailMsg
    int 21h

    mov ah, 3Fh
    mov bx, 0
    mov cx, MAX
    mov dx, offset email
    int 21h
    mov l4, ax
    call TrimCRLFEmail
    call PadEmail

    ; Enter Password
    mov ah, 9
    mov dx, offset enterMsg
    int 21h
    mov dx, offset passwordMsg
    int 21h

    mov ah, 3Fh
    mov bx, 0
    mov cx, MAX
    mov dx, offset password
    int 21h
    mov l5, ax
    call TrimCRLFPassword
    call PadPassword

    ;Enter Color Change

    mov ah, 9
    mov dx, offset newline
    int 21h
    mov ah, 9
    mov dx, offset colorChangeMsg
    int 21h
    mov ah, 9
    mov dx, offset newline
    int 21h
    mov dx, offset colorChangeMsg1
    int 21h
    mov ah, 9
    mov dx, offset newline
    int 21h
    mov dx, offset colorChangeMsg2
    int 21h
    mov ah, 9
    mov dx, offset newline
    int 21h
    mov dx, offset colorChangeMsg3
    int 21h
    
; Read user's choice
mov ah, 1 ; Read a single character
int 21h
mov colorChoice, al ; Store the input character

; Newline after input
mov ah, 9
mov dx, offset newline
int 21h

; Check color choice
cmp colorChoice, '1'
jne CheckRed        ; If NOT '1', jump to check if it's '2'
jmp DisplayBlue     ; If it IS '1', jump to DisplayBlue 

CheckRed:
cmp colorChoice, '2'
jne InvalidChoice   ; If NOT '2', jump to invalid input
jmp DisplayRed      ; If it IS '2', jump to DisplayRed 

InvalidChoice:
; If neither '1' nor '2', display error and loop
mov ah, 9
mov dx, offset newline
int 21h
mov ah, 9
mov dx, offset invalidInp
int 21h

mov ah, 9
mov dx, offset newline
int 21h
mov ah, 9
mov dx, offset newline
int 21h
mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h

mov ah, 9
mov bl, 4Fh
mov cx, 8
int 10h

mov ah, 9
mov dx, offset space
int 21h
mov dx, offset submit
int 21h
mov dx, offset space
int 21h


mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space
int 21h

 
mov ah, 9
mov bl, 4Fh
mov cx, 8
int 10h

mov ah, 9
mov dx, offset space
int 21h
mov dx, offset cancel
int 21h
mov dx, offset space
int 21h


mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space
int 21h

 
mov ah, 9
mov bl, 4Fh
mov cx, 6
int 10h

mov ah, 9
mov dx, offset space
int 21h
mov dx, offset edit
int 21h
mov dx, offset space
int 21h

    jmp ExitProgram     ; Exit after displaying error
    




DisplayBlue:
    ; Newlining
    mov ah, 9
    mov dx, offset newline
    int 21h

    ; Display Review
    mov ah, 9
    mov dx, offset review
    int 21h
    mov dx, offset newline
    int 21h 

    mov ah, 9
    mov bl, 00h
    mov cx, 1
    int 10h

    mov ah, 9
    mov dx, offset space 
    int 21h


    mov ah, 9
    mov bl, 1Fh
    mov cx, 58
    int 10h

    mov ah, 9
    mov dx, offset topborder
    int 21h
    mov dx, offset newline
    int 21h

    ; R2
    ; 1 Black 
    mov ah, 9
    mov bl, 00h
    mov cx, 1
    int 10h

    mov ah, 9
    mov dx, offset space 
    int 21h

    mov ah, 9
    mov bl, 1Fh
    mov cx, 58
    int 10h

    mov ah, 2
    mov dl, 179
    int 21h

    mov ah, 9
    mov dx, offset space
    int 21h
    mov dx, offset fullNameMsg
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h

    mov ah, 2
    mov dl, 179
    int 21h

    mov ah, 9
    mov dx, offset space
    int 21h
    
    mov ah, 40h 
    mov bx, 1
    mov cx, MAX
    mov dx, offset nameInput
    int 21h

    mov ah, 2
    mov dl, 179
    int 21h

    mov ah, 9
    mov dx, offset newline
    int 21h

    ; R3
    ; 1 Black 
    mov ah, 9
    mov bl, 00h
    mov cx, 1
    int 10h

    mov ah, 9
    mov dx, offset space 
    int 21h


    mov ah, 9
    mov bl, 1Fh
    mov cx, 58
    int 10h

    mov ah, 9
    mov dx, offset betweenborder
    int 21h
    mov dx, offset newline
    int 21h

 
    mov ah, 9
    mov bl, 00h
    mov cx, 1
    int 10h

    mov ah, 9
    mov dx, offset space 
    int 21h

    mov ah, 9
    mov bl, 1Fh
    mov cx, 58
    int 10h

    mov ah, 2   
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset space
    int 21h
    mov dx, offset birthdayMsg
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset space
    int 21h
    
mov ah, 40h ;
    mov bx, 1
    mov cx, MAX
    mov dx, offset birthday
    int 21h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset newline
    int 21h

; R5
; 1 Black 
mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h

mov ah, 9
mov bl, 1Fh
mov cx, 58
int 10h

mov ah, 9
    mov dx, offset betweenborder
    int 21h
    mov dx, offset newline
    int 21h

; R6
; 1 Black 
mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h

mov ah, 9
mov bl, 1Fh
mov cx, 58
int 10h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset space
    int 21h
    mov dx, offset genderMsg
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset space
    int 21h
    
mov ah, 40h ;
    mov bx, 1
    mov cx, MAX
    mov dx, offset gender
    int 21h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset newline
    int 21h

; R7
; 1 Black 
mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h

mov ah, 9
mov bl, 1Fh
mov cx, 58
int 10h

mov ah, 9
    mov dx, offset betweenborder
    int 21h
    mov dx, offset newline
    int 21h

; R8
; 1 Black 
mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h

mov ah, 9
mov bl, 1Fh
mov cx, 58
int 10h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset space
    int 21h
    mov dx, offset emailMsg
    int 21h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset space
    int 21h
    
mov ah, 40h ;
    mov bx, 1
    mov cx, MAX
    mov dx, offset email
    int 21h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset newline
    int 21h

; R9
; 1 Black 
mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h

mov ah, 9
mov bl, 1Fh
mov cx, 58
int 10h

mov ah, 9
    mov dx, offset betweenborder
    int 21h
    mov dx, offset newline
    int 21h

; R10
; 1 Black 
mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h

mov ah, 9
mov bl, 1Fh
mov cx, 58
int 10h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset space
    int 21h
    mov dx, offset passwordMsg
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset space
    int 21h
    
mov ah, 40h 
    mov bx, 1
    mov cx, MAX
    mov dx, offset password
    int 21h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset newline
    int 21h

; R11
; 1 Black 
mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h

mov ah, 9
mov bl, 1Fh
mov cx, 58
int 10h

mov ah, 9
    mov dx, offset botborder
    int 21h
    mov dx, offset newline
    int 21h

; Newlining
mov ah, 9
    mov dx, offset newline
    int 21h


mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h

 
mov ah, 9
mov bl, 4Fh
mov cx, 8
int 10h

mov ah, 9
    mov dx, offset space
    int 21h
    mov dx, offset submit
    int 21h
    mov dx, offset space
    int 21h


mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
    mov dx, offset space
    int 21h

 
mov ah, 9
mov bl, 4Fh
mov cx, 8
int 10h

mov ah, 9
    mov dx, offset space
    int 21h
    mov dx, offset cancel
    int 21h
    mov dx, offset space
    int 21h


mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
    mov dx, offset space
    int 21h

 
mov ah, 9
mov bl, 4Fh
mov cx, 6
int 10h

mov ah, 9
mov dx, offset space
int 21h
mov dx, offset edit
int 21h
mov dx, offset space
int 21h 

jmp ExitProgram









DisplayRed:
    ; Newlining
    mov ah, 9
    mov dx, offset newline
    int 21h

    ; Display Review
    mov ah, 9
    mov dx, offset review
    int 21h
    mov dx, offset newline
    int 21h 

    mov ah, 9
    mov bl, 00h
    mov cx, 1
    int 10h

    mov ah, 9
    mov dx, offset space 
    int 21h

    
    mov ah, 9
    mov bl, 4Fh
    mov cx, 58
    int 10h

    mov ah, 9
    mov dx, offset topborder
    int 21h
    mov dx, offset newline
    int 21h

    mov ah, 9
    mov bl, 00h
    mov cx, 1
    int 10h

    mov ah, 9
    mov dx, offset space 
    int 21h


    mov ah, 9
    mov bl, 4Fh
    mov cx, 58
    int 10h

    mov ah, 2
    mov dl, 179
    int 21h

    mov ah, 9
    mov dx, offset space
    int 21h
    mov dx, offset fullNameMsg
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h

    mov ah, 2
    mov dl, 179
    int 21h

    mov ah, 9
    mov dx, offset space
    int 21h
    
    mov ah, 40h 
    mov bx, 1
    mov cx, MAX
    mov dx, offset nameInput
    int 21h

    mov ah, 2
    mov dl, 179
    int 21h

    mov ah, 9
    mov dx, offset newline
    int 21h

   
    mov ah, 9
    mov bl, 00h
    mov cx, 1
    int 10h

    mov ah, 9
    mov dx, offset space 
    int 21h

    
    mov ah, 9
    mov bl, 4Fh
    mov cx, 58
    int 10h

    mov ah, 9
    mov dx, offset betweenborder
    int 21h
    mov dx, offset newline
    int 21h


mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h


mov ah, 9
mov bl, 4Fh
mov cx, 58
int 10h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset space
    int 21h
    mov dx, offset birthdayMsg
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset space
    int 21h
    
mov ah, 40h ;
    mov bx, 1
    mov cx, MAX
    mov dx, offset birthday
    int 21h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset newline
    int 21h

; R5
; 1 Black 
mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h

mov ah, 9
mov bl, 4Fh
mov cx, 58
int 10h

mov ah, 9
    mov dx, offset betweenborder
    int 21h
    mov dx, offset newline
    int 21h

; R6
; 1 Black 
mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h

mov ah, 9
mov bl, 4Fh
mov cx, 58
int 10h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset space
    int 21h
    mov dx, offset genderMsg
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h
    mov dx, offset space
    int 21h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset space
    int 21h
    
mov ah, 40h ;
    mov bx, 1
    mov cx, MAX
    mov dx, offset gender
    int 21h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset newline
    int 21h

; R7
; 1 Black 
mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h

mov ah, 9
mov bl, 4Fh
mov cx, 58
int 10h

mov ah, 9
    mov dx, offset betweenborder
    int 21h
    mov dx, offset newline
    int 21h

; R8
; 1 Black 
mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h

mov ah, 9
mov bl, 4Fh
mov cx, 58
int 10h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset space
    int 21h
    mov dx, offset emailMsg
    int 21h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset space
    int 21h
    
mov ah, 40h ;
    mov bx, 1
    mov cx, MAX
    mov dx, offset email
    int 21h

mov ah, 2
    mov dl, 179
    int 21h

mov ah, 9
    mov dx, offset newline
    int 21h

; R9
; 1 Black 
mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h

mov ah, 9
mov bl, 4Fh
mov cx, 58
int 10h

mov ah, 9
    mov dx, offset betweenborder
    int 21h
    mov dx, offset newline
    int 21h

; R10
; 1 Black 
mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h

mov ah, 9
mov bl, 4Fh
mov cx, 58
int 10h

mov ah, 2
mov dl, 179
int 21h

mov ah, 9
mov dx, offset space
int 21h
mov dx, offset passwordMsg
int 21h
mov dx, offset space
int 21h
mov dx, offset space
int 21h
mov dx, offset space
int 21h
mov dx, offset space
int 21h
mov dx, offset space
int 21h

mov ah, 2
mov dl, 179
int 21h

mov ah, 9
mov dx, offset space
int 21h

mov ah, 40h 
mov bx, 1
mov cx, MAX
mov dx, offset password
int 21h

mov ah, 2
mov dl, 179
int 21h

mov ah, 9
mov dx, offset newline
int 21h

; 1 Black 
mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h


mov ah, 9
mov bl, 4Fh
mov cx, 58
int 10h

mov ah, 9
mov dx, offset botborder
int 21h
mov dx, offset newline
int 21h


mov ah, 9
mov dx, offset newline
int 21h



mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space 
int 21h


mov ah, 9
mov bl, 4Fh
mov cx, 8
int 10h

mov ah, 9
mov dx, offset space
int 21h
mov dx, offset submit
int 21h
mov dx, offset space
int 21h


mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space
int 21h

 
mov ah, 9
mov bl, 4Fh
mov cx, 8
int 10h

mov ah, 9
mov dx, offset space
int 21h
mov dx, offset cancel
int 21h
mov dx, offset space
int 21h


mov ah, 9
mov bl, 00h
mov cx, 1
int 10h

mov ah, 9
mov dx, offset space
int 21h

 
mov ah, 9
mov bl, 4Fh
mov cx, 6
int 10h

mov ah, 9
mov dx, offset space
int 21h
mov dx, offset edit
int 21h
mov dx, offset space
int 21h
jmp ExitProgram


;jmp to exitprog

ExitProgram:
mov ah, 4Ch
int 21h




;Subroutes



; Subroutine: TrimCRLFName
TrimCRLFName PROC
    cmp l1, 2
    jb  TrimDone1      

    mov si, offset nameInput
    add si, l1
    sub si, 2          

    mov al, [si]
    cmp al, 0Dh
    jne TrimDone1
    mov al, [si+1]
    cmp al, 0Ah
    jne TrimDone1

    sub l1, 2

TrimDone1:
    ret
TrimCRLFName ENDP

PadName PROC
    mov cx, MAX
    sub cx, l1       
    jz PadDone1      
    mov si, offset nameInput
    add si, l1       
PadLoop1:
    mov byte ptr [si], 20h
    inc si
    loop PadLoop1
PadDone1:
    ret
PadName ENDP


; Subroutine: TrimCRLFBirthday
TrimCRLFBirthday PROC
    cmp l2, 2
    jb  TrimDone2      

    mov si, offset birthday
    add si, l2
    sub si, 2          

    mov al, [si]
    cmp al, 0Dh
    jne TrimDone2
    mov al, [si+1]
    cmp al, 0Ah
    jne TrimDone2

    sub l2, 2

TrimDone2:
    ret
TrimCRLFBirthday ENDP

PadBirthday PROC
    mov cx, MAX
    sub cx, l2       
    jz PadDone2      
    mov si, offset birthday
    add si, l2       
PadLoop2:
    mov byte ptr [si], 20h
    inc si
    loop PadLoop2
PadDone2:
    ret
PadBirthday ENDP


; Subroutine: TrimCRLFGender
TrimCRLFGender PROC
    cmp l3, 2
    jb  TrimDone3      

    mov si, offset gender
    add si, l3
    sub si, 2          

    mov al, [si]
    cmp al, 0Dh
    jne TrimDone3
    mov al, [si+1]
    cmp al, 0Ah
    jne TrimDone3

    sub l3, 2

TrimDone3:
    ret
TrimCRLFGender ENDP

PadGender PROC
    mov cx, MAX
    sub cx, l3       
    jz PadDone3      
    mov si, offset gender
    add si, l3       
PadLoop3:
    mov byte ptr [si], 20h
    inc si
    loop PadLoop3
PadDone3:
    ret
PadGender ENDP


; Subroutine: TrimCRLFEmail
TrimCRLFEmail PROC
    cmp l4, 2
    jb  TrimDone4      

    mov si, offset email
    add si, l4
    sub si, 2          

    mov al, [si]
    cmp al, 0Dh
    jne TrimDone4
    mov al, [si+1]
    cmp al, 0Ah
    jne TrimDone4

    sub l4, 2

TrimDone4:
    ret
TrimCRLFEmail ENDP

PadEmail PROC
    mov cx, MAX
    sub cx, l4       
    jz PadDone4      
    mov si, offset email
    add si, l4       
PadLoop4:
    mov byte ptr [si], 20h
    inc si
    loop PadLoop4
PadDone4:
    ret
PadEmail ENDP


; Subroutine: TrimCRLFPassword
TrimCRLFPassword PROC
    cmp l5, 2
    jb  TrimDone5      

    mov si, offset password
    add si, l5
    sub si, 2          

    mov al, [si]
    cmp al, 0Dh
    jne TrimDone5
    mov al, [si+1]
    cmp al, 0Ah
    jne TrimDone5

    sub l5, 2

TrimDone5:
    ret
TrimCRLFPassword ENDP

PadPassword PROC
    mov cx, MAX
    sub cx, l5       
    jz PadDone5      
    mov si, offset password
    add si, l5       
PadLoop5:
    mov byte ptr [si], 20h
    inc si
    loop PadLoop5
PadDone5:
    ret
PadPassword ENDP


end start

; testest
