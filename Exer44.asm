; Filename: EXER44.ASM
; Date: October 25, 2025

; Create an Assembly Language program to display a main menu that
; lets users choose which 2025 calendar month to display. Use the
; following:
; 1. Loops to display the table borders.
; 2. Loops to display the month date numbers.
; 3. Loop to repeatedly display main menu when y or Y is
; pressed, until n or N is pressed.
; 4. Different font and table fill colors for each calendar
; month.
; 5. A function to display each calendar month.
; 6. Each 2025 calendar month must be accurate.


.model small
.stack 100h
.data

nl db 13, 10, '$'
str1 db '2025 Calendar', 13,10,'Programmer: GooberXD', 13,10, 'Date Finished: OCTOBER 26, 2025', 13,10, 'Main Menu$'
str2 db 'Enter choice: $'
str3 db 'Again? Y/N: $'
str4 db 'INVALID ENTRY!$'
str5 db 'Thank you. Come back soon.$'
line1 db '                                     $'
jan db 'January$'
feb db 'February$'
mar db 'March$'
apr db 'April$'
may db 'May$'
jun db 'June$'
jul db 'July$'
aug db 'August$'
sep db 'September$'
oct db 'October$'
nov db 'November$'
dec1 db 'December$'
year db '2025$'
one db ' 1 $'
two db ' 2 $'
thr db ' 3 $'
fou db ' 4 $'
fiv db ' 5 $'
six db ' 6 $'
sev db ' 7 $'
eig db ' 8 $'
nin db ' 9 $'
ten db ' 10 $'
ele db ' 11 $'
twelve db ' 12 $'

