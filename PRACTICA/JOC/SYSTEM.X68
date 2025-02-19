; ==============================================================================
; SYSTEM
; ==============================================================================
            
; ------------------------------------------------------------------------------
SYSINIT
; INITIALIZE SYSTEM.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------           
            MOVE.L  #SCRPLOT,($80+SCRUPTN*4)    ;INSTALAM ALS TRAPS 
            MOVE.L  #KBDUPD,($80+KBDUPTN*4)     
            MOVE.L  #SNDPLAY,($80+SNDPLTN*4)
            MOVE.L  #MSEUPD,($80+MSEUPTN*4)
            MOVE.L  #SCRTIM,($60+SCRINTN*4)     ;INSTALAM A LA INTERRUPCIÓ 1

            JSR     SCRINIT
            JSR     KBDINIT
            JSR     SNDINIT
            JSR     MSEINIT 
            JSR     DMMINIT                    
            
            MOVE.W  SR,-(A7)
            ANDI.W  #$D8FF,(A7)                 ;REHABILITAM LES INSTRUCCIONS:
                                                ;%1101   1000    1111    1111        
            RTE     

           
; ------------------------------------------------------------------------------
SNDINIT
; SOUND SYSTEM INIT.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------           
            MOVEM.L D0-D1/A0-A1,-(A7)
            LEA     .SNDLIST,A0
.LOOP       MOVE.L  (A0)+,D0
            BEQ     .DONE                  
            MOVE.L  D0,A1          
            MOVE.B  #71,D0
            TRAP    #15
            ADDQ.B  #1,D1                       ;AFEGIM L'IDENTIFICADOR DE CADA SO        
            BRA     .LOOP
.DONE       MOVEM.L (A7)+,D0-D1/A0-A1     
            RTS
            
            
.SNDHIT     DC.B    'SND/minecraft_hit_sound.wav',0       
.SNDWIN     DC.B    'SND/sims3_win_sound.wav',0
.SNDLOSE    DC.B    'SND/sims3_toilet_breaks.wav',0
.SNDSELECT  DC.B    'SND/select_sound.wav',0
.SNDATTACK  DC.B    'SND/minecraft_spider.wav',0
.SNDLIST    DC.L    .SNDHIT,.SNDWIN,.SNDLOSE,.SNDSELECT,.SNDATTACK,0          

; ------------------------------------------------------------------------------
SNDPLAY
; PLAY SOUND.
; INPUT    : D7 SOUND ID
;          : D1.B  BIT 7=1 LOOP, BIT 7=0 PLAY ONLY ONCE
;                  BITS 6-0 SOUND ID
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------           
            MOVEM.L  D0-D1,-(A7)
            MOVE.B  #72,D0
            MOVE.B  D7,D1
            TRAP    #15

            MOVEM.L  (A7)+,D0-D1
            RTE                   
                           
            
            
; ------------------------------------------------------------------------------
SCRINIT
; INITIALIZE SCREEN: SET SCREEN RESOLUTION, SET WINDOWED MODE
; ENABLE DOUBLE BUFFER, ENABLE TIMED INTERRUPT.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D3,-(A7)

            ; SET SCREEN RESOLUTION
            MOVE.B  #33,D0
            MOVE.L  #SCRWIDTH<<16|SCRHEIGH,D1
            TRAP    #15
            
            ; SET WINDOWED MODE           
            MOVE.L  #1,D1
            TRAP    #15
            
            ; CLEAR SCREEN
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
  
            ; ENABLE DOUBLE BUFFER
            MOVE.B  #92,D0
            MOVE.B  #17,D1
            TRAP    #15
            
            
            ; ENABLE TIMED INTERRUPT
            MOVE.B  #32,D0
            MOVE.B  #6,D1
            MOVE.B  #%10000001|SCRINTN,D2    ; HABILITA UNA INTERRUPCIÓ, LA 1
            MOVE.L  #1000/SCRFPS,D3          ; 50 FOTOGRAMES PER SEGON
            TRAP    #15
            
            ; CLEAR INTERRUPT AND CYCLE COUNTERS
            CLR.W   (SCRINTCT)    
            
            MOVEM.L (A7)+,D0-D3
            
            RTS
            
            
; ------------------------------------------------------------------------------
SCRPLOT
; UPDATE DOUBLE BUFFER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------ 
            MOVEM.W D0-D1,-(A7)
            ; SWITCH BUFFERS
            MOVE.B  #94,D0
            TRAP    #15 
            
            ;CLEAR HIDDEN BUFFER
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
                        
            MOVEM.W (A7)+,D0-D1
            RTE ; PERQUE ES RUTINA DE SISTEMA 
            
; ------------------------------------------------------------------------------
SCRTIM 
; TIMED INTERRUPT SERVICE ROUTINE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------ 
            ADDQ.B  #1,(SCRINTCT)
            ADDQ.B  #1,(SCRCYCCT)
            RTE
            
; ------------------------------------------------------------------------------
KBDINIT
; INITIALIZE KEYBOARD
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            CLR.L   (KBDVAL)   
            CLR.L   (KBDEDGE) 
            RTS

; ------------------------------------------------------------------------------
KBDUPD
; UPDATE KEYBOARD
; SSFFPPRR --> S : SPACE | F : FIRE  | P : PAUSE | R : RIGHT
;
       ;     BTST.L  #0,D1   ; TEST FOR RIGHT
       ;     BTST.L  #8,D1   ; TEST FOR SPACE
       ;     BTST.L  #16,D1  ; TEST FOR FIRE
       ;     BTST.L  #24,D1  ; TEST FOR PAUSE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L  D0-D1,-(A7)
            
            
            MOVE.B  #19,D0     
            MOVE.L  #KBDSPACE<<24+KBDFIRE<<16+KBDPAUSE<<8+KBDRIGHT,D1 
            TRAP    #15

            ; CALCULAR KBDEDGE 
            MOVE.L  (KBDVAL),D0 
            NOT.L   D0
            AND.L   D1,D0
            MOVE.L  D0,(KBDEDGE)

            ; GUARDAR KBD    
                         
            MOVE.L  D1,(KBDVAL) 
            MOVEM.L  (A7)+,D0-D1

            RTE


; ------------------------------------------------------------------------------
MSEINIT
; INITIALIZE MOUSE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1,-(A7)
         ; INICIALITZAR MOUSE IRQ
            MOVE.W  #$0101,D1         ;HABILITAR EL MOUSE IRQ LEVEL 1
            MOVE.B  #60,D0
            TRAP    #15
            
            CLR.L   (MSECOORD)
            CLR.W   (MSEVAL)
            
            MOVEM.L (A7)+,D0-D1
            RTS

; ------------------------------------------------------------------------------
MSEUPD
; UPDATE MOUSE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D1,-(A7)
          ; MOUSE READ
            MOVE.B  #0,D1           ;COMPROVAR SI S'HA MOGUT
            MOVE.B  #61,D0
            TRAP    #15
          
            MOVE.L  D1,(MSECOORD)   ;GUARDAR COORDENADES EN VARIABLE 
            MOVE.W  D0,(MSEVAL)
            
            MOVEM.L (A7)+,D0-D1

            RTE







*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
