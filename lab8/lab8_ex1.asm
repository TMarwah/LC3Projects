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
LD R5, LOAD_FILL_VALUE_3200
JSRR R5

; add 1 to hardcoded value
ADD R1, R1, #1

LD R5, OUTPUT_AS_DECIMAL_3400
JSRR R5

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
STR R7, R6, #0

; Code
AND R1, R1, x0
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
; Return Value: Decimal number to terminal
;=================================================

.orig x3400

; Backup registers
ADD R6, R6, #-1
STR R7, R6, #0

; Code
AND R2, R2, x0
ADD R2, R2, R1
AND R4, R4, x0

ADD R1, R1, #0
BRp PRINT_POSITIVE
LD R0, MINUS_SIGN
OUT
BR SKIP_POSITIVE

PRINT_POSITIVE
SKIP_POSITIVE

;TEN THOUSANDTHS PLACE
ten_thousandths_place
    LD R3, ten_thousandths
    ADD R2, R2, R3
    BRn tthousandths_place_complete
    ADD R4, R4, #1
BR ten_thousandths_place
tthousandths_place_complete
ADD R2, R2, R3

LD R5 ASCII_OFFSET
ADD R4, R4, R5
AND R0, R0, x0
ADD R0, R0, R4
OUT

AND R4, R4, x0
AND R3, R3, x0
;THOUSANDTHS PLACE
thousandths_place
    LD R3, thousandths
    ADD R2, R2, R3
    BRn thousandths_place_complete
    ADD R4, R4, #1
BR thousandths_place
thousandths_place_complete
ADD R2, R2, R3

ADD R4, R4, R5
AND R0, R0, x0
ADD R0, R0, R4
OUT

; Restore registers
LDR R7, R6, #0
ADD R6, R6, #1

RET
ASCII_OFFSET .FILL x30
MINUS_SIGN .FILL x2D
ten_thousandths .FILL #-10000 
thousandths .FILL #-1000
hundereths .FILL #-100
tenths .FILL #-10
ones .FILL #1

.end