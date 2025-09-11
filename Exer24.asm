; Filename: EXER24.ASM
; Date: 9/11/2025

; Create a College Enrollment Form. Get user input. Display a summary 
; of the inputs. Include the necessary documentation as comments in 
; your code.
; Expected Output:

; Cebu Institute of Technology – University
; STUDENT ENROLLMENT FORM
; Please enter the following information:
; Student ID Number: 1111
; First Name: Jose
; Middle Name: Protacio
; Last Name: Rizal
; Address: 171-A D. Jakosalem Street, Brgy. Tejero, Cebu City, Cebu, 
; Philippines
; Course: BSCS
; Year: 1
; Birthday Month: September
; Birthday Day: 7
; Birthday Year: 2003
; Email Address: jose.rizal@cit.edu
; SUMMARY
; Please check if all pieces of information are correct.
; ID Number: 1111
; Full Name: Rizal, Jose Protacio
; Address: 171-A D. Jakosalem Street, Brgy. Tejero, Cebu City, Cebu, Philippines
; Course & Year: BSCS 1
; Birthday: September 7, 2003
; Email Address: jose.rizal@cit.edu
; Thank you for enrolling at CIT-U.
; Copyright 2024
; Programmer: YOUR FULL NAME HERE


; Filename: CollegeEnrollmentForm.asm
; Programmer: YOUR FULL NAME HERE
; Date: 9/11/2025
; Description: College Enrollment Form
; Prompts user to input enrollment details and displays a summary.

.MODEL small
.STACK 100h
.DATA
    MAXLEN EQU 60
    bufferSize EQU MAXLEN + 2  ; buffer space for input + CR LF

    ; Title and instructions
    title1      db 'Cebu Institute of Technology – University', 13,10, '$'
    title2      db 'STUDENT ENROLLMENT FORM', 13,10, '$'
    promptInfo  db 'Please enter the following information:', 13,10, '$'

    ; Prompts
    promptID       db 'Student ID Number: $'
    promptFirst    db 'First Name: $'
    promptMiddle   db 'Middle Name: $'
    promptLast     db 'Last Name: $'
    promptAddress  db 'Address: $'
    promptCourse   db 'Course: $'
    promptYear     db 'Year: $'
    promptMonth    db 'Birthday Month: $'
    promptDay      db 'Birthday Day: $'
    promptYearB    db 'Birthday Year: $'
    promptEmail    db 'Email Address: $'

    ; Summary headers and labels
    summaryTitle   db 13,10,'SUMMARY', 13,10, '$'
    summaryCheck   db 'Please check if all pieces of information are correct.', 13,10, '$'
    labelID        db 'ID Number: $'
    labelFullName  db 'Full Name: $'
    labelAddress   db 'Address: $'
    labelCourseYr  db 'Course & Year: $'
    labelBirthday  db 'Birthday: $'
    labelEmail     db 'Email Address: $'
    thankYou       db 13,10, 'Thank you for enrolling at CIT-U.', 13,10, '$'
    copyrightMsg   db 'Copyright 2024', 13,10, '$'
    programmerMsg  db 'Programmer: GooberXD', 13,10, '$'

    spaceStr       db ' $'
    commaSpace     db ', $'

    ; Input buffers
    studentID    db bufferSize dup (?)
    firstName    db bufferSize dup (?)
    middleName   db bufferSize dup (?)
    lastName     db bufferSize dup (?)
    address      db bufferSize dup (?)
    course       db bufferSize dup (?)
    year         db bufferSize dup (?)
    birthMonth   db bufferSize dup (?)
    birthDay     db bufferSize dup (?)
    birthYear    db bufferSize dup (?)
    email        db bufferSize dup (?)

