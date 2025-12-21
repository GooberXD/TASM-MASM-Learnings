; Filename: FINALEXAM_GooberXD.ASM
; CS243 Lab Hands-on Final Exam
; First Semester SY 2025-2026
; Student Name: GooberXD
; Date Finished: December 11, 2025

.MODEL SMALL
.STACK 100H

.DATA
    ; =============================================================
    ; CONSTANTS AND VARIABLES
    ; =============================================================
    
    ; Header Strings
    HEADER1         DB 'Cebu Institute of Technology - University$'
    HEADER2         DB 'College of Computer Studies$'
    HEADER3         DB 'FAVORITE CLASSMATE VOTING SYSTEM$'
    HEADER4         DB 'Programmer: GooberXD$' 
    
    ; Menu Strings 
    MENU_TITLE      DB 'MAIN MENU$'
    
    ; Option 1
    OPT1_NUM        DB '1. $'
    OPT1_TXT        DB 'Vote$'    
    
    ; Option 2
    OPT2_NUM        DB '2. $'
    OPT2_TXT        DB 'View$'    
    
    ; Option 3
    OPT3_NUM        DB '3. $'
    OPT3_TXT        DB 'Update$'  
    
    ; Option 4
    OPT4_NUM        DB '4. $'
    OPT4_TXT        DB 'Delete$'  
    
    ; Option 5
    OPT5_TXT        DB '5. Exit$'
    
    PROMPT_CHOICE   DB 'Enter choice: $'
    
    ; Operation Strings 
    TITLE_VOTE      DB 'Vote$'
    TITLE_VIEW      DB 'View$'
    TITLE_UPDATE    DB 'Update$'
    TITLE_DELETE    DB 'Delete$'
    
    ; Input Prompts
    PROMPT_NAME     DB 'Enter candidate name: $'
    PROMPT_RATING   DB 'Enter vote rating (0-100): $'
    PROMPT_REC_UPD  DB 'Enter record number to update: $'
    PROMPT_NEW_NAME DB 'Enter new candidate name: $'
    PROMPT_NEW_RATE DB 'Enter new vote rating (0-100): $'
    PROMPT_REC_DEL  DB 'Enter record number to delete: $'
    
    ; Messages
    MSG_PAUSE       DB 'Press any key to go back to Main Menu...$'
    MSG_NO_REC      DB 'No record found.$'
    MSG_DELETED     DB 'Record deleted.$'
    MSG_EXITING     DB 'Exiting...$'
    MSG_THANKYOU    DB 'Thank you for using Favorite Classmate Voting System.$'
    MSG_FULL        DB 'Database is full!$'
    MSG_INVALID     DB 'Invalid input!$'
    
    ; Formatting
    NEWLINE         DB 0DH, 0AH, '$'
    SEPARATOR       DB ' - $'
    DOT_SPACE       DB '. $'
    
    ; Data Storage
    MAX_CAPACITY    EQU 10
    NAME_SIZE       EQU 30
    RATING_SIZE     EQU 5
    
    RECORD_COUNT    DB 0  ; Current number of records
    CURRENT_IDX     DB 0  ; TEMP VARIABLE 
    
    ; Arrays
    NAMES_ARR       DB 300 DUP ('$') ; 10 records * 30 chars
    RATINGS_ARR     DB 50 DUP ('$')  ; 10 records * 5 chars
    
    ; Input Buffers
    IN_NAME_BUF     DB 29, ?, 29 DUP('$') ; Max 29 chars
    IN_RATE_BUF     DB 4, ?, 4 DUP('$')   ; Max 4 chars
    IN_CHAR_BUF     DB ?, '$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX      ; Set ES for string operations

  
    MOV AX, 1003H   
    MOV BX, 0000H   
    INT 10H

MAIN_LOOP:
    ; --- MAIN MENU: BLACK BACKGROUND ---
    MOV BL, 07H     ; Black BG (0), White FG (7)
    CALL CLEAR_SCREEN
    
    CALL DISPLAY_HEADER
    
    ; Display Menu Title
    LEA DX, MENU_TITLE
    CALL PRINT_STR_NL
    
    ; --- OPTION 1: VOTE (YELLOW BG) ---
    LEA DX, OPT1_NUM
    CALL PRINT_STR          
    LEA DX, OPT1_TXT
    MOV BL, 0E0H            
    CALL PRINT_STR_COLOR    ; Print " Vote " with color
    CALL NEW_LINE
    
    ; --- OPTION 2: VIEW (RED BG) ---
    LEA DX, OPT2_NUM
    CALL PRINT_STR          
    LEA DX, OPT2_TXT
    MOV BL, 4FH             ; 4F = Red BG, White FG
    CALL PRINT_STR_COLOR    
    CALL NEW_LINE
    
    ; --- OPTION 3: UPDATE (GREEN BG) ---
    LEA DX, OPT3_NUM
    CALL PRINT_STR          
    LEA DX, OPT3_TXT
    MOV BL, 2FH             
    CALL PRINT_STR_COLOR    
    CALL NEW_LINE
    
    ; --- OPTION 4: DELETE (BLUE BG) ---
    LEA DX, OPT4_NUM
    CALL PRINT_STR          
    LEA DX, OPT4_TXT
    MOV BL, 1FH             
    CALL PRINT_STR_COLOR    
    CALL NEW_LINE
    
    ; --- OPTION 5: EXIT (NORMAL) ---
    LEA DX, OPT5_TXT
    CALL PRINT_STR_NL
    
    CALL NEW_LINE
    LEA DX, PROMPT_CHOICE
    CALL PRINT_STR
    
    ; Get Choice
    MOV AH, 01H
    INT 21H
    MOV BL, AL      
    
    
    CMP BL, '1'
    JNE CHECK_2
    JMP GO_VOTE
    
