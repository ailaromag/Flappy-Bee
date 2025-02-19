# Flappy-Bee
Implementación del juego Flappy Bird con algunos añadidos en el Easy68k como práctica para la asignatura de Estructura de Computadores 2.

Esta práctica trata de una implementación del juego popular del Flappy Bird con algunos añadidos. En nuestro caso particular se trata de una abeja, por eso "Flappy Bee", que debe conseguir no chocarse con los árboles y evitar a los enemigos, a medida que va intentando conseguir bollas de miel que aparecen flotando para conseguir puntos. El juego se acaba cuando la abeja muere o cuando consigue llegar al nivel máximo, en nuestro caso el nivel 10. Controles de juego: La abeja se moverá haciendo uso de la tecla espacio al ser presionada para subir, y liberando ésta para bajar. Por otro lado, para conseguir las bollas de miel se tendrá que clicar encima haciendo uso del ratón. 
Tabla de puntos/vidas:

                  POINTS   LIFES 

LIFES START         /        3
SPIDER DAMAGE     -200      -1
COLUMN DAMAGE     DEATH    DEATH
COLUMN SCORE       +25       /
HONEY BONUS        +100      /

Al inicio de la partida se empieza con 0 puntos y 3 vidas, por lo tanto, partiendo de los datos del esquema anterior, podemos ver que si no se han acumulado al menos 200 puntos, la colisión con una araña será mortal. 
Las características escogidas son la visualización de imágenes y la implementación del ratón.

Visualización de imágenes; Se implementa en BITMAP. X68, y lo utilizamos en varios lugares, como en la pantalla de inicio, en el juego 
para implementar una nube, y en las pantallas de "WIN" y "GAME OVER". 
Primeramente, desarrollamos en Netbeans un programa que transforma imágenes al formato requerido por el Easy68K en filas de 8 Long, de la 
siguiente manera: DC.L $000000,$000000,$000000,$000000,$000000,$000000,$000000,$0000000,

Estos Longs conforman cada color de cada bit. Luego en el Easy68k en la rutina MAPPLOT iteramos por el array de Longs mientras que 
llamamos a las subrutinas del TRAP #15 correspondientes a poner un color y dibujar un cuadrado. Las imágenes se han procesado como 
Bitmaps ya que las hemos creado en el paint y nos resultaba más fácil comprender así como se transformaba la imagen en la lista de Longs, 
pero el programa hecho en Netbeans llamado BitmapConverter2.java fácilmente podría ser modificado por funciona con otros formatos de 
imágenes.

Implementación del ratón; La realizamos en en su caso. X68 en las rutinas de MSEINIT y MSEUPD. En MSEINIT inicializamos el IRQ del ratón, 
habilitando el nivel 1 para el movimiento y el click del botón del ratón. Guardamos las coordenadas en la variable MSECOORD y el estado 
del ratón (pisado o liberado) en MSEVAL. Después en MSEUPD vamos comprobando si el ratón se ha movido y actualizamos las coordenadas.
