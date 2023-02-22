;========================
; Main Program
;========================
.ORIG x3000
    
    ; Setup parameter
    AND R1, R1, #0
    ADD R1, R1, #5
    
    ; Call the factorial sub-routine
    LD R6, FACT_SUB_ADDR
    JSRR R6
    
    HALT
;========================
; Local Data
;========================
FACT_SUB_ADDR   .FILL x3200
.END

;=======================================================================
; Subroutine: SUB_FACT
; Parameter (R1): Starting number for the factorial.
; Postcondition: Take the factorial of the value in R1.
; Return Value (R0): Result of the factorial.
;=======================================================================
.ORIG x3200
;========================
; Subroutine Instructions
;========================
FACT_SUB_START
; Backup Registers
ST R1, BACKUP_R1_3200
ST R2, BACKUP_R2_3200
ST R6, BACKUP_R6_3200

; Subroutine Logic

ADD R1, R1, #-1
BRz BASE_3200 ; Recursive Base Case: if r1 == 0 jump to base case

; Recursive call
JSR FACT_SUB_START

; Setup multiplication parameters
ADD R2, R0, #0 ; Move result of factorial call to R2
ADD R1, R1, #1 ; Use original value of R1

; Perform multiplication
LD R6, MUL_SUB_ADDR_3200
JSRR R6
BR RESTORE_3200 ; Skip the base case

; Handle base case, return 1
BASE_3200
AND R0, R0, #0
ADD R0, R0, #1

; Restore Registers
RESTORE_3200
LD R1, BACKUP_R1_3200
LD R2, BACKUP_R2_3200
LD R6, BACKUP_R6_3200

RET

;========================
; Subroutine Data
;========================
MUL_SUB_ADDR_3200   .FILL x3400

BACKUP_R1_3200  .BLKW #1
BACKUP_R2_3200  .BLKW #1
BACKUP_R6_3200  .BLKW #1
.END

;=======================================================================
; Subroutine: SUB_MULT
; Parameter (R1): First operand.
; Parameter (R2): Second operand.
; Postcondition: Multiply the first operand by the second operand.
; Return Value (R0): Return the product.
;=======================================================================
.ORIG x3400
;========================
; Subroutine Instructions
;========================
; Backup registers
ST R1, BACKUP_R1_3400
ST R2, BACKUP_R2_3400

; Subroutine logic
AND R0, R0, #0

MULT_LOOP_3400
    ADD R0, R0, R1
    ADD R2, R2, #-1
    BRp MULT_LOOP_3400

; Restore registers
LD R1, BACKUP_R1_3400
LD R2, BACKUP_R2_3400
RET

;========================
; Subroutine Data
;========================
BACKUP_R1_3400  .BLKW #1
BACKUP_R2_3400  .BLKW #1
.END



;Q1. Running the code initializes R1 to 5 and then calls the SUB_FACT subroutine
;    The SR subtracts 1 from R1, then calls the routine from within itself,
;    causing a loop, then once R1 equals 0, the BASE_3200 branch is taken,
;    which adds 1 to R0, then restores R1 to 1. Since R7 is not backed up,
;    the subroutine is taken infinitely

;Q2. R0 contains a 0 while R1 contains a 5
 
;Q3. R0 contains a 0 while R1 contains a 4  
;    
;Q4. R0     R1
;    -----------
;    0   |   3
;    0   |   2 
;    0   |   1
;    0   |   0

;Q5. Before executing RET, R7 has a value of x3206, (address after JSR)

;Q6. R7 has the value of x320A, which contains the BR RESTORE_3200 instruction

;Possible solution: Back up R7 to return into main rather than within the prog