CHECK_2:
    CMP BL, '2'
    JNE CHECK_3
    JMP GO_VIEW

CHECK_3:
    CMP BL, '3'
    JNE CHECK_4
    JMP GO_UPDATE

CHECK_4:
    CMP BL, '4'
    JNE CHECK_5
    JMP GO_DELETE

CHECK_5:
    CMP BL, '5'
    JNE INVALID_CHOICE
    JMP GO_EXIT

INVALID_CHOICE:
    JMP MAIN_LOOP

; =============================================================
; 1. VOTE (CREATE)
; =============================================================
GO_VOTE:
    ; Normal screen (Black BG) for input/operation
    MOV BL, 07H     
    CALL CLEAR_SCREEN
    
    CALL DISPLAY_HEADER
    
    ; --- PRINT TITLE WITH COLOR (YELLOW) ---
    LEA DX, TITLE_VOTE
    MOV BL, 0E0H            ; Yellow BG, Black FG
    CALL PRINT_STR_COLOR
    CALL NEW_LINE
    
    ; Check if full
    CMP RECORD_COUNT, MAX_CAPACITY
    JAE STORAGE_FULL
    
    ; Input Name
    LEA DX, PROMPT_NAME
    CALL PRINT_STR
    LEA DX, IN_NAME_BUF
    CALL GET_STRING
    CALL NEW_LINE
    
    ; Input Rating
    LEA DX, PROMPT_RATING
    CALL PRINT_STR
    LEA DX, IN_RATE_BUF
    CALL GET_STRING
    CALL NEW_LINE
    
    ; Calculate Offset for Name
    XOR AX, AX
    MOV AL, RECORD_COUNT
    MOV CX, NAME_SIZE
    MUL CX
    LEA DI, NAMES_ARR
    ADD DI, AX
    
    ; Copy Name
    LEA SI, IN_NAME_BUF + 2
    MOV CL, [IN_NAME_BUF + 1]
    XOR CH, CH
    CLD
    REP MOVSB
    
    ; Calculate Offset for Rating
    XOR AX, AX
    MOV AL, RECORD_COUNT
    MOV CX, RATING_SIZE
    MUL CX
    LEA DI, RATINGS_ARR
    ADD DI, AX
    
    ; Copy Rating
    LEA SI, IN_RATE_BUF + 2
    MOV CL, [IN_RATE_BUF + 1]
    XOR CH, CH
    REP MOVSB
    
    INC RECORD_COUNT
    JMP PAUSE_RET

STORAGE_FULL:
    LEA DX, MSG_FULL
    CALL PRINT_STR_NL
    JMP PAUSE_RET

; =============================================================
; 2. VIEW (READ)
; =============================================================
GO_VIEW:
    ; Normal screen (Black BG)
    MOV BL, 07H
    CALL CLEAR_SCREEN
    
    CALL DISPLAY_HEADER
    
    ; --- PRINT TITLE WITH COLOR (RED) ---
    LEA DX, TITLE_VIEW
    MOV BL, 4FH             ; Red BG, White FG
    CALL PRINT_STR_COLOR
    CALL NEW_LINE
    
    CMP RECORD_COUNT, 0
    JE NO_RECORDS
    
    CALL DISPLAY_ALL_RECORDS
    JMP PAUSE_RET

NO_RECORDS:
    LEA DX, MSG_NO_REC
    CALL PRINT_STR_NL
    JMP PAUSE_RET

