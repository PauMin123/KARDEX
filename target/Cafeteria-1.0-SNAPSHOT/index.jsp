<%-- 
    Document   : index
    Created on : 19 oct 2024, 12:32:38?a.m.
    Author     : HP
--%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventario de la Cafetería El Maná</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="mb-4">Inventario de la Cafetería El Maná</h1>
        <div class="mb-3">
            <a href="registrarKardex.jsp" class="btn btn-primary btn-lg">Registros de Entradas y Salidas</a>
        </div>
        <div>
            <a href="ConsultarKardex.jsp" class="btn btn-secondary btn-lg">Consultar Existencias</a>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
