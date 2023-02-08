;=================================================
; Name: Tanmay Marwah
; Email: tmarw001@ucr.edu
; 
; Lab: lab 5, ex 2
; Lab section: 23
; TA: Westin Montano, Omer Eren
; 
;=================================================
.orig x3000
; Initialize the stack. Don't worry about what that means for now.
ld r6, top_stack_addr ; DO NOT MODIFY, AND DON'T USE R6, OTHER THAN FOR BACKUP/RESTORE

; your code goes here
LD R1, ARRAY_PTR
LD R5, SUB_GET_STRING
jsrr R5

AND R0, R0, x0
LD R0, ARRAY_PTR
TRAP x22

LD R1, ARRAY_PTR
LD R3, ARRAY_PTR
;LD R5, SUB_IS_PALINDROME
jsrr R5

halt

; your local data goes here
SUB_GET_STRING .fill x3200
ARRAY_PTR .fill x4000
top_stack_addr .fill xFE00 ; DO NOT MODIFY THIS LINE OF CODE
.end

.ORIG x4000
ARRAY .BLKW #100
.end

; your subroutines go below here
;------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R1): The starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
;	terminated by the [ENTER] key (the "sentinel"), and has stored 
;	the received characters in an array of characters starting at (R1).
;	the array is NULL-terminated; the sentinel character is NOT stored.
; Return Value (R5): The number of non-sentinel chars read from the user.
;	R1 contains the starting address of the array unchanged.
;-------------------------------------------------------------------------
.ORIG x3200

    ADD R6, R6, #-1
    STR R7, R6, #0
    ADD R6, R6, #-1
    STR R3, R6, #0
    ADD R6, R6, #-1
    STR R5, R6, #0
    
AND R5, R5, x0
DO_WHILE_LOOP
    GETC
    OUT
    ADD R0,R0, #-10
    BRz END_OF_STRING ;if newline is entered, leave loop
    ADD R0, R0, x0A
    STR R0, R1, #0
    ADD R5, R5, #1
    ADD R1, R1, #1 ; offset mem loc by 1 (move array loc to the right)
    BRp DO_WHILE_LOOP ; jump back
END_DO_WHILE_LOOP

END_OF_STRING
    AND R0, R0, x0
    STR R0, R1, #0
    
RET



.end

;-------------------------------------------------------------------------
; Subroutine: SUB_IS_PALINDROME
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R1)
;		 is a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;-------------------------------------------------------------------------
.ORIG x3300
    ADD R6, R6, #-1
    STR R7, R6, #0
    ADD R6, R6, #-1
    STR R3, R6, #0
    ADD R6, R6, #-1
    STR R5, R6, #0
    
    LDR R2, R1, #0
    ADD R3, R3, R5
    LDR R0, R3, #0
    
    
    CHECK_PALINDROME
        NOT R2, R2
        ADD R4, R2, R0
        BRnp NOT_PALI ; break if subtraction !=0 aka not same char
        
        ADD R1, R1, #1 ;change addresses
        ADD R3, R3, #-1 ;change addresses
        LDR R2, R1, #0
        LDR R0, R3, #0
        NOT R1,R1
        ADD R4, R1, R3
        BRnz FINISHED_CHECK
    
    
    
    NOT_PALI
    AND R4, R4, x0
    ADD R4, R4, #1
    BRp DONE

    FINISHED_CHECK
    AND R4, R4, x0




DONE

.end