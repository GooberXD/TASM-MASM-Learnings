; Filename: Exer6.asm
; Displaying characters:

; Display text using string variables (4 string variables). 
; First Name Middle Name Last Name
; Bachelor of Science in Computer Science 2nd Year
; College of Computer Studies
; Cebu Institute of Technology - University
; Date: August 27, 2025

.model small
.stack 100

.data
YourName DB 'Goober', 13, 10, '$'
School DB 'Bachelor of Science in Computer Science 2nd Year', 13, 10, '$'
CCS DB 'College of Computer Studies', 13, 10, '$'
CIT DB 'Cebu Institute of Technology - University', 13, 10, '$'

.code
main proc
    ; initialize DS
    mov ax, @data
    mov ds, ax

    ; print name
    mov dx, OFFSET YourName
    mov ah, 09h
    int 21h

    ; print school
    mov dx, OFFSET School
    mov ah, 09h
    int 21h

    ; prints ccs
    mov dx, OFFSET CCS
    mov ah, 09h
    int 21h

    ; prints citu
    mov dx, OFFSET CIT
    mov ah, 09h
    int 21h

    ; exit program
    mov ah, 4Ch
    int 21h

int 27h
end main