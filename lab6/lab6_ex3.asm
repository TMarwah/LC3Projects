;=================================================
; Name: Tanmay Marwah
; Email: tmarw001@ucr.edu
; 
; Lab: lab 6, ex 3
; Lab section: 23
; TA: Westin Montano and Omer Eren
; 
;=================================================
.ORIG x3000

;CLEAN REGISTERS BEFORE NEW RUN
AND R0, R0, x0
AND R1, R1, x0
AND R2, R2, x0
AND R3, R3, x0
AND R4, R4, x0
AND R5, R5, x0
AND R6, R6, x0
AND R7, R7, x0

;load base, max, and top of stack
LD R3, BASE
LD R4, MAX
LD R5, TOS
LD R6, REGISTER_STORE_STACK
LEA R2, VALUES

    STACK_FILLER
    AND R1, R1, x0
    LDR R1, R2, #0
    LD R0, SUB_STACK_PUSH
    JSRR R0
    ADD R2, R2, #1
    ADD R1, R1, #0
    BRp STACK_FILLER

    STACK_POPPER
    LD R0, SUB_STACK_POP
    JSRR R0
    ADD R0, R0, #0
    BRp STACK_POPPER

;ASK FOR FIRST NUMBER
LEA R0, ENTER_NUM_PROMPT
PUTS
    
GETC
OUT
    
;LOAD OFFSET
LD R2, ASCII_OFFSET
NOT R2, R2
ADD R2, R2, 1
    
ADD R0, R0, R2 ;convert ascii char to number
    
AND R1, R1, x0
ADD R1, R1, R0 ;load number into R1 for PUSHING
    
LD R0, SUB_STACK_PUSH
JSRR R0

AND R0, R0, x0
LD R0, NEWLINE_MAIN
OUT

;ASK FOR SECOND NUMBER
LEA R0, ENTER_NUM_PROMPT
PUTS
    
GETC
OUT
    
;LOAD OFFSET
AND R2,R2, x0
LD R2, ASCII_OFFSET
NOT R2, R2
ADD R2, R2, 1
    
ADD R0, R0, R2 ;convert ascii char to number
    
AND R1, R1, x0
ADD R1, R1, R0 ;load number into R1 for PUSHING
    
LD R0, SUB_STACK_PUSH
JSRR R0

LD R0, SUB_RPN_ADDITION
JSRR R0

LD R0, SUB_STACK_POP
JSRR R0

LD R2, SUB_CHAR_CONVERT
JSRR R2

HALT
BASE .fill xA000
MAX .fill xA005
TOS .fill xA000
REGISTER_STORE_STACK .fill xFE00
SUB_STACK_PUSH .fill x3200
SUB_STACK_POP .fill x3400
SUB_RPN_ADDITION .fill x3600
SUB_CHAR_CONVERT .fill x3800
VALUES .fill #1
       .fill #2
       .fill #3
       .fill #4
       .fill #5
       .fill #6 ;will not get pushed due to overflow
ENTER_NUM_PROMPT .STRINGZ "Please enter a number"
ENTER_OP_PROMPT .STRINGZ "Please enter an operation"
ASCII_OFFSET .fill x30
NEWLINE_MAIN .fill x0A
.END

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R1): The value to push onto the stack
; Parameter (R3): BASE: A pointer to the base (one less than the lowest available                      ;                       address) of the stack
; Parameter (R4): MAX: The "highest" available address in the stack
; Parameter (R5): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R1) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R5 ??? updated TOS
;------------------------------------------------------------------------------------------
.ORIG x3200

    ;STORE REGISTERS INTO REG_STORE_STACK
    ADD R6, R6, #-1
    STR R7, R6, #0
    ADD R6, R6, #-1
    STR R3, R6, #0
    ADD R6, R6, #-1
    STR R4, R6, #0
    ADD R6, R6, #-1
    STR R2, R6, #0
    
    ;CHECK IF TOP OF STACK IS REACHED
    AND R2, R2, x0
    NOT R5, R5
    ADD R5, R5, 1
    ADD R2, R4, R5
    BRz TOP_REACHED
    
    ;PUT R1, into STACK
    NOT R5, R5
    ADD R5, R5, 1
    ADD R5, R5, #1
    STR R1, R5, #0
    ADD R5, R5, #0 ;ensure branch as r5 is always pos
    BRnp SKIP_OVERFLOW_MSG
    
    TOP_REACHED ;STACK IS FULL
    NOT R5, R5
    ADD R5, R5, 1
    AND R0, R0, x0
    LEA R0, OVERFLOW_MESSAGE ;print overflow message
    TRAP x22
    AND R0, R0, x0
    LD R0, NEWLINE
    OUT
    LD R1, NULL_PUSH
    
    SKIP_OVERFLOW_MSG
    
    
    LDR R2, R6, #0
    ADD R6, R6, #1
    LDR R4, R6, #0
    ADD R6, R6, #1
    LDR R3, R6, #0
    ADD R6, R6, #1
    LDR R7, R6, #0
    ADD R6, R6, #1

RET

