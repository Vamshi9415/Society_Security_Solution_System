<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Visitor Exit</title>
    <!-- Add Bootstrap CSS if not already included -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Visitor Exit</h2>
        <form action="VisitorExitServlet" method="post" class="my-4">
            <div class="form-group">
                <label for="SecurityCode">Security Code:</label>
                <input type="text" class="form-control" id="SecurityCode" name="SecurityCode" required>
            </div>
            <div class="form-group">
                <label for="checkOutTime">Check-Out Time:</label>
                <input type="datetime-local" class="form-control" name="checkOutTime" required>
            </div>
            <button type="submit" class="btn btn-primary">Enter</button>
        </form>
    </div>


</body>
</html>
