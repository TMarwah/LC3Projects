;=================================================
; Name: Tanmay Marwah
; Email: tmarw001@ucr.edu
; 
; Lab: lab 8, ex 1
; Lab section: 23
; TA: Westin Montano, Omer Eren
; 
;=================================================

.orig x3000
LD R5, LOAD_FILL_VALUE_3200
JSRR R5

;add 1 to hardcoded value
ADD R1, R1, #1

;LD R5, OUTPUT_AS_DECIMAL_3400
;JSRR R5

LD R6, top_stack_addr

; Test harness
;-------------------------------------------------

HALT

; Test harness local data
;-------------------------------------------------
top_stack_addr .fill xFE00
LOAD_FILL_VALUE_3200 .fill x3200
OUTPUT_AS_DECIMAL_3400 .fill x3400
.end

;=================================================
; Subroutine: LOAD_FILL_VALUE_3200
; Parameter: NONE
; Postcondition: Load .FILL value into R1
; Return Value: (R1): Contains FILL value
;=================================================

.orig x3200

; Backup registers
ADD R6, R6, #-1
STR R7, R6, #-1

; Code
LD R1, VAL_TO_CONVERT

; Restore registers
LDR R7, R6, #0
ADD R6, R6, #1

RET
;hardcoded value
VAL_TO_CONVERT .fill #32767
.end

;=================================================
; Subroutine: OUTPUT_AS_DECIMAL_3400
; Parameter: (R1): Value that must be converted
; Postcondition: Print new value as decimal number
; Return Value: l
;=================================================

.orig x3400

; Backup registers
ADD R6, R6, #-1
STR R7, R6, #-1

; Code
ADD R1, R1, #0
BRp PRINT_POSITIVE
LD R0, MINUS
OUT
BR SKIP_POSITIVE

PRINT_POSITIVE
SKIP_POSITIVE



; Restore registers
LDR R7, R6, #0
ADD R6, R6, #1
RET
MINUS_SIGN .FILL x2D
.end