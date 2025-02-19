*-------------------------------------------------------------------------------
* BITMAP -- CLASSE AMB SUBRUTINA MAPPLOT QUE DIBUIXA UNA IMATGE A PARTIR DE 
*           LONGS DE COLORS
*------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
MAPPLOT
; PLOT THE BITMAP.
; INPUT    : NONE (COORDINATES FOR CENTER)
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

        MOVEM.L  A1/D0-D5,-(A7)
          
        MOVE.W  (POSXINI),(BITXPOS)
        MOVE.W  (POSYINI),(BITYPOS)
            
         
        MOVE.W   (BMPHEIG),D6    ; COORDENADA Y, ITERA BMPHEIGH VEGADES
        SUBQ    #1,D6
.LOOP2      
        MOVE.W   (BMPWIDT),D5    ; COORDENADA X, ITERA BMPWIDT VEGADES
        SUBQ    #1,D5
.LOOP1 
        MOVE.L  (A1)+,D1         ; OBTENIM EL COLOR                            
	    MOVEQ	#80,D0			 ; PEN AND FILL COLOURS
	    TRAP    #15
	    MOVEQ	#81,D0			
	    TRAP	#15

        ;CALCULAM COORDENADES X E Y PEL PIXEL
	    MOVE.W  (BITXPOS),D1
        MOVE.W  (BITYPOS),D2 
        SUB.W   (PIXSIZE),D2
        
	    MOVE.W	D1,D3	        			
	    ADD.W	(PIXSIZE),D3	 ; OBTENIM EL TAMANY DEL QUADRAT 
	    MOVE.W	(BITYPOS),D4				
	    
        ;RECUPERAM LA POSICIO DEL SEGUENT PIXEL X
        MOVE.W  D3,(BITXPOS)
        
        ;DIBUIXAM PIXEL 
	    MOVEQ	#87,D0			        
        TRAP	#15	
			        
        DBEQ    D5,.LOOP1
        ;PASSAM A LA SEGUENT FILA
        MOVE.W  (POSXINI),(BITXPOS)
        MOVE.W  D2,(BITYPOS)      ; ACTUALITZAM LA POSICIO Y DE LA SEGUENT FILA DE PIXES
        
        DBEQ    D6,.LOOP2
 
        MOVEM.L (A7)+,A1/D0-D5
        RTS


*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
