; FILE: PREFINAL.ASM
; DESCRIPTION: Air Condition Unit Controller Simulation
; DATE: 11/20/25

; INSTRUCTIONS:

; 1. Write an Assembly Language program to control an air condition unit.

; 2. Code Filename: PREFINAL_YOURLASTNAME.ASM (Example: PREFINAL_LASTNAME.ASM)

; 3. You have until five (5) minutes before dismissal to finish this task.

; 4. Criteria for Grading (100%)
; Complete and correct text content - 20%
; Correct input and output process - 30%
; Proper layout of UI elements (such as alignment, correct sequence of elements) - 30%
; Use of color and design - 20%

; 5. Upload your SOURCE CODE .ASM to your OneDrive or Google Drive folder.

; 6. Attach and submit the URL link here.

; 7. Don't forget to TURN IN.

; 9. The air condition unit has the following controllable features and values to choose from for each feature:
; 1) Power - On, Off
; 2) Swing - On, Off
; 3) Eco Mode - On, Off
; 4) Fan - On, Off
; 5) Cool - On, Off
; 6) Turbo - On, Off
; 7) Timer - On, Off
; 8) Quiet - On, Off
; 9) Sleep - On, Off

; 10. Every time you run the program, all features are set to default values (Off).

; 11. Design an user-friendly interface to allow the user to set the values for each feature. Use colors to make your user interface more interesting.

; 12. Provide an always visible status of all the features, together with the main menu.

; 13. Display blinking INPUT ERROR! for each input error made by user.

; 14. Sample Display (you may create your own user interface design). 
; Take note that pressing each number toggles the value of each feature to On or Off. 
; For example: If the current value of 1 Power is Off, then pressing 1 will change Power value to On. 
; Then pressing again 1 Power will change value to Off. 
; Use CLEAR SCREEN to update the MAIN MENU STATUS every time a user presses a valid choice.

; ===SAMPLE RUN===

; CIT-U AIR CONDITION UNIT
; Programmer: YOUR FULL NAME HERE
; WELCOME!
; MAIN MENU STATUS
; 1 Power: Off     4 Eco Mode: Off     7 Turbo: Off      0 Exit
; 2 Swing: Off      5 Fan: Off           8 Timer: Off
; 3 Quiet: Off     6 Cool: Off             9 Sleep: Off
; Enter choice: 1

; || CLEAR SCREEN after pressing ENTER key and update MAIN MENU STATUS
; \/

; CIT-U AIR CONDITION UNIT
; Programmer: YOUR FULL NAME HERE
; WELCOME!
; MAIN MENU STATUS
; 1 Power: On        4 Eco Mode: Off    7 Turbo: Off      0 Exit
; 2 Swing: Off      5 Fan: Off           8 Timer: Off
; 3 Quiet: Off     6 Cool: Off            9 Sleep: Off
; Enter choice: 9

; || CLEAR SCREEN after pressing ENTER key and update MAIN MENU STATUS
; \/

; CIT-U AIR CONDITION UNIT
; Programmer: YOUR FULL NAME HERE
; WELCOME!
; MAIN MENU STATUS
; 1 Power: On        4 Eco Mode: Off    7 Turbo: Off      0 Exit
; 2 Swing: Off      5 Fan: Off           8 Timer: Off
; 3 Quiet: Off     6 Cool: Off             9 Sleep: On
; Enter choice: a
; INPUT ERROR!

; || CLEAR SCREEN after pressing enter when INPUT ERROR! occurs.
; \/

; CIT-U AIR CONDITION UNIT
; Programmer: YOUR FULL NAME HERE
; WELCOME!
; MAIN MENU STATUS
; 1 Power: On        4 Eco Mode: Off    7 Turbo: Off      0 Exit
; 2 Swing: Off      5 Fan: Off           8 Timer: Off
; 3 Quiet: Off     6 Cool: Off             9 Sleep: On
; Enter choice: 4

; || CLEAR SCREEN after pressing ENTER key and update MAIN MENU STATUS
; \/

; CIT-U AIR CONDITION UNIT
; Programmer: YOUR FULL NAME HERE
; WELCOME!
; MAIN MENU STATUS
; 1 Power: On       4 Eco Mode: On     7 Turbo: Off      0 Exit
; 2 Swing: Off      5 Fan: Off           8 Timer: Off
; 3 Quiet: Off     6 Cool: Off            9 Sleep: On
; Enter choice: 0