days db 'S  ',  179,   ' M  ', 179,  ' T  ', 179,   ' W  ', 179, ' T  ',  179,  ' F  ',  179,  ' S$'
jan1 db '   ',  179,   '    ', 179,  '    ', 179,   '  1 ', 179, '  2 ',  179,  '  3 ',  179,  '  4', 13,10,13,10, 179, '  5 ',  179,   '  6 ', 179,  '  7 ', 179,   '  8 ', 179, '  9 ',  179,  ' 10 ',  179,  ' 11 ', 13,10,13,10, 179, ' 12 ',  179,   ' 13 ', 179,  ' 14 ', 179,   ' 15 ', 179, ' 16 ',  179,  ' 17 ',  179,  ' 18 ', 13,10,13,10, 179, ' 19 ',  179,   ' 20 ', 179,  ' 21 ', 179,   ' 22 ', 179, ' 23 ',  179,  ' 24 ',  179,  ' 25 ', 13,10,13,10, 179, ' 26 ',  179,   ' 27 ', 179,  ' 28 ', 179,   ' 29 ', 179, ' 30 ',  179,  ' 31 ',  179,  '    $'
feb1 db '   ',  179,   '    ', 179,  '    ', 179,   '    ', 179, '    ',  179,  '    ',  179,  '  1', 13,10,13,10, 179, '  2 ',  179,   '  3 ', 179,  '  4 ', 179,   '  5 ', 179, '  6 ',  179,  '  7 ',  179,  '  8 ', 13,10,13,10, 179, '  9 ',  179,   ' 10 ', 179,  ' 11 ', 179,   ' 12 ', 179, ' 13 ',  179,  ' 14 ',  179,  ' 15 ', 13,10,13,10, 179, ' 16 ',  179,   ' 17 ', 179,  ' 18 ', 179,   ' 19 ', 179, ' 20 ',  179,  ' 21 ',  179,  ' 22 ', 13,10,13,10, 179, ' 23 ',  179,   ' 24 ', 179,  ' 25 ', 179,   ' 26 ', 179, ' 27 ',  179,  ' 28 ',  179,  '    $'
mar1 db '   ',  179,   '    ', 179,  '    ', 179,   '    ', 179, '    ',  179,  '    ',  179,  '  1', 13,10,13,10, 179, '  2 ',  179,   '  3 ', 179,  '  4 ', 179,   '  5 ', 179, '  6 ',  179,  '  7 ',  179,  '  8 ', 13,10,13,10, 179, '  9 ',  179,   ' 10 ', 179,  ' 11 ', 179,   ' 12 ', 179, ' 13 ',  179,  ' 14 ',  179,  ' 15 ', 13,10,13,10, 179, ' 16 ',  179,   ' 17 ', 179,  ' 18 ', 179,   ' 19 ', 179, ' 20 ',  179,  ' 21 ',  179,  ' 22 ', 13,10,13,10, 179, ' 23 ',  179,   ' 24 ', 179,  ' 25 ', 179,   ' 26 ', 179, ' 27 ',  179,  ' 28 ',  179,  ' 29 ', 13,10,13,10, 179, ' 30 ',  179,   ' 31 ', 179,  '    ', 179,   '    ', 179, '    ',  179,  '    ',  179,  '    $'
apr1 db '   ',  179,   '    ', 179,  '  1 ', 179,   '  2 ', 179, '  3 ',  179,  '  4 ',  179,  '  5', 13,10,13,10, 179, '  6 ',  179,   '  7 ', 179,  '  8 ', 179,   '  9 ', 179, ' 10 ',  179,  ' 11 ',  179,  ' 12 ', 13,10,13,10, 179, ' 13 ',  179,   ' 14 ', 179,  ' 15 ', 179,   ' 16 ', 179, ' 17 ',  179,  ' 18 ',  179,  ' 19 ', 13,10,13,10, 179, ' 20 ',  179,   ' 21 ', 179,  ' 22 ', 179,   ' 23 ', 179, ' 24 ',  179,  ' 25 ',  179,  ' 26 ', 13,10,13,10, 179, ' 27 ',  179,   ' 28 ', 179,  ' 29 ', 179,   ' 30 ', 179, '    ',  179,  '    ',  179,  '    $'
may1 db '   ',  179,   '    ', 179,  '    ', 179,   '    ', 179, '  1 ',  179,  '  2 ',  179,  '  3', 13,10,13,10, 179, '  4 ',  179,   '  5 ', 179,  '  6 ', 179,   '  7 ', 179, '  8 ',  179,  '  9 ',  179,  ' 10 ', 13,10,13,10, 179, ' 11 ',  179,   ' 12 ', 179,  ' 13 ', 179,   ' 14 ', 179, ' 15 ',  179,  ' 16 ',  179,  ' 17 ', 13,10,13,10, 179, ' 18 ',  179,   ' 19 ', 179,  ' 20 ', 179,   ' 21 ', 179, ' 22 ',  179,  ' 23 ',  179,  ' 24 ', 13,10,13,10, 179, ' 25 ',  179,   ' 26 ', 179,  ' 27 ', 179,   ' 28 ', 179, ' 29 ',  179,  ' 30 ',  179,  ' 31 $'
jun1 db ' 1 ',  179,   '  2 ', 179,  '  3 ', 179,   '  4 ', 179, '  5 ',  179,  '  6 ',  179,  '  7', 13,10,13,10, 179, '  8 ',  179,   '  9 ', 179,  ' 10 ', 179,   ' 11 ', 179, ' 12 ',  179,  ' 13 ',  179,  ' 14 ', 13,10,13,10, 179, ' 15 ',  179,   ' 16 ', 179,  ' 17 ', 179,   ' 18 ', 179, ' 19 ',  179,  ' 20 ',  179,  ' 21 ', 13,10,13,10, 179, ' 22 ',  179,   ' 23 ', 179,  ' 24 ', 179,   ' 25 ', 179, ' 26 ',  179,  ' 27 ',  179,  ' 28 ', 13,10,13,10, 179, ' 29 ',  179,   ' 30 ', 179,  '    ', 179,   '    ', 179, '    ',  179,  '    ',  179,  '    $'
jul1 db '   ',  179,   '    ', 179,  '  1 ', 179,   '  2 ', 179, '  3 ',  179,  '  4 ',  179,  '  5', 13,10,13,10, 179, '  6 ',  179,   '  7 ', 179,  '  8 ', 179,   '  9 ', 179, ' 10 ',  179,  ' 11 ',  179,  ' 12 ', 13,10,13,10, 179, ' 13 ',  179,   ' 14 ', 179,  ' 15 ', 179,   ' 16 ', 179, ' 17 ',  179,  ' 18 ',  179,  ' 19 ', 13,10,13,10, 179, ' 20 ',  179,   ' 21 ', 179,  ' 22 ', 179,   ' 23 ', 179, ' 24 ',  179,  ' 25 ',  179,  ' 26 ', 13,10,13,10, 179, ' 27 ',  179,   ' 28 ', 179,  ' 29 ', 179,   ' 30 ', 179, ' 31 ',  179,  '    ',  179,  '    $'
aug1 db '   ',  179,   '    ', 179,  '    ', 179,   '    ', 179, '    ',  179,  '  1 ',  179,  '  2', 13,10,13,10, 179, '  3 ',  179,   '  4 ', 179,  '  5 ', 179,   '  6 ', 179, '  7 ',  179,  '  8 ',  179,  '  9 ', 13,10,13,10, 179, ' 10 ',  179,   ' 11 ', 179,  ' 12 ', 179,   ' 13 ', 179, ' 14 ',  179,  ' 15 ',  179,  ' 16 ', 13,10,13,10, 179, ' 17 ',  179,   ' 18 ', 179,  ' 19 ', 179,   ' 20 ', 179, ' 21 ',  179,  ' 22 ',  179,  ' 23 ', 13,10,13,10, 179, ' 24 ',  179,   ' 25 ', 179,  ' 26 ', 179,   ' 27 ', 179, ' 28 ',  179,  ' 29 ',  179,  ' 30 ', 13,10,13,10, 179, ' 31 ',  179,   '    ', 179,  '    ', 179,   '    ', 179, '    ',  179,  '    ',  179,  '    $'
sep1 db '   ',  179,   '  1 ', 179,  '  2 ', 179,   '  3 ', 179, '  4 ',  179,  '  5 ',  179,  '  6', 13,10,13,10, 179, '  7 ',  179,   '  8 ', 179,  '  9 ', 179,   ' 10 ', 179, ' 11 ',  179,  ' 12 ',  179,  ' 13 ', 13,10,13,10, 179, ' 14 ',  179,   ' 15 ', 179,  ' 16 ', 179,   ' 17 ', 179, ' 18 ',  179,  ' 19 ',  179,  ' 20 ', 13,10,13,10, 179, ' 21 ',  179,   ' 22 ', 179,  ' 23 ', 179,   ' 24 ', 179, ' 25 ',  179,  ' 26 ',  179,  ' 27 ', 13,10,13,10, 179, ' 28 ',  179,   ' 29 ', 179,  ' 30 ', 179,   '    ', 179, '    ',  179,  '    ',  179,  '    $'
oct1 db '   ',  179,   '    ', 179,  '    ', 179,   '  1 ', 179, '  2 ',  179,  '  3 ',  179,  '  4', 13,10,13,10, 179, '  5 ',  179,   '  6 ', 179,  '  7 ', 179,   '  8 ', 179, '  9 ',  179,  ' 10 ',  179,  ' 11 ', 13,10,13,10, 179, ' 12 ',  179,   ' 13 ', 179,  ' 14 ', 179,   ' 15 ', 179, ' 16 ',  179,  ' 17 ',  179,  ' 18 ', 13,10,13,10, 179, ' 19 ',  179,   ' 20 ', 179,  ' 21 ', 179,   ' 22 ', 179, ' 23 ',  179,  ' 24 ',  179,  ' 25 ', 13,10,13,10, 179, ' 26 ',  179,   ' 27 ', 179,  ' 28 ', 179,   ' 29 ', 179, ' 30 ',  179,  ' 31 ',  179,  '    $'
nov1 db '   ',  179,   '    ', 179,  '    ', 179,   '    ', 179, '    ',  179,  '    ',  179,  '  1', 13,10,13,10, 179, '  2 ',  179,   '  3 ', 179,  '  4 ', 179,   '  5 ', 179, '  6 ',  179,  '  7 ',  179,  '  8 ', 13,10,13,10, 179, '  9 ',  179,   ' 10 ', 179,  ' 11 ', 179,   ' 12 ', 179, ' 13 ',  179,  ' 14 ',  179,  ' 15 ', 13,10,13,10, 179, ' 16 ',  179,   ' 17 ', 179,  ' 18 ', 179,   ' 19 ', 179, ' 20 ',  179,  ' 21 ',  179,  ' 22 ', 13,10,13,10, 179, ' 23 ',  179,   ' 24 ', 179,  ' 25 ', 179,   ' 26 ', 179, ' 27 ',  179,  ' 28 ',  179,  ' 29 ', 13,10,13,10, 179, ' 30 ',  179,   '    ', 179,  '    ', 179,   '    ', 179, '    ',  179,  '    ',  179,  '    $'
dec2 db '   ',  179,   '  1 ', 179,  '  2 ', 179,   '  3 ', 179, '  4 ',  179,  '  5 ',  179,  '  6', 13,10,13,10, 179, '  7 ',  179,   '  8 ', 179,  '  9 ', 179,   ' 10 ', 179, ' 11 ',  179,  ' 12 ',  179,  ' 13 ', 13,10,13,10, 179, ' 14 ',  179,   ' 15 ', 179,  ' 16 ', 179,   ' 17 ', 179, ' 18 ',  179,  ' 19 ',  179,  ' 20 ', 13,10,13,10, 179, ' 21 ',  179,   ' 22 ', 179,  ' 23 ', 179,   ' 24 ', 179, ' 25 ',  179,  ' 26 ',  179,  ' 27 ', 13,10,13,10, 179, ' 28 ',  179,   ' 29 ', 179,  ' 30 ', 179,   ' 31 ', 179, '    ',  179,  '    ',  179,  '    $'

