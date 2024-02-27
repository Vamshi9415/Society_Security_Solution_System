<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Regular Visitor Details</title>
    <!-- Add Bootstrap CSS if not already included -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Register Regular Visitor Details</h2>
        <form action="RegularVisitorServlet" method="post" class="my-4">
            <div class="form-group">
                <label for="visitorName">Visitor Name:</label>
                <input type="text" class="form-control" name="visitorName" required>
            </div>
            <div class="form-group">
                <label for="visitorContact">Visitor Contact:</label>
                <input type="number" class="form-control" name="visitorContact" required>
            </div>
            <div id="regularVisitorFields" class="my-3">
                <div class="form-group">
                    <label for="securityCode">Security Code:</label>
                    <input type="text" class="form-control" name="securityCode">
                </div>
                <div class="form-group">
                    <label for="role">Role:</label>
                    <select class="form-control" name="role">
                        <option value="DailyVisitor">Daily Visitor</option>
                        <option value="Vendor">Vendor</option>
                    </select>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>

    <!-- Add Bootstrap JS and Popper.js links if needed -->
    <!-- Add your JavaScript for form validation if necessary -->
</body>
</html>