; =============================================================
; 3. UPDATE
; =============================================================
GO_UPDATE:
    ; Normal screen (Black BG)
    MOV BL, 07H
    CALL CLEAR_SCREEN
    
    CALL DISPLAY_HEADER
    
    ; --- PRINT TITLE WITH COLOR (GREEN) ---
    LEA DX, TITLE_UPDATE
    MOV BL, 2FH             ; Green BG, White FG
    CALL PRINT_STR_COLOR
    CALL NEW_LINE
    
    CMP RECORD_COUNT, 0
    JE NO_RECORDS
    
    CALL DISPLAY_ALL_RECORDS
    
    ; Ask for record number
    LEA DX, PROMPT_REC_UPD
    CALL PRINT_STR
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BL, AL
    
    CALL NEW_LINE
    
    ; === FIX FOR JUMP RANGE ===
    CMP BL, 1
    JB UPDATE_ERROR_STUB    
    CMP BL, RECORD_COUNT
    JA UPDATE_ERROR_STUB    
    
    ; If valid, jump over the stub
    JMP CONTINUE_UPDATE

UPDATE_ERROR_STUB:
    JMP UPDATE_INVALID      

CONTINUE_UPDATE:
    DEC BL
    
    MOV CURRENT_IDX, BL 
    
    ; Input New Name
    LEA DX, PROMPT_NEW_NAME
    CALL PRINT_STR
    LEA DX, IN_NAME_BUF
    CALL GET_STRING
    CALL NEW_LINE
    
    ; Input New Rating
    LEA DX, PROMPT_NEW_RATE
    CALL PRINT_STR
    LEA DX, IN_RATE_BUF
    CALL GET_STRING
    CALL NEW_LINE
    
    ; --- UPDATE NAME ---
    XOR AX, AX
    MOV AL, CURRENT_IDX 
    MOV CX, NAME_SIZE
    MUL CX
    LEA DI, NAMES_ARR
    ADD DI, AX
    
    PUSH DI
    MOV CX, NAME_SIZE
    MOV AL, '$'
    REP STOSB
    POP DI
    
    LEA SI, IN_NAME_BUF + 2
    MOV CL, [IN_NAME_BUF + 1]
    XOR CH, CH
    CLD             ; Ensure forward direction
    REP MOVSB
    
    ; --- UPDATE RATING ---
    XOR AX, AX
    MOV AL, CURRENT_IDX 
    MOV CX, RATING_SIZE
    MUL CX
    LEA DI, RATINGS_ARR
    ADD DI, AX
    
    PUSH DI
    MOV CX, RATING_SIZE
    MOV AL, '$'
    REP STOSB
    POP DI
    
    LEA SI, IN_RATE_BUF + 2
    MOV CL, [IN_RATE_BUF + 1]
    XOR CH, CH
    REP MOVSB
    
    JMP PAUSE_RET

UPDATE_INVALID:
    LEA DX, MSG_INVALID
    CALL PRINT_STR_NL
    JMP PAUSE_RET

; =============================================================
; 4. DELETE
; =============================================================
GO_DELETE:
    ; Normal screen (Black BG)
    MOV BL, 07H
    CALL CLEAR_SCREEN

    CALL DISPLAY_HEADER
    
    ; --- PRINT TITLE WITH COLOR (BLUE) ---
    LEA DX, TITLE_DELETE
    MOV BL, 1FH             ; Blue BG, White FG
    CALL PRINT_STR_COLOR
    CALL NEW_LINE
    
    CMP RECORD_COUNT, 0
    ; === FIX FOR JUMP OUT OF RANGE ===
    JNE PROCEED_TO_DELETE
    JMP NO_RECORDS_DEL
    
PROCEED_TO_DELETE:
    CALL DISPLAY_ALL_RECORDS
    
    ; Ask for record number
    LEA DX, PROMPT_REC_DEL
    CALL PRINT_STR
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BL, AL
    
    CALL NEW_LINE
    
    ; === FIX FOR JUMP RANGE ===
    CMP BL, 1
    JB DELETE_ERROR_STUB    
    CMP BL, RECORD_COUNT
    JA DELETE_ERROR_STUB    
    
    JMP CONTINUE_DELETE

DELETE_ERROR_STUB:
    JMP DELETE_INVALID      

CONTINUE_DELETE:
    DEC BL
    
    MOV CL, BL
    XOR CH, CH
    
SHIFT_LOOP:
    MOV AL, CL
    INC AL
    CMP AL, RECORD_COUNT
    JAE FINISH_DELETE
    
    ; Shift Name
    XOR AX, AX
    MOV AL, CL
    INC AL
    MOV DX, NAME_SIZE
    MUL DX
    LEA SI, NAMES_ARR
    ADD SI, AX
    
    XOR AX, AX
    MOV AL, CL
    MOV DX, NAME_SIZE
    MUL DX
    LEA DI, NAMES_ARR
    ADD DI, AX
    
    PUSH CX
    MOV CX, NAME_SIZE
    REP MOVSB
    POP CX
    
    ; Shift Rating
    XOR AX, AX
    MOV AL, CL
    INC AL
    MOV DX, RATING_SIZE
    MUL DX
    LEA SI, RATINGS_ARR
    ADD SI, AX
    
    XOR AX, AX
    MOV AL, CL
    MOV DX, RATING_SIZE
    MUL DX
    LEA DI, RATINGS_ARR
    ADD DI, AX
    
    PUSH CX
    MOV CX, RATING_SIZE
    REP MOVSB
    POP CX
    
    INC CL
    JMP SHIFT_LOOP

