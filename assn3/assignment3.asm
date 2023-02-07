;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Tanmay Marwah
; Email: tmarw001@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 23
; TA: Westin Monatno, Omer Eren
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
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LD R4, LOOP_COUNT
LD R7, PACKET_COUNT
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 

;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------


WHILE
    ADD R1, R1, #0
    
    BRp BIT_IS_ONE
    
    ;BIT IS 0
    LD R0, ASCII0
    OUT
    ADD R7,R7, #-1
    BRp SKIP
    
    ;BIT IS 1
    BIT_IS_ONE
    LD R0, ASCII1
    ADD R7,R7, #-1
    OUT
    
    SKIP
    BRz PACKET_SPACE ;counter is done
    BRp PACKET_SKIP ;counter is not done
    
    PACKET_SPACE
        LD R0, SPACE
        OUT 
        LD R7, PACKET_COUNT
    
    PACKET_SKIP
    ADD R1, R1, R1
    ADD R4,R4,#-1
    BRp WHILE
END_WHILE

LD R0, SPACE
OUT

    

HALT
;---------------	
;Data
;---------------
Value_ptr	.FILL xCA01	; The address where value to be displayed is stored
ASCII0 .fill x30
ASCII1 .fill x31
LOOP_COUNT .fill #16
PACKET_COUNT .fill #4
SPACE .fill x20
.END

.ORIG xCA01					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
