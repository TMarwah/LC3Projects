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
LD R3, DEC_65
LD R4, HEX_41

HALT

DEC_65 .FILL #65
HEX_41 .FILL x41
;bin values are the same
;ascii is A

.end