; Thank you. Be cool always!

; =====NOTHING FOLLOWS=====

.MODEL SMALL
.STACK 100h

.DATA
    ; --- UI STRINGS ---
    header_txt   DB 'CIT-U AIR CONDITION UNIT$'
    prog_name    DB 'Programmer: GooberXD$' 
    welcome_txt  DB 'WELCOME!$'
    menu_title   DB 'MAIN MENU STATUS$'
    
    ; --- MENU LABELS (Padded for alignment) ---
    ; Row 1
    lbl_1        DB '1 Power:   $'
    lbl_4        DB '4 Eco Mode:  $'
    lbl_7        DB '7 Turbo:   $'
    lbl_0        DB '0 Exit$'
    
    ; Row 2
    lbl_2        DB '2 Swing:   $'
    lbl_5        DB '5 Fan:       $'
    lbl_8        DB '8 Timer:   $'
    
    ; Row 3
    lbl_3        DB '3 Quiet:   $'
    lbl_6        DB '6 Cool:      $'
    lbl_9        DB '9 Sleep:   $'

    ; --- STATUS STRINGS ---
    str_on       DB 'On $'
    str_off      DB 'Off$'
    
    ; --- PROMPTS AND MESSAGES ---
    prompt_txt   DB 'Enter choice: $'
    error_txt    DB 'INPUT ERROR!$'
    pwr_msg      DB 'Power is turned off!$' 
    exit_txt     DB 'Thank you. Be cool always!$'

    ; --- STATE VARIABLES ---
    ; 0 = Off, 1 = On. 
    ; Index 1=Power, Index 2=Swing, etc.
    states       DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
    
    ; --- INPUT VARIABLES ---
    input_char   DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 00h
    MOV AL, 03h
    INT 10h

PROGRAM_LOOP:
    CALL DRAW_INTERFACE
    
    ; Move cursor to bottom to ask for input
    MOV DH, 7       ; Row 7 (Adjusted for layout)
    MOV DL, 0       ; Col 0
    CALL SET_CURSOR
    
    ; Print "Enter choice: "
    LEA DX, prompt_txt
    MOV AH, 09h
    INT 21h
    
    ; Get Input (Single Char)
    MOV AH, 01h
    INT 21h
    MOV input_char, AL
    
    ; --- LOGIC: Handle Enter Key Requirement ---
    CMP input_char, 0Dh 
    JE  INPUT_ERROR_HANDLER
    
    ; Save the valid input temporarily in BL
    MOV BL, input_char
    
    ; Wait for second key (Expect Enter/13)
    MOV AH, 01h
    INT 21h
    CMP AL, 0Dh     ; Check if second key is ENTER
    JNE INPUT_ERROR_HANDLER 
    
    ; Restore the actual input for processing
    MOV AL, BL

    ; Check for '0' (Exit)
    CMP AL, '0'
    JE  EXIT_PROGRAM

    ; Check range '1' to '9'
    CMP AL, '1'
    JB  INPUT_ERROR_HANDLER
    CMP AL, '9'
    JA  INPUT_ERROR_HANDLER

    ; --- VALIDATION SUCCESSFUL, PREPARE LOGIC ---
    
    ; Convert ASCII to Integer Index
    SUB AL, '0'
    MOV AH, 0
    MOV SI, AX      ; SI now holds index 1-9
    
    ; =========================================================
    ; LOGIC: CHECK POWER STATE
    ; =========================================================
    
    ; 1. Check if the user pressed '1' (Power button)
    CMP SI, 1
    JE  TOGGLE_FEATURE  ; If user pressed 1, allow toggle regardless of state
    
    ; 2. If user pressed anything else (2-9), check if Power is ON
    ; Power state is stored at states[1]
    CMP states[1], 1    ; Compare Power state with 1 (On)
    JE  TOGGLE_FEATURE  ; If Power is On, allow toggle
    
    ; 3. If Power is OFF and user tried to change something else
    JMP POWER_OFF_HANDLER 