OVERFLOW_MESSAGE .STRINGZ "Overflow occured"
NEWLINE .FILL x0A
NULL_PUSH .fill #0
.END

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R3): BASE: A pointer to the base (one less than the lowest available                      ;                       address) of the stack
; Parameter (R4): MAX: The "highest" available address in the stack
; Parameter (R5): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack and copied it to R0.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Values: R0 ??? value popped off the stack
;		   R5 ??? updated TOS
;------------------------------------------------------------------------------------------
.ORIG x3400

    ;STORE REGISTERS INTO REG_STORE_STACK
    ADD R6, R6, #-1
    STR R7, R6, #0
    ADD R6, R6, #-1
    STR R3, R6, #0
    ADD R6, R6, #-1
    STR R4, R6, #0
    ADD R6, R6, #-1
    STR R2, R6, #0

    ;CHECK IF BOTTOM OF STACK IS REACHED
    NOT R5, R5
    ADD R5, R5, 1
    ADD R2, R3, R5
    BRz UNDERFLOW_OCCURED
    
    ;POP TOP VAL INTO R0, into STACK
    NOT R5, R5
    ADD R5, R5, 1
    LDR R0, R5, #0
    LD R2, NULL_POP
    STR R2, R5, #0
    ADD R5, R5, #-1
    ADD R5, R5, #0 ;ensure branch as r5 is always pos
    BRnp SKIP_UNDERFLOW_MSG
    
    UNDERFLOW_OCCURED
        NOT R5, R5
        ADD R5, R5, 1
        AND R0, R0, x0
        LEA R0, UNDERFLOW_MESSAGE
        PUTS
        AND R0, R0, x0
        LD R0, NEWLINE2
        OUT
        LDR R0, R5, #0
    
    SKIP_UNDERFLOW_MSG
    
    
    LDR R2, R6, #0
    ADD R6, R6, #1
    LDR R4, R6, #0
    ADD R6, R6, #1
    LDR R3, R6, #0
    ADD R6, R6, #1
    LDR R7, R6, #0
    ADD R6, R6, #1
    
RET
UNDERFLOW_MESSAGE .STRINGZ "Underflow occured"
NEWLINE2 .fill x0A
NULL_POP .fill #0
.END

;------------------------------------------------------------------------------------------
; Subroutine: SUB_RPN_ADDITION
; Parameter (R3): BASE: A pointer to the base (one less than the lowest available                      ;                       address) of the stack
; Parameter (R4): MAX: The "highest" available address in the stack
; Parameter (R5): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped off the top two values of the stack,
;		    added them together, and pushed the resulting value back
;		    onto the stack.
; Return Value: R5 ??? updated TOS address
;------------------------------------------------------------------------------------------
.ORIG x3600

    ;STORE REGISTERS INTO REG_STORE_STACK
    ADD R6, R6, #-1
    STR R7, R6, #0
    ADD R6, R6, #-1
    STR R3, R6, #0
    ADD R6, R6, #-1
    STR R4, R6, #0
    ADD R6, R6, #-1
    STR R2, R6, #0
    ADD R6, R6, #-1
    STR R5, R6, #0

    AND R1, R1, x0 ;clear for addition
    
    LD R0, SUB_STACK_POP_PTR_3400
    JSRR R0
    
    ADD R1, R1, R0 ;num 1 added to reg1
    
    AND R0, R0, x0
    LD R0, SUB_STACK_POP_PTR_3400
    JSRR R0
    
    ADD R1, R1, R0 ;num 2 added to reg1
    
    LD R0, SUB_STACK_PUSH_PTR_3200 ;push result into stack
    JSRR R0

    ;RETURN REGISTERS FROM REG_STORE_STACK
    LDR R5, R6, #0
    ADD R6, R6, #1
    LDR R2, R6, #0
    ADD R6, R6, #1
    LDR R4, R6, #0
    ADD R6, R6, #1
    LDR R3, R6, #0
    ADD R6, R6, #1
    LDR R7, R6, #0
    ADD R6, R6, #1





RET
SUB_STACK_PUSH_PTR_3200 .fill x3200
SUB_STACK_POP_PTR_3400 .fill x3400




.END
;------------------------------------------------------------------------------------------
; Subroutine: SUB_CHAR_CONVERT
; Parameter (R0): Value popped off stack
; Postcondition: The subroutine has popped off the top values of the stack,
;		    converts to char, and printed the resulting value back
;		    onto the stack.
; Return Value: console output
;------------------------------------------------------------------------------------------
.ORIG x3800
    ;STORE REGISTERS INTO REG_STORE_STACK
    ADD R6, R6, #-1
    STR R7, R6, #0
    ADD R6, R6, #-1
    STR R3, R6, #0
    ADD R6, R6, #-1
    STR R4, R6, #0
    ADD R6, R6, #-1
    STR R2, R6, #0
    ADD R6, R6, #-1
    STR R5, R6, #0
    
    LD R0, NEWLINE_3800
    OUT 
    
    LD R2, SUB_STACK_POP_PTR_3400_INTERNAL
    JSRR R2
    
    LD R2, ASCII_CONV_CHAR
    ADD R0, R0, R2
    OUT

    ;RETURN REGISTERS FROM REG_STORE_STACK
    LDR R5, R6, #0
    ADD R6, R6, #1
    LDR R2, R6, #0
    ADD R6, R6, #1
    LDR R4, R6, #0
    ADD R6, R6, #1
    LDR R3, R6, #0
    ADD R6, R6, #1
    LDR R7, R6, #0
    ADD R6, R6, #1

RET
SUB_STACK_POP_PTR_3400_INTERNAL .FILL x3400
ASCII_CONV_CHAR .fill x30
NEWLINE_3800 .fill x0A
.END