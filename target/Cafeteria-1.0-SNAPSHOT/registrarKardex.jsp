<%-- 
    Document   : registrarKardex
    Created on : 18 oct 2024, 9:50:23?p.m.
    Author     : HP
--%>

<%@page import="com.cafeteria.ProductoDAO"%>
<%@page import="com.cafeteria.KardexDAO"%>
<%@page import="com.cafeteria.Kardex"%>
<%@page import="com.cafeteria.Producto"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Kardex</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Registrar Movimiento de Kardex</h2>
        
        <%
            List<Producto> productos = null;

            try {
                ProductoDAO productoDAO = new ProductoDAO();
                productos = productoDAO.listarProductos();
                
                if (productos.isEmpty()) {
                    out.println("<div class='alert alert-warning'>No se encontraron productos en la base de datos.</div>");
                }
            } catch (Exception e) {
                e.printStackTrace(); // Imprime la traza del error en la consola
                out.println("<div class='alert alert-danger'>Error al listar productos: " + e.getMessage() + "</div>");
            }
        %>

        <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            try {
                int idProducto = Integer.parseInt(request.getParameter("idProducto"));
                String tipoMovimiento = request.getParameter("tipoMovimiento");
                int cantidadMovimiento = Integer.parseInt(request.getParameter("cantidad"));
                String fechaString = request.getParameter("fecha");

                // Validar el formato de fecha
                java.sql.Date fecha = java.sql.Date.valueOf(fechaString);

                // Obtener el producto actual
                ProductoDAO productoDAO = new ProductoDAO();
                Producto producto = productoDAO.obtenerProductoPorId(idProducto);
                
                if (producto == null) {
                    out.println("<div class='alert alert-danger'>Producto no encontrado.</div>");
                    return;
                }

                int nuevaCantidad = producto.getCantidad();

                // Validar salida de cantidad
                if (tipoMovimiento.equals("salida") && nuevaCantidad < cantidadMovimiento) {
                    out.println("<div class='alert alert-danger'>No hay suficiente cantidad en stock.</div>");
                    return;
                }

                // Actualizar la cantidad según el tipo de movimiento
                if (tipoMovimiento.equals("entrada")) {
                    nuevaCantidad += cantidadMovimiento;
                } else if (tipoMovimiento.equals("salida")) {
                    nuevaCantidad -= cantidadMovimiento;
                }

                // Actualizar el producto en la base de datos
                producto.setCantidad(nuevaCantidad);
                productoDAO.actualizarCantidad(producto);

                // Crear y registrar el movimiento en Kardex
                Kardex kardex = new Kardex();
                kardex.setProducto(producto);
                kardex.setFecha(fecha);
                kardex.setTipoMovimiento(tipoMovimiento);
                kardex.setCantidad(cantidadMovimiento);

                KardexDAO kardexDAO = new KardexDAO();
                kardexDAO.registrarMovimiento(kardex);

                out.println("<div class='alert alert-success'>Movimiento registrado con éxito.</div>");
            } catch (SQLException e) {
                e.printStackTrace(); // Traza del error
                out.println("<div class='alert alert-danger'>Error en la base de datos: " + e.getMessage() + "</div>");
            } catch (IllegalArgumentException e) {
                e.printStackTrace(); // Traza del error
                out.println("<div class='alert alert-danger'>Error en el formato de datos: " + e.getMessage() + "</div>");
            } catch (Exception e) {
                e.printStackTrace(); // Traza del error
                out.println("<div class='alert alert-danger'>Error al registrar el movimiento: " + e.getMessage() + "</div>");
            }
        }
        %>

        <form method="post" class="mt-4">
            <div class="form-group">
                <label for="idProducto">Producto:</label>
                <select name="idProducto" class="form-control" required>
                    <% if (productos != null) { %>
                        <% for (Producto producto : productos) { %>
                            <option value="<%= producto.getIdProducto() %>"><%= producto.getNombre() %></option>
                        <% } %>
                    <% } %>
                </select>
            </div>

            <div class="form-group">
                <label for="tipoMovimiento">Tipo de Movimiento:</label>
                <select name="tipoMovimiento" class="form-control" required>
                    <option value="entrada">Entrada</option>
                    <option value="salida">Salida</option>
                </select>
            </div>

            <div class="form-group">
                <label for="cantidad">Cantidad:</label>
                <input type="number" name="cantidad" class="form-control" required />
            </div>

            <div class="form-group">
                <label for="fecha">Fecha:</label>
                <input type="date" name="fecha" class="form-control" required />
            </div>

            <button type="submit" class="btn btn-primary">Registrar</button>
        </form>

        <!-- Botón para volver a la página principal -->
        <a href="index.jsp" class="btn btn-secondary mt-3">Volver a Inicio</a>

    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
