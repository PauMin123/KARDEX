<%-- 
    Document   : ConsultarKardex
    Created on : 18 oct 2024, 9:52:12?p.m.
    Author     : HP
--%>

<%@page import="com.cafeteria.ProductoDAO"%>
<%@page import="com.cafeteria.KardexDAO"%>
<%@page import="com.cafeteria.Producto"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultar Existencias Diarias</title>
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
        <h2>Consultar Existencias Diarias</h2>

        <%
            List<Producto> productos = null;
            try {
                ProductoDAO productoDAO = new ProductoDAO();
                productos = productoDAO.listarProductos();

                if (productos.isEmpty()) {
                    out.println("<div class='alert alert-warning'>No se encontraron productos en la base de datos.</div>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger'>Error al listar productos: " + e.getMessage() + "</div>");
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
                <label for="fecha">Fecha:</label>
                <input type="date" name="fecha" class="form-control" required />
            </div>

            <div class="form-group">
                <label for="fechaInicio">Fecha de Inicio:</label>
                <input type="date" name="fechaInicio" class="form-control" required />
            </div>

            <div class="form-group">
                <label for="fechaFin">Fecha de Fin:</label>
                <input type="date" name="fechaFin" class="form-control" required />
            </div>

            <button type="submit" class="btn btn-primary">Consultar</button>
        </form>

        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                try {
                    int idProducto = Integer.parseInt(request.getParameter("idProducto"));
                    Date fechaConsulta = Date.valueOf(request.getParameter("fecha"));
                    Date fechaInicio = Date.valueOf(request.getParameter("fechaInicio"));
                    Date fechaFin = Date.valueOf(request.getParameter("fechaFin"));

                    KardexDAO kardexDAO = new KardexDAO();

                    // Obtener la cantidad disponible en la fecha específica
                    int cantidadDisponible = kardexDAO.obtenerCantidadDisponible(idProducto, fechaConsulta);
                    out.println("<div class='alert alert-info'>Cantidad disponible en " + fechaConsulta + ": " + cantidadDisponible + "</div>");

                    // Obtener las cantidades en el rango de fechas
                    List<Integer> cantidades = kardexDAO.obtenerCantidadPorRangoFechas(idProducto, fechaInicio, fechaFin);
                    if (!cantidades.isEmpty()) {
                        out.println("<div class='alert alert-info'>Cantidades Ingresadas: " + cantidades.get(0) + ", Cantidades Vendidas: " + cantidades.get(1) + "</div>");
                    } else {
                        out.println("<div class='alert alert-warning'>No se encontraron movimientos en el rango de fechas especificado.</div>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger'>Error al consultar existencias: " + e.getMessage() + "</div>");
                }
            }
        %>
                <!-- Botón para volver a index.jsp -->
        <a href="index.jsp" class="btn btn-secondary mt-3">Volver a Inicio</a>
    </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>


