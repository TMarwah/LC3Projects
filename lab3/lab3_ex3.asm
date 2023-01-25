;=================================================
; Name: Tanmay Marwah
; Email: tmarw001@ucr.edu
; 
; Lab: lab 3, ex 3
; Lab section: 23
; TA: Westin Montano and Omer Eren
; 
;=================================================
.ORIG x3000

;load reg 1 with starting address of the array
LEA R1, ARRAY_1

;load loop counter
LD R2, DEC_10

DO_WHILE_LOOP
    GETC
    OUT
    STR R0, R1, #0 ; store input into mem loc specified by R1 (array)
    ADD R1, R1, #1 ; offset mem loc by 1 (move array loc to the right)
    ADD R2, R2, #-1 ; deduct from loop counter
    BRp DO_WHILE_LOOP ; jump back if last mod (loop counter) is positive non zero
END_DO_WHILE_LOOP

;empty used addresses
AND R1, R1, x0
AND R2, R2, x0

;load reg 1 with starting address of the array
LEA R1, ARRAY_1

;load loop counter
LD R2, DEC_10

;seperate inputs from outputs (clean)
LD R0, newline
OUT

OUTPUT_LOOP
    AND R0, R0, x0
    LDR R0, R1, #0
    OUT
    LD R0, newline
    OUT
    ADD R1, R1, #1
    ADD R2, R2, #-1
    BRp OUTPUT_LOOP
END_OUTPUT_LOOP
    



HALT

DEC_10 .FILL #10
ARRAY_1 .BLKW #10
newline .FILL x0A



.END

