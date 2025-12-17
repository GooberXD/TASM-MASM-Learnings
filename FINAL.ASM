; Filename: FINAL.ASM
; Programmer: GooberXD
; Date: December 6, 2025
; SUBJECT: CS243 

; System Name: CITU LIBRARY MANAGEMENT SYSTEM

; This is a comprehensive Library Management System developed entirely in x86 Assembly Language (TASM). 
; The program is designed to simulate a real-world information system without relying on external databases or filesystems. 
; Instead, it utilizes direct memory management and parallel arrays to store, retrieve, and manipulate data in RAM during runtime.

; The system features a Text User Interface (TUI) reminiscent of 
; classic BIOS or Borland applications, utilizing direct video memory manipulation 
; to render colored backgrounds, box-drawing borders, and styled input fields.

; Key Capabilities:

; User Authentication:
; Registration: Allows new users to create accounts (stored in memory).
; Login: Secure entry verification using string comparison logic.
; Visual Feedback: Features flashing red text alerts for incorrect passwords or non-existent accounts.

; Full CRUD Operations (Book Management):
; Create: Add new books with ID, Title, and Author.
; Read: View all active books in a perfectly aligned, formatted grid table.
; Update: Search for a book by ID and edit its details.
; Delete: Remove books by id

; Advanced Graphical Interface (TUI):
; Custom Color Palette.
; Box Drawing using extended ASCII characters for a windowed look.
; Visual Input Fields for data entry.

.MODEL SMALL
.STACK 100H

; ====================================================================
; MACROS
; ====================================================================

PRINT MACRO msg
    PUSH AX
    PUSH DX
    LEA DX, msg
    MOV AH, 09h
    INT 21h
    POP DX
    POP AX
ENDM

GOTOXY MACRO Row, Col
    PUSH AX
    PUSH BX
    PUSH DX
    MOV AH, 02h
    MOV BH, 00h     ; Page 0
    MOV DH, Row
    MOV DL, Col
    INT 10h
    POP DX
    POP BX
    POP AX
ENDM

CLS_COLOR MACRO Color
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV AX, 0600h   ; Scroll full screen
    MOV BH, Color   ; Attribute
    MOV CX, 0000h   ; Top Left
    MOV DX, 184Fh   ; Bottom Right
    INT 10h
    GOTOXY 0, 0
    POP DX
    POP CX
    POP BX
    POP AX
ENDM

; ====================================================================
; DATA SEGMENT
; ====================================================================
.DATA
    ; --- Configuration ---
    MAX_BOOKS   EQU 10
    MAX_USERS   EQU 5
    STR_LEN     EQU 20
    DB_SIZE     EQU 200

    ; --- Colors ---
    MAIN_COLOR  EQU 1Fh ; White on Blue
    HEAD_COLOR  EQU 4Eh ; Yellow on Red
    ERR_COLOR   EQU 4Fh ; White on Red
    INPUT_COLOR EQU 0Fh ; White on Black

    ; --- UI Elements ---
    boxTop      DB 201, 38 DUP(205), 187, '$'
    boxMid      DB 186, '                                      ', 186, '$'
    boxBot      DB 200, 38 DUP(205), 188, '$'
    
    appTitle    DB ' CITU LIBRARY MANAGEMENT SYSTEM $'
    loginTitle  DB '   AUTHENTICATION   $'
    mainTitle   DB '     MAIN MENU      $'
    
    txtUser     DB ' Username: $'
    txtPass     DB ' Password: $'
    txtLogin    DB ' [1] Login    $'
    txtReg      DB ' [2] Register $'
    txtExit     DB ' [3] Exit     $'
    
    txtAdd      DB ' [1] Add Book   $'
    txtView     DB ' [2] View Books $'
    txtEdit     DB ' [3] Edit Book  $'
    txtDel      DB ' [4] Delete Book$'
    txtOut      DB ' [5] Logout     $'
    
    devMsg      DB 'Dev: GooberXD$'
    devDate     DB 'December 6, 2025$'
    devAppName  DB 'CITU Library Management System$'
    
    askID       DB ' Book ID   : $'
    askTitle    DB ' Book Title: $'
    askAuthor   DB ' Author    : $'
    
    msgSuccess  DB ' SUCCESS! Press Key...$'
    msgFull     DB ' DB FULL! Press Key...$'
    msgExit     DB ' Shutting down...     $'
    msgWrongPass DB ' WRONG PASSWORD!      $' 
    msgNoAccount DB ' USER NOT FOUND!      $'
    msgNotFound  DB ' RECORD NOT FOUND!    $'
    msgDel       DB ' RECORD DELETED!      $'

    ; --- Table Header ---
    tblHead     DB ' ID            ', 179, ' Title              ', 179, ' Author             $'
    tblLine     DB 15 DUP(196), 197, 20 DUP(196), 197, 20 DUP(196), '$'
    tblSep      DB 179, '$'

    ; --- Database Variables ---
    bookIDs     DB MAX_BOOKS DUP(STR_LEN DUP('$'))
    bookTitles  DB MAX_BOOKS DUP(STR_LEN DUP('$'))
    bookAuthors DB MAX_BOOKS DUP(STR_LEN DUP('$'))
    isActive    DB MAX_BOOKS DUP(0)  
    bookCount   DW 0

    userNames   DB MAX_USERS DUP(STR_LEN DUP('$'))
    userPass    DB MAX_USERS DUP(STR_LEN DUP('$'))
    userCount   DW 0

    inputBuff   DB STR_LEN, ?, STR_LEN DUP('$') 
    currIndex   DW 0
    foundIndex  DW 0

