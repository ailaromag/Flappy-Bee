*-----------------------------------------------------------
* SYSTEM CONSTANTS
*-----------------------------------------------------------

; --- SCREEN RELATED CONSTANTS -----------------------------

SCRWIDTH        EQU     640
SCRHEIGH        EQU     640 
SCRFPS          EQU     50          ; SCREEN FRAMES PER SECOND   		
	       

; --- KEYCODES---------------------------------------------

KBDLEFT         EQU     $25
KBDUP           EQU     $26
KBDRIGHT        EQU     $27
KBDDOWN         EQU     $28    
KBDSPACE        EQU     ' '     
KBDFIRE         EQU     'M'
KBDPAUSE        EQU     'P'  

; -- SOUND IDENTIFIERS ------------------------------------
SNDHIT          EQU     0      
SNDWIN          EQU     1
SNDLOSE         EQU     2
SNDSELECT       EQU     3
SNDATTACK       EQU     4

; --- TRAP NUMBERS ----------------------------------------

SCRUPTN         EQU     0           ; SCREEN UPDATE TRAP NUMBER
KBDUPTN         EQU     1           ; KEYBOARD UPDATE TRAP NUMBER
SNDPLTN         EQU     2           ; SOUND PLAY TRAP NUMBER
MSEUPTN         EQU     3           ; MOUSE UPDATE TRAP NUMBER

; --- INTERRUPT NUMBERS -----------------------------------

SCRINTN         EQU     1           ; TIMED INTERRUPT NUMBER



*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