inputChar1 db ?
inputChar2 db ?

row db ?
col db ?

row1 db 5
col1 db 44


row2 db 7 
col2 db 37

tempR db 0
tempC db 0

tempR2 db 0
tempR3 db 0
tempR4 db 0        
row3 db 8
col3 db 50

row4 db 6
col4 db 4

temp1 db 0
temp2 db 0
temp3 db 0
temp4 db 0

space1 db '    ', 179, '$'    

L1 db 218, 196, 196, 196, 196, 194, 196, 196, 196, 196, 194, 196, 196, 196, 196, 194, 196, 196, 196, 196, 194, 196, 196, 196, 196, 194, 196, 196, 196, 196, 194, 196, 196, 196, 196, 191, '$'
L2 db 195, 196, 196, 196, 196, 197, 196, 196, 196, 196, 197, 196, 196, 196, 196, 197, 196, 196, 196, 196, 197, 196, 196, 196, 196, 197, 196, 196, 196, 196, 197, 196, 196, 196, 196, 180, '$'
L3 db 179, '    ', 179, '    ', 179, '    ', 179, '    ', 179, '    ', 179, '    ', 179, '    ', 179, '$'
L4 db 192, 196, 196, 196, 196, 193, 196, 196, 196, 196, 193, 196, 196, 196, 196, 193, 196, 196, 196, 196, 193, 196, 196, 196, 196, 193, 196, 196, 196, 196, 193, 196, 196, 196, 196, 217, '$'

