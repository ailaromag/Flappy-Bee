*-----------------------------------------------------------------------------
* TITLE      :  FLAPPY BEE GAME
* WRITTEN BY :  AILA ROMAGUERA & ALBA AGUILERA
* DATE       :  CURS 2024-2025
* DESCRIPTION:  ESTRUCTURA DE COMPUTADORES II
*-----------------------------------------------------------------------------
    		
		    ORG    $1000
		    
		    ;CONSTANTS:
		    INCLUDE "CONST.X68" 
		    INCLUDE "SYSCONST.X68" 
		    INCLUDE "LIB/DMMCONST.X68"
		    INCLUDE "LIB/UTLCONST.X68"
		    INCLUDE "IMAGES.X68" 
		    
		    ;CODE:
		    INCLUDE "LIB/DMMCODE.X68"  
            INCLUDE "LIB/AGLCODE.X68"
            INCLUDE "LIB/UTLCODE.X68"    
		    INCLUDE "SYSTEM.X68" 
		    INCLUDE "BEE.X68"    
		    INCLUDE "SCORE.X68"  
		    INCLUDE "COLUMN.X68" 
		    INCLUDE "HONEY.X68"  
		    INCLUDE "GAME.X68"   
		    INCLUDE "BITMAP.X68" 
		    INCLUDE "SKY.X68"    
		    INCLUDE "IMGDATA.X68"
		    INCLUDE "POLYIMG.X68"
		    INCLUDE "XPLOSION.X68"
		    INCLUDE "SPIDER.X68" 	    
		    
		    ;VARIABLES:
		    INCLUDE "VARS.X68"   
		    INCLUDE "LIB/UTLVARS.X68"
            INCLUDE "SYSVARS.X68"
            INCLUDE "LIB/DMMVARS.X68"
            
            ;STATES:
            INCLUDE "INSTRUCTIONS.X68"
            INCLUDE "INTRO.X68"  
            INCLUDE "WIN.X68"    
            INCLUDE "GOVER.X68"   
            INCLUDE "STATES.X68"  

START     
; --- INITIALIZATION -----------------------------------------------------------      
            
            ORI.W   #$0700,SR          ; DESHABILITAM LES INTERRUPCIONS:
            JSR     SYSINIT
            JSR     UTLINIT 
            JSR     STAINIT
 
.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES
            TRAP    #KBDUPTN          ; KEYBOARD UPDATE
            TRAP    #MSEUPTN          ; MOUSE UPDATE  
; UPDATE GAME LOGIC
            JSR     STAUPD
           
; --- SYNC ---------------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)
            BEQ     .WINT
            CLR.B   (SCRINTCT)              
            
; --- PLOT ---------------------------------------------------------------------
            
            JSR     STAPLOT
                    
            TRAP    #SCRUPTN          ; UPDATE DOUBLE BUFFER
            BRA     .LOOP

            SIMHALT
             
            END     START
       























































*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
