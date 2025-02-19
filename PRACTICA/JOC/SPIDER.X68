; ==============================================================================
; SPIDER MANAGEMENT (AGENT)
; (W) +0 X COORDINATE --> A0     ; DEFINIM ELS OFFSETS DE LA MEMORIA LOCAL (DE INSTÀNCIA)
; (W) +2 Y COORDINATE --> 2(A0)
; (W) +4 SPIDER STATE --> 4(A0)
; (W) +8 Y MAX        --> 8(A0)
; (W) +16 COLLISION STATE --> 16(A0)
; ==============================================================================
  
 
; -----------------------------------------------------------------------------
SPDINIT
; INITALIZES A SPIDER
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - ASSUMES SCRHEIGH IS GREATER THAN 255
; -----------------------------------------------------------------------------

            MOVEM.L D0-D1/A1,-(A7)
            MOVE.W  #SCRWIDTH/2,(A0)

            MOVE.W  #0,2(A0)
            MOVE.W  #0,4(A0)          
            
            JSR     UTLRAND
            AND.L   #$00000007,D0             ; MASCARA PER AGAFAR ELS DARRERS 3 BITS
            
            MOVE.L  D0, D1                    ; COPIAM D0 
            LEA     .SPDPOSITIONS,A1
            LSL.W   #1, D1                    ; CALCULAM EL OFFSET
            MOVE.W  (A1,D1.W),8(A0)           ; POSEM DE LA POSICIÓ ALEATORIA ; DINS GAPPOSY


            MOVE.W  #$FF,4(A0)                ; SPIDER VA CAP ABAIX
            MOVE.W  #$FF,16(A0)               ; SPIDER NO A COLISIONAT            
            
            MOVEM.L (A7)+,D0-D1/A1 
            
            RTS
            
.SPDPOSITIONS   ;POSICIONS Y ON ARRIBARÀ L'ARANYA COM A MÀXIM 
                DC.W    600  
                DC.W    500             
                DC.W    400       
                DC.W    SCRHEIGH/2                     
                DC.W    SCRHEIGH/2-SPDSIZEH           
                DC.W    SCRHEIGH/3  
                DC.W    SCRHEIGH/4 
                DC.W    SCRHEIGH/5                          

 
; -----------------------------------------------------------------------------
SPDUPD
; UPDATES A SPIDER
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------

            MOVEM.W  D0-D6,-(A7)
            ; L'ARANYA ES MOU A CAP ABAIX AMB VELOCITAT CONSTANT
            MOVE.W  (A0),D0
            SUB.W   #SPDSPEED,D0
        
            ; COMPROVAR COLISIO HORITZONTAL
            CMP.W   #-SPDSIZEW-SPDSIZEW/2,D0
            BLT     .COLLFT
            BRA     .CONTINUE
.COLLFT     ; COLISIO ESQUERRA
            JSR     AGLKILL             ; ELIMINAM L'ARANYA
            BRA     .DONE
.CONTINUE            
            MOVE.W  2(A0),D1            ; OBTENIM LA POSICIO Y            
            MOVE.W  8(A0),D2  
            CMP.W   D2,D1
            BLT     .SUMAR
            CLR.W   4(A0)               ; CAMBIAM L'ESTAT PERQUE JA NO BAIXARÀ MÉS
            JMP     .DONE

.SUMAR      ADD.W   #SPDSPEEDY,D1

.DONE       
            TST.W   16(A0)
            BEQ     .ALREADY_COLLISIONED
            JSR     SPDCOLLISION

.ALREADY_COLLISIONED
            MOVE.W  D0,(A0)                                          
            MOVE.W  D1,2(A0)                     
            MOVEM.W  (A7)+,D0-D6
            
            RTS            
            
            
