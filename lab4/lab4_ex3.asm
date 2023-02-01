;=================================================
; Name: Tanmay Marwah
; Email: tmarw001@ucr.edu
; 
; Lab: lab 4, ex 3
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


AND R1, R1, x0
LD R1, ARRAY_PTR

AND R2, R2, x0
LDR R2, R1, #6





HALT
ARRAY_PTR .FILL x4000
DEC_10 .FILL #10
DEC_1 .FILL #1
.END




.ORIG x4000
ARRAY .BLKW #10
.END
