;=================================================
; Name: Tanmay Marwah
; Email: tmarw001@ucr.edu
; 
; Lab: lab 4, ex 4
; Lab section: 23
; TA: Westin Montano and Omer Eren
; 
;=================================================

.ORIG x3000

;LOAD R1 with array starting address
LD R1, ARRAY_PTR

;LOAD loop counter
LD R2, DEC_10

;zero out R0
AND R0, R0, x0
LD R0, DEC_1


;========================
;LOAD ARRAY WITH VALS 0-9
;========================
DO_WHILE_LOOP
    STR R0, R1, #0
    ADD R1, R1, #1
    ADD R0, R0, R0
    ADD R2, R2, #-1 ;iterate loop
    BRp DO_WHILE_LOOP
END_DO_WHILE_LOOP


;==========================
;CLEAN REGISTERS FOR OUTPUT
;==========================
AND R0, R0, x0

AND R1, R1, x0
LD R1, ARRAY_PTR

AND R2, R2, x0
LD R2, DEC_10

LD R3, ASCII_OFFSET


OUTPUT_LOOP
    LDR R0, R1, #0
    ADD R0, R0, R3
    OUT 
    LD R0, NEWLINE
    OUT
    ADD R1, R1, #1
    ADD R2, R2, #-1
    BRp OUTPUT_LOOP
END_OUTPUT_LOOP

;==========================
;Why the weird output?
;x10 corresponds to decimal 16, so when offsetting by x30 we get to x40. 
;However, x40 corresponds to decimal 64
;Furthermore, x40 as an ascii is "@"
;==========================



HALT
ARRAY_PTR .FILL x4000
DEC_10 .FILL #10
DEC_1 .FILL #1
ASCII_OFFSET .FILL x30
NEWLINE .FILL x0A
.END




.ORIG x4000
ARRAY .BLKW #10
.END