; ====================================================================
; CODE SEGMENT
; ====================================================================
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX

    MOV AX, 1003h
    MOV BX, 0000h
    INT 10h

    CALL InitMemory
    
    CALL DrawBackground
    CALL DrawCenterBox
    GOTOXY 12, 29
    PRINT devMsg
    MOV AH, 01h
    GOTOXY 13, 32
    PRINT devDate
    MOV AH, 01h
    GOTOXY 14, 25
    PRINT devAppName
    MOV AH, 01h
    INT 21h

AuthLoop:
    CALL DrawBackground
    CALL DrawCenterBox
    
    GOTOXY 9, 30
    PRINT loginTitle
    GOTOXY 11, 32
    PRINT txtLogin
    GOTOXY 12, 32
    PRINT txtReg
    GOTOXY 13, 32
    PRINT txtExit
    
    MOV AH, 01h
    INT 21h
    
    CMP AL, '1'
    JE  DoLogin
    CMP AL, '2'
    JE  DoRegister
    CMP AL, '3'
    JE  ExitJump
    JMP AuthLoop

ExitJump:
    JMP ExitProg

DoLogin:
    CALL LoginProc
    CMP AX, 1       
    JE  MainMenu
    JMP AuthLoop

DoRegister:
    CALL RegisterProc
    JMP AuthLoop

MainMenu:
    CALL DrawBackground
    CALL DrawCenterBox
    
    GOTOXY 9, 30
    PRINT mainTitle
    GOTOXY 11, 32
    PRINT txtAdd
    GOTOXY 12, 32
    PRINT txtView
    GOTOXY 13, 32
    PRINT txtEdit
    GOTOXY 14, 32
    PRINT txtDel
    GOTOXY 15, 32
    PRINT txtOut
    
    MOV AH, 01h
    INT 21h
    
    CMP AL, '1'
    JE  OpAdd
    CMP AL, '2'
    JE  OpView
    CMP AL, '3'
    JE  OpEdit
    CMP AL, '4'
    JE  OpDelete
    CMP AL, '5'
    JMP AuthLoop
    JMP MainMenu

OpAdd:
    CALL AddBook
    JMP MainMenu
OpView:
    CALL ViewBooks
    MOV AH, 01h
    INT 21h
    JMP MainMenu
OpEdit:
    CALL EditBook
    JMP MainMenu
OpDelete:
    CALL DeleteBook
    JMP MainMenu

ExitProg:
    CLS_COLOR 07h 
    PRINT msgExit
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

; ====================================================================
; GUI UTILITIES
; ====================================================================

DrawBackground PROC
    CLS_COLOR MAIN_COLOR
    MOV AH, 06h
    MOV AL, 0       
    MOV BH, HEAD_COLOR
    MOV CX, 0000h   
    MOV DX, 024Fh   
    INT 10h
    GOTOXY 1, 25
    PRINT appTitle
    RET
DrawBackground ENDP

