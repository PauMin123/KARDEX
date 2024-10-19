/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cafeteria;

/**
 *
 * @author HP
 */
import java.util.Date;

public class Kardex {
    private int idKardex;
    private Producto producto;
    private Date fecha;
    private String tipoMovimiento;  // 'entrada' o 'salida'
    private int cantidad;

    // Getters y setters
    public int getIdKardex() {
        return idKardex;
    }
    public void setIdKardex(int idKardex) {
        this.idKardex = idKardex;
    }
    public Producto getProducto() {
        return producto;
    }
    public void setProducto(Producto producto) {
        this.producto = producto;
    }
    public Date getFecha() {
        return fecha;
    }
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    public String getTipoMovimiento() {
        return tipoMovimiento;
    }
    public void setTipoMovimiento(String tipoMovimiento) {
        this.tipoMovimiento = tipoMovimiento;
    }
    public int getCantidad() {
        return cantidad;
    }
    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
}
