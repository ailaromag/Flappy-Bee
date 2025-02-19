; ==============================================================================
; BEE MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
BEEINIT
; INITIALIZE BEE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.W  #SCRHEIGH/2,(BEEPOSY) ;CENTRAM LA COORD Y DE BEE A LA PANTALLA
            MOVE.L  #-3,(BEEVELY)
            MOVE.W  #$FF,(BEEWINGS)
            MOVE.W  #LIFES,(LIFESVAR)
            RTS
            
; ------------------------------------------------------------------------------
BEEUPD
; UPDATES THE BEE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D2,-(A7)
                       
            MOVE.L  (KBDVAL),D1          
            BTST.L  #24,D1                  ;COMPROVAM SI L'ESPAI ESTA APRETAT
            BEQ     .NOPRESSED           
            ; BOTA:
            ; ACTUALITZAM LA VELOCITAT:
            CLR.L   (BEEVELY)
            MOVE.W  #-5,(BEEVELY+2)       
            
.NOPRESSED  
            ; CAIGUDA LLIURE ACCELERADA:
            MOVE.L  (BEEVELY),D0           ;AGAFAM LA VELOCITAT DEL MOMENT                      
            ADD.W   D0,(BEEPOSY)           ;ACTUALITZAM LA POSICIO 

            ;AGAFAM LA PARTE SENCERA DE LA VELOCITAT
            MOVE.W  (BEEVELY+2),D1
            CMP.W   #20,D1           
            BGE.W   .VEL_MAX  
            ADD.L   #ACC,(BEEVELY)      
           
.VEL_MAX       
            MOVE.W  (BEEPOSY),D2           
            ;COMPROVAR LES COLISIONS AMB LA PANTALLA
            CMP.W   #BEEHEIGH/2,D2         ;TOP COLLISION
            BGE     .CONT2
            MOVE.W  #BEEHEIGH/2,D2    
            BRA     .DONE
.CONT2      CMP.W   #SCRHEIGH+BEEHEIGH,D2  ;BOTTOM COLLISION 
            BLE     .DONE
            MOVE.W  #1,(COLLISIONS)
            
.DONE       MOVE.W  D2,(BEEPOSY)            
            MOVEM.L  (A7)+,D0-D2
            RTS
          
; ------------------------------------------------------------------------------
BEEPLOT
; PLOTS THE BEE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            
            ;1ER DEFINIM ELS COLORS:
            ;CONTOUR COLOR
            MOVE.B  #80,D0
            MOVE.L  #BEEPCOL,D1
            TRAP    #15
            
            ;FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #BEEFCOL,D1
            TRAP    #15
            
            ;DEFINIM LES COORDENADES
            MOVE.W  #BEEPOSX-BEEWIDTH/2,D1
            MOVE.W  #BEEPOSX+BEEWIDTH/2,D3            
            MOVE.W  (BEEPOSY),D2
            SUB.W   #BEEHEIGH/2,D2
            MOVE.W  (BEEPOSY),D4
            ADD.W   #BEEHEIGH/2,D4
            
            
            ;DIBUIXAM L'EL·LIPSE
            MOVE.B  #88,D0
            TRAP    #15 
            
             ;PEN COLOR
            MOVE.B  #80,D0
            CLR.L   D1
            TRAP    #15
            
            ;FILL COLOR
            MOVE.B  #81,D0
            TRAP    #15
            
                      
            ; DRAW LEFT LINE:
            MOVE.W  #BEEPOSX-BEEWIDTH/4-3,D1
            MOVE.W  #BEEPOSX-BEEWIDTH/4,D3
            MOVE.W  (BEEPOSY),D2
            ADD.W   #2,D2
            SUB.W   #BEEHEIGH/2,D2
            MOVE.W  (BEEPOSY),D4
            ADD.W   #BEEHEIGH/2-2,D4
            
            MOVE.B  #87,D0
            TRAP    #15
            
            ; DRAW RIGHT LINE:
            MOVE.W  #BEEPOSX,D1
            MOVE.W  #BEEPOSX+3,D3
            MOVE.W  (BEEPOSY),D2
            SUB.W   #BEEHEIGH/2,D2
            MOVE.W  (BEEPOSY),D4
            ADD.W   #BEEHEIGH/2,D4           
            MOVE.B  #87,D0
            TRAP    #15
                       
             ;PEN COLOR
            MOVE.B  #80,D0
            CLR.L   D1
            TRAP    #15
            
            ;FILL COLOR
            MOVE.B  #81,D0
            TRAP    #15
            
            ; DRAW EYE
            MOVE.W  #BEEPOSX+BEEWIDTH/4-2,D1
            MOVE.W  #BEEPOSX+BEEWIDTH/4+2,D3
            MOVE.W  (BEEPOSY),D2
            SUB.W   #2,D2
            MOVE.W  (BEEPOSY),D4
            ADD.W   #2,D4
            MOVE.B  #87,D0
            TRAP    #15            
            
              ;PEN COLOR
            MOVE.B  #80,D0
            MOVE.L  #$00FFFFFF,D1
            TRAP    #15
            
            ;FILL COLOR
            MOVE.B  #81,D0
            TRAP    #15
              ; DRAW EYE PUPIL
            MOVE.W  #BEEPOSX+BEEWIDTH/4-2,D1
            MOVE.W  #BEEPOSX+BEEWIDTH/4-1,D3
            MOVE.W  (BEEPOSY),D2
            SUB.W   #2,D2
            MOVE.W  (BEEPOSY),D4
            ADD.W   #1,D4
            
            MOVE.B  #87,D0
            TRAP    #15            
            JSR     WINGSUPD
            
            MOVEM.L (A7)+,D0-D4

            RTS
    
; ------------------------------------------------------------------------------
PLTBEEWINGS
; PLOTS THE BEE WINGS.
; INPUT    : (A1) - CONTAINS THE VALUE OF WINGHEIGH FOR UP AND DOWN MOTION
; OUTPUT   : NONE
; MODIFIES : NONE
; ----------------------------------------------------------------------------


            MOVEM.L D0-D5/A1,-(A7)
            ;PEN COLOR
            MOVE.B  #80,D0
            MOVE.L  #WINGCOL,D1
            TRAP    #15
            
            ;FILL COLOR
            MOVE.B  #81,D0
            TRAP    #1
            
            ;DIBUIXAM LES ALES ADALT:
            ;DEFINIM LES COORDENADES
            MOVE.W  #BEEPOSX-WINGWIDTH/2,D1
            MOVE.W  #BEEPOSX+WINGWIDTH/2,D3
            
            MOVE.W  (BEEPOSY),D2
            MOVE.W  (A1),D5
            ADD.W   #BEEHEIGH/2,D5
            SUB.W   D5,D2
            MOVE.W  (BEEPOSY),D4
            SUB.W   #BEEHEIGH/2,D4
            
            MOVE.B  #88,D0
            TRAP    #15

            MOVEM.L (A7)+,D0-D5/A1
   
            RTS
            
; ------------------------------------------------------------------------------
WINGSUPD
; PLOT THE BEE WINGS.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ----------------------------------------------------------------------------
            MOVEM.L  D0/A1,-(A7)
            MOVE.B  (SCRCYCCT),D0
            AND.B   #%00000001,D0  ;(CADA 4 CICLES : 4*20MS)
            BNE     .DOWN
.UP         MOVE.W  #WINGHEIGH1,(A1)
            JMP     .END
.DOWN       MOVE.W  #WINGHEIGH2,(A1)                       
.END        JSR     PLTBEEWINGS

            MOVEM.L  (A7)+,D0/A1
            RTS        









*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