DrawCenterBox PROC
    GOTOXY 8, 20
    PRINT boxTop
    MOV CX, 8
    MOV DH, 9
DrawBoxLoop:
    GOTOXY DH, 20
    PRINT boxMid
    INC DH
    LOOP DrawBoxLoop
    GOTOXY 17, 20
    PRINT boxBot
    RET
DrawCenterBox ENDP

DrawInputField PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV AH, 06h     
    MOV AL, 0
    MOV BH, INPUT_COLOR
    MOV CH, DH      
    MOV CL, DL      
    MOV BP, CX      
    ADD DL, 15      
    INT 10h
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DrawInputField ENDP

; ====================================================================
; LOGIC PROCEDURES
; ====================================================================

RegisterProc PROC
    CALL DrawBackground
    GOTOXY 5, 5
    PRINT txtReg
    GOTOXY 8, 20
    PRINT txtUser
    MOV DH, 8
    MOV DL, 32
    CALL DrawInputField
    GOTOXY 8, 32
    CALL GetInput
    
    CMP userCount, MAX_USERS
    JB  RegContinue
    JMP RegFull
RegContinue:
    
    MOV AX, userCount
    MOV BX, STR_LEN
    MUL BX
    MOV DI, AX
    LEA SI, inputBuff + 2
    LEA BX, userNames
    ADD BX, DI
    CALL StringCopy
    
    GOTOXY 10, 20
    PRINT txtPass
    MOV DH, 10
    MOV DL, 32
    CALL DrawInputField
    GOTOXY 10, 32
    CALL GetInput
    
    LEA SI, inputBuff + 2
    LEA BX, userPass
    ADD BX, DI
    CALL StringCopy
    
    INC userCount
    GOTOXY 12, 20
    PRINT msgSuccess
    MOV AH, 01h
    INT 21h
    RET
RegFull:
    GOTOXY 12, 20
    PRINT msgFull
    MOV AH, 01h
    INT 21h
    RET
RegisterProc ENDP

LoginProc PROC
    CALL DrawBackground
    GOTOXY 5, 5
    PRINT txtLogin
    
    GOTOXY 8, 20
    PRINT txtUser
    MOV DH, 8
    MOV DL, 32
    CALL DrawInputField
    GOTOXY 8, 32
    CALL GetInput
    
    MOV CX, userCount
    CMP CX, 0
    JE L_NotFoundJump
    
    MOV BX, 0
L_Search:
    PUSH BX
    MOV AX, BX
    MOV DX, STR_LEN
    MUL DX
    MOV DI, AX
    LEA SI, inputBuff + 2
    LEA BX, userNames
    ADD BX, DI
    MOV DI, BX
    CALL CompareStrings
    POP BX
    CMP AX, 1
    JE  L_Found
    INC BX
    
    DEC CX
    JNZ L_Search_Trampoline
    JMP L_NotFound
L_Search_Trampoline:
    JMP L_Search

L_NotFoundJump:
    JMP L_NotFound

L_Found:
    MOV currIndex, BX
    GOTOXY 10, 20
    PRINT txtPass
    MOV DH, 10
    MOV DL, 32
    CALL DrawInputField
    GOTOXY 10, 32
    CALL GetInput
    
    MOV AX, currIndex
    MOV DX, STR_LEN
    MUL DX
    MOV DI, AX
    LEA SI, inputBuff + 2
    LEA BX, userPass
    ADD BX, DI
    MOV DI, BX
    CALL CompareStrings
    CMP AX, 1
    JE L_Success

    LEA SI, msgWrongPass
    JMP L_Flash

L_NotFound:
    LEA SI, msgNoAccount
    JMP L_Flash

L_Success:
    MOV AX, 1
    RET

L_Flash:
    GOTOXY 12, 20
    PUSH SI
FlashLoop:
    MOV AL, [SI]
    CMP AL, '$'
    JE  FlashWait
    MOV AH, 09h
    MOV BH, 00h
    MOV BL, 8Ch 
    MOV CX, 1
    INT 10h
    MOV AH, 03h
    INT 10h
    INC DL
    MOV AH, 02h
    INT 10h
    INC SI
    JMP FlashLoop
FlashWait:
    POP SI
    MOV AH, 01h
    INT 21h
    MOV AX, 0
    RET
LoginProc ENDP

