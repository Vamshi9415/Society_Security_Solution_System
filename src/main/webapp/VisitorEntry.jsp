<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Regular Visitor Entry</title>
    <!-- Add Bootstrap CSS if not already included -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Regular Visitor Entry</h2>
        <form action="VisitorEnterServlet" method="post" class="my-4">
            <div class="form-group">
                <label for="SecurityCode">Security Code:</label>
                <input type="text" class="form-control" id="SecurityCode" name="SecurityCode" required>
            </div>
            <div class="form-group">
                <label for="checkInTime">Check-In Time:</label>
                <input type="datetime-local" class="form-control" name="checkInTime" required>
            </div>
            <button type="submit" class="btn btn-primary">Enter</button>
        </form>
    </div>

    <!-- Add Bootstrap JS and Popper.js links if needed -->
    <!-- Add your JavaScript for form validation if necessary -->
</body>
</html>