lineColor db 4Eh
.code
main proc
    mov ax, @data 
    mov ds, ax

START:

mov ah, 00h    
mov al, 03h    ; Standard 80x25 color text mode
int 10h


mov al, [row]
mov bl, 0
cmp al, bl
je skip4           
    mov ah, 09h
    lea dx, nl     
    int 21h
skip4:
mov ah, 09h
lea dx, str1     
int 21h
mov row, 0
row_loop1:
mov ah, 09h
lea dx, nl     
int 21h

mov col, 1
col_loop1:
mov ah, 02h
mov dl, 196
int 21h

inc col
mov al, [col]
cmp al, [col1]
jb col_loop1      
mov ah, 09h
lea dx, nl
int 21h
inc row
mov al, [row]
cmp al, [row1]
jb row_loop1     
mov ah, 03h
mov bh, 0
int 10h

mov [tempR], dh       ; starting row
mov [tempC], dl       ; starting column


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 9
mov dl, 0              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 218      
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 8
mov dl, 0              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 179      
int 21h

    mov ah, 09h
    lea dx, one
    int 21h

    mov ah, 09h
    lea dx, jan
    int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 7
mov dl, 0              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 195      
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 6
mov dl, 0              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 179      
int 21h

    mov ah, 09h
    lea dx, two
    int 21h

    mov ah, 09h
    lea dx, feb
    int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 5
mov dl, 0              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 195    
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 4
mov dl, 0              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 179      
int 21h

    mov ah, 09h
    lea dx, thr
    int 21h

    mov ah, 09h
    lea dx, mar
    int 21h


mov ah, 02h
mov bh, 0             
mov dh, [tempR]              ; row (Y position)
sub dh, 3
mov dl, 0              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 195      
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 2
mov dl, 0              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 179      
int 21h

mov ah, 09h
lea dx, fou
int 21h

mov ah, 09h
lea dx, apr
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 1
mov dl, 0              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 192     
int 21h

mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 9
mov dl, 14              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 194      
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 8
mov dl, 14              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 179      
int 21h

mov ah, 09h
lea dx, fiv
int 21h

mov ah, 09h
lea dx, may
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 7
mov dl, 14              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 197      
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 6
mov dl, 14              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 179      
int 21h

    mov ah, 09h
    lea dx, six
    int 21h

    mov ah, 09h
    lea dx, jun
    int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 5
mov dl, 14              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 197    
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 4
mov dl, 14              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 179      
int 21h

    mov ah, 09h
    lea dx, sev
    int 21h

    mov ah, 09h
    lea dx, jul
    int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 3
mov dl, 14              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 197      
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 2
mov dl, 14              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 179      
int 21h

    mov ah, 09h
    lea dx, eig
    int 21h

    mov ah, 09h
    lea dx, aug
    int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 1
mov dl, 14              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 193     
int 21h

mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 9
mov dl, 28              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 194      
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 8
mov dl, 28              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 179      
int 21h

    mov ah, 09h
    lea dx, nin
    int 21h

    mov ah, 09h
    lea dx, sep
    int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 7
mov dl, 28              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 197      
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 6
mov dl, 28              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 179      
int 21h

    mov ah, 09h
    lea dx, ten
    int 21h

    mov ah, 09h
    lea dx, oct
    int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 5
