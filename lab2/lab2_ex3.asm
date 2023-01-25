;=================================================
; Name: Tanmay Marwah
; Email: tmarw001@ucr.edu
; 
; Lab: lab 2. ex 1
; Lab section: 23
; TA: Westin Montano, Omer Eren
; 
;=================================================

.ORIG x3000
;load r5/r6 with the mem locations(ptr)
LD R5, DEC_65_PTR
LD R6, HEX_41_PTR

;load r3/r4 with the data in the mem locations of r5/r6
LDR R3, R5, #0
LDR R4, R6, #0

;increment
ADD R3, R3, #1
ADD R4, R4, #1

;store relative, take val in r3/r4 and store into r5/r6 mem adress
STR R3, R5, #0
STR R4, R6, #0
HALT

; fill pointer locations
DEC_65_PTR .FILL x4000
HEX_41_PTR .FILL x4001

.END

;remote data
.orig x4000
DEC_65 .FILL #65
HEX_41 .FILL x41

.END