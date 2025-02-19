;-------------------------------------------------------------------------------
; GAME MANAGEMENT
;-------------------------------------------------------------------------------
    		
; ------------------------------------------------------------------------------
GAMINIT
; INITIALIZES THE GAME.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            JSR     DMMINIT             ;BUIDAM LA LLISTA D'AGENTS
            JSR     BEEINIT
            BRA     SCOINIT
            
; ------------------------------------------------------------------------------
GAMUPD
; UPDATES THE GAME.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D7/A1-A3,-(A7)
            MOVE.B  (SCRCYCCT),D0
            AND.B   #%01111111,D0       ;DONARA 0 CADA X CICLES (X*20 =  MS)
            BNE     .GOUPD    

          
            ; AGENT COLUMN           
            LEA     COLINIT,A1
            LEA     COLUPD,A2
            LEA     COLPLOT,A3
            MOVE.W  #1,D0
            JSR     AGLADD     
            
            MOVE.B  (SCRCYCCT),D0
            AND.B   #%11111111,D0       
            BNE     .GOUPD    
            ; AGENT HONEYBALL          
            LEA     HONINIT,A1
            LEA     HONUPD,A2
            LEA     HONPLOT,A3
            MOVE.W  #2,D0
            JSR     AGLADD  


            MOVE.B  (SCRCYCCT),D0
            AND.B   #%01111111,D0 
            BNE     .GOUPD
            ;AGENT SPIDER
            LEA     SPDINIT,A1 
            LEA     SPDUPD,A2
            LEA     SPDPLOT,A3
            MOVE.W  #SPDTYPE,D0
            JSR     AGLADD       

.GOUPD      JSR     AGLUPD                      
            JSR     BEEUPD
                                                  
            CMP.W   #LEVLMAX,(LEVEL)
            BLT     .CHKLOSS
            MOVE.W  #3,(STANEXT)
            BRA     .DONE
            
.CHKLOSS    CMP.W   #COLLMAX,(COLLISIONS)
            BLT     .CHKLIFES
            MOVE.W  #4,(STANEXT)           
.CHKLIFES
            CMP     #0,(LIFESVAR)
            BGT     .DONE
            MOVE.W  #4,(STANEXT)

.DONE       

            MOVEM.L (A7)+,D0-D7/A1-A3
            RTS

; ------------------------------------------------------------------------------
GAMPLOT
; PLOT THE GAME.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            JSR     SKYPLOT
            JSR     AGLPLOT
            JSR     SCOPLOT
            BRA     BEEPLOT
    




























*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
