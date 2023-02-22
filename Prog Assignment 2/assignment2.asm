;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Tanmay Marwah
; Email: tmarw001@ucr.edu
; 
; Assignment name: Assignment 2
; Lab section: 23
; TA: Westin Montano & Omer Eren
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------

;take and print user input num
GETC
OUT 
;put user num in reg1
ADD R1, R0,  #0
;load and print newline to reg0
LD R0, newline
OUT

;take and print user input num
GETC
OUT
;put user num in reg2
ADD R2, R0,  #0
;load and print newline to reg0
LD R0, newline
OUT

;-------------------------------
;PRINT OPERATION
;--------------------------------
;clear out r0
AND R0, R0, x0
;place num1
ADD R0, R1,  #0
OUT

;print minus
LEA R0, minus
PUTS

;clear out r0
AND R0, R0, x0000
;place num2
ADD R0, R2,  #0
OUT

;print equals
LEA R0, equals
PUTS

;-------------------------------
;CONVERT CHAR TO NUM
;--------------------------------

;2's comp of asciioffset
LD R3, asciioffset
NOT R3, R3
ADD R3, R3, 1

;turn chars into nums
ADD R1 ,R1, R3
ADD R2, R2, R3

;2's comp num2
NOT R2, R2
ADD R2, R2, 1

;perform opp, num is in R3
ADD R3 ,R1, R2


BRn NEGATIVE_RESULT
;POSITIVE_RESULT
    LD R4, asciioffset
    AND R0,R0, x0
    ;return to char
    ADD R0, R3, R4
    OUT
    BRp END ;skip negative instructions

NEGATIVE_RESULT
    LD R4, asciioffset
    ;get magnitude
    NOT R3, R3
    ADD R3, R3, 1
    ;clear and output '-'
    AND R0,R0, x0
    LEA R0, nospace_minus
    PUTS
    ;clear
    AND R0,R0, x0
    ;return to char
    ADD R0, R3, R4
    OUT
END
LD R0, newline
OUT
HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
minus 	.STRINGZ	" - "
nospace_minus .STRINGZ "-"
equals 	.STRINGZ	" = "
newline .FILL x0A	; newline character - use with LD followed by OUT
asciioffset .FILL x30
;---------------	
;END of PROGRAM
;---------------	
.END

