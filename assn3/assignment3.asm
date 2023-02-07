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
LD R3, PACKET_NUMS
LDR R1, R6, #0  		; R1 <-- value to be displayed as binary 

;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------


WHILE
    ADD R1, R1, #0 ; make sure to use r1 as last modified reg
    
    BRn BIT_IS_ONE ;if num is negative, two's comp says msb must be a 1
    
    ;BIT IS 0
    LD R0, ASCII0 ; if not neg, msb is 0 according 
    OUT
    ADD R7,R7, #-1
    BRp SKIP
    BRz SKIP
    
    ;BIT IS 1
    BIT_IS_ONE
        LD R0, ASCII1
        ADD R7,R7, #-1
        OUT
    
    SKIP
    ADD R3, R3, #0 ; change last mod reg to checking if at last packet or not
    BRz PACKET_NUMS_SKIP ;if 0, means we are at the last packet and do not need space
    ADD R7, R7, #0 ; change last mod reg to checking if 4 bits have been printed or not
    BRz PACKET_SPACE ;counter is done
    BRp PACKET_SKIP ;counter is not done
    
    PACKET_SPACE ; print space between 4 bit packets
        AND R0,R0,x0
        LD R0, SPACE
        OUT 
        ADD R3, R3, #-1
        LD R7, PACKET_COUNT
    
   PACKET_SKIP ; skip if packet is not done
   PACKET_NUMS_SKIP ; skip if last packet is reached, space is not needed

    ADD R1, R1, R1
    ADD R4,R4,#-1
    BRp WHILE
END_WHILE

LD R0, NEWLINE
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
NEWLINE .fill x0A
PACKET_NUMS .fill #3
.END

.ORIG xCA01					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
