;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Tanmay Marwah   
; Email: tmarw001@ucr.edu
; 
; Assignment name: Assignment 1
; Lab section: 23
; TA: Westin Montano & Omer Eren
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

;------------------------------------------
;           BUILD TABLE HERE
;------------------------------------------
;
;-----------------------------------------------
; REG VALUES     R0  R1  R2  R3  R4  R5  R6  R7
;-----------------------------------------------
; Pre-loop      0   6   12  0    0   0   0   0
; Iteration 01  0   5   12  12   0   0   0   0
; Iteration 02  0   4   12  24   0   0   0   0
; Iteration 03  0   3   12  36   0   0   0   0
; Iteration 04  0   2   12  48   0   0   0   0
; Iteration 05  0   1   12  60   0   0   0   0
; Iteration 06  0   0   12  72   0   0   0   0
; END           0   0   12  72   0   0   0   0


.ORIG x3000			; Program begins here
;-------------
;Instructions: CODE GOES HERE
;-------------
LD R1, DEC_6
LD R2, DEC_12
LD R3, DEC_0

DO_WHILE ADD R3, R3, R2
    ADD R1, R1, #-1 ;iterate
    BRp DO_WHILE    ;continue while last modified (R1) is pos AKA: exit when R1 = 0
END_DO_WHILE_LOOP

AND R1, R1, x0

HALT
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------
DEC_0 .FILL #0  ;populate with value 0
DEC_6 .FILL #6  ;populate with value 6
DEC_12 .FILL #12    ;populate with value 12




;---------------	
;END of PROGRAM
;---------------	
.END


