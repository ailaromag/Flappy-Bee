*-----------------------------------------------------------
* GAME VARIABLES
*-----------------------------------------------------------
  
; --- BEE RELATED VARIABLES --------------------------------

BEEPOSY     DS.W    1           ; BEE Y COORDINATE       
BEEVELY     DS.L    1           ; BEE INSTANT Y VELOCITY 
BEEPOSYJMP  DS.W    1           ; BEE POINT OF REFERENCE 
                                ; FOR JUMP 
BEEWINGS    DS.W    1           ; IF 0 WINGS UP IF 1 WINGS DOWN

; --- SCOREBOARD RELATED VARIABLES -------------------------
LIFESVAR    DS.W    1           ; LIFES THE BEE HAS
POINTS      DS.W    1           ; NUMBER OF KILLED ENEMIES
LEVEL       DS.W    1           ; NUMBER OF SUCCEDED COLUMNS 
COLLISIONS  DS.W    1           ; NUMBER OF COLLISIONS   

; --- INTRO STATE RELATED VARIABLES ------------------------

ISCTIMER    DS.W    1           ; INTRO TIMER
BTNPOSX0    DS.W    1           ; INTRO BUTTON INITIAL X POSITION
BTNPOSY0    DS.W    1           ; INTRO BUTTON INITIAL Y POSITION

; --- INSTRUCTIONS STATE RELATED VARIABLES ----------------
INSTIMER    DS.W    1           ; INSTRUCTIONS TIMER

; --- STATE RELATED VARIABLES ------------------------------

STACUR      DS.W    1           ; CURRENT STATE
STANEXT     DS.W    1           ; NEXT STATE

; --- BITMAP RELATED VARIABLES -----------------------------
POSXINI     DS.W    1           ; BIT X INITIAL COORDINATE
POSYINI     DS.W    1           ; BIT Y INITIAL COORDINATE
BITXPOS     DS.W    1           ; BIT X COORDINATE
BITYPOS     DS.W    1           ; BIT Y COORDINATE
PIXSIZE     DS.W    1           ; PIXSIZE
BMPWIDT     DS.W    1           ; BITMAP WIDTH
BMPHEIG     DS.W    1           ; BITMAP HEIGH











*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
