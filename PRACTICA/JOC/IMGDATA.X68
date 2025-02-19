*-----------------------------------------------------------
* POLIGONS QUE DEFINEIXEN EL TÍTOL DEL JOC, D
* ESCRITS EN UN FORMAT ACCEPTAT PER POLYIMG.X68
* LLISTA DE PUNTERS A LES COORDINADES DE CADA IMATGE
* LES LLETRES S'HAN CREAT A PAINT I S'HAN EXTRET LES COORDENADES
*-----------------------------------------------------------
    		
; --- LIST OF POINTERS TO LETTERS -------------------------

IMGLIST     DC.L    .LOGO_FLAPPY              ; 0  
            DC.L    .LOGO_BEE                 ; 1

; --- PICTURE DATA -----------------------------------------        
            
.LOGO_FLAPPY
            ;LETTER F
            DC.W    1             ; PEN COLOR
            DC.B    0,240,0,172
            DC.W    2             ; FILL COLOR
            DC.B    0,240,0,172
            DC.W    8,0,0,25,90
            DC.W    8,25,0,50,20
            DC.W    8,25,30,42,50
            
            ;LETTER L
            DC.W    8,60,0,85,90
            DC.W    8,85,65,110,90
            
            ;LETTER A
            DC.W    8,120,20,145,90
            DC.W    8,155,20,180,90
            DC.W    8,132,0,168,20
            DC.W    8,145,45,155,65
            DC.W    7,120,20
            DC.W    6,132,0
            DC.W    10,128,17
            DC.W    7,180,20
            DC.W    6,168,0
            DC.W    10,170,10
            
            ;LETTER P
            DC.W    9,190,0,240,55
            DC.W    8,190,0,215,90
            
            ;LETTER P
            DC.W    9,250,0,300,55
            DC.W    8,250,0,275,90
            
            ;LETTER Y
            DC.W    7,310,0
            DC.W    6,325,40
            DC.W    6,340,40
            DC.W    6,325,0
            DC.W    6,310,0
            DC.W    10,315,5          
            DC.W    7,335,40
            DC.W    6,345,40
            DC.W    6,360,0
            DC.W    6,345,0
            DC.W    6,330,40
            DC.W    10,340,35
            DC.W    8,325,40,345,90  
            DC.W    0
            
.LOGO_BEE               
             ;LETTER B
            DC.W    9,0,0,35,35
            DC.W    9,0,35,50,90
            DC.W    8,0,0,25,90
              
            ;LETTER E
            DC.W    8,60,0,85,90
            DC.W    8,85,0,110,20
            DC.W    8,85,30,102,50
            DC.W    8,85,70,110,90

            ;LETTER E
            DC.W    8,120,0,145,90
            DC.W    8,145,0,170,20
            DC.W    8,145,30,162,50
            DC.W    8,145,70,170,90
            DC.W    0




     







*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
