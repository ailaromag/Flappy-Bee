; ==============================================================================
; WIN MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
WINUPD
; INTRO SCREEN UPDATE
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.L  D1,-(A7)
            MOVE.L  (KBDEDGE),D1           
            BTST.L  #0,D1           ; COMPROVAM TECLA FLETXA DRETA

            BEQ     .CONT
            CLR.W   (STANEXT)      
.CONT       MOVE.L  (A7)+,D1
            RTS   
            
; ------------------------------------------------------------------------------
WINPLOT
;INTRO SCREEN PLOT
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D7/A0,-(A7)
            
            
            MOVE.L  #$8F6B71,D1
            MOVE.B  #80,D0
            TRAP    #15
            MOVE.B  #81,D0
            TRAP    #15
                  
            MOVE.W  #0,D1
            MOVE.W  #0,D2
            MOVE.W  #SCRWIDTH,D3
            MOVE.W  #SCRHEIGH,D4
            MOVE.B  #87,D0
            TRAP    #15

            ;DEFINIM LES PROPIETATS DE LA FONT
            MOVE.L  #$00FFFFFF,D1
            MOVE.L  #$040F0000,D2
            MOVE.B  #21,D0
            TRAP    #15
            
            LEA     .TXT1,A0
            MOVE.B  #13,D0
            JSR     UTLPRINT
                   
            MOVE.B #SNDWIN,D7       ;SO DE VICTORIA
            TRAP   #SNDPLTN
                        
            MOVE.L  #WINCOL,D1      ;COLOR DE FONS
            MOVE.B  #80,D0
            TRAP    #15
            MOVE.B  #81,D0
            TRAP    #15            
            
            ;DIBUIXAM LA SOMBRA DE L'ABELLA           
            MOVE.W  #SCRWIDTH/2-36,D1
            MOVE.W  #SCRHEIGH/2+86,D2
            MOVE.W  D1,D3
            ADD.W   #75,D3
            MOVE.W  D2,D4
            ADD.W   #20,D4
            MOVE.B  #88,D0
            TRAP    #15
            
            BTST.B  #3,(SCRCYCCT)  ;IMPLEMENTAM EL PARPADEIG (DE 8 EN 8 CICLES)
            BEQ     .DOWN
            
            ; DIBUIXAM LA IMATGE DE L'ABELLA 
            MOVE.W  #SCRWIDTH/2-16*3,D0
            MOVE.W  #SCRHEIGH/2-10,D1          
            JSR     BEEWINPLOT
            
            
            LEA     .TXT2,A0
            MOVE.B  #25,D0
            MOVE.B  #2,D2           ;INDICAM EL TAMANY 2 DE LLETRA
            JSR     UTLPRINT
            JMP     .DONE
.DOWN                        
            MOVE.W  #SCRWIDTH/2-16*3,D0
            MOVE.W  #SCRHEIGH/2+7,D1          
            JSR     BEEWINPLOT
                       
.DONE       MOVEM.L (A7)+,D0-D7/A0
            RTS
            

.TXT1       DC.B    'Y O U                  W O N !',0
.TXT2       DC.B    'PRESS RIGHT ARROW KEY TO GO BACK',0 
            DS.W    0                  


; ------------------------------------------------------------------------------
BEEWINPLOT
; PLOTS THE BEE WINNING IMAGE
; INPUT    : D0 - POSXINI
;            D1 - POSYINI 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L  D0-D1/A1,-(A7)
            
            MOVE.W  D0,(POSXINI)
            MOVE.W  D1,(POSYINI)

            MOVE.W  #3,(PIXSIZE)
            MOVE.W  #32,(BMPHEIG)
            MOVE.W  #32,(BMPWIDT)        

            LEA     BEEWIN,A1
            JSR     MAPPLOT
             
             
            MOVEM.L (A7)+,D0-D1/A1
            RTS





*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
