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

public class ProductoDAO {
    // Método para listar productos
    public List<Producto> listarProductos() {
        List<Producto> productos = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConexion.getConexion(); // Obtener la conexión
            String sql = "SELECT * FROM productos"; // Cambia 'productos' al nombre de tu tabla
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Producto producto = new Producto();
                producto.setIdProducto(rs.getInt("id_producto")); // Asegúrate de que el nombre de la columna sea correcto
                producto.setNombre(rs.getString("nombre_producto")); // Asegúrate de que el nombre de la columna sea correcto
                producto.setCantidad(rs.getInt("cantidad")); // Asegúrate de que el nombre de la columna sea correcto
                productos.add(producto);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Muestra el error en la consola para diagnóstico
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace(); // Manejo de excepciones
            }
        }
        return productos;
    }

    // Método para obtener un producto por su ID
    public Producto obtenerProductoPorId(int idProducto) throws SQLException {
        Producto producto = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConexion.getConexion(); // Obtener la conexión
            String sql = "SELECT * FROM productos WHERE id_producto = ?"; // Asegúrate de que el nombre de la columna sea correcto
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idProducto);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                producto = new Producto();
                producto.setIdProducto(rs.getInt("id_producto")); // Asegúrate de que el nombre de la columna sea correcto
                producto.setNombre(rs.getString("nombre_producto")); // Asegúrate de que el nombre de la columna sea correcto
                producto.setCantidad(rs.getInt("cantidad")); // Asegúrate de que el nombre de la columna sea correcto
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Muestra el error en la consola para diagnóstico
            throw e; // Lanza la excepción para que se maneje en otro lugar
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace(); // Manejo de excepciones
            }
        }
        return producto;
    }

    // Método para actualizar la cantidad del producto
    public void actualizarCantidad(Producto producto) throws SQLException {
        String sql = "UPDATE productos SET cantidad = ? WHERE id_producto = ?"; // Asegúrate de que el nombre de la columna sea correcto
        try (Connection connection = DBConexion.getConexion();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, producto.getCantidad());
            statement.setInt(2, producto.getIdProducto());
            statement.executeUpdate();
        }
    }
}