; -----------------------------------------------------------------------------
SPDPLOT
; PLOTS A SPIDER
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            
            MOVEM.L D0-D6,-(A7)
            ;SET PEN COLOR
            MOVE.B  #80,D0
            MOVE.L  #SPDPCOL,D1
            TRAP    #15                        
            ;SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #SPDFCOL,D1
            TRAP    #15
            ;DRAW BALL
            MOVE.W  (A0),D1
            MOVE.W  2(A0),D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W  #SPDSIZEW,D3
            ADD.W  #SPDSIZEH,D4
            MOVE.B  #88,D0
            TRAP    #15
                       
            ;SET PEN COLOR
            MOVE.B  #80,D0
            MOVE.L  #$00FFFFFF,D1
            TRAP    #15 
            
            ;DRAW STRING FROM TOP SCREEN TO SPIDER
            MOVE.W  (A0),D1
            ADD.W   #SPDSIZEW/2,D1
            MOVE.W  D1,D3
            MOVE.W  #0,D2
            MOVE.W  2(A0),D4
            MOVE.B  #84,D0
            TRAP    #15
   
            ;SET PEN COLOR
            MOVE.B  #80,D0
            MOVE.L  #$000000FF,D1
            TRAP    #15                        
            ;SET FILL COLOR
            MOVE.B  #81,D0
            TRAP    #15
            ;DRAW EYES
            ;FIRST EYE
            MOVE.W  (A0),D1
            ADD.W  #SPDSIZEW/4,D1
            MOVE.W  D1,D3
            ADD.W   #2,D3
            MOVE.W  2(A0),D2
            ADD.W   #SPDSIZEH/2,D2
            MOVE.W  D2,D4
            ADD.W  #SPDSIZEH/2-4,D4
            MOVE.W  #87,D0
            TRAP    #15
            
            ;SECOND EYE
            ADD.W   #SPDSIZEW/2,D1
            MOVE.W  D1,D3
            ADD.W   #2,D3
            MOVE.W  #87,D0
            TRAP    #15  
            
            ;SET PEN COLOR
            MOVE.B  #80,D0
            CLR.L   D1
            TRAP    #15 

            ; DRAW LEGS:
            MOVE.B  #3,D1
            MOVE.B  #93,D0
            TRAP    #15
            
            LEA     .COORD_LEGS,A1        
            MOVE.W  #7,D3
           
.MOVE_TO    MOVE.W  (A0),D1
            MOVE.W  2(A0),D2
            CMP.W   #3,D3
            BGT     .CONTINUE
            ADD.W   #SPDSIZEW,D1
                       
.CONTINUE   MOVEM.W (A1)+,D5-D6             ; GET 2 WORDS
            ADD.W   D5,D1
            ADD.W   D6,D2
            MOVE.B  #86,D0
            TRAP    #15
            MOVE.W  #1,D4
.DRAW_LINE  MOVEM.W (A1)+,D5-D6             ; GET 2 WORDS
            ADD.W   D5,D1
            ADD.W   D6,D2
            MOVE.B  #85,D0
            TRAP    #15
            DBEQ    D4,.DRAW_LINE
            DBEQ    D3,.MOVE_TO
       
            ;RESET PEN WIDTH
            MOVE.B  #1,D1
            MOVE.B  #93,D0
            TRAP    #15
                    
            MOVEM.L (A7)+,D0-D6
            RTS
.COORD_LEGS
            DC.W    4,4         ;VALUES OF X AND Y
            DC.W    -8,-8
            DC.W    -12,12
            
            DC.W    1,10
            DC.W    -7,0
            DC.W    -10,12   

            DC.W    0,18
            DC.W    -7,3
            DC.W    -5,6 
            
            DC.W    4,25
            DC.W    -7,4
            DC.W    -2,6
            
            DC.W    -4,4        ;VALUES OF X AND Y
            DC.W    8,-8
            DC.W    12,12
            
            DC.W    -1,10
            DC.W    7,0
            DC.W    10,12   

            DC.W    0,18
            DC.W    7,3
            DC.W    5,6 
            
            DC.W    -4,25
            DC.W    7,4
            DC.W    2,6

            

            
; -----------------------------------------------------------------------------
SPDCOLLISION
; COLLISIONS A SPIDER
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            
            MOVEM.L D1-D3/D7,-(A7)
            ;COMPARAM LA POSICIO X DE L'ARANYA AMB L'ABELLA
            
            MOVE.W  (BEEPOSX),D1
            SUB.W   (A0),D1
            BPL     .NO_NEG          ;MIRAR SI EL VALOR ES NEGATIU
            NEG.W   D1               ;NEGAR PER OBTENIR EL VALOR ABSOLUT
.NO_NEG     CMP.W   #BEEWIDTH/2+SPDSIZEW/2,D1
            BGE     .NO_COLISION
            
            MOVE.W  (BEEPOSY),D2
            SUB.W   2(A0),D2
            BPL     .NO_NEG2
            NEG.W   D2
.NO_NEG2    CMP.W   #BEEHEIGH/2+SPDSIZEH/2,D2
            BGE     .NO_COLISION
            
            MOVE.W  (LIFESVAR),D3
            SUB.W   #1,D3
            MOVE.W   D3,(LIFESVAR)
;BEE COLLISION:
             ;ATTACK SOUND:
            MOVE.B #SNDATTACK,D7    
            TRAP   #SNDPLTN
            CLR.W   16(A0)          ; COLLISION STATE = ON
           
            ;SPIDER DAMAGE
            CMP.W   #SPDDAMAGE,(POINTS)
            BGE     .SUB
            ADDQ.W  #1,(COLLISIONS)
            JMP     .NO_COLISION
.SUB        SUB.W   #SPDDAMAGE,(POINTS)       

.NO_COLISION            
            MOVEM.L (A7)+,D1-D3/D7
            RTS            

     





















*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
