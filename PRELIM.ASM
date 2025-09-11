; Filename: PRELIM.ASM
; Date: September 4, 2025
; LAB PRELIM EXAM ACTIVITY

; Create the USER INTERFACE as shown below using Assembly Language.
; Follow as much as possible the layout of the user interface. 
; You may use colors closer to the ones shown below (examples: shade of blue, shade of red).
; You have 2 hours to finish this task.

.model medium
.stack 100h
.data
 
;testest
TESTer db "Welcome $"
testtit db "bruh $"
 
; email
EnterDet db "Please enter your details$"
WelcomeBack db "Welcome back$"
email db " Email Address$"
password db " Password$"
thirty db "  Remember for 30 days$"
forgor db "                            Forgot Password$"
LINE db "-----------------------------------$"
; mov ah, 0Eh         ; BIOS teletype function
; mov al, 218         ; '┌' in code page 437
; int 10h

; mov ah, 0Eh         ; BIOS teletype function
; mov al, 191         ; '┐' in code page 437
; int 10h

; mov ah, 0Eh         ; BIOS teletype function
; mov al, 192         ; '└' in code page 437
; int 10h

; mov ah, 0Eh         ; BIOS teletype function
; mov al, 217         ; '┘' in code page 437
; int 10h

; Signup
signUp db "Sign Up$"
signUpGoogle db "Sign Up with Google$"
nameauth db "Created by: Goober$"
noACC db "Don't have an account?  Sign Up$"
 
 
.code
__PRINT_CALL MACRO count, color, ascii
    mov cx, count         
    mov bl, color        
    mov dl, ascii        
    xor ax, ax
    mov al, dl
    push ax            
    xor ax, ax
    mov al, bl
    push ax            
    push cx           
    call print_repeated_char
ENDM
 
__LN_CURSOR MACRO
   
    inc dh
    mov dl, 0
    mov bh, 0
    mov ah, 02h       
    int 10h
ENDM
 
__SET_CURSOR MACRO row, col
    mov dh, row
    mov dl, col
    mov bh, 0           
    mov ah, 02h         
    int 10h
ENDM
 
__PRINT_ONLY_BG MACRO rep, color
    mov ah, 09h
    mov bh, 0
    mov cx, rep
    mov al, ' '
    mov bl, color
    int 10h
ENDM
 
print_repeated_char PROC
    push bp
    mov bp, sp
 
    mov cx, [bp+4]      
    mov bl, byte ptr [bp+6] 
    mov bl, byte ptr [bp+6]
    __PRINT_ONLY_BG [bp+4], bl
 
    mov cx, [bp+4]      
    print_loop:
        mov ah, 02h
        mov dl, byte ptr [bp+8]
        int 21h
 
    loop print_loop
 
    pop bp
    ret 4              
print_repeated_char ENDP
 
__SET_WHOLE_BG MACRO color
    __SET_CURSOR 0,0
   
    mov cx, 25      
    go_nxcol:
        push cx
            __PRINT_ONLY_BG 80, color
        pop cx
        __LN_CURSOR
    loop go_nxcol
ENDM
                                          
;main START
start:
 
mov ax, @data
mov ds, ax
 
__SET_WHOLE_BG 70h
;border
__SET_CURSOR 0, 0
__PRINT_ONLY_BG 80, 44h
__SET_CURSOR 1, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 2, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 3, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 4, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 5, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 6, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 7, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 8, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 9, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 10, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 11, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 12, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 13, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 14, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 15, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 16, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 17, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 18, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 19, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 20, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 21, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 22, 0
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 1, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 2, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 3, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 4, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 5, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 6, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 7, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 8, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 9, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 10, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 11, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 12, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 13, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 14, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 15, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 16, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 17, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 18, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 19, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 20, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 21, 79
__PRINT_ONLY_BG 1, 44h
__SET_CURSOR 22, 79
__PRINT_ONLY_BG 1, 44h


;starter area
__SET_CURSOR 3, 3
mov ah, 09h 
mov dx, OFFSET EnterDet
int 21h
 
__SET_CURSOR 4, 3
mov ah, 09h 
mov dx, OFFSET WelcomeBack
int 21h


;;email area
__SET_CURSOR 5, 3
mov ah, 0Eh         ; BIOS teletype function
mov al, 218         ; '┌' in code page 437
int 10h
mov ah, 09h 
mov dx, OFFSET LINE
int 21h
mov ah, 0Eh         ; BIOS teletype function
mov al, 191         ; '┐' in code page 437
int 10h

 
__SET_CURSOR 6, 3

mov ah, 0Eh         ; BIOS teletype function
mov al, 179         ; '|' in code page 437
int 10h

mov ah, 09h 
mov dx, OFFSET email
int 21h

__SET_CURSOR 6, 39

mov ah, 0Eh         ; BIOS teletype function
mov al, 179         ; '|' in code page 437
int 10h

__SET_CURSOR 7, 3
mov ah, 0Eh         ; BIOS teletype function
mov al, 192         ; '└' in code page 437
int 10h

mov ah, 09h 
mov dx, OFFSET LINE
int 21h

mov ah, 0Eh         ; BIOS teletype function
mov al, 217         ; '┘' in code page 437
int 10h


;;password area
__SET_CURSOR 8, 3
mov ah, 0Eh         ; BIOS teletype function
mov al, 218         ; '┌' in code page 437
int 10h
mov ah, 09h 
mov dx, OFFSET LINE
int 21h

mov ah, 0Eh         ; BIOS teletype function
mov al, 191         ; '┐' in code page 437
int 10h
 
__SET_CURSOR 9, 3

mov ah, 0Eh         ; BIOS teletype function
mov al, 179         ; '|' in code page 437
int 10h

mov ah, 09h 
mov dx, OFFSET password
int 21h

__SET_CURSOR 9, 39

mov ah, 0Eh         ; BIOS teletype function
mov al, 179         ; '|' in code page 437
int 10h

__SET_CURSOR 10, 3
mov ah, 0Eh         ; BIOS teletype function
mov al, 192         ; '└' in code page 437
int 10h

mov ah, 09h 
mov dx, OFFSET LINE
int 21h

mov ah, 0Eh         ; BIOS teletype function
mov al, 217         ; '┘' in code page 437
int 10h

;;remember section

 __SET_CURSOR 13, 3
__PRINT_ONLY_BG 1, 88h
mov ah, 09h 
mov dx, OFFSET thirty
int 21h
mov ah, 09h 
mov dx, OFFSET forgor
int 21h

 
;sign up section area
__SET_CURSOR 15, 33
mov ah, 02h
mov dl, '['
int 21h
mov ah, 02h
mov dl, ' '
int 21h
 
mov ah, 09h ; prints og signup
mov dx, OFFSET signUp
int 21h
mov ah, 02h
mov dl, ' '
int 21h
mov ah, 02h
mov dl, ']'
int 21h

__SET_CURSOR 16, 27
mov ah, 02h
mov dl, '['
int 21h
mov ah, 02h
mov dl, ' '
int 21h
 
mov ah, 09h ; prints google sign
mov dx, OFFSET signUpGoogle

int 21h
mov ah, 02h
mov dl, ' '
int 21h
mov ah, 02h
mov dl, ']'
int 21h

__SET_CURSOR 18, 23
mov ah, 09h ; prints no acc?
mov dx, OFFSET noACC
int 21h



;; name
__SET_CURSOR 22, 4
mov ah, 09h 
mov dx, OFFSET nameauth
int 21h

__SET_CURSOR 23, 0
__PRINT_ONLY_BG 80, 44h

int 27h
 
end start
