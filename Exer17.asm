; Filename: EXER17.ASM
; Date: 9/11/2025
; Description: This assembly language program will continuously get 
; character input and display back input until Enter key is pressed.
.MODEL small
.STACK 200h
.DATA
.CODE
ProgramStart:
EchoLoop:
    mov ah, 1          ; DOS keyboard input function
    int 21h            ; get the next key

    cmp al, 13         ; was the key the Enter key?
    jz EchoDone        ; yes, so exit

    mov cx, 5          ; set counter to 5 for printing, changing the number changes the amount of time it is echoed, 
                       ; echoed is always number + 1 
                       ; eg, 5 results to 6

PrintCharLoop:
    mov dl, al         ; put the character into DL
    mov ah, 2          ; DOS display output function
    int 21h            ; display the character

    loop PrintCharLoop ; decrement cx and loop if cx != 0

    jmp EchoLoop       ; get next character

EchoDone:
    mov ah, 4ch        ; DOS terminate program function
    int 21h            ; terminate the program

END ProgramStart
; this version echoes 5 times

; original code
; .MODEL small
; .STACK 200h
; .DATA
; .CODE
; ProgramStart:
;  EchoLoop:
;  mov ah,1 ; DOS keyboard input function
;  int 21h ; get the next key

;  cmp al,13 ; was the key the Enter key?
;  jz EchoDone ; yes, so we're done echoing
;  mov dl,al ; put the character into DL
;  mov ah,2 ; DOS display output function
;  int 21h ; display the character
;  jmp EchoLoop ; echo the next character
;  EchoDone:
;  mov ah,4ch ; DOS terminate program function
;  int 21h ; terminate the program
 
; END ProgramStart