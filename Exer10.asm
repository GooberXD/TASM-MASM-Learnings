; Filename: Exer9.asm
; Displaying characters:

;create yellow duck
; Date: August 28, 2025


putc MACRO char
    mov ah, 02h
    mov dl, char
    int 21h
ENDM
renderc MACRO char, page, color, write
    mov ah, 09h 
    mov al, char ; character to write
    mov bh, page ; page number
    mov bl, color
    mov cx, write; how many times to write
    int 10h
ENDM
setcursor MACRO row, col
    mov ah, 02h
    mov bh, 00h
    mov dh, row
    mov dl, col
    int 10h
ENDM

.model small
.code
.stack 100h
start :
    ; Set to video mode 
    mov ah, 00h
    mov al, 03h
    int 10h


	setcursor 1, 8
	renderc 20h, 0, 6fh, 8

	setcursor 2, 6
	renderc 20h, 0, 6fh, 12

	setcursor 3, 6
	renderc 20h, 0, 4fh, 2

	setcursor 3, 8
	renderc 20h, 0, 6fh, 2

	setcursor 3, 10
	renderc 20h, 0, 7fh, 2

	setcursor 3, 12
	renderc 20h, 0, 6fh, 6

	setcursor 4, 2
	renderc 20h, 0, 4fh, 6

	setcursor 4, 8
	renderc 20h, 0, 6fh, 10

	setcursor 5, 4
	renderc 20h, 0, 4fh, 6

	setcursor 5, 10
	renderc 20h, 0, 6fh, 6

	setcursor 6, 8
	renderc 20h, 0, 6fh, 6

	setcursor 7, 6
	renderc 20h, 0, 6fh, 6

	setcursor 7, 14
	renderc 20h, 0, 6fh, 6

	setcursor 7, 22
	renderc 20h, 0, 6fh, 2

	setcursor 8, 4
	renderc 20h, 0, 6fh, 16

	setcursor 8, 20
	renderc 20h, 0, 0h, 2

	setcursor 8, 22
	renderc 20h, 0, 6fh, 2

	setcursor 9, 2
	renderc 20h, 0, 6fh, 8

	setcursor 9, 10
	renderc 20h, 0, 0h, 2

	setcursor 9, 12
	renderc 20h, 0, 6fh, 6

	setcursor 9, 18
	renderc 20h, 0, 0h, 2

	setcursor 9, 20
	renderc 20h, 0, 6fh, 4

	setcursor 10, 2
	renderc 20h, 0, 6fh, 10

	setcursor 10, 12
	renderc 20h, 0, 0h, 6

	setcursor 10, 18
	renderc 20h, 0, 6fh, 6

	setcursor 11, 2
	renderc 20h, 0, 6fh, 22

	setcursor 12, 4
	renderc 20h, 0, 6fh, 18

	setcursor 13, 6
	renderc 20h, 0, 6fh, 14

	setcursor 1, 8
	renderc 20h, 0, 6fh, 8

	setcursor 2, 6
	renderc 20h, 0, 6fh, 12

	setcursor 3, 6
	renderc 20h, 0, 4fh, 2

	setcursor 3, 8
	renderc 20h, 0, 6fh, 2

	setcursor 3, 10
	renderc 20h, 0, 7fh, 2

	setcursor 3, 12
	renderc 20h, 0, 6fh, 6

	setcursor 4, 2
	renderc 20h, 0, 4fh, 6

	setcursor 4, 8
	renderc 20h, 0, 6fh, 10

	setcursor 5, 4
	renderc 20h, 0, 4fh, 6

	setcursor 5, 10
	renderc 20h, 0, 6fh, 6

	setcursor 6, 8
	renderc 20h, 0, 6fh, 6

	setcursor 7, 6
	renderc 20h, 0, 6fh, 6

	setcursor 7, 14
	renderc 20h, 0, 6fh, 6

	setcursor 7, 22
	renderc 20h, 0, 6fh, 2

	setcursor 8, 4
	renderc 20h, 0, 6fh, 16

	setcursor 8, 20
	renderc 20h, 0, 0h, 2

	setcursor 8, 22
	renderc 20h, 0, 6fh, 2

	setcursor 9, 2
	renderc 20h, 0, 6fh, 8

	setcursor 9, 10
	renderc 20h, 0, 0h, 2

	setcursor 9, 12
	renderc 20h, 0, 6fh, 6

	setcursor 9, 18
	renderc 20h, 0, 0h, 2

	setcursor 9, 20
	renderc 20h, 0, 6fh, 4

	setcursor 10, 2
	renderc 20h, 0, 6fh, 10

	setcursor 10, 12
	renderc 20h, 0, 0h, 6

	setcursor 10, 18
	renderc 20h, 0, 6fh, 6

	setcursor 11, 2
	renderc 20h, 0, 6fh, 22

	setcursor 12, 4
	renderc 20h, 0, 6fh, 18

	setcursor 13, 6
	renderc 20h, 0, 6fh, 14

    mov ah, 4Ch      ; DOS exit function
    mov al, 0        ; Return code 0
    int 21h          ; Call DOS interrupt
end start ; end program