TOGGLE_FEATURE:
    ; Toggle the state (0 -> 1, 1 -> 0) using XOR
    MOV AL, states[SI]
    XOR AL, 1
    MOV states[SI], AL
    
    JMP PROGRAM_LOOP ; Loop back

; ----------------------------------------------------------
; ERROR HANDLER 1: Generic Input Error (Invalid Key)
; ----------------------------------------------------------
INPUT_ERROR_HANDLER:
    ; Move cursor to next line
    MOV DH, 8
    MOV DL, 0
    CALL SET_CURSOR
    
    ; Print Blinking Error
    CALL PRINT_BLINKING_ERROR
    
    ; Wait for a key press before clearing
    MOV AH, 07h 
    INT 21h
    
    JMP PROGRAM_LOOP

; ----------------------------------------------------------
; ERROR HANDLER 2: Power Off Constraint
; ----------------------------------------------------------
POWER_OFF_HANDLER:
    ; Move cursor to next line
    MOV DH, 8
    MOV DL, 0
    CALL SET_CURSOR
    
    ; Print specific message in Red
    LEA DX, pwr_msg
    MOV BL, 0Ch      ; Light Red
    CALL PRINT_WITH_COLOR
    
    ; Wait for a key press before clearing
    MOV AH, 07h 
    INT 21h
    
    JMP PROGRAM_LOOP

EXIT_PROGRAM:
    ; Move cursor down
    MOV DH, 10
    MOV DL, 0
    CALL SET_CURSOR

    ; Print Exit Message in Light Cyan
    LEA DX, exit_txt
    MOV BL, 0Bh     ; 0Bh = Light Cyan
    CALL PRINT_WITH_COLOR
    
    ; Terminate Program
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

; ==========================================================
; PROCEDURE: DRAW_INTERFACE
; Clears screen and draws all static text (with colors) and statuses
; ==========================================================
DRAW_INTERFACE PROC
    ; Clear Screen
    MOV AX, 0600h   ; AH=06 (Scroll), AL=00 (Full screen)
    MOV BH, 07h     ; Attribute: White on Black
    MOV CX, 0000h   ; Upper left
    MOV DX, 184Fh   ; Lower right
    INT 10h

    ; --- HEADER (YELLOW) ---
    MOV DH, 0
    MOV DL, 0
    CALL SET_CURSOR
    LEA DX, header_txt
    MOV BL, 0Eh     ; 0Eh = Yellow
    CALL PRINT_WITH_COLOR
    
    ; --- PROGRAMMER NAME (CYAN) ---
    MOV DH, 1
    MOV DL, 0
    CALL SET_CURSOR
    LEA DX, prog_name
    MOV BL, 0Bh     ; 0Bh = Light Cyan
    CALL PRINT_WITH_COLOR

    ; --- WELCOME (GREEN) ---
    MOV DH, 2
    MOV DL, 0
    CALL SET_CURSOR
    LEA DX, welcome_txt
    MOV BL, 0Ah     ; 0Ah = Light Green
    CALL PRINT_WITH_COLOR
    
    ; --- MENU TITLE (GREEN) ---
    MOV DH, 3
    MOV DL, 0
    CALL SET_CURSOR
    LEA DX, menu_title
    MOV BL, 0Ah     ; 0Ah = Light Green
    CALL PRINT_WITH_COLOR

    ; --- DRAW MENU ITEMS AND STATUSES ---
    
    ; === ROW 4 ===
    ; 1 Power
    MOV DH, 4
    MOV DL, 0
    CALL SET_CURSOR
    LEA DX, lbl_1
    CALL PRINT_LABEL 
    MOV SI, 1        
    CALL PRINT_STATE 
    
    ; 4 Eco Mode
    MOV DH, 4
    MOV DL, 25
    CALL SET_CURSOR
    LEA DX, lbl_4
    CALL PRINT_LABEL
    MOV SI, 4
    CALL PRINT_STATE
    
    ; 7 Turbo
    MOV DH, 4
    MOV DL, 50
    CALL SET_CURSOR
    LEA DX, lbl_7
    CALL PRINT_LABEL
    MOV SI, 7
    CALL PRINT_STATE

    ; 0 Exit
    MOV DH, 4
    MOV DL, 70
    CALL SET_CURSOR
    LEA DX, lbl_0
    CALL PRINT_LABEL

    ; === ROW 5 ===
    ; 2 Swing
    MOV DH, 5
    MOV DL, 0
    CALL SET_CURSOR
    LEA DX, lbl_2
    CALL PRINT_LABEL
    MOV SI, 2
    CALL PRINT_STATE
    
    ; 5 Fan
    MOV DH, 5
    MOV DL, 25
    CALL SET_CURSOR
    LEA DX, lbl_5
    CALL PRINT_LABEL
    MOV SI, 5
    CALL PRINT_STATE
    
    ; 8 Timer
    MOV DH, 5
    MOV DL, 50
    CALL SET_CURSOR
    LEA DX, lbl_8
    CALL PRINT_LABEL
    MOV SI, 8
    CALL PRINT_STATE

    ; === ROW 6 ===
    ; 3 Quiet
    MOV DH, 6
    MOV DL, 0
    CALL SET_CURSOR
    LEA DX, lbl_3
    CALL PRINT_LABEL
    MOV SI, 3
    CALL PRINT_STATE
    
    ; 6 Cool
    MOV DH, 6
    MOV DL, 25
    CALL SET_CURSOR
    LEA DX, lbl_6
    CALL PRINT_LABEL
    MOV SI, 6
    CALL PRINT_STATE
    
    ; 9 Sleep
    MOV DH, 6
    MOV DL, 50
    CALL SET_CURSOR
    LEA DX, lbl_9
    CALL PRINT_LABEL
    MOV SI, 9
    CALL PRINT_STATE

    RET
