; ==============================================================================
; COLUMN MANAGEMENT (AGENT)
; COLPOSX   (W) +0  --> A0     ; DEFINIM ELS OFFSETS DE LA MEMORIA LOCAL (DE INSTÀNCIA)
; GAPPOSY   (W) +2  --> 2(A0)
; ==============================================================================
            
; ------------------------------------------------------------------------------
COLINIT
; INITIALIZE COLUMN. WE INITIALIZE THE VARIABLES
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.L D0-D1/A1,-(A7)
            MOVE.W  #SCRWIDTH,(A0)            ; COLOCAM LA COLUMNA A LA DRETA PANTALLA
                        
            JSR     UTLRAND
            AND.L   #$00000007,D0
           
            MOVE.L  D0, D1                    
            LEA     .GAPPOSITIONS,A1
            LSL.W   #1, D1                    ; CALCULAMOS EL OFFSET
            MOVE.W  (A1,D1.W),2(A0)           ; POSEM DE LA POSICIÓ ALEATORIA DINS GAPPOSY
            MOVEM.L (A7)+,D0-D1/A1
            
            RTS
            
            
.GAPPOSITIONS         
                DC.W    SCRHEIGH/2             ;0
                DC.W    SCRHEIGH/4             ;1
                DC.W    SCRHEIGH-SCRHEIGH/4    ;2    
                DC.W    COLGAP                 ;3    
                DC.W    SCRHEIGH-COLGAP        ;4
                DC.W    SCRHEIGH-COLGAP/2      ;5
                DC.W    COLGAP/2               ;6 
                DC.W    COLGAP+COLGAP          ;7
                 
      
; ------------------------------------------------------------------------------
COLUPD
; UPDATES THE COLUMN.
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L  D0-D7,-(A7)
            ; ACTUALITZAM LES COORDENADES DE LA COLUMNA
            MOVE.W  (A0),D0
            SUB.W   #COLSPEED,D0
            
            ; COMPROVAM LES COLLISIONS HORITZONTALS(PANTALLA ESQUERRA)
            CMP.W   #-COLWIDTH/2,D0
            BLT     .COLLFT
            BRA     .CHKBEE
.COLLFT     ; COLISIO ESQUERRA
            JSR     AGLKILL             ; ELIMINAM LA COLUMNA
            BRA     .DONE
            
             MOVE.W  #COLWIDTH/2,D5


            MOVE.W  #COLGAP/2,D6
.CHKBEE     JSR     AGLCOLLISION


            CMP.W   #1,(COLLISIONS)
            BLT     .NO_HIT
            MOVE.B #SNDHIT,D7           ; GAME OVER SOUND
            TRAP   #SNDPLTN                
.NO_HIT                    
             MOVE.W  #COLWIDTH/2,D5
            ADD.W   (A0),D5
            CMP.W   #BEEPOSX,D5
            BNE     .DONE
            ; AUGMENTAM EL NIVELL:
            ADDQ.W   #1,(LEVEL)
            ADD.W   #COLSCORE,(POINTS)     

            ; ACTUALITZAM LA POSICIÓ
.DONE       
            MOVE.W  D0,(A0)
            MOVEM.L  (A7)+,D0-D7
            
            RTS
            
; ------------------------------------------------------------------------------
COLPLOT
; PLOT THE COLUMN.
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D4,-(A7)
             ;1ER DEFINIM ELS COLORS:
            ;CONTOUR COLOR
            MOVE.B  #80,D0
            MOVE.L  #COLPCOL,D1
            TRAP    #15
            
            ;FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #COLFCOL,D1
            TRAP    #15
            
            
            ; FIRST PART OF THE COLUMN: 
            ; DEFINE COORDINATES:
            MOVE.W  (A0),D1
            SUB.W   #COLWIDTH/2,D1
            MOVE.W  (A0),D3
            ADD.W   #COLWIDTH/2,D3
            
            MOVE.W  #COLPOSY,D2
            MOVE.W  2(A0),D4
            SUB.W   #COLGAP/2,D4

            
            MOVE.B  #87,D0
            TRAP    #15
  
            
            ; SECOND PART OF THE COLUMN:
            ; ONLY DE Y COORDINATES CHANGE
            MOVE.W  2(A0),D2
            ADD.W   #COLGAP/2,D2
            MOVE.W  #SCRHEIGH,D4
            
            TRAP    #15
            
            ;PEN COLOR
            MOVE.B  #80,D0
            MOVE.L  #COLDETCOL,D1
            TRAP    #15
            
            ;FILL COLOR
            MOVE.B  #81,D0
            TRAP    #15
       
            ;DRAW COLUMN DETAILS
            ;FIRST DETAIL
            MOVE.W  (A0),D1
            SUB.W   #COLWIDTH/3,D1
            MOVE.W  D1,D3
            ADD.W   #3,D3
            
            MOVE.W #0,D2
            MOVE.W 2(A0),D4
            SUB.W  #COLGAP,D4                   
            MOVE.B #87,D0
            TRAP   #15
            
            ;SECOND DETAIL
            MOVE.W  (A0),D1
            ADD.W   #COLWIDTH/3,D1
            MOVE.W  D1,D3
            ADD.W   #3,D3
            
            MOVE.W 2(A0),D2     
            SUB.W  #COLGAP*2,D2
            MOVE.W 2(A0),D4
            SUB.W  #COLGAP/2,D4                   
            MOVE.B #87,D0
            TRAP   #15
            
            ;THIRD DETAIL
            MOVE.W  (A0),D1
            MOVE.W  D1,D3
            ADD.W   #3,D3
            
            MOVE.W 2(A0),D2     
            SUB.W  #COLGAP*2-COLGAP/4,D2
            MOVE.W 2(A0),D4
            SUB.W  #COLGAP-COLGAP/4,D4                   
            MOVE.B #87,D0
            TRAP   #15
            
            ;COLUMN DETAILS FOR LOWER PART
            
            ;DRAW COLUMN DETAILS
            ;FIRST DETAIL
            MOVE.W  (A0),D1
            SUB.W   #COLWIDTH/3,D1
            MOVE.W  D1,D3
            ADD.W   #3,D3
            
            
            MOVE.W  2(A0),D2
            ADD.W   #COLGAP/2,D2
            MOVE.W  #SCRHEIGH,D4                  
            MOVE.B #87,D0
            TRAP   #15
            
            ;SECOND DETAIL 
            MOVE.W  (A0),D1
            ADD.W   #5,D1
            MOVE.W  D1,D3
            ADD.W   #3,D3
            
            MOVE.W 2(A0),D2     
            ADD.W  #COLGAP,D2
            MOVE.W #SCRHEIGH,D4
            MOVE.B #87,D0
            TRAP   #15
                  
            MOVEM.L (A7)+,D0-D4           

            RTS
                  






























*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