mov dl, 28              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 197    
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 4
mov dl, 28              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 179      
int 21h

    mov ah, 09h
    lea dx, ele
    int 21h

    mov ah, 09h
    lea dx, nov
    int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 3
mov dl, 28              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 197      
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 2
mov dl, 28              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 179      
int 21h

    mov ah, 09h
    lea dx, twelve
    int 21h

    mov ah, 09h
    lea dx, dec1
    int 21h


mov ah, 02h
mov bh, 0              
mov dh, [tempR]              ; row (Y position)
sub dh, 1
mov dl, 28              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 193     
int 21h



mov ah, 02h
mov bh, 0              
mov dh, [tempR]              
sub dh, 9
mov dl, 43              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 191
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 8
mov dl, 43              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 179      
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 7
mov dl, 43              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 180     
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 6
mov dl, 43              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 179      
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 5
mov dl, 43              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 180   
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 4
mov dl, 43              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 179      
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 3
mov dl, 43              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 180     
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 2
mov dl, 43              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 179      
int 21h


mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
sub dh, 1
mov dl, 43              ; column (X position)
int 10h                ; set cursor
mov ah, 02h      
mov dl, 217     
int 21h

mov ah, 03h
mov bh, 0
int 10h

mov [row], dh       ; starting row
mov [col], dl       ; starting column
mov ah, 02h
mov bh, 0              ; page
mov dh, [tempR]              ; row (Y position)
mov dl, [tempC]              ; column (X position)
int 10h                ; set cursor

mov ah, 09h
lea dx, str2     
int 21h

mov ah, 01h       ; DOS function: input character (waits for key)
int 21h           ; AL = character
mov inputChar1, al ; store its ASCII code

mov bl, '1'
cmp al, bl
je oo_one

mov bl, '2'
cmp al, bl
je oo_two

mov bl, '3'
cmp al, bl
je oo_three

mov bl, '4'
cmp al, bl
je oo_four

mov bl, '5'
cmp al, bl
je oo_five

mov bl, '6'
cmp al, bl
je oo_six

mov bl, '7'
cmp al, bl
je oo_seven

mov bl, '8'
cmp al, bl
je oo_eight

mov bl, '9'
cmp al, bl
je oo_nine

jmp far ptr skip1
    
oo_one:
    mov ah, 01h       
    int 21h           ; AL = character
    mov inputChar2, al ; store its ASCII code

    mov ah, inputChar2
    cmp ah, '0'
    je oo_ten
    cmp ah, '1'
    je oo_eleven
    cmp ah, '2'
    je oo_twelve
    cmp ah, 13
    je oo_one1

    jmp far ptr INVALID_INPUT
oo_one1:
    call CLEAR_SCREEN
    jmp far ptr ONE_
oo_two:
    call CLEAR_SCREEN
    jmp far ptr TWO_
oo_three:
    call CLEAR_SCREEN
    jmp far ptr THREE_
oo_four:
    call CLEAR_SCREEN
    jmp far ptr FOUR_
oo_five:
    call CLEAR_SCREEN
    jmp far ptr FIVE_
oo_six:
    call CLEAR_SCREEN
    jmp far ptr SIX_
oo_seven:
    call CLEAR_SCREEN
    jmp far ptr SEVEN_
oo_eight:
    call CLEAR_SCREEN
    jmp far ptr EIGHT_
oo_nine:
    call CLEAR_SCREEN
    jmp far ptr NINE_
oo_ten:    
    call CLEAR_SCREEN
    jmp far ptr TEN_
oo_eleven:
    call CLEAR_SCREEN
    jmp far ptr ELEVEN_
oo_twelve:
    call CLEAR_SCREEN
    jmp far ptr TWELVE_
skip1:
    jmp far ptr INVALID_INPUT

get_row PROC
    mov ah, 03h     ; DOS BIOS: Get cursor position
    mov bh, 0       
    int 10h        

    mov [tempR2], dh 
    ret
get_row ENDP

oo_box1 PROC
call get_row

mov temp2, 0
red_part PROC

    mov temp1, 1
    
    print_loop:

        mov ah, 09h
        lea dx, nl   
        int 21h

red_part ENDP

    inc [temp2]
    mov al, [temp2]
    cmp al, 14
    jl red_part


mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 14
mov dl, 0           ; Column from temp2
int 10h
mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L1
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 13
mov dl, 0           ; Column from temp2
int 10h

mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L3
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 12
mov dl, 0           ; Column from temp2
int 10h

mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L2
int 21h
mov ah, 02h        
mov bh, 0          
mov dh, [tempR2]
sub dh, 11
mov dl, 0           
int 10h
mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L3
int 21h
mov ah, 02h        
mov bh, 0          
mov dh, [tempR2]
sub dh, 10
mov dl, 0           
int 10h
mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L2
int 21h


mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 9
mov dl, 0           ; Column from temp2
int 10h
mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L3
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 8
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L2
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 7
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L3
int 21h

; Set Cursor
mov ah, 02h        
mov bh, 0          
mov dh, [tempR2]
sub dh, 6
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L2
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 5
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L3
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 4
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L2
int 21h


mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 3
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L3
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 2
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L4
int 21h
mov al, [tempR2]    
mov [tempR4], al

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR4]
sub dh, 13
mov dl, 2           
int 10h

mov ah, 09h
lea dx, days
int 21h

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR4]
sub dh, 2
mov dl, 0           ; Column from temp2
int 10h

RET
oo_box1 ENDP

oo_box2 PROC
call get_row

mov temp2, 0
red_part2 PROC

mov temp1, 1

print_loop2:
    mov ah, 09h
    lea dx, nl   
    int 21h

red_part2 ENDP

inc [temp2]
mov al, [temp2]
cmp al, 16          
jl red_part2

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 16
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L1
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 15
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L3
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 14
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L2
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 13
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L3
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 12
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L2
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 11
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L3
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 10
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L2
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 9
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L3
int 21h

; Set Cursor L2
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 8
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L2
int 21h

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 7
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L3
int 21h



; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 6
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L2
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 5
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L3
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 4
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L2
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 3
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L3
int 21h

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]
sub dh, 2
mov dl, 0           ; Column from temp2
int 10h


mov ah, 09h
mov al, ' '
mov bh, 0
sub bh, 0
mov bl, [lineColor] 
mov cx, 36
int 10h

mov ah, 09h
lea dx, L4
int 21h
mov al, [tempR2]    
mov [tempR4], al

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR4]
sub dh, 15
mov dl, 2           
int 10h

mov ah, 09h
lea dx, days
int 21h

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR4]
sub dh, 2
mov dl, 0           ; Column from temp2
int 10h

RET
oo_box2 ENDP

ONE_:
mov [lineColor], 5Eh

mov ah, 09h
lea dx, jan
int 21h

mov ah, 02h      
mov dl, ' '     
int 21h

mov ah, 09h
lea dx, year
int 21h

mov ah, 09h
lea dx, nl
int 21h

call oo_box1 

mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    


mov ah, 02h        
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
sub dh, 11
mov dl, 2           ; Column from temp2
int 10h

mov ah, 09h
lea dx, jan1
int 21h

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR4]
sub dh, 2
mov dl, 0           ; Column from temp2
int 10h



call get_row

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
mov dl, 0           ; Column from temp2
int 10h

jmp far ptr CHECK
TWO_:
mov [lineColor], 2Eh

mov ah, 09h
lea dx, nl
int 21h

mov ah, 09h
lea dx, feb
int 21h

mov ah, 02h      
mov dl, ' '     
int 21h

mov ah, 09h
lea dx, year
int 21h

mov ah, 09h
lea dx, nl
int 21h

call oo_box1

mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    


mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
sub dh, 11
mov dl, 2           ; Column from temp2
int 10h

mov ah, 09h
lea dx, feb1
int 21h

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR4]
sub dh, 2
mov dl, 0           ; Column from temp2
int 10h



call get_row

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
mov dl, 0           ; Column from temp2
int 10h

jmp far ptr CHECK
THREE_:
mov [lineColor], 5Eh

mov ah, 09h
lea dx, nl
int 21h

mov ah, 09h
lea dx, mar
int 21h

mov ah, 02h      
mov dl, ' '     
int 21h

mov ah, 09h
lea dx, year
int 21h

mov ah, 09h
lea dx, nl
int 21h

call oo_box2

mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    

mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    


mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
sub dh, 13
mov dl, 2           ; Column from temp2
int 10h

mov ah, 09h
lea dx, mar1
int 21h

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR4]
sub dh, 2
mov dl, 0           ; Column from temp2
int 10h



call get_row

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
mov dl, 0           ; Column from temp2
int 10h

jmp far ptr CHECK
FOUR_:
mov [lineColor], 6Ah

mov ah, 09h
lea dx, nl
int 21h

mov ah, 09h
lea dx, apr
int 21h

mov ah, 02h      
mov dl, ' '     
int 21h

mov ah, 09h
lea dx, year
int 21h

mov ah, 09h
lea dx, nl
int 21h

call oo_box1

mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    

mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    


mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
sub dh, 11
mov dl, 2           ; Column from temp2
int 10h

mov ah, 09h
lea dx, apr1
int 21h

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR4]
sub dh, 2
mov dl, 0           ; Column from temp2
int 10h

