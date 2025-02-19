; ==============================================================================
; SKY MANAGEMENT
; ==============================================================================

; ------------------------------------------------------------------------------
SKYPLOT
; PLOTS THE SKY.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D5/A1-A2,-(A7)
            
            MOVE.B  #4,D5        
            LEA     .SKYCOLORS,A1
            LEA     .SKYCOORDINATES,A2
            
            MOVE.W  #SCRHEIGH,D2

.LOOP       ;ITERAM PER DIBUIXAR EL DEGRADAT DE 4 COLORS DEL FONS         

            MOVE.L  (A1)+,D1
            MOVE.B  #80,D0
            TRAP    #15
            MOVE.B  #81,D0
            TRAP    #15
            
            MOVE.W  #0,D1
            MOVE.W  #SCRWIDTH,D3

            MOVE.W  D2,D4
            MOVE.W  (A2)+,D2
            MOVE.B  #87,D0
            TRAP    #15
            
            DBRA    D5,.LOOP
                      
            ;DIBUIXAM MUNTANYA
            LEA     .SKYCOLORS,A1
            MOVE.L  (A1),D1
            MOVE.B  #80,D0
            TRAP    #15
            MOVE.B  #81,D0
            TRAP    #15
            
            MOVE.W  #315,D1
            MOVE.W  #SCRWIDTH+20,D3

            MOVE.W  #SCRHEIGH/2,D2
            MOVE.W  #SCRHEIGH,D4
            MOVE.B  #88,D0
            TRAP    #15
            
            ;DIBUIXAM SEGONA MUNTANYA
            MOVE.W  #-100,D1
            MOVE.W  #380,D3

            MOVE.W  #350,D2
            MOVE.W  #780,D4
            MOVE.B  #88,D0
            TRAP    #15
            
            ;DIBUIZAM UN NIGUL
            ;INICIALITZAM LES VARIABLES DEL BITMAP:
            MOVE.W  #SCRWIDTH/2-128,(POSXINI)
            MOVE.W  #200,(POSYINI)
            MOVE.W  #4,(PIXSIZE)
            MOVE.W  #5,(BMPHEIG)
            MOVE.W  #16,(BMPWIDT)
            
            LEA     CLOUDMAP,A1
            JSR     MAPPLOT
             
          
            
            MOVEM.L (A7)+,D0-D5/A1-A2
           
            RTS
.SKYCOORDINATES DC.W    427             ;GROUND  
                DC.W    320             ;GRAD1
                DC.W    213             ;GRAD2
                DC.W    106             ;GRAD3
                DC.W    0               ;GRAD4
.SKYCOLORS 
                DC.L    SKYCOL0
                DC.L    SKYCOL1
                DC.L    SKYCOL2
                DC.L    SKYCOL3
                DC.L    SKYCOL4     
                











*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
