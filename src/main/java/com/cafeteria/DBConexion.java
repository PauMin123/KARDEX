/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cafeteria;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConexion {
    private static final String URL = "jdbc:mysql://localhost:5432/cafeteria";  // Cambia el puerto a 3306 si usas MySQL, yo use docker
    private static final String USER = "root";  // Cambia 'root' a tu usuario de MySQL
    private static final String PASSWORD = "12345";  // Pon tu contraseña de MySQL


    public static Connection getConexion() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Asegúrate de tener el driver JDBC de MySQL
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new UnsupportedOperationException("Error de driver: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            throw new UnsupportedOperationException("Error de conexión: " + e.getMessage());
        }
        return connection;
    }
}