call get_row

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
mov dl, 0           ; Column from temp2
int 10h

jmp far ptr CHECK
FIVE_:
mov [lineColor], 1Bh

mov ah, 09h
lea dx, nl
int 21h

mov ah, 09h
lea dx, may
int 21h

mov ah, 02h      
mov dl, ' '     
int 21h

mov ah, 09h
lea dx, year
int 21h

mov ah, 09h
lea dx, nl
int 21h

call oo_box1

mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    



mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    


mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
sub dh, 11
mov dl, 2           ; Column from temp2
int 10h

mov ah, 09h
lea dx, may1
int 21h

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR4]
sub dh, 2
mov dl, 0           ; Column from temp2
int 10h

call get_row

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
mov dl, 0           ; Column from temp2
int 10h

jmp far ptr CHECK
SIX_:
mov [lineColor], 4Ch

mov ah, 09h
lea dx, nl
int 21h

mov ah, 09h
lea dx, jun
int 21h

mov ah, 02h      
mov dl, ' '     
int 21h

mov ah, 09h
lea dx, year
int 21h

mov ah, 09h
lea dx, nl
int 21h

call oo_box1

mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    



mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
sub dh, 11
mov dl, 2           ; Column from temp2
int 10h

mov ah, 09h
lea dx, jun1
int 21h

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR4]
sub dh, 2
mov dl, 0           ; Column from temp2
int 10h

call get_row

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
mov dl, 0           ; Column from temp2
int 10h

jmp far ptr CHECK
SEVEN_:
mov [lineColor], 7Bh

mov ah, 09h
lea dx, nl
int 21h

mov ah, 09h
lea dx, jul
int 21h

mov ah, 02h      
mov dl, ' '     
int 21h

mov ah, 09h
lea dx, year
int 21h

mov ah, 09h
lea dx, nl
int 21h

call oo_box1

mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    


mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    


mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
sub dh, 11
mov dl, 2           ; Column from temp2
int 10h

mov ah, 09h
lea dx, jul1
int 21h

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR4]
sub dh, 2
mov dl, 0           ; Column from temp2
int 10h

call get_row

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
mov dl, 0           ; Column from temp2
int 10h

jmp far ptr CHECK
EIGHT_:
mov [lineColor], 2Dh

mov ah, 09h
lea dx, nl
int 21h

mov ah, 09h
lea dx, aug
int 21h

mov ah, 02h      
mov dl, ' '     
int 21h

mov ah, 09h
lea dx, year
int 21h

mov ah, 09h
lea dx, nl
int 21h

call oo_box2

mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    

mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
sub dh, 13
mov dl, 2           ; Column from temp2
int 10h

mov ah, 09h
lea dx, aug1
int 21h

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR4]
sub dh, 2
mov dl, 0           ; Column from temp2
int 10h

call get_row

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
mov dl, 0           ; Column from temp2
int 10h

jmp far ptr CHECK
NINE_:
mov [lineColor], 6Ch

mov ah, 09h
lea dx, nl
int 21h

mov ah, 09h
lea dx, sep
int 21h

mov ah, 02h      
mov dl, ' '     
int 21h

mov ah, 09h
lea dx, year
int 21h

mov ah, 09h
lea dx, nl
int 21h

call oo_box1
mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    


mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    


mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
sub dh, 11
mov dl, 2           ; Column from temp2
int 10h

mov ah, 09h
lea dx, sep1
int 21h

mov ah, 02h        
mov bh, 0          
mov dh, [tempR4]
sub dh, 2
mov dl, 0           ; Column from temp2
int 10h

call get_row

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
mov dl, 0           ; Column from temp2
int 10h

jmp far ptr CHECK
TEN_:
mov ah, 09h
lea dx, nl
int 21h

mov [lineColor], 101D

mov ah, 09h
lea dx, nl
int 21h

mov ah, 09h
lea dx, oct
int 21h

mov ah, 02h      
mov dl, ' '     
int 21h

mov ah, 09h
lea dx, year
int 21h

mov ah, 09h
lea dx, nl
int 21h

call oo_box1

mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    


mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
sub dh, 11
mov dl, 2           ; Column from temp2
int 10h

mov ah, 09h
lea dx, oct1
int 21h

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR4]
sub dh, 2
mov dl, 0           ; Column from temp2
int 10h

call get_row

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
mov dl, 0           ; Column from temp2
int 10h

jmp far ptr CHECK
ELEVEN_:
mov [lineColor], 25H

mov ah, 09h
lea dx, nl
int 21h

mov ah, 09h
lea dx, nov
int 21h

mov ah, 02h      
mov dl, ' '     
int 21h

