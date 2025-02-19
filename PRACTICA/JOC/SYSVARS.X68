*-----------------------------------------------------------
* SYSTEM VARIABLES
*-----------------------------------------------------------
    		
; --- KEYBOARD RELATED VARIABLES ---------------------------

KBDVAL      DS.L    1           ; KEY STATE (SI LA TECLA ESTA PITJADA)
KBDEDGE     DS.L    1           ; KEY EDGE (INDICA SI S'ACABA DE PITJAR LA TECLA)		

; --- TIMED INTERRUPT RELATED VARIABLES --------------------
SCRINTCT    DS.B    1           ; INTERRUPT COUNTER
SCRCYCCT    DS.B    1           ; CYCLE COUNTER
            DS.W    0

; --- MOUSE RELATED VARIABLES ------------------------------
MSECOORD    DS.L    1           ; MOUSE COORDINATES, 16 BITS Y, 16 BITS X
MSEVAL      DS.W    1           ; MOUSE VALUE (INDICATES IF LEFT BUTTON IS PRESSED)


*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
