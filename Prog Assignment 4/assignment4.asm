;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Tanmay Marwah
; Email: tmarw001@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 23
; TA: Westin Montano and Omer Eren
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R4
;=================================================================================

.ORIG x3000	

;RERUN if error prints
RESET_PROG
;CLEAN BEFORE RUNNING
AND R0, R0, x0
AND R1, R1, x0
AND R2, R2, x0
AND R3, R3, x0
AND R4, R4, x0
AND R5, R5, x0
AND R6, R6, x0
AND R7, R7, x0
;-------------
;Instructions
;-------------
; output intro prompt
LD R0, introPromptPtr
TRAP x22

; Set up flags, counters, accumulators as needed
LD R5, MULTIPLY_COUNTER
LD R2, NUMCOUNT
LD R1, POSFLAG
; Get first character, test for '\n', '+', '-', digit/non-digit 	
GETC
OUT

; is very first character = '\n'? if so, just quit (no message)!
ADD R0, R0, #-10
BRz QUIT_INPUT
ADD R0, R0, #10

; is it = '+'? if so, ignore it, go get digits
AND R7, R7, x0
LD R7, PLUS_OFFSET ;offset for PLUS char
NOT R7, R7
ADD R7, R7, #1
ADD R0, R0, R7
BRz POSITIVE_NUM
LD R7, PLUS_OFFSET
ADD R0, R0, R7

; is it = '-'? if so, set neg flag, go get digits
LD R7, MINUS_OFFSET ;offset for MINUS char
NOT R7, R7
ADD R7, R7, #1
ADD R0, R0, R7
BRz NEGATIVE_NUM
LD R7, MINUS_OFFSET
ADD R0, R0, R7

; is it < '0'? if so, it is not a digit	- o/p error message, start over
LD R7, LOWER_BOUND_CHECK
NOT R7, R7
ADD R7, R7, #1
ADD R0, R0, R7
BRn ERROR_MESSAGE
;reset value
LD R7, LOWER_BOUND_CHECK
ADD R0, R0, R7

; is it > '9'? if so, it is not a digit	- o/p error message, start over
LD R7, UPPER_BOUND_CHECK
NOT R7, R7
ADD R7, R7, #1
ADD R0, R0, R7
BRp ERROR_MESSAGE
;reset value
LD R7, UPPER_BOUND_CHECK
ADD R0, R0, R7	

BR VALID_NUM


ERROR_MESSAGE
LD R0, NEWLINE
OUT
LD R0, errorMessagePtr
PUTS
LD R0, NEWLINE
BR RESET_PROG


; if none of the above, first character is first numeric digit - convert it to number & store in target register!
VALID_NUM
LD R7, ASCII_OFFSET
NOT R7, R7
ADD R7, R7, #1
ADD R0, R0, R7
ADD R4, R0, #0
ADD R2, R2, #-1 ; 1 num has been added
BR NO_SIGN_ENTERED

NEGATIVE_NUM ;set negative flag ( 0 )
AND R1, R1, x0
LD R1, NEGFLAG
BR skip_flag

POSITIVE_NUM ;set positive flag ( 1 )
AND R1, R1, x0
LD R1, POSFLAG

skip_flag ; ensure that positive flag is skipped if negative sign is entered
NO_SIGN_ENTERED

; Now get remaining digits from user in a loop (max 5), testing each to see if it is a digit, and build up number in accumulator
GET_NUMBERS_LOOP
    AND R6, R6, x0
    ADD R6, R4, #0
    GETC
    OUT
    ADD R0, R0, #-10
    BRz NEWLINE_FOUND
    ADD R0, R0, #10
    
    LD R7, LOWER_BOUND_CHECK
    NOT R7, R7
    ADD R7, R7, #1
    ADD R0, R0, R7
    BRn ERROR_MESSAGE
    ;reset value
    LD R7, LOWER_BOUND_CHECK
    ADD R0, R0, R7
    
    LD R7, UPPER_BOUND_CHECK
    NOT R7, R7
    ADD R7, R7, #1
    ADD R0, R0, R7
    BRp ERROR_MESSAGE
    ;reset value
    LD R7, UPPER_BOUND_CHECK
    ADD R0, R0, R7
    
    
    
    LD R7, ASCII_OFFSET
    NOT R7, R7
    ADD R7, R7, #1
    ADD R0, R0, R7
    LD R5, MULTIPLY_COUNTER
    MULTIPLY_10
        ADD R6, R6, R4
        ADD R5, R5, #-1
        BRp MULTIPLY_10
    AND R4, R4, x0
    ADD R4, R6, R0
    ADD R2, R2, #-1
    BRp GET_NUMBERS_LOOP

NEWLINE_FOUND

ADD R1, R1, #0
BRz NEGATIVE_NUMBER
BR POSNUM

;POSITIVE NUMBER
;DO NOTHING

NEGATIVE_NUMBER
NOT R4, R4
ADD R4, R4, #1 ;twos comp

POSNUM
; remember to end with a newline!
LD R0, NEWLINE
OUT

QUIT_INPUT	



HALT

;---------------	
; Program Data
;---------------
ASCII_OFFSET .FILL x30
NEWLINE .FILL x0A
PLUS_OFFSET .FILL x2B
MINUS_OFFSET .FILL x2D
introPromptPtr  .FILL xB000
errorMessagePtr .FILL xB200
POSFLAG .FILL #1
NEGFLAG .FILL #0
LOWER_BOUND_CHECK .FILL x30
UPPER_BOUND_CHECK .FILL x39
MULTIPLY_COUNTER .FILL #9
NUMCOUNT .FILL #5

.END

;------------
; Remote data
;------------
.ORIG xB000	 ; intro prompt
.STRINGZ	 "Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"

.END					
					
.ORIG xB200	 ; error message
.STRINGZ	 "ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
