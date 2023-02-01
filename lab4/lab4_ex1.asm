;=================================================
; Name: Tanmay Marwah
; Email: tmarw001@ucr.edu
; 
; Lab: lab 4, ex 1
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

;========================
;LOAD ARRAY WITH VALS 0-9
;========================
DO_WHILE_LOOP
    STR R0, R1, #0
    ADD R0, R0, #1 ;load next num to be placed into array
    ADD R1, R1, #1 ;offset mem loc to array index 1
    ADD R2, R2, #-1 ;iterate loop
    BRp DO_WHILE_LOOP
END_DO_WHILE_LOOP


;reset array mem loc
AND R1, R1, x0
LD R1, ARRAY_PTR

;clear out r2 for use
AND R2, R2, x0

;store the val at mem loc x4000 (start of array) with offset of 6 (effectively the 7th value)
LDR R2, R1, #6



HALT
ARRAY_PTR .FILL x4000
DEC_10 .FILL #10
.END




.ORIG x4000
ARRAY .BLKW #10
.END
