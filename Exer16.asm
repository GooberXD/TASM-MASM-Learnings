; Filename: EXER16.ASM
; Date: 9/11/2025
; Description: This assembly language program will get character input and 
; display back character input.
.MODEL small
.STACK 200h
.DATA
 inputChar db ? ; db means define byte or reserve 1 byte of memory
 ;                variable to store the input character
 ;                ? means don’t assign an initial value to inputChar

newline db 13, 10, '$'  ;for newline
inputMsg db "Enter a character: $"
outputMsg db "You entered: $"
.CODE
Main:
 ; initialize the data segment
 mov ax, @data
 mov ds, ax

 ; display the input prompt message
 mov ah, 09h 
 mov dx, OFFSET inputMsg
 int 21h

 ; read a character from the keyboard
 mov ah,01h
 int 21h
 mov inputChar,al

 ; print newline before output message
 mov ah, 09h
 mov dx, OFFSET newline
 int 21h

 ; display the output message
 mov ah, 09h 
 mov dx, OFFSET outputMsg
 int 21h

 ; display the character back
 mov dl, inputChar
 mov ah, 02h
 int 21h



 ; exit program
 mov ax,4C00h ; function to exit program
 int 21h
END Main