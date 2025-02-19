; =============================================================================
; EXPLOSION MANAGEMENT (AGENT)
;    (W) +0  --> A0     - COORD X
;    (W) +2  --> 2(A0)  - COORD Y
;    (W) +4  --> 4(A0)  - VELOCITAT X
;    (W) +6  --> 6(A0)  - VELOCITAT Y
; ==============================================================================

; -----------------------------------------------------------------------------
XPLINIT
; INITALIZES AN EXPLOSION ITEM
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
;            D1 X COORDINATE
;            D2 Y COORDINATE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - ASSUMES SCRHEIGH IS GREATER THAN 255
; -----------------------------------------------------------------------------
            MOVEM.L D0-D2,-(A7)
            MOVE.W  D1,(A0)                 ; DEFINIM POSICIO X
            MOVE.W  D2,2(A0)                ; DEFINIM POSICIO Y
            JSR     UTLRAND                 ; OBTENIM VELOCITATS A L'ATZAR
            AND.W   #$01F,D0
            SUB.W   #$0F,D0
            MOVE.W  D0,4(A0)
            JSR     UTLRAND
            AND.W   #$01F,D0
            SUB.W   #$0F,D0
            MOVE.W  D0,6(A0)
            MOVEM.L (A7)+,D0-D2
            RTS

; -----------------------------------------------------------------------------
XPLUPD
; UPDATES AN EXPLOSION ITEM
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  D0,-(A7)
            MOVE.W  4(A0),D0                ; ACTUALITZAM COORDENADES
            SUB.W   D0,(A0)
            MOVE.W  6(A0),D0
            ADD.W   D0,2(A0)
            CMP.W   #-XPLSIZE,(A0)
            BLE     .KILL
            CMP.W   #SCRWIDTH,(A0)
            BGE     .KILL
            CMP.W   #-XPLSIZE,2(A0)
            BLE     .KILL
            CMP.W   #SCRHEIGH,2(A0)
            BGE     .KILL
.END        MOVE.W  (A7)+,D0
            RTS
.KILL       JSR   AGLKILL
            BRA   .END

; -----------------------------------------------------------------------------
XPLPLOT
; PLOTS AN EXPLOSION ITEM
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

            MOVE.W  (A0),D1
            MOVE.W  2(A0),D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W   #XPLSIZE,D3
            ADD.W   #XPLSIZE,D4
            MOVE.B  #88,D0
            TRAP    #15
            MOVEM.W (A7)+,D1-D4
            RTS
     


*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
