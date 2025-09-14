
; Filename: EXER26.ASM
; Date: 9/14/2025

; Create an Assembly Language program based on the sample output below. 
; Before the form displays, ask the user to input all the needed data
; as shown on the summary form. Afterwards, display the form with all 
; the data entered by the user.


putc MACRO char
    mov ah, 02h
    mov dl, char
    int 21h
ENDM
renderc MACRO char, page, color, write
    mov ah, 09h 
    mov al, char
    mov bh, page
    mov bl, color
    mov cx, write
    int 10h
ENDM
setcursor MACRO row, col
    mov ah, 02h
    mov bh, 00h
    mov dh, row
    mov dl, col
    int 10h
ENDM
colorz MACRO color, write
    mov ah, 09h 
    mov bl, color
    mov cx, write
    int 10h
ENDM
.model small
.data
	txt_0_R1_C25 db "CEBU INSTITURE OF TECHNOLOGY",'$'
	txt_1_R2_C23 db "VEHICLE STICKER APLLICATION FORM",'$'
	txt_2_R3_C27 db "PLEASE FILL OUT THE FORM BELOW",'$'
	txt_3_R6_C6 db "PERSONAL TYPE:",'$'
	txt_4_R6_C44 db "VEHICLE TYPE:",'$'
	txt_5_R8_C6 db "NAME OF APPLICANT:",'$'
	txt_6_R8_C44 db "ID NUMBER: ",'$'
	txt_7_R10_C6 db "MOBILE NUMBER:",'$'
	txt_8_R10_C44 db "ADDRESS:",'$'
	txt_9_R12_C6 db "VEHICLE NUMBER:",'$'
	txt_10_R12_C44 db "PLATE NUMBER:",'$'
	txt_11_R14_C6 db "VEHICLE COLOR:",'$'
	txt_12_R14_C44 db "VEHICLE TYPE:",'$'
	txt_13_R20_C21 db "COPYRIGHT 2025 BY GOOB GEEB GEEBEROOO",'$'
	txt_14_R22_C32 db "THANK YOU!",'$'

    MAXLEN EQU 60

    ; Title and instructions
    title1      db 'Cebu Institute of Technology - University', 13,10, '$'
    title2      db 'VEHICLE STICKER APPLICATION FORM', 13,10, '$'
    promptInfo  db 'Please fill out the form below.', 13,10, '$'

    ; Prompts
    promptPersonnel db 'Personnel Type: $'
    promptSticker   db 'Vehicle Sticker Type: $'
    promptName      db 'Name of Applicant/Driver: $'
    promptID        db 'ID Number: $'
    promptMobile    db 'Mobile Number: $'
    promptAddress   db 'Address: $'
    promptBrand     db 'Vehicle Make/Brand: $'
    promptPlate     db 'Plate Number: $'
    promptColor     db 'Vehicle Color: $'
    promptType      db 'Vehicle Type: $'

    ; Input buffers: DOS 0Ah format [maxLen][len][data...]
    personnelType db MAXLEN, 0, MAXLEN dup(?)
    stickerType   db MAXLEN, 0, MAXLEN dup(?)
    applicantName db MAXLEN, 0, MAXLEN dup(?)
    idNumber      db MAXLEN, 0, MAXLEN dup(?)
    mobileNumber  db MAXLEN, 0, MAXLEN dup(?)
    address       db MAXLEN, 0, MAXLEN dup(?)
    vehicleBrand  db MAXLEN, 0, MAXLEN dup(?)
    plateNumber   db MAXLEN, 0, MAXLEN dup(?)
    vehicleColor  db MAXLEN, 0, MAXLEN dup(?)
    vehicleType   db MAXLEN, 0, MAXLEN dup(?)
.code

