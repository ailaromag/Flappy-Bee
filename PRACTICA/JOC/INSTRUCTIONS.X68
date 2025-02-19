; ==============================================================================
; INSTRUCTIONS MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
INSINIT
; INSTRUCTIONS SCREEN INIT
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            CLR.W   (INSTIMER)
            RTS
            
; ------------------------------------------------------------------------------
INSUPD
; INSTRUCTIONS SCREEN UPDATE
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.L  D1,-(A7)
            MOVE.L  (KBDEDGE),D1           
            BTST.L  #24,D1          ;TEST FOR SPACE KEY
            BEQ     .CONT
            CLR.W   (STANEXT)      
.CONT       
*ADDQ.W  #1,(INSTIMER)
*            CMP.W   #INSMAXTM,(INSTIMER)
*            BLT     .DONE
*            CLR.W   (STANEXT)
*.DONE   
            MOVE.L  (A7)+,D1
            RTS
            
; ------------------------------------------------------------------------------
INSPLOT
; INSTRUCTIONS SCREEN PLOT
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.L D0-D1/A0-A1,-(A7)            
            MOVE.L  #15,D0       ; ROW 8
            LEA     .TXTLST,A1
.LOOP       MOVE.L  (A1)+,D1
            BEQ     .DONE
            MOVE.B  #1,D2                   ;INDICAM EL TAMANY 1
            MOVE.L  D1,A0
            JSR     UTLPRINT
 
            
            BRA     .LOOP
       
.DONE       MOVEM.L (A7)+,D0-D1/A0-A1
            RTS
            
.TXT1       DC.B    'KEEP FLYING PRESSING THE SPACE BUTTON',0
.TXT2       DC.B    'TO DODGE DE TREES',0
.TXT3       DC.B    'GET THE HONEY CLICKING ON IT WITH THE MOUSE',0
.TXT4       DC.B    '',0 
.TXT5       DC.B    'AND DON`T FORGET TO ESCAPE THE ENEMIES!',0
            DS.W    0           
.TXTLST     DC.L    .TXT1,.TXT2,.TXT3,.TXT4,.TXT5,0





*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
