*-----------------------------------------------------------
* GAME CONSTANTS
*-----------------------------------------------------------
    		
; --- BEE RELATED CONSTANTS -------------------------------

BEEWIDTH        EQU     32          ; WIDTH OF 16 PIXELS        
BEEHEIGH        EQU     20          ; HEIGH OF 8 PIXELS
BEEPCOL         EQU     $0000FFFF   ; PEN COLOR (YELLOW)
BEEFCOL         EQU     $0000FFFF   ; FILL COLOR (YELLOW) 
BEESPEED        EQU     7           ; MAGNITUDE OF THE Y DISPLACEMENT
GRAVITY         EQU     9           ; MAGNITUDE OF THE Y GRAVITY (ALWAYS POSITIVE)
BEEPOSX         EQU     48          ; X POSITION 
BEEMAXJMP       EQU     80          ; MAXIMUM HEIGH OF BEE JUMP
BEEDECC         EQU     1           ; BEE DECELERATION
WINGWIDTH       EQU     12          ; BEE WING WIDTH
WINGHEIGH1      EQU     24          ; BEE WING EXTENDED HEIGHT
WINGHEIGH2      EQU     6           ; BEE WING CLOSED HEIGHT
WINGCOL         EQU     $00808080   ; BEE COLOR GREY
ACC             EQU     $00000001   ; BEE FALLING ACCELERATION
LIFES           EQU     3           ; BEE LIFES


; --- COLUMN RELATED CONSTANTS --------------------------------

COLWIDTH        EQU     48          ; WIDTH OF COLUMN 12 PIXELS
COLGAP          EQU     200         ; HEIGH OF THE GAP BETWEEN THE COLUMNS    
COLPOSY         EQU     0           ; Y POSITION
COLSPEED        EQU     2           ; MAGNITUDE OF THE X DISPLACEMENT
COLPCOL         EQU     $00004b96   ; COL CONTOUR COLOR
COLFCOL         EQU     $00004b96   ; COL FILL COLOR
COLDETCOL       EQU     $00174164   ; COL DETAIL LINES COLOR
COLSCORE        EQU     25          ; COL SUCCESS SCORE


; --- HONEY BALL RELATED CONSTANTS ---------------------------------

HONSIZE         EQU     60           ; HONEY BALL DIAMETER    
HONPCOL         EQU     $000F72DC    ; DARK YELLOW COLOR
HONFCOL         EQU     $001B9CE0    ; YELLOW COLOR
HONSCORE        EQU     100          ; HONEY BALL POINTS
HONNFRAG        EQU     5            ; NUMBER OF FRAGMENTS IN EXPLOSION
HONSPEED        EQU     2            ; MAGNITUDE OF THE X DISPLACEMENT
HONMINSIZE      EQU     40           ; HONEY BALL MINIMUM DIAMETER
HONMAXSIZE      EQU     100          ; HONEY BALL MAXIMUM DIAMETER
HONBONUS        EQU     100          ; HONEY BONUS POINTS
HONNFRAG        EQU     5            ; NUMBER OF FRAGMENTS IN EXPLOSION

; --- EXPLOSION RELATED CONSTANTS ---------------------------------------------

XPLSIZE         EQU     20           ; EXPLOSION ITEM DIAMETER (PIXELS)

; --- SPIDER RELATED CONSTANTS ----------------------------------------
SPDPCOL         EQU     $00000000    ; SPIDER PEN COLOR
SPDFCOL         EQU     $00000000    ; SPIDER FILL COLOR
SPDSIZEW        EQU     35           ; SPIDER X DIAMETER
SPDSIZEH        EQU     30           ; SPIDER Y DIAMETER
SPDSPEED        EQU     2            ; MAGNITUDE OF THE X DISPLACEMENT
SPDSPEEDY       EQU     3            ; MAGNITUDE OF THE Y DISPLACEMENT
SPDDAMAGE       EQU     200          ; DAMAGE POINTS
SPDMAXH         EQU     250          ; MAXIMUM HEIGH FOR SPIDER TO GO DOWN

; --- SCOREBOARD RELATED CONSTANTS ----------------------------

SCOFCOL         EQU     $00174164   ; TEXT BACKGROUND COLOR
SCOCHRCOL       EQU     $0000001B   ; TEXT CHARACTER COLOR
SCOLINE1        EQU     $0201       ; FIRST TEXT LINE COORDINATES
SCOLINE2        EQU     $0202       ; SECOND TEXT LINE COORDINATES
SCOLINE3        EQU     $0203       ; THIRD TEXT LINE COORDINATES
SCOLINE4        EQU     $0204       ; 4TH TEXT LINE COORDINATES
SCODIMX         EQU     200         ; X DIMENSION
SCODIMY         EQU     80          ; Y DIMENSION

; --- STATE RELATED CONSTANTS ---------------------------------

STANONE         EQU     -1          ; NON-EXISTENT STATE NUMBER
ISCMAXTM        EQU     20          ; INTRO SCREEN WAITNING CYCLES
INSMAXTM        EQU     20          ; INSTRUCTIONS SCREEN WAITING CYCLES

; --- AGENT TYPES -------------------------------------------------------------
COLTYPE         EQU     1
HONTYPE         EQU     2
XPLTYPE         EQU     3
SPDTYPE         EQU     4

; --- VICTORY/DEFEAT CONSTANTS --------------------------------
LEVLMAX         EQU     10           ; NUM MAXIM OF COLUMNS PASSED
COLLMAX         EQU     1            ; NUMBER MAXIMUM COLLISIONS

; --- SKY -----------------------------------------------------
SKYCOL0         EQU      $00555531   ;GROUND
SKYCOL1         EQU      $0059A3F5   ;GRAD1
SKYCOL2         EQU      $00889DE8   ;GRAD2    
SKYCOL3         EQU      $00D192D0   ;GRAD3
SKYCOL4         EQU      $00F68EC5   ;GRAD4


; --- INTRO RELATED CONSTANTS --------------------------------
INTROCOL        EQU      $00D192D0

; --- WIN SCREEN CONSTANTS -----------------------------------
WINCOL          EQU      $005F454B

; --- BITMAP --------------------------------------------------
BMPWIDTH        EQU     64          ; BITMAP WIDTH
BMPHEIGH        EQU     64          ; BITMAP HEIGHT
PIXSIZECONST    EQU     4           ; PIXEL SIZE, 1 SHOWED PIXEL CONSISTS OF 4 REAL PIXEL
NOCOLOR         EQU     $00FFFF80   ; COLOR DEFINED AS NO COLOR

































*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
