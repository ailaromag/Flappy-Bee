; ==============================================================================
; INTRO MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
ISCINIT
; INTRO SCREEN INIT
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
*            ; INICIALITZAM EL TIMER
            CLR.W   (ISCTIMER)      
            RTS
            
        
; ------------------------------------------------------------------------------
ISCUPD
; INTRO SCREEN UPDATE
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.L D1/D7,-(A7)       
            
            MOVE.L  (KBDEDGE),D1           
            BTST.L  #24,D1          ;COMPROVAM TECLA ESPAI
            BEQ     .CONT
            MOVE.B #SNDSELECT,D7    ;SO DE SELECCIO
            TRAP   #SNDPLTN
            MOVE.W  #2,(STANEXT)    ;PASSAM AL SEGÜENT ESTAT
            
.CONT       ADDQ.W  #1,(ISCTIMER)
            CMP.W   #ISCMAXTM,(ISCTIMER)
            BLT     .DONE
            MOVE.W  #1,(STANEXT)

    
.DONE       MOVEM.L (A7)+,D1/D7   
            RTS
            
; ------------------------------------------------------------------------------
ISCPLOT
;INTRO SCREEN PLOT
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D7/A0-A1,-(A7)
                                     
            ;INICIALITZAM LES VARIABLES DEL BITMAP:
            MOVE.W  #SCRWIDTH/2-128,(POSXINI)
            MOVE.W  #SCRHEIGH/2+128,(POSYINI)
            MOVE.W  #4,(PIXSIZE)
            MOVE.W  #64,(BMPHEIG)
            MOVE.W  #64,(BMPWIDT)
             
            LEA    BEEMAP,A1                ; DIBUIXAM L'ABELLA
            JSR    MAPPLOT

            MOVE.L  #$711DB0,D1
            MOVE.B  #81,D0
            TRAP    #15
            MOVE.B  #80,D0
            TRAP    #15
            
            ; DIBUIXAM EL LOGO. 
            LEA     IMGLIST,A0
            MOVE.W  #(SCRWIDTH-345)/2,D5    ; DEFINIM LA POSICIO X
            MOVE.W  #SCRHEIGH/2-250,D6      ; DEFINIM LA POSICIO Y, ADALT DE LA PANTALLA
            MOVE.W  #0,D7
            JSR     POLYIMGID                 
   
            MOVE.W  #(SCRWIDTH)/2,D5        
            MOVE.W  #SCRHEIGH-150,D6        ; POSICIO Y, ABAIX DE LA PANTALLA
            MOVE.W  #1,D7
            JSR     POLYIMGID                         
           
            MOVE.L  #HONPCOL,D1
            MOVE.B  #81,D0
            TRAP    #15
            MOVE.B  #80,D0
            TRAP    #15
            
            ;DIBUIXAM EL SOMBREJAT DE "BEE"
            LEA     IMGLIST,A0
            MOVE.W  #(SCRWIDTH)/2-4,D5      ; DESPLAÇAM 4 PIXELS EL LOGO RESPECTE A L'ALTRE 'BEE'   
            MOVE.W  #SCRHEIGH-154,D6      
            MOVE.W  #1,D7
            JSR     POLYIMGID
 
            
            CLR.L   D1
            MOVE.B  #81,D0
            TRAP    #15

            
            BTST.B  #3,(SCRCYCCT)            ;IMPLEMENTAM EL PARPADEIG (DE 8 EN 8 CICLES)
            BEQ     .DONE
            
            ; DEFINIM PROPIETATS DE LA FONT
            MOVE.L  #$00FFFFFF,D1
            MOVE.L  #$040C0000,D2
            MOVE.B  #21,D0
            TRAP    #15
            
            LEA     .TXT2,A0
            MOVE.B  #29,D0
            MOVE.B  #1,D2                   ;INDICAM EL TAMANY 1
            JSR     UTLPRINT
            
.DONE       MOVEM.L (A7)+,D0-D7/A0-A1
            RTS
            

.TXT1       DC.B    'FLAPPY BEE 68000',0
.TXT2       DC.B    'PRESS SPACE KEY TO START',0 
            DS.W    0           

*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