DRAW_INTERFACE ENDP

; ==========================================================
; PROCEDURE: PRINT_WITH_COLOR
; Input: DX = Offset of string (ending with $)
;        BL = Color Attribute
; ==========================================================
PRINT_WITH_COLOR PROC
    MOV SI, DX       ; Move string offset to SI
P_COLOR_LOOP:
    LODSB            ; Load char from DS:SI into AL
    CMP AL, '$'      ; Check for end of string
    JE  P_COLOR_DONE
    
    MOV AH, 09h      ; Write Char & Attribute
    MOV CX, 1        ; Write 1 char
    MOV BH, 0        ; Page 0
    ; BL is already set by caller
    INT 10h
    
    ; Move Cursor Forward
    MOV AH, 03h      ; Get current cursor position
    INT 10h
    INC DL           ; Move 1 column right
    MOV AH, 02h      ; Set new cursor position
    INT 10h
    
    JMP P_COLOR_LOOP

P_COLOR_DONE:
    RET
PRINT_WITH_COLOR ENDP

; ==========================================================
; PROCEDURE: PRINT_STATE
; Input: SI = Index in 'states' array
; Logic: Checks states[SI]. If 1 -> Print Green "On", If 0 -> Print Red "Off"
; ==========================================================
PRINT_STATE PROC
    CMP states[SI], 1
    JE  STATE_IS_ON
    
    ; Case: OFF (Red Color)
    LEA DX, str_off  ; Load Address
    MOV BL, 04h      ; Red Text
    CALL PRINT_WITH_COLOR
    RET

STATE_IS_ON:
    ; Case: ON (Light Green Color)
    LEA DX, str_on   ; Load Address
    MOV BL, 0Ah      ; Light Green Text
    CALL PRINT_WITH_COLOR
    RET
PRINT_STATE ENDP

; ==========================================================
; PROCEDURE: PRINT_BLINKING_ERROR
; Prints "INPUT ERROR!" in blinking red
; ==========================================================
PRINT_BLINKING_ERROR PROC
    LEA DX, error_txt
    MOV BL, 8Ch      ; 1000 1100b (Blink bit set + Light Red)
    CALL PRINT_WITH_COLOR
    RET
PRINT_BLINKING_ERROR ENDP

; ==========================================================
; PROCEDURE: SET_CURSOR
; Inputs: DH = Row, DL = Column
; ==========================================================
SET_CURSOR PROC
    MOV AH, 02h
    MOV BH, 00h
    INT 10h
    RET
SET_CURSOR ENDP

; ==========================================================
; PROCEDURE: PRINT_LABEL
; Input: DX points to string ending in $
; ==========================================================
PRINT_LABEL PROC
    MOV AH, 09h
    INT 21h
    RET
PRINT_LABEL ENDP

END MAIN