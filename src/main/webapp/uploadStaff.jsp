<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Staff Details</title>
    <!-- Add Bootstrap CSS and Animate.css links -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Upload Staff Details</h2>
        <form action="StaffServlet" method="post" class="my-4">
            <div class="form-group">
                <label for="staffName">Staff Name</label>
                <input type="text" class="form-control" name="staffName" required>
            </div>
            <div class="form-group">
                <label for="staffPhoneNumber">Staff PhoneNumber</label>
                <input type="text" class="form-control" name="staffPhoneNumber" required>
            </div>
            <div class="form-group">
                <label for="staffType">Staff Type:</label>
                <select class="form-control" name="staffType" required>
                    <option value="Security Person">Security Person</option>
                    <option value="Cleaning Staff">Cleaning Staff</option>
                    <option value="Gardener">Gardener</option>
                    <option value="Other">Other</option>
                </select>
            </div>
            <div class="form-group">
                <label for="buildingId">Building ID</label>
                <select class="form-control" name="buildingId" required>
                    <option value="" disabled selected>Select Building ID</option>
                    <!-- Your dynamic options here (Java code) -->
                    <%
                        String url = "jdbc:mysql://localhost:3306/dbms";
                        String username = "root";
                        String password = "vamshibachu";

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection connection = DriverManager.getConnection(url, username, password);

                            String buildingQuery = "select buildingId from building";
                            PreparedStatement buildingPreparedStatement = connection.prepareStatement(buildingQuery);

                            ResultSet buildingResultSet = buildingPreparedStatement.executeQuery();

                            while (buildingResultSet.next()) {
                                int buildingId = buildingResultSet.getInt("buildingId");
                    %>
                                <option value="<%= buildingId %>"><%= buildingId %></option>
                    <%
                            }
                            buildingResultSet.close();
                            buildingPreparedStatement.close();
                        } catch (SQLException | ClassNotFoundException e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </div>
            <button type="submit" class="btn btn-primary animate__animated animate__fadeIn">Upload Staff Details</button>
        </form>
    </div>

    <!-- Add Bootstrap JS and Popper.js links if needed -->
    <!-- Add your JavaScript for form validation if necessary -->

</body>
</html>
