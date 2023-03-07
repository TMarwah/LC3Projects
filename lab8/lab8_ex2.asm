;=================================================
; Name: Tanmay Marwah
; Email: tmarw001@ucr.edu
; 
; Lab: lab 8, ex 2
; Lab section: 23
; TA: Westin Monatano and Omer Eren
; 
;=================================================

.orig x3000

;CLEAN BEFORE RUNNING
AND R0, R0, x0
AND R1, R1, x0
AND R2, R2, x0
AND R3, R3, x0
AND R4, R4, x0
AND R5, R5, x0
AND R6, R6, x0
AND R7, R7, x0

LD R6, top_stack_addr

; Test harness
;-------------------------------------------------
LEA R0, enter_prompt
trap x22
getc
out

ADD R1, R0, #0
ADD R2, R0, #0

LD R5, PARITY_CHECK_3600
JSRR R5

AND R0, R0, x0
LD R0, NEWLINE
OUT

LEA R0, return_prompt_LEAD 
TRAP x22

AND R0, R0, x0
ADD R0, R2, #0

OUT

LEA R0, return_prompt_TRAIL
TRAP x22

LD R4, ASCII_OFFSET 
AND R0, R0, x0
ADD R0, R3, R4
OUT

HALT

; Test harness local data
;-------------------------------------------------
top_stack_addr .fill xFE00
enter_prompt .STRINGZ "Enter a character: "
return_prompt_LEAD .STRINGZ "The number of 1's in '"
return_prompt_TRAIL .STRINGZ "' is: "
ASCII_OFFSET .FILL x30
PARITY_CHECK_3600 .fill x3600
NEWLINE .fill x0a

.end

;=================================================
; Subroutine: PARITY_CHECK_3600
; Parameter: (R1): character entered by user
; Postcondition: // Fixme
; Return Value (R3): // Fixme
;=================================================

.orig x3600

; Backup registers
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R4, R6, #0
ADD R6, R6, #-1
STR R2, R6, #0

; Code
AND R2, R2, x0
LD R2, BITCOUNT ;num of bits

CONTINUE_SEARCHING
ADD R1, R1, #0
BRn ONE_DETECTED
BRzp SHIFT_LEFT

ONE_DETECTED
ADD R3, R3, #1
ADD R1, R1, R1 ; left shift
ADD R2, R2, #-1
BRz DONE_CHECKING
BR CONTINUE_SEARCHING

SHIFT_LEFT
ADD R1, R1, R1 ; left shift
ADD R2, R2, #-1
BRz DONE_CHECKING
BR CONTINUE_SEARCHING

DONE_CHECKING
; Restore registers
LDR R2, R6, #0
ADD R6, R6, #1
LDR R4, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1
RET
BITCOUNT .fill #16
.end