FINISH_DELETE:
    DEC RECORD_COUNT
    LEA DX, MSG_DELETED
    CALL PRINT_STR_NL
    JMP PAUSE_RET

DELETE_INVALID:
    LEA DX, MSG_INVALID
    CALL PRINT_STR_NL
    JMP PAUSE_RET

NO_RECORDS_DEL:
    LEA DX, MSG_NO_REC
    CALL PRINT_STR_NL
    JMP PAUSE_RET

; =============================================================
; 5. EXIT
; =============================================================
GO_EXIT:
    CALL NEW_LINE
    LEA DX, MSG_EXITING
    CALL PRINT_STR_NL
    LEA DX, MSG_THANKYOU
    CALL PRINT_STR_NL
    MOV AH, 4CH
    INT 21H

; =============================================================
; SUBROUTINES
; =============================================================

PAUSE_RET:
    CALL NEW_LINE
    LEA DX, MSG_PAUSE
    CALL PRINT_STR_NL
    MOV AH, 07H
    INT 21H
    JMP MAIN_LOOP

MAIN ENDP

; Procedure: Clear Screen with Color
; INPUT: BL register contains the Color Attribute
CLEAR_SCREEN PROC
    MOV AX, 0600H   
    MOV BH, BL      
    MOV CX, 0000H   
    MOV DX, 184FH   
    INT 10H
    
    ; Reset Cursor to 0,0
    MOV AH, 02H
    MOV BH, 00H
    MOV DX, 0000H
    INT 10H
    RET
CLEAR_SCREEN ENDP

; Procedure: Print String with Color
PRINT_STR_COLOR PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    
    MOV SI, DX      ; SI points to string
    MOV BH, 00H     ; Page 0
    
PSC_LOOP:
    MOV AL, [SI]
    CMP AL, '$'
    JE PSC_EXIT
    
    ; 1. Write Character with Attribute at current cursor pos
    MOV AH, 09H
    MOV CX, 1
    INT 10H
    
    ; 2. Advance Cursor
    ; Get current position (DX)
    MOV AH, 03H
    INT 10H
    
    INC DL          
    
    ; Set new position
    MOV AH, 02H
    INT 10H
    
    INC SI
    JMP PSC_LOOP
    
PSC_EXIT:
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_STR_COLOR ENDP

DISPLAY_HEADER PROC
    LEA DX, HEADER1
    CALL PRINT_STR_NL
    LEA DX, HEADER2
    CALL PRINT_STR_NL
    LEA DX, HEADER3
    CALL PRINT_STR_NL
    LEA DX, HEADER4
    CALL PRINT_STR_NL
    CALL NEW_LINE
    RET
DISPLAY_HEADER ENDP

DISPLAY_ALL_RECORDS PROC
    XOR CX, CX
    MOV CL, 0
    
DISPLAY_LOOP:
    CMP CL, RECORD_COUNT
    JAE END_DISPLAY
    
    ; Print Number
    MOV AL, CL
    ADD AL, 1
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    
    LEA DX, DOT_SPACE
    CALL PRINT_STR
    
    ; Print Name
    XOR AX, AX
    MOV AL, CL
    MOV BX, NAME_SIZE
    MUL BX
    LEA DX, NAMES_ARR
    ADD DX, AX
    CALL PRINT_STR
    
    LEA DX, SEPARATOR
    CALL PRINT_STR
    
    ; Print Rating
    XOR AX, AX
    MOV AL, CL
    MOV BX, RATING_SIZE
    MUL BX
    LEA DX, RATINGS_ARR
    ADD DX, AX
    CALL PRINT_STR
    
    CALL NEW_LINE
    
    INC CL
    JMP DISPLAY_LOOP
    
END_DISPLAY:
    RET
DISPLAY_ALL_RECORDS ENDP

PRINT_STR PROC
    MOV AH, 09H
    INT 21H
    RET
PRINT_STR ENDP

PRINT_STR_NL PROC
    MOV AH, 09H
    INT 21H
    CALL NEW_LINE
    RET
PRINT_STR_NL ENDP

NEW_LINE PROC
    LEA DX, NEWLINE
    MOV AH, 09H
    INT 21H
    RET
NEW_LINE ENDP

GET_STRING PROC
    MOV AH, 0AH
    INT 21H
    
    MOV BX, DX
    MOV AL, [BX+1]
    XOR AH, AH
    ADD BX, AX
    MOV BYTE PTR [BX+2], '$'
    RET
GET_STRING ENDP

END MAIN