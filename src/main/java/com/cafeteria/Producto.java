/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cafeteria;

/**
 *
 * @author HP
 */

import java.sql.Date;

public class Producto {
    private int idProducto;
    private String nombre;
    private String tipo;
    private Date fecha; // Atributo para almacenar la fecha
    private int cantidad; // Atributo para almacenar la cantidad

    // Getters y setters
    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public Date getFecha() { // Método para obtener la fecha
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    
    public int getCantidad() { // Método para obtener la cantidad
        return cantidad;
    }

    public void setCantidad(int cantidad) { // Método para establecer la cantidad
        this.cantidad = cantidad;
    }
}