.CODE
ProgramStart:
    mov ax, @data
    mov ds, ax

    ; Print Titles
    mov dx, OFFSET title1
    call PrintString
    mov dx, OFFSET title2
    call PrintString
    mov dx, OFFSET promptInfo
    call PrintString

    ; Input Student ID Number
    mov dx, OFFSET promptID
    call PrintString
    mov dx, OFFSET studentID
    mov cx, MAXLEN
    call ReadString

    ; Input First Name
    mov dx, OFFSET promptFirst
    call PrintString
    mov dx, OFFSET firstName
    mov cx, MAXLEN
    call ReadString

    ; Input Middle Name
    mov dx, OFFSET promptMiddle
    call PrintString
    mov dx, OFFSET middleName
    mov cx, MAXLEN
    call ReadString

    ; Input Last Name
    mov dx, OFFSET promptLast
    call PrintString
    mov dx, OFFSET lastName
    mov cx, MAXLEN
    call ReadString

    ; Input Address
    mov dx, OFFSET promptAddress
    call PrintString
    mov dx, OFFSET address
    mov cx, MAXLEN
    call ReadString

    ; Input Course
    mov dx, OFFSET promptCourse
    call PrintString
    mov dx, OFFSET course
    mov cx, MAXLEN
    call ReadString

    ; Input Year
    mov dx, OFFSET promptYear
    call PrintString
    mov dx, OFFSET year
    mov cx, MAXLEN
    call ReadString

    ; Input Birthday Month
    mov dx, OFFSET promptMonth
    call PrintString
    mov dx, OFFSET birthMonth
    mov cx, MAXLEN
    call ReadString

    ; Input Birthday Day
    mov dx, OFFSET promptDay
    call PrintString
    mov dx, OFFSET birthDay
    mov cx, MAXLEN
    call ReadString

    ; Input Birthday Year
    mov dx, OFFSET promptYearB
    call PrintString
    mov dx, OFFSET birthYear
    mov cx, MAXLEN
    call ReadString

    ; Input Email
    mov dx, OFFSET promptEmail
    call PrintString
    mov dx, OFFSET email
    mov cx, MAXLEN
    call ReadString

    ; Print Summary Title and Check Message
    mov dx, OFFSET summaryTitle
    call PrintString
    mov dx, OFFSET summaryCheck
    call PrintString

    ; Print ID Number:
    mov dx, OFFSET labelID
    call PrintString
    mov dx, OFFSET studentID
    call PrintStringClean

    ; Newline after ID Number
    call PrintNewLine

    ; Print Full Name in format: LastName, FirstName MiddleName
    mov dx, OFFSET labelFullName
    call PrintString

    mov dx, OFFSET lastName
    call PrintStringClean

    mov dx, OFFSET commaSpace  ; print comma + space
    call PrintString

    mov dx, OFFSET firstName
    call PrintStringClean

    mov dx, OFFSET spaceStr    ; print space
    call PrintString

    mov dx, OFFSET middleName
    call PrintStringClean

    call PrintNewLine

    ; Print Address
    mov dx, OFFSET labelAddress
    call PrintString
    mov dx, OFFSET address
    call PrintStringClean
    call PrintNewLine

    ; Print Course & Year
    mov dx, OFFSET labelCourseYr
    call PrintString
    mov dx, OFFSET course
    call PrintStringClean

    mov dx, OFFSET spaceStr
    call PrintString

    mov dx, OFFSET year
    call PrintStringClean
    call PrintNewLine

    ; Print Birthday in format Month Day, Year
    mov dx, OFFSET labelBirthday
    call PrintString

    mov dx, OFFSET birthMonth
    call PrintStringClean

    mov dl, ' '
    mov ah, 02h
    int 21h

    mov dx, OFFSET birthDay
    call PrintStringClean

    mov dl, ','
    mov ah, 02h
    int 21h

    mov dl, ' '
    mov ah, 02h
    int 21h

    mov dx, OFFSET birthYear
    call PrintStringClean
    call PrintNewLine

    ; Print Email Address
    mov dx, OFFSET labelEmail
    call PrintString
    mov dx, OFFSET email
    call PrintStringClean
    call PrintNewLine

    ; Print Thank You and copyright messages
    mov dx, OFFSET thankYou
    call PrintString

    mov dx, OFFSET copyrightMsg
    call PrintString

    mov dx, OFFSET programmerMsg
    call PrintString

    ; Exit program
    mov ah, 4Ch
    int 21h

;-----------------------------------
; Subroutine: PrintString
; Prints $-terminated string at DS:DX
PrintString PROC
    mov ah, 09h
    int 21h
    ret
PrintString ENDP

;-----------------------------------
; Subroutine: ReadString
; Reads string from standard input to DS:DX buffer
; CX = max number of characters to read (excluding CR,LF)
; This subroutine replaces CR and LF with '$' to terminate string
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

    mov di, si
    add di, cx
    mov [di], al      ; Replace CR with '$'

    dec di
    mov [di], al      ; Replace LF with '$'

    pop dx
    pop cx
    pop bx
    pop ax
    ret
ReadString ENDP

;-----------------------------------
; Subroutine: PrintStringClean
; Prints string until '$' terminator
PrintStringClean PROC
    mov ah, 09h
    int 21h
    ret
PrintStringClean ENDP

;-----------------------------------
; Subroutine: PrintNewLine
; Prints carriage return and line feed
PrintNewLine PROC
    mov dl, 13
    mov ah, 02h
    int 21h
    mov dl, 10
    mov ah, 02h
    int 21h
    ret
PrintNewLine ENDP

END ProgramStart
