; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Tanmay Marwah
; Email: tmarw001@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 23
; TA: Westin Montano and Omer Eren
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
; PUT ALL YOUR CODE AFTER THE main LABEL
;=================================================================================

;---------------------------------------------------------------------------------
;  Initialize program by setting stack pointer and calling main subroutine
;---------------------------------------------------------------------------------
.ORIG x3000

; initialize the stack
ld r6, stack_addr

; call main subroutine
lea r5, main
jsrr r5

;---------------------------------------------------------------------------------
; Main Subroutine
;---------------------------------------------------------------------------------
main
; get a string from the user
; * put your code here
LEA r4, user_prompt
LEA r1, user_string
LD r5,  get_user_string_addr
JSRR r5
; find size of input string
; * put your code here
LD r5,  strlen_addr
JSRR r5

AND R2, R2, x0
ADD R2, R1, R0 ;load r2 with address of last char
ADD R2, R2, #-1 ;REMOVE SENTINEL

AND R0, R0, x0 ;prep pali return
ADD R0, R0, #1
; call palindrome method
; * put your code here
LD r5, palindrome_addr
JSRR r5
; determine of stirng is a palindrome
; * put your code here
ADD R0, R0, #0
BRz NOT_PALINDROME
BR SKIP_NOT
NOT_PALINDROME
; decide whether or not to print "not"
; * put your code here
LEA r0, result_string
trap x22
LEA r0, not_string
trap x22
LEA r0, final_string
trap x22
BR FINISH

SKIP_NOT
LEA r0, result_string
trap x22
; print the result to the screen
; * put your code here
LEA r0, final_string
trap x22
FINISH
HALT

;---------------------------------------------------------------------------------
; Required labels/addresses
;---------------------------------------------------------------------------------

; Stack address ** DO NOT CHANGE **
stack_addr           .FILL    xFE00

; Addresses of subroutines, other than main
get_user_string_addr .FILL    x3200
strlen_addr          .FILL    x3300
palindrome_addr      .FILL	  x3400


; Reserve memory for strings in the progrtam
user_prompt          .STRINGZ "Enter a string: "
result_string        .STRINGZ "The string is "
not_string           .STRINGZ "not "
final_string         .STRINGZ	"a palindrome\n"

; Reserve memory for user input string
user_string          .BLKW	  100

.END

;---------------------------------------------------------------------------------
; Subroutine: get_user_string
; Parameter (R1): The starting address of the character array
;            (R4): The enter prompt
; Postcondition: The subroutine has prompted the user to input a string,
;	terminated by the [ENTER] key (the "sentinel"), and has stored 
;	the received characters in an array of characters starting at (R1).
;	the array is NULL-terminated; the sentinel character is NOT stored.
; Return Value: none
;---------------------------------------------------------------------------------
.ORIG x3200
get_user_string
; Backup all used registers, R7 first, using proper stack discipline
    ADD R6, R6, #-1
    STR R7, R6, #0 ; R7
    ADD R6, R6, #-1
    STR R3, R6, #0 ; R3
    ADD R6, R6, #-1
    STR R0, R6, #0 ; R0
    ADD R6, R6, #-1
    STR R5, R6, #0 ; R5
    ADD R6, R6, #-1
    STR R4, R6, #0 ; R4
    ADD R6, R6, #-1
    STR R1, R6, #0 ; R1
    
    
;load user prompt
AND R0, R0, x0
ADD R0, R4, #0
trap x22

DO_WHILE_LOOP
    GETC
    OUT
    ADD R0,R0, #-10
    BRz END_OF_STRING ;if newline is entered, leave loop
    ADD R0, R0, x0A
    STR R0, R1, #0
    ADD R1, R1, #1 ; offset mem loc by 1 (move array loc to the right)
    BRp DO_WHILE_LOOP ; jump back
END_DO_WHILE_LOOP
END_OF_STRING

; mark end of loop with sentinel
AND R0, R0, x0
STR R0, R1, #0

