; ==============================================================================
; SCOREBOARD MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
SCOINIT
; INITIALIZE SCOREBOARD
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            CLR.W   (POINTS)
            CLR.W   (LEVEL)
            CLR.W   (COLLISIONS)
            RTS
            
; ------------------------------------------------------------------------------
SCOPLOT
; PLOT THE SCOREBOARD
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
           MOVEM.L D0-D4/A1,-(A7)

            ; SET BACKGROUND COLOR
            MOVE.B  #81,D0
            MOVE.L  #SCOFCOL,D1
            TRAP    #15
            
            MOVE.B  #80,D0
            MOVE.L  #SCOCHRCOL,D1
            TRAP    #15
            
            ; DRAW RECTANGLE FOR SCORE
            MOVE.B  #87,D0
            MOVE.W  #5,D1
            MOVE.W  #5,D2
            MOVE.W  #SCODIMX,D3
            MOVE.W  #SCODIMY,D4
            TRAP    #15
            
            ; SET FONT PROPERTIES
            MOVE.L  #SCOCHRCOL,D1
            MOVE.L  #$040C0000,D2
            MOVE.B  #21,D0
            TRAP    #15
            
            
            ; SET FIRST LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE1,D1
            TRAP    #15

            ; PRINT FIRST LINE
            LEA     .TXT1,A1
            CLR.L   D1
            MOVE.W  (POINTS),D1
            MOVE.B  #17,D0
            TRAP    #15

            ; SET SECOND LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE2,D1
            TRAP    #15

            ; PRINT SECOND LINE
            LEA     .TXT2,A1
            CLR.L   D1
            MOVE.W  (LIFESVAR),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET THIRD LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE3,D1
            TRAP    #15
            
            ; PRINT THIRD LINE
            LEA     .TXT3,A1
            CLR.L   D1
            MOVE.W  (LEVEL),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET FOURTH LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE4,D1
            TRAP    #15         
     
            MOVEM.L (A7)+,D0-D4/A1
            
            RTS
.TXT1       DC.B    'POINTS     :',0
.TXT2       DC.B    'LIFES      :',0
.TXT3       DC.B    'LEVEL      :',0
            DS.W    0





*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
