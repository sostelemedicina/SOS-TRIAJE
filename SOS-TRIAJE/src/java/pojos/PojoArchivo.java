/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pojos;

/**
 *
 * @author prod1
 */
public class PojoArchivo {
    
    public String Nombre;
    public String Descripcion;
    public byte[] Adjunto;
    
    public PojoArchivo(String Nombre, String Descripcion, byte[] Adjunto){    
        this.Nombre = Nombre;
        this.Descripcion = Descripcion;
        this.Adjunto = Adjunto;
    }    
    
}