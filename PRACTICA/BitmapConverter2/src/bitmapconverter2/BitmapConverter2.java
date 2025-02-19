/*
 */
package bitmapconverter2;

import java.io.FileInputStream;
import java.io.IOException;

public class BitmapConverter2 {

    public static void main(String[] args) {
        BitmapConverter2 bp = new BitmapConverter2();
        bp.main();
    }

    public void main() {

        // Ruta del archivo BMP
       // String rutaArchivo = "HEART.bmp";
       String rutaArchivo = "WIN_BEE_64PIX.bmp";

        try (FileInputStream fis = new FileInputStream(rutaArchivo)) {
            // Saltar los primeros 54 bytes de la cabecera BMP
            fis.skip(54);

            int byteLeido;
            int agrupador = 0;          // Contador para agrupar 3 bytes en una palabra de 6 dígitos
            int palabrasPorLinea = 0;   // Contador para palabras por línea (8 por línea)
            long valor24Bits = 0;       // Acumulador para cada palabra de 3 bytes

            System.out.print("    DC.L    "); // Empezar la primera línea

            // Leer byte a byte hasta el final del archivo
            while ((byteLeido = fis.read()) != -1) {
                // Acumular los bytes en un valor de 24 bits (3 bytes por palabra)
                valor24Bits = (valor24Bits << 8) | (byteLeido & 0xFF);
                agrupador++;

                if (agrupador == 3) { 
                    System.out.printf("$%06X", valor24Bits); 
                    palabrasPorLinea++;
                    agrupador = 0; 
                    valor24Bits = 0; 

                    if (palabrasPorLinea == 8) { // 8 palabras por línea
                        System.out.println(); 
                        System.out.print("    DC.L    "); 
                        palabrasPorLinea = 0; 
                    } else {
                        System.out.print(","); 
                    }
                }
            }

            // Si quedan bytes sin completar un grupo de 3, rellenar con ceros
            if (agrupador > 0) {
                valor24Bits = valor24Bits << (8 * (3 - agrupador)); 
                System.out.printf("$%06X", valor24Bits);
                palabrasPorLinea++;
            }

            // Completar línea
            if (palabrasPorLinea > 0) {
                System.out.println();
            }

        } catch (IOException e) {
            System.out.println("Error al leer el archivo: " + e.getMessage());
        }
    }
}