mov ah, 09h
lea dx, year
int 21h

mov ah, 09h
lea dx, nl
int 21h

call oo_box2

mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    

mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
sub dh, 13
mov dl, 2           ; Column from temp2
int 10h

mov ah, 09h
lea dx, nov1
int 21h


mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR4]
sub dh, 2
mov dl, 0           ; Column from temp2
int 10h

call get_row

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
mov dl, 0           ; Column from temp2
int 10h

jmp far ptr CHECK
TWELVE_:
mov [lineColor], 5Fh

mov ah, 09h
lea dx, nl
int 21h

mov ah, 09h
lea dx, dec1
int 21h

mov ah, 02h      
mov dl, ' '     
int 21h

mov ah, 09h
lea dx, year
int 21h

mov ah, 09h
lea dx, nl
int 21h

call oo_box1

mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    


mov ah, 03h        
mov bh, 0          
int 10h            

mov [tempR3], dh    

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
sub dh, 11
mov dl, 2           ; Column from temp2
int 10h

mov ah, 09h
lea dx, dec2
int 21h

mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR4]
sub dh, 2
mov dl, 0           ; Column from temp2
int 10h

call get_row

; Set Cursor
mov ah, 02h        ; Set cursor position
mov bh, 0          
mov dh, [tempR2]    ; Row from temp1
mov dl, 0           ; Column from temp2
int 10h

jmp far ptr CHECK
CHECK:
mov ah, 09h
lea dx, nl
int 21h

mov ah, 09h
lea dx, str3     
int 21h

mov ah, 01h       ; DOS function: input character (waits for key)
int 21h           ; AL = character
mov inputChar1, al ; store its ASCII code

mov ah, inputChar1
cmp ah, 'Y'
je oo_start

cmp ah, 'y'
je oo_start

cmp ah, 'N'
je done

cmp ah, 'n'
je done

jmp far ptr INVALID_INPUT


oo_start:

jmp far ptr START
    


CLEAR_SCREEN PROC
mov ah, 06h    ; Scroll active page up
mov al, 00h    ; Number of lines to scroll (00h clears screen)
mov bh, 07h    ; Attribute for blank lines (white on black)
mov cx, 0000h  ; Row, column of upper-left corner (0,0)
mov dx, 184fh  ; Row, column of lower-right corner (24,79)
int 10h        ; Call video interrupt
ret
CLEAR_SCREEN ENDP

INVALID_INPUT:

; Print a newline using int 21h (if 'nl' is defined as CR+LF)
mov ah, 09h
lea dx, nl
int 21h

; Get current cursor position (for later use, if needed)
mov ah, 03h
mov bh, 0          ; Page number (0 for default)
int 10h            ; DX now contains DH=row, DL=column
; Store current row and column for potential later use
mov [tempR], dh
mov [tempC], dl

mov ah, 02h
mov bh, 0
mov dh, [tempR]     ; Row (Y position) - This would be the row *before* the newline
mov dl, 0           ; Column (X position)
int 10h             ; set cursor

; Print another newline using int 21h
mov ah, 09h
lea dx, nl
int 21h
; --- Original section ends ---

; --- Logic to print the next section two lines below ---

; Get current cursor position (after the above operations)
mov ah, 03h
mov bh, 0          ; Page number (0 for default)
int 10h            ; DX now contains DH=row, DL=column

; Store the current row. This is the row *after* the last printed newline.
mov [tempR], dh

mov dh, [tempR]
add dh, -1          ; Increment row by 2
mov [tempR], dh    ; Store the new target row

; Set cursor to the new target row, column 0
mov ah, 02h        ; Set Cursor Position
mov bh, 0          ; Page number (0 for default)
mov dh, [tempR]    ; Target Row
mov dl, 0          ; Target Column (start of the line)
int 10h            ; Execute BIOS interrupt

mov ah, 09h
mov al, ' '        ; Character to write (a space)
mov bh, 0          ; Page number
mov bl, 4Eh        ; Attribute: background color (4 for red), foreground color (E for yellow)
add bl, 128        ; Set high bit for blinking or bright background (depends on mode)
mov cx, 14         ; Number of times to write the character
int 10h            ; Write Character and Attribute

mov ah, 09h
lea dx, str4
int 21h


jmp far ptr CHECK

done:
call CLEAR_SCREEN
mov ah, 09h
lea dx, nl     
int 21h

mov ah, 09h
lea dx, nl     
int 21h

mov ah, 02h 
mov bh, 0 
mov dh, [tempR] 
dec dh
mov dl, 0
int 10h 

mov ah, 09h
lea dx, str5     
int 21h

mov ax, 4C00h 
int 21h

main endp
end main