; Resture all used registers, R7 last, using proper stack discipline
    LDR R1, R6, #0
    ADD R6, R6, #1
    LDR R4, R6, #0
    ADD R6, R6, #1
    LDR R5, R6, #0
    ADD R6, R6, #1
    LDR R0, R6, #0
    ADD R6, R6, #1
    LDR R3, R6, #0
    ADD R6, R6, #1
    LDR R7, R6, #0
    ADD R6, R6, #1
RET
.END

;---------------------------------------------------------------------------------
; Subroutine: strlen
; Parameter (R1): The starting address of the character array
; Postcondition: The subroutine updates R0 for each character found
;                in the array, ending once the sentinel is detected.
; Return Value (R0): The number of non-sentinel chars in the array.
;	R1 contains the starting address of the array unchanged.
;---------------------------------------------------------------------------------
.ORIG x3300
strlen
    
; Backup all used registers, R7 first, using proper stack discipline
    ADD R6, R6, #-1
    STR R7, R6, #0 ; R7
    ADD R6, R6, #-1
    STR R5, R6, #0 ; R5
    ADD R6, R6, #-1
    STR R3, R6, #0 ; R3
    ADD R6, R6, #-1
    STR R1, R6, #0 ; R1
    
    

;code
AND R3, R3, x0
AND R0, R0, x0
CHAR_COUNT
    LDR R3, R1, #0
    ADD R3, R3, #-10
    BRnz SENTINEL_DETECTED
    ADD R0, R0, #1
    ADD R1, R1, #1
    BR CHAR_COUNT
SENTINEL_DETECTED

; Resture all used registers, R7 last, using proper stack discipline
    LDR R1, R6, #0
    ADD R6, R6, #1
    LDR R3, R6, #0
    ADD R6, R6, #1
    LDR R5, R6, #0
    ADD R6, R6, #1
    LDR R7, R6, #0
    ADD R6, R6, #1

RET
.END

;---------------------------------------------------------------------------------
; Subroutine: palindrome
; Parameter (R1): The starting address of the character array
;            (R2): The ending address of the character array
; Postcondition: The subroutine checks the characters located at the
;                 parameter addresses to see if they are equal. Returns
;                 true if they are, false if they arent.
; Return Value: (R0): 1 if palindrome, 0 if not
;---------------------------------------------------------------------------------
.ORIG x3400
palindrome ; Hint, do not change this label and use for recursive alls
; Backup all used registers, R7 first, using proper stack discipline
    ADD R6, R6, #-1
    STR R7, R6, #0 ; R7
    ADD R6, R6, #-1
    STR R5, R6, #0 ; R5
    ADD R6, R6, #-1
    STR R3, R6, #0 ; R4
    ADD R6, R6, #-1
    STR R3, R6, #0 ; R3
    ADD R6, R6, #-1
    STR R1, R6, #0 ; R1

;code

NOT R1, R1
ADD R1, R1, #1 ; flip r1

ADD R3, R1, R2 ;check if addresses are equal
brp KEEP_CHECKING ;skip return if the addresses are not past or the same
ret ;jump if they are
KEEP_CHECKING
NOT R1, R1
ADD R1, R1, #1 ; revert r1

AND R3, R3, x0
AND R4, R4, x0

LDR R3, R1, #0
LDR R4, R2, #0

NOT R4, R4
ADD R4, R4, #1
ADD R3, R3, R4
brnp NOT_PALI

AND R0, R0, x0
ADD R0, R0, #1

ADD R1, R1, #1 ;address iteration
ADD R2, R2, #-1 ;address iteration
BR SKIP_RETURN ;skip return if still pali

NOT_PALI ;return as pali not detected
AND R0, R0, x0
RET ;exit jsr chunk
SKIP_RETURN
JSR palindrome



FINISHED_CHECKING
; Resture all used registers, R7 last, using proper stack discipline

    LDR R1, R6, #0
    ADD R6, R6, #1
    LDR R3, R6, #0
    ADD R6, R6, #1
    LDR R4, R6, #0
    ADD R6, R6, #1
    LDR R5, R6, #0
    ADD R6, R6, #1
    LDR R7, R6, #0
    ADD R6, R6, #1
RET
.END
