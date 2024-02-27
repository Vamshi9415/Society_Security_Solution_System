<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Normal Visitor Details</title>
    <!-- Add Bootstrap CSS and Animate.css links if not already included -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Register Normal Visitor Details</h2>
        <form action="VisitorServlet" method="POST" class="my-4">
            <div class="form-group">
                <label for="visitorName">Visitor Name:</label>
                <input type="text" class="form-control" name="visitorName" required>
            </div>
            <div class="form-group">
                <label for="visitorContact">Visitor Contact:</label>
                <input type="text" class="form-control" name="visitorContact" required>
            </div>
            <div id="normalVisitorFields">
                <div class="form-group">
                    <label for="flatId">Flat ID:</label>
                    <select class="form-control" name="flatId" required>
                        <option value="" disabled selected>Select Flat ID</option>

                        <%
                            String url = "jdbc:mysql://localhost:3306/dbms";
                            String username = "root";
                            String password = "vamshibachu";

                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection connection = DriverManager.getConnection(url, username, password);

                                String flatQuery = "SELECT f.flatId FROM flat f";

                                PreparedStatement flatPreparedStatement = connection.prepareStatement(flatQuery);

                                ResultSet flatResultSet = flatPreparedStatement.executeQuery();

                                while (flatResultSet.next()) {
                                    String flatId = flatResultSet.getString("flatId");
                        %>
                                    <option value="<%= flatId %>"><%= flatId %></option>
                        <%
                                }
                                flatResultSet.close();
                                flatPreparedStatement.close();
                            } catch (SQLException | ClassNotFoundException e) {
                                e.printStackTrace();
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="status">Status:</label>
                    <input type="text" class="form-control" name="status" value="pending">
                </div>
                <div class="form-group">
                    <label for="checkInTime">Check-In Time:</label>
                    <input type="datetime-local" class="form-control" name="checkInTime" required>
                </div>
            </div>
            <button type="submit" class="btn btn-primary animate__animated animate__fadeIn">Submit</button>
        </form>
    </div>

    <!-- Add Bootstrap JS and Popper.js links if needed -->
    <!-- Add your JavaScript for form validation if necessary -->
</body>
</html>
