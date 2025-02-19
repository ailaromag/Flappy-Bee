; ==============================================================================
; HONEYBALL MANAGEMENT (AGENT)
; (W) +0 X COORDINATE --> A0     ; DEFINIM ELS OFFSETS DE LA MEMORIA LOCAL (DE INSTÀNCIA)
; (W) +2 Y COORDINATE --> 2(A0)
; (W) +4 BALL DIAMETER--> 4(A0)
; (W) +4 BALL STATE   --> 8(A0)
; ==============================================================================
  
 
; -----------------------------------------------------------------------------
HONINIT
; INITALIZES A HONEY BALL
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - ASSUMES SCRHEIGH IS GREATER THAN 255
; -----------------------------------------------------------------------------
            MOVEM.L  D0/A1,-(A7)            
            MOVE.W  #SCRWIDTH+SCRWIDTH/5-HONSIZE/2,(A0)
            MOVE.W  #HONSIZE,4(A0)
            
            
            JSR     UTLRAND
            AND.L   #$0000000C,D0             ; MÀSCARA PER AGAFAR ELS MÚLTIPLES DE 2
            LEA     .HONPOSITIONS,A1
            MOVE.W  (A1,D0),2(A0)             ; POSEM DE LA POSICIÓ ALEATORIA DINS GAPPOSY
           
            CLR.W    8(A0)                    ; LA BOLLA ESTA DECREIXENT

            MOVEM.L  (A7)+,D0/A1
            RTS
            
.HONPOSITIONS   
                DC.W    SCRHEIGH-SCRHEIGH/4+HONSIZE   
                DC.W    SCRHEIGH/2             
                DC.W    SCRHEIGH-HONSIZE       
                DC.W    0                      
                DC.W    SCRHEIGH/5             
                DC.W    SCRHEIGH-SCRHEIGH/5+HONSIZE   
                DC.W    SCRHEIGH/4             
              

 
 ; -----------------------------------------------------------------------------
HONUPD
; UPDATES A HONEY BALL
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L  D0-D6,-(A7)
            
            
            MOVE.W  (A0),D0
            MOVE.W  2(A0),D6            ; COORDENADA Y INICIAL 
            SUB.W   #HONSPEED,D0        ; ES DESPLAÇA A L'ESQUERRA
            
             ; COMPROVAM LES COLISIONS HORITZONTALS
            MOVE.W  4(A0),D1
            NEG.W   D1
            CMP.W   D1,D0
            BLT     .COLLFT
            BRA     .CONTINUE
.COLLFT     ; COLISIO ESQUERRA
            JSR     AGLKILL             ; ELIMINAM LA COLUMNA
            BRA     .END

.CONTINUE            
            ; ACTUALTZAM EL TAMANY
            MOVE.W  4(A0),D2  
            ; COMPROVAM SI LA BOLLA CREIX O DISMINUEIX
            AND.W   #$FF,8(A0)
            BNE     .AUMENTAR_BOLA

;DISMINUIR:
            CMP.W   #HONMINSIZE,D2
            BGT     .RESTAR             ; LA BOLLA ES MASSA PETITA, HA DE CREIXER
            MOVE.W  #$FF,8(A0)
            JMP     .DONE
            
.RESTAR     SUB.W   #2,D2
            ; ACTUALITZAM LA COORDENADA X INICIAL
            ADD.W   #1,D0
            ADD.W   #1,D6
            JMP     .DONE            

.AUMENTAR_BOLA
            CMP.W   #HONMAXSIZE,D2
            BLT     .SUMAR
            CLR.W   8(A0)               ; LA BOLLA ESTA EN "DECREMENT"
            JMP     .DONE
.SUMAR            
            ADD.W   #2,D2
            SUB.W   #1,D0
            SUB.W   #1,D6
          
.DONE           
            ; COMPROVAM SI EL MOUSE A CLICAT LA BOLLA DE MEL
            MOVE.W  (MSEVAL),D1   
            CMP.W   #1,D1               ; TEST PER CLICK
            BEQ     .KILL
            BRA     .NOT_KILL           
.KILL       
            ; COMPROVAM LA POSICIÓ DEL CLICK

            
            MOVE.W  (A0),D3               ; COORD X HONEY
            MOVE.W  4(A0),D4              ; HONEY DIAMETER
            ADD.W   D4,D3                 ; X RIGHT BOUNDARY                       
            CMP.W   (MSECOORD+2),D3       ; COORD X POSITIVA
            BLT     .NOT_KILL  
            MOVE.W  (A0),D3
            CMP.W   (MSECOORD+2),D3       ; COORD X NEGATIVA
            BGT     .NOT_KILL
            
            MOVE.W  2(A0),D5              ; COORD Y HONEY
            ADD.W   D4,D5                 ; LOW Y BOUNDARY
            CMP.W   (MSECOORD),D5
            BLT     .NOT_KILL
            MOVE.W  2(A0),D5              ; COORD Y HONEY
            CMP.W   (MSECOORD),D5
            BGT     .NOT_KILL
            
    

            JSR     AGLKILL               ; HONEY KILL
            JSR     HONXPLO
            ADD.W   #HONBONUS,(POINTS)
            
            BRA     .END            
          
            ; GUARDAM LA POSICIO
       
.NOT_KILL            
            MOVE.W  D0,(A0)
            MOVE.W  D2,4(A0)
            MOVE.W  D6,2(A0)

.END        MOVEM.L  (A7)+,D0-D6         
            RTS            
            
            
; -----------------------------------------------------------------------------
HONPLOT
; PLOTS A HONEY BALL
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            
            MOVEM.W D1-D4,-(A7)
            ;SET PEN COLOR
            MOVE.B  #80,D0
            MOVE.L  #HONPCOL,D1
            TRAP    #15                        
            ;SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #HONFCOL,D1
            TRAP    #15
            ;DRAW BALL
            MOVE.W  (A0),D1
            MOVE.W  2(A0),D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W  4(A0),D3
            ADD.W  4(A0),D4
            MOVE.B  #88,D0
            TRAP    #15
            MOVEM.W (A7)+,D1-D4
            RTS

; -----------------------------------------------------------------------------
HONXPLO
; EXPLODES A HONEY BALL
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L A1-A3/D0-D5,-(A7)
            MOVE.W  #HONNFRAG,D4
.LOOP       LEA     XPLINIT,A1
            LEA     XPLUPD,A2
            LEA     XPLPLOT,A3
            MOVE.W  #XPLTYPE,D0
            MOVE.W  (A0),D1
            ADD.W   #HONSIZE/2,D1
            MOVE.W  2(A0),D2
            ADD.W   #HONSIZE/2,D2
            JSR     AGLADD
            DBRA.W  D4,.LOOP
            JSR     AGLKILL
            MOVEM.L (A7)+,A1-A3/D0-D5
            RTS

     









*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