AddBook PROC
    CALL DrawBackground
    GOTOXY 5, 5
    PRINT txtAdd
    
    CMP bookCount, MAX_BOOKS
    JB  A_Continue
    JMP A_Full
A_Continue:
    
    GOTOXY 8, 20
    PRINT askID
    MOV DH, 8
    MOV DL, 35
    CALL DrawInputField
    GOTOXY 8, 35
    CALL GetInput
    
    MOV AX, bookCount
    MOV currIndex, AX
    MOV BX, STR_LEN
    MUL BX
    MOV DI, AX
    LEA SI, inputBuff + 2
    LEA BX, bookIDs
    ADD BX, DI
    CALL StringCopy
    
    GOTOXY 10, 20
    PRINT askTitle
    MOV DH, 10
    MOV DL, 35
    CALL DrawInputField
    GOTOXY 10, 35
    CALL GetInput
    LEA SI, inputBuff + 2
    LEA BX, bookTitles
    ADD BX, DI
    CALL StringCopy
    
    GOTOXY 12, 20
    PRINT askAuthor
    MOV DH, 12
    MOV DL, 35
    CALL DrawInputField
    GOTOXY 12, 35
    CALL GetInput
    LEA SI, inputBuff + 2
    LEA BX, bookAuthors
    ADD BX, DI
    CALL StringCopy
    
    MOV BX, currIndex
    LEA SI, isActive
    MOV BYTE PTR [SI + BX], 1
    INC bookCount
    
    GOTOXY 14, 20
    PRINT msgSuccess
    MOV AH, 01h
    INT 21h
    RET
A_Full:
    GOTOXY 14, 20
    PRINT msgFull
    MOV AH, 01h
    INT 21h
    RET
AddBook ENDP

ViewBooks PROC
    CALL DrawBackground
    GOTOXY 5, 25
    PRINT txtView
    
    GOTOXY 7, 5
    PRINT tblHead
    GOTOXY 8, 5
    PRINT tblLine
    
    MOV CX, MAX_BOOKS
    MOV BX, 0
    MOV DH, 9 
    
V_Loop:
    LEA SI, isActive
    MOV AL, [SI + BX]
    CMP AL, 1
    JE  V_Print
    JMP V_Next

V_Print:
    GOTOXY DH, 5
    PUSH BX
    
    PUSH DX 
    
    MOV AX, BX
    MOV CX, STR_LEN ; 
    MUL CX          
    MOV DI, AX
    
    ; ID
    LEA DX, bookIDs
    ADD DX, DI
    MOV CX, 15
    CALL PrintFixed
    PRINT tblSep
    
    ; Title
    LEA DX, bookTitles
    ADD DX, DI
    MOV CX, 20
    CALL PrintFixed
    PRINT tblSep
    
    ; Author
    LEA DX, bookAuthors
    ADD DX, DI
    MOV CX, 20
    CALL PrintFixed
    
    ; --- RESTORE DX (Row Counter) ---
    POP DX
    
    POP BX
    INC DH 
    
V_Next:
    INC BX
    CMP BX, MAX_BOOKS
    JAE V_Done
    JMP V_Loop

V_Done:
    RET
ViewBooks ENDP

EditBook PROC
    CALL DrawBackground
    GOTOXY 5, 5
    PRINT txtEdit
    
    GOTOXY 8, 20
    PRINT askID
    MOV DH, 8
    MOV DL, 35
    CALL DrawInputField
    GOTOXY 8, 35
    CALL GetInput
    
    CALL FindBookID
    CMP AX, 0
    JNE E_Found
    JMP E_Fail
    
E_Found:
    MOV AX, foundIndex
    MOV BX, STR_LEN
    MUL BX
    MOV DI, AX
    
    GOTOXY 10, 20
    PRINT askTitle
    MOV DH, 10
    MOV DL, 35
    CALL DrawInputField
    GOTOXY 10, 35
    CALL GetInput
    LEA SI, inputBuff + 2
    LEA BX, bookTitles
    ADD BX, DI
    CALL StringCopy
    
    GOTOXY 12, 20
    PRINT askAuthor
    MOV DH, 12
    MOV DL, 35
    CALL DrawInputField
    GOTOXY 12, 35
    CALL GetInput
    LEA SI, inputBuff + 2
    LEA BX, bookAuthors
    ADD BX, DI
    CALL StringCopy
    
    GOTOXY 14, 20
    PRINT msgSuccess
    MOV AH, 01h
    INT 21h
    RET
    
