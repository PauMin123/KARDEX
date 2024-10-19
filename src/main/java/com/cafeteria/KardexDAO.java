/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cafeteria;

/**
 *
 * @author HP
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class KardexDAO {

    // Método para registrar un movimiento en Kardex
    public void registrarMovimiento(Kardex kardex) throws SQLException {
        Connection con = DBConexion.getConexion();
        String query = "INSERT INTO kardex (id_producto, fecha, tipo_movimiento, cantidad) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, kardex.getProducto().getIdProducto());
        ps.setDate(2, new java.sql.Date(kardex.getFecha().getTime()));
        ps.setString(3, kardex.getTipoMovimiento());
        ps.setInt(4, kardex.getCantidad());

        ps.executeUpdate();
        ps.close();
        con.close();
    }

   // Método para obtener la cantidad disponible de un producto en una fecha específica
public int obtenerCantidadDisponible(int idProducto, Date fecha) throws SQLException {
    int cantidadDisponible = 0;
    String sql = "SELECT cantidad FROM productos WHERE id_producto = ? AND fecha <= ?";

    try (Connection conn = DBConexion.getConexion();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setInt(1, idProducto);
        pstmt.setDate(2, fecha);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            cantidadDisponible = rs.getInt("cantidad");
        }
        rs.close();
    }
    return cantidadDisponible;
}


    // Método para obtener la cantidad recibida y vendida en un rango de fechas
    public List<Integer> obtenerCantidadPorRangoFechas(int idProducto, Date fechaInicio, Date fechaFin) throws SQLException {
        List<Integer> cantidades = new ArrayList<>();
        String sql = "SELECT SUM(CASE WHEN tipo_movimiento = 'entrada' THEN cantidad ELSE 0 END) AS entradas, " +
                     "SUM(CASE WHEN tipo_movimiento = 'salida' THEN cantidad ELSE 0 END) AS salidas " +
                     "FROM kardex WHERE id_producto = ? AND fecha BETWEEN ? AND ?";

        try (Connection conn = DBConexion.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idProducto);
            pstmt.setDate(2, fechaInicio);
            pstmt.setDate(3, fechaFin);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                cantidades.add(rs.getInt("entradas"));
                cantidades.add(rs.getInt("salidas"));
            }
            rs.close();
        }
        return cantidades;
    }

    // Método para consultar movimientos en un rango de fechas
    public List<Kardex> consultarMovimientos(int idProducto, Date fechaInicio, Date fechaFin) throws SQLException {
        Connection con = DBConexion.getConexion();
        String query = "SELECT * FROM kardex WHERE id_producto = ? AND fecha BETWEEN ? AND ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, idProducto);
        ps.setDate(2, fechaInicio);
        ps.setDate(3, fechaFin);
        ResultSet rs = ps.executeQuery();

        List<Kardex> movimientos = new ArrayList<>();
        while (rs.next()) {
            Kardex k = new Kardex();
            k.setIdKardex(rs.getInt("id_kardex"));
            // Rellenar más campos según tu modelo Kardex
            k.setFecha(rs.getDate("fecha"));
            k.setTipoMovimiento(rs.getString("tipo_movimiento"));
            k.setCantidad(rs.getInt("cantidad"));
            // Asumiendo que tienes un método para obtener el producto por ID
            ProductoDAO productoDAO = new ProductoDAO();
            Producto producto = productoDAO.obtenerProductoPorId(rs.getInt("id_producto"));
            k.setProducto(producto);
            movimientos.add(k);
        }
        rs.close();
        ps.close();
        con.close();
        return movimientos;
    }
}