.stack 100h
start :
    mov ax, @data
    mov ds, ax

	; Print Titles
    mov dx, OFFSET title1
    call PrintString
    mov dx, OFFSET title2
    call PrintString
    mov dx, OFFSET promptInfo
    call PrintString

    ; Input Personnel Type
    mov dx, OFFSET promptPersonnel
    call PrintString
    mov dx, OFFSET personnelType
    call ReadString

    ; Input Sticker Type
    mov dx, OFFSET promptSticker
    call PrintString
    mov dx, OFFSET stickerType
    call ReadString

    ; Input Name
    mov dx, OFFSET promptName
    call PrintString
    mov dx, OFFSET applicantName
    call ReadString

    ; Input ID Number
    mov dx, OFFSET promptID
    call PrintString
    mov dx, OFFSET idNumber
    call ReadString

    ; Input Mobile Number
    mov dx, OFFSET promptMobile
    call PrintString
    mov dx, OFFSET mobileNumber
    call ReadString

    ; Input Address
    mov dx, OFFSET promptAddress
    call PrintString
    mov dx, OFFSET address
    call ReadString

    ; Input Vehicle Brand
    mov dx, OFFSET promptBrand
    call PrintString
    mov dx, OFFSET vehicleBrand
    call ReadString

    ; Input Plate Number
    mov dx, OFFSET promptPlate
    call PrintString
    mov dx, OFFSET plateNumber
    call ReadString

    ; Input Vehicle Color
    mov dx, OFFSET promptColor
    call PrintString
    mov dx, OFFSET vehicleColor
    call ReadString

    ; Input Vehicle Type
    mov dx, OFFSET promptType
    call PrintString
    mov dx, OFFSET vehicleType
    call ReadString


    ; Set to video mode 
    mov ah, 00h
    mov al, 03h ; 80x25 color text mode
    int 10h


	setcursor 0, 0
	renderc 32, 0, 0fh, 80

	setcursor 1, 0
	renderc 32, 0, 0fh, 1

	setcursor 1, 1
	renderc 32, 0, 7fh, 1

	setcursor 1, 2
	renderc 32, 0, 4fh, 23

	setcursor 1, 25
	colorz 79, 500
	mov ah, 09h
	mov dx, offset txt_0_R1_C25
	int 21h

	

	setcursor 1, 53
	renderc 32, 0, 4fh, 25

	setcursor 1, 78
	renderc 32, 0, 7fh, 1

	setcursor 1, 79
	renderc 32, 0, 0fh, 1

	setcursor 2, 0
	renderc 32, 0, 0fh, 1

	setcursor 2, 1
	renderc 32, 0, 7fh, 1

	setcursor 2, 2
	renderc 32, 0, 4fh, 21

	setcursor 2, 23
	colorz 79, 32
	mov ah, 09h
	mov dx, offset txt_1_R2_C23
	int 21h

	setcursor 2, 55
	renderc 32, 0, 4fh, 23

	setcursor 2, 78
	renderc 32, 0, 7fh, 1

	setcursor 2, 79
	renderc 32, 0, 0fh, 1

	setcursor 3, 0
	renderc 32, 0, 0fh, 1

	setcursor 3, 1
	renderc 32, 0, 7fh, 1

	setcursor 3, 2
	renderc 32, 0, 4fh, 25

	setcursor 3, 24
	colorz 70, 30
	mov ah, 09h
	mov dx, offset txt_2_R3_C27
	int 21h

	setcursor 3, 57
	renderc 32, 0, 4fh, 21

	setcursor 3, 78
	renderc 32, 0, 7fh, 1

	setcursor 3, 79
	renderc 32, 0, 0fh, 1

	setcursor 4, 0
	renderc 32, 0, 0fh, 1

	setcursor 4, 1
	renderc 32, 0, 7fh, 78

	setcursor 4, 79
	renderc 32, 0, 0fh, 1

	setcursor 5, 0
	renderc 32, 0, 0fh, 1

	setcursor 5, 1
	renderc 32, 0, 7fh, 78

	setcursor 5, 79
	renderc 32, 0, 0fh, 1

	setcursor 6, 0
	renderc 32, 0, 0fh, 1

	setcursor 6, 1
	renderc 32, 0, 7fh, 5

	setcursor 6, 6
	colorz 112, 500
	mov ah, 09h
	mov dx, offset txt_3_R6_C6
	int 21h

	setcursor 6, 20
	renderc 32, 0, 7fh, 24

	setcursor 6, 21
    mov dx, OFFSET personnelType+2
    call PrintStringClean

	setcursor 6, 44
	colorz 112, 13
	mov ah, 09h
	mov dx, offset txt_4_R6_C44
	int 21h

	

	setcursor 6, 57
	renderc 32, 0, 7fh, 22

	setcursor 6,58
    mov dx, OFFSET vehicleType+2
    call PrintStringClean

	setcursor 6, 79
	renderc 32, 0, 0fh, 1

	setcursor 7, 0
	renderc 32, 0, 0fh, 1

	setcursor 7, 1
	renderc 32, 0, 7fh, 78

	setcursor 7, 79
	renderc 32, 0, 0fh, 1

	setcursor 8, 0
	renderc 32, 0, 0fh, 1

	setcursor 8, 1
	renderc 32, 0, 7fh, 5

	setcursor 8, 6
	colorz 112, 200
	mov ah, 09h
	mov dx, offset txt_5_R8_C6
	int 21h

	setcursor 8, 24
	renderc 32, 0, 7fh, 20

	setcursor 8, 44
	colorz 112, 200
	mov ah, 09h
	mov dx, offset txt_6_R8_C44
	int 21h
	
	setcursor 8, 25
    mov dx, OFFSET applicantName+2
    call PrintStringClean


	setcursor 8, 55
	renderc 32, 0, 7fh, 24
	
	setcursor 8,55
    mov dx, OFFSET idNumber+2
    call PrintStringClean

	setcursor 8, 79
	renderc 32, 0, 0fh, 1

	setcursor 9, 0
	renderc 32, 0, 0fh, 1

	setcursor 9, 1
	renderc 32, 0, 7fh, 78

	setcursor 9, 79
	renderc 32, 0, 0fh, 1

	setcursor 10, 0
	renderc 32, 0, 0fh, 1

	setcursor 10, 1
	renderc 32, 0, 7fh, 5

	setcursor 10, 6
	colorz 112, 14
	mov ah, 09h
	mov dx, offset txt_7_R10_C6
	int 21h

	setcursor 10, 20
	renderc 32, 0, 7fh, 24

	setcursor 10, 44
	colorz 112, 8
	mov ah, 09h
	mov dx, offset txt_8_R10_C44
	int 21h

	setcursor 10, 52
	renderc 32, 0, 7fh, 27

	setcursor 10, 79
	renderc 32, 0, 0fh, 1

    setcursor 10,21
    mov dx, OFFSET mobileNumber+2
    call PrintStringClean

    setcursor 10,53
    mov dx, OFFSET address+2
    call PrintStringClean

	setcursor 11, 0
	renderc 32, 0, 0fh, 1

	setcursor 11, 1
	renderc 32, 0, 7fh, 78

	setcursor 11, 79
	renderc 32, 0, 0fh, 1

	setcursor 12, 0
	renderc 32, 0, 0fh, 1

	setcursor 12, 1
	renderc 32, 0, 7fh, 5

	setcursor 12, 6
	colorz 112, 15
	mov ah, 09h
	mov dx, offset txt_9_R12_C6
	int 21h

	setcursor 12, 21
	renderc 32, 0, 7fh, 23

	setcursor 12, 44
	colorz 112, 13
	mov ah, 09h
	mov dx, offset txt_10_R12_C44
	int 21h

	setcursor 12, 57
	renderc 32, 0, 7fh, 22

	setcursor 12, 79
	renderc 32, 0, 0fh, 1

    setcursor 12,22
    mov dx, OFFSET vehicleBrand+2
    call PrintStringClean

    setcursor 12,58
    mov dx, OFFSET plateNumber+2
    call PrintStringClean

	setcursor 13, 0
	renderc 32, 0, 0fh, 1

	setcursor 13, 1
	renderc 32, 0, 7fh, 78

	setcursor 13, 79
	renderc 32, 0, 0fh, 1

	setcursor 14, 0
	renderc 32, 0, 0fh, 1

	setcursor 14, 1
	renderc 32, 0, 7fh, 5

	setcursor 14, 6
	colorz 112, 50
	mov ah, 09h
	mov dx, offset txt_11_R14_C6
	int 21h

	setcursor 14, 20
	renderc 32, 0, 7fh, 24

	setcursor 14, 44
	colorz 112, 13
	mov ah, 09h
	mov dx, offset txt_12_R14_C44
	int 21h

	setcursor 14, 57
	renderc 32, 0, 7fh, 22

	setcursor 14, 79
	renderc 32, 0, 0fh, 1

    setcursor 14,21
    mov dx, OFFSET vehicleColor+2
    call PrintStringClean

    setcursor 14,58
    mov dx, OFFSET vehicleType+2
    call PrintStringClean

	setcursor 15, 0
	renderc 32, 0, 0fh, 1

	setcursor 15, 1
	renderc 32, 0, 7fh, 78

	setcursor 15, 79
	renderc 32, 0, 0fh, 1

	setcursor 16, 0
	renderc 32, 0, 0fh, 1

	setcursor 16, 1
	renderc 32, 0, 7fh, 78

	setcursor 16, 79
	renderc 32, 0, 0fh, 1

	setcursor 17, 0
	renderc 32, 0, 0fh, 1

	setcursor 17, 1
	renderc 32, 0, 7fh, 78

	setcursor 17, 79
	renderc 32, 0, 0fh, 1

	setcursor 18, 0
	renderc 32, 0, 0fh, 1

	setcursor 18, 1
	renderc 32, 0, 7fh, 78

	setcursor 18, 79
	renderc 32, 0, 0fh, 1

	setcursor 19, 0
	renderc 32, 0, 0fh, 1

	setcursor 19, 1
	renderc 32, 0, 7fh, 78

	setcursor 19, 79
	renderc 32, 0, 0fh, 1

	setcursor 20, 0
	renderc 32, 0, 0fh, 1

	setcursor 20, 1
	renderc 32, 0, 7fh, 20

	setcursor 20, 21
	colorz 127, 37
	mov ah, 09h
	mov dx, offset txt_13_R20_C21
	int 21h

	setcursor 20, 58
	renderc 32, 0, 7fh, 21

	setcursor 20, 79
	renderc 32, 0, 0fh, 1

	setcursor 21, 0
	renderc 32, 0, 0fh, 80

	setcursor 22, 0
	renderc 32, 0, 0fh, 32

	setcursor 22, 32
	colorz 6, 10
	mov ah, 09h
	mov dx, offset txt_14_R22_C32
	int 21h

	setcursor 22, 42
	renderc 32, 0, 0fh, 38

	setcursor 23, 0
	renderc 32, 0, 0fh, 80

    mov ah, 4Ch      ; DOS exit function
    mov al, 0        ; Return code 0
    int 21h          ; Call DOS interrupt

;-----------------------------------
; Subroutine: PrintString
PrintString PROC
    mov ah, 09h
    int 21h
    ret
PrintString ENDP

;-----------------------------------
; Subroutine: ReadString
; DX -> buffer in 0Ah format: [maxLen][len][data...]
ReadString PROC
    push ax
    push dx
    push si
    push di
    push cx

    mov ah, 0Ah
    int 21h                ; DOS buffered input

    mov si, dx
    mov cl, [si+1]         ; CL = number of chars entered
    mov ch, 0
    add si, 2              ; SI -> start of data
    mov di, si
    add di, cx             ; DI -> position after last char
    mov byte ptr [di], '$' ; add $ terminator

    pop cx
    pop di
    pop si
    pop dx
    pop ax
    ret
ReadString ENDP

;-----------------------------------
; Subroutine: PrintStringClean
PrintStringClean PROC
    mov ah, 09h
    int 21h
    ret
PrintStringClean ENDP

;-----------------------------------
; Subroutine: PrintNewLine
PrintNewLine PROC
    mov dl, 13
    mov ah, 02h
    int 21h
    mov dl, 10
    mov ah, 02h
    int 21h
    ret
PrintNewLine ENDP

end start ; end program



;; fuck this language - J




