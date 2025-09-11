; Filename: EXER18.ASM
; Date: 9/11/2025
; Description: This assembly language program will get character input and 
; and determine if input is 'y' or 'Y' to display good morning message
; else display good afternoon message.

; original code
; .MODEL small
; .STACK 100h
; .DATA
;  TimePrompt DB 'Is it after 12 noon (Y/N)?$'
;  GoodMorningMessage LABEL BYTE 
;  DB 13,10,'Good morning, world!',13,10,'$'
;  GoodAfternoonMessage LABEL BYTE 
;  DB 13,10,'Good afternoon, world!',13,10,'$'
; .CODE
; ProgramStart:

;  mov ax,@data
;  mov ds,ax ; set DS to point to data segment
;  mov dx,OFFSET TimePrompt ; point to the time prompt
;  mov ah,9 ; DOS print string function
;  int 21h ; display time prompt
;  mov ah,1 ; DOS get character function
;  int 21h ; get single character response
;  cmp al,'y' ; typed lowercase ‘y’ for after noon?
;  jz IsAfternoon ; jz = jump if zero. Yes, it’s afternoon
;  cmp al,'Y' ; typed uppercase ‘Y’ for afternoon?
;  jnz IsMorning ; no, it’s before noon
; IsAfternoon:
;  mov dx,OFFSET GoodAfternoonMessage ; point to the afternoon greeting
;  jmp DisplayGreeting ; point to the afternoon greeting
; IsMorning:
;  mov dx,OFFSET GoodMorningMessage ; point to before noon greeting
 
; DisplayGreeting:
;  mov ah,9 ; DOS print string function
;  int 21h ; display the greeting
;  mov ah,4ch ; DOS terminate program function
;  int 21h ; terminate program
; END ProgramStart


; modified test
.MODEL small
.STACK 100h
.DATA
 TimePrompt DB 'Is it 10 pm (Y/N)?$'
 EmoTime LABEL BYTE 
 DB 13,10,'Lets relapse',13,10,'$'
 NoEmoTime LABEL BYTE 
 DB 13,10,'NO EMOING, LOCK IN TWIN',13,10,'$'
.CODE
ProgramStart:

 mov ax,@data
 mov ds,ax ; set DS to point to data segment
 mov dx,OFFSET TimePrompt ; point to the time prompt
 mov ah,9 ; DOS print string function
 int 21h ; display time prompt
 
 mov ah,1 ; DOS get character function
 int 21h ; get single character response
 cmp al,'y' ; typed lowercase ‘y’ for after noon?
 jz IsEmo ; jz = jump if zero. Yes, it’s afternoon
 cmp al,'Y' ; typed uppercase ‘Y’ for afternoon?
 jnz IsNotEmo ; no, it’s before noon

IsEmo:
 mov dx,OFFSET EmoTime ; point to the afternoon greeting
 jmp DisplayGreeting ; point to the afternoon greeting
IsNotEmo:
 mov dx,OFFSET NoEmoTime ; point to before noon greeting
 
DisplayGreeting:
 mov ah,9 ; DOS print string function
 int 21h ; display the greeting
 mov ah,4ch ; DOS terminate program function
 int 21h ; terminate program
END ProgramStart