E_Fail:
    GOTOXY 10, 20
    PRINT msgNotFound
    MOV AH, 01h
    INT 21h
    RET
EditBook ENDP

DeleteBook PROC
    CALL DrawBackground
    GOTOXY 5, 5
    PRINT txtDel
    
    GOTOXY 8, 20
    PRINT askID
    MOV DH, 8
    MOV DL, 35
    CALL DrawInputField
    GOTOXY 8, 35
    CALL GetInput
    
    CALL FindBookID
    CMP AX, 0
    JNE D_Found
    JMP D_Fail
    
D_Found:
    MOV BX, foundIndex
    LEA SI, isActive
    MOV BYTE PTR [SI + BX], 0
    
    GOTOXY 10, 20
    PRINT msgDel
    MOV AH, 01h
    INT 21h
    RET

D_Fail:
    GOTOXY 10, 20
    PRINT msgNotFound
    MOV AH, 01h
    INT 21h
    RET
DeleteBook ENDP

; ====================================================================
; HELPERS
; ====================================================================

InitMemory PROC
    MOV bookCount, 0
    MOV userCount, 0
    LEA DI, isActive
    MOV CX, MAX_BOOKS
    MOV AL, 0
    REP STOSB
    LEA DI, bookIDs
    MOV CX, DB_SIZE
    MOV AL, '$'
    REP STOSB
    LEA DI, bookTitles
    MOV CX, DB_SIZE
    MOV AL, '$'
    REP STOSB
    LEA DI, bookAuthors
    MOV CX, DB_SIZE
    MOV AL, '$'
    REP STOSB
    RET
InitMemory ENDP

GetInput PROC
    LEA DX, inputBuff
    MOV AH, 0Ah
    INT 21h
    RET
GetInput ENDP

StringCopy PROC
    PUSH CX
    PUSH SI
    PUSH DI
    MOV CL, [inputBuff + 1] 
    MOV CH, 0
    MOV DI, BX
    REP MOVSB
    MOV BYTE PTR [DI], '$'
    POP DI
    POP SI
    POP CX
    RET
StringCopy ENDP

CompareStrings PROC
    PUSH CX
    PUSH SI
    PUSH DI
    MOV CL, [inputBuff + 1] 
    MOV CH, 0
    REPE CMPSB
    JNE NoMatch
    MOV AL, [DI]
    CMP AL, '$'
    JNE NoMatch
    MOV AX, 1
    JMP CompEnd
NoMatch:
    MOV AX, 0
CompEnd:
    POP DI
    POP SI
    POP CX
    RET
CompareStrings ENDP

FindBookID PROC
    MOV CX, MAX_BOOKS
    MOV BX, 0
FindLoop:
    LEA SI, isActive
    MOV AL, [SI + BX]
    CMP AL, 0
    JE  FindNext
    PUSH BX
    MOV AX, BX
    MOV DX, STR_LEN
    MUL DX
    MOV DI, AX
    LEA SI, inputBuff + 2
    LEA BX, bookIDs
    ADD BX, DI
    MOV DI, BX
    CALL CompareStrings
    POP BX
    CMP AX, 1
    JE  FoundIt
FindNext:
    INC BX
    LOOP FindLoop
    MOV AX, 0
    RET
FoundIt:
    MOV foundIndex, BX
    MOV AX, 1
    RET
FindBookID ENDP

PrintFixed PROC
    PUSH AX
    PUSH BX
    PUSH SI
    PUSH CX
    PUSH DX
    MOV SI, DX      
    MOV BX, 0       
PF_Loop:
    CMP BX, CX      
    JAE PF_Pad      
    MOV AL, [SI]
    CMP AL, '$'
    JE  PF_Pad      
    MOV AH, 02h
    MOV DL, AL
    INT 21h
    INC SI
    INC BX
    JMP PF_Loop
PF_Pad:
    CMP BX, CX      
    JAE PF_Done
    MOV AH, 02h
    MOV DL, ' '
    INT 21h
    INC BX
    JMP PF_Pad
PF_Done:
    POP DX
    POP CX
    POP SI
    POP BX
    POP AX
    RET
PrintFixed ENDP

END MAIN