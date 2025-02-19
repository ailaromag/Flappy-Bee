; ==============================================================================
; GAMEOVER MANAGEMENT
; ==============================================================================

            
; ------------------------------------------------------------------------------
GOVERUPD
; INTRO SCREEN UPDATE
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.L  D1,-(A7)            
            MOVE.L  (KBDEDGE),D1           
            BTST.L  #0,D1           ; COMPROVAM LA TECLA DRETA
            BEQ     .CONT
            CLR.W   (STANEXT)                   
.CONT       MOVE.L  (A7)+,D1
            RTS            
            
; ------------------------------------------------------------------------------
GOVERPLOT
; INTRO SCREEN PLOT
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D7/A0,-(A7)

           ; DEFINIM LES PROPIETATS DE LA FONT
            MOVE.L  #$00FFFFFF,D1
            MOVE.L  #$040F0000,D2
            MOVE.B  #21,D0
            TRAP    #15
                        
            LEA     .TXT1,A0
            MOVE.B  #15,D0
            JSR     UTLPRINT
            
            ;DIBUIXAM LA IMATGE DEL COR
            MOVE.W  #SCRWIDTH/2-10,D0
            MOVE.W  #SCRHEIGH/2+7,D1          
            JSR     HEARTPLOT
            
            ;DIBUIXAM LA IMATGE DE L'ARANYA
            MOVE.W  #SCRWIDTH/2-50,D0
            MOVE.W  #SCRHEIGH/3,D1
            JSR     SPIDERPLOT
          
            BTST.B  #3,(SCRCYCCT)   ;IMPLEMENTAM EL PARPADEIG
            BEQ     .DONE
            
            LEA     .TXT2,A0
            MOVE.B  #25,D0
            MOVE.B  #2,D2           ;INDICAM EL TAMANY 2 DE LLETRA
            JSR     UTLPRINT         
.DONE      
            MOVE.B #SNDLOSE,D7      ;SO DE GAME OVER 
            TRAP   #SNDPLTN            

            MOVEM.L (A7)+,D0-D7/A0
            RTS
            

.TXT1       DC.B    'G A M E                 O V E R',0
.TXT2       DC.B    'PRESS RIGHT ARROW KEY TO GO BACK',0 
            DS.W    0                  


       
; ------------------------------------------------------------------------------
HEARTPLOT
; PLOT THE HEART IMAGE
; INPUT    : D0 - POSXINI
;            D1 - POSYINI 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L  D0-D1/A1,-(A7)
            
            MOVE.W  D0,(POSXINI)
            MOVE.W  D1,(POSYINI)
            MOVE.W  #3,(PIXSIZE)
            MOVE.W  #14,(BMPHEIG)
            MOVE.W  #16,(BMPWIDT)        

            LEA     HEARTMAP,A1
            JSR     MAPPLOT
                          
            MOVEM.L (A7)+,D0-D1/A1
            RTS
             
; ------------------------------------------------------------------------------
SPIDERPLOT
; PLOT THE SPIDER IMAGE
; INPUT    : D0 - POSXINI
;            D1 - POSYINI 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L  D0-D1/A1,-(A7)
            
            MOVE.W  D0,(POSXINI)
            MOVE.W  D1,(POSYINI)
            MOVE.W  #2,(PIXSIZE)
            MOVE.W  #32,(BMPHEIG)
            MOVE.W  #64,(BMPWIDT)        

            LEA     BLACKSPIDER,A1
            JSR     MAPPLOT
             
             
            MOVEM.L (A7)+,D0-D1/A1
            RTS             
 
*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
