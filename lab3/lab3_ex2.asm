;=================================================
; Name: Tanmay Marwah
; Email: tmarw001@ucr.edu
; 
; Lab: lab 3, ex 2
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




HALT

DEC_10 .FILL #10
ARRAY_1 .BLKW #10



.END

