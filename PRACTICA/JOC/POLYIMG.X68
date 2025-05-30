*-----------------------------------------------------------
* LLIBRERIA QUE DIBUIXA POLIGONS PER CREAR IMATGES A PARTIR
* DE COORDENADES 
*-----------------------------------------------------------
    		

; -----------------------------------------------------------------------------
POLYIMGID
; DRAWS A PICTURE BY ID
; INPUT    - A0 POINTER TO THE LIST OF POINTERS TO PICTURES
;            D5.W X OFFSET
;            D6.W Y OFFSET
;            D7.W OBJECT ID
; OUTPUT   - NONE
; MODIFIES - A1
; -----------------------------------------------------------------------------
            ROL.W   #2,D7                  
            MOVE.L  (A0,D7.W),A1            ; AGAFAM L'ADRE�A DE LA IMATGE
            ROR.W   #2,D7                   
                                            ; CONTINUAM EXECUTANT GFXDRPIC

; -----------------------------------------------------------------------------
GFXDRPIC
; DRAWS A PICTURE
; INPUT    - A1 POINTER TO THE PICTURE
;            D5.W X OFFSET
;            D6.W Y OFFSET
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
DRWPIC      MOVEM.L D0-D4/A0-A1,-(A7)
.LOOP       MOVE.W  (A1)+,D0                ; IDENTIFICADOR
            BEQ     .END
            LEA     .JMPTBL,A0
            ROL.W   #2,D0                   
            MOVE.L  (A0,D0.W),A0            ; OBTENIM L'ADRE�A DE JUMP
            ROR.W   #2,D0                   ; RECUPERAM D0
            ADD.W   #79,D0                  ; CREAM EL CODI TRAP
            JMP     (A0)                    ; BOTAM A LA SUBRITUNA CORRESPONENT
.END        MOVEM.L (A7)+,D0-D4/A0-A1
            RTS
.JMPTBL     DC.L    .LOOP                   ; 00 UNUSED
            DC.L    .D1L                    ; 01 SET PEN
            DC.L    .D1L                    ; 02 SET FILL
            DC.L    .D1D2W                  ; 03 DRAW PIXEL
            DC.L    .D1L2                   ; 04 SET PEN AND FILL
            DC.L    .D1D4W                  ; 05 DRAW LINE FULL SPECS
            DC.L    .D1D2W                  ; 06 DRAW LINE POLYLINE VERSION
            DC.L    .D1D2W                  ; 07 MOVE TO
            DC.L    .D1D4W                  ; 08 DRAW FILLED RECTANGLE
            DC.L    .D1D4W                  ; 09 DRAW FILLED ELLIPSE
            DC.L    .D1D2W                  ; 10 FLOOD FILL
            DC.L    .D1D4W                  ; 11 DRAW UNFILLED RECTANGLE
            DC.L    .D1D4W                  ; 12 DRAW UNFILLED ELLIPSE
            DC.L    .D1W                    ; 13 SET DRAWING MODE
            DC.L    .D1W                    ; 14 SET PEN WIDTH
.D1W        MOVE.W  (A1)+,D1                ; GET WORD
            TRAP    #15
            JMP     .LOOP
.D1L        MOVE.L  (A1)+,D1                ; GET LONG
            TRAP    #15
            JMP     .LOOP
.D1L2       MOVE.L  (A1)+,D1                ; GET LONG AND DO SET PEN AND FILL
            MOVE.B  #80,D0
            TRAP    #15
            ADDQ.B  #1,D0
            TRAP    #15
            JMP     .LOOP
.D1D2W      MOVEM.W (A1)+,D1-D2             ; GET 2 WORDS
            ADD.W   D5,D1
            ADD.W   D6,D2
            TRAP    #15
            JMP     .LOOP
.D1D4W      MOVEM.W (A1)+,D1-D4             ; GET 4 WORDS
            ADD.W   D5,D1
            ADD.W   D6,D2
            ADD.W   D5,D3
            ADD.W   D6,D4
            TRAP    #15
            JMP     .LOOP
		       

*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
