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

LD R5, LOAD_FILL_VALUE_3200
JSRR R5

; add 1 to hardcoded value
ADD R1, R1, #1

LD R5, OUTPUT_AS_DECIMAL_3400
JSRR R5



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
; Return Value: l
;=================================================

.orig x3400

; Backup registers
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R4, R6, #0
ADD R6, R6, #-1
STR R3, R6, #0
ADD R6, R6, #-1
STR R2, R6, #0

; Print minus if neg, otherwise skip
ADD R1, R1, #0
BRp PRINT_POSITIVE
LD R0, MINUS_SIGN
OUT
BR SKIP_POSITIVE

PRINT_POSITIVE
SKIP_POSITIVE

LD R4, ASCII_OFFSET

AND R3, R3, x0
AND R2, R2, x0
COUNT_TEN_THOUSANDTHS
    LD R2, ten_thousandths
    ADD R1, R1, R2
    BRn TEN_THOUSANDTHS_DONE
    ADD R3, R3, #1
    BR COUNT_TEN_THOUSANDTHS

TEN_THOUSANDTHS_DONE
NOT R2, R2
ADD R2, R2, #1
ADD R1, R2, R1

AND R0, R0, x0
ADD R0, R3, #0
ADD R0, R0, R4

OUT

AND R3, R3, x0
AND R2, R2, x0
COUNT_THOUSANDTHS
    LD R2, thousandths
    ADD R1, R1, R2
    BRn THOUSANDTHS_DONE
    ADD R3, R3, #1
    BR COUNT_THOUSANDTHS

THOUSANDTHS_DONE
NOT R2, R2
ADD R2, R2, #1
ADD R1, R2, R1

AND R0, R0, x0
ADD R0, R3, #0
ADD R0, R0, R4

OUT

AND R3, R3, x0
AND R2, R2, x0
COUNT_HUNDERETHS
    LD R2, hundereths
    ADD R1, R1, R2
    BRn HUNDERETHS_DONE
    ADD R3, R3, #1
    BR COUNT_HUNDERETHS

HUNDERETHS_DONE
NOT R2, R2
ADD R2, R2, #1
ADD R1, R2, R1

AND R0, R0, x0
ADD R0, R3, #0
ADD R0, R0, R4

OUT

AND R3, R3, x0
AND R2, R2, x0
COUNT_TENS
    LD R2, tens
    ADD R1, R1, R2
    BRn TENS_DONE
    ADD R3, R3, #1
    BR COUNT_TENS

TENS_DONE
NOT R2, R2
ADD R2, R2, #1
ADD R1, R2, R1

AND R0, R0, x0
ADD R0, R3, #0
ADD R0, R0, R4

OUT

;PRINT ONES
AND R0, R0, x0
ADD R0, R1, #0
ADD R0, R0, R4
OUT

; Restore registers
LDR R2, R6, #0
ADD R6, R6, #1
LDR R3, R6, #0
ADD R6, R6, #1
LDR R4, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1
RET
MINUS_SIGN .FILL x2D
ten_thousandths .FILL #-10000
thousandths .FILL #-1000
hundereths .FILL #-100
tens .FILL #-10
ones .FILL #-1
ASCII_OFFSET .FILL x30
.end