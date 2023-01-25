;=================================================
; Name: Tanmay Marwah
; Email: tmarw001@ucr.edu
; 
; Lab: lab 3, ex 1
; Lab section: 23
; TA: Westin Montano and Omer Eren
; 
;=================================================

.ORIG x3000

;load R5 with the DATA_PTR ( AKA ARRAY START)
LD R5, DATA_PTR

;load r3/r4 with the data in the mem locations of r5 (x4000) and r5 + 1 (x4001)
LDR R3, R5, #0
LDR R4, R5, #1 ; offset 1 address

;increment and reassign
ADD R3, R3, #1
ADD R4, R4, #1

;store relative, take val in r3/r4 and store into r5 and r5 + 1 mem adress
STR R3, R5, #0
STR R3, R5, #1 ; offset 1 address
HALT

;pointer for remote data
DATA_PTR .FILL x4000


.END

;remote data
.orig x4000
DEC_65 .FILL #65 ; address x4000
HEX_41 .FILL x41 ; address x4001 (or R5 , #1)

.END







