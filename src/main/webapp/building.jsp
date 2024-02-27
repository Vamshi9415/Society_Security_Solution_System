<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Building Details</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <div class="col">
                <h2 class="mb-3">Building Details</h2>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Building ID</th>
                            <th>Building Name</th>
                            <th>Location</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String url = "jdbc:mysql://localhost:3306/dbms";
                            String username = "root";
                            String password = "vamshibachu";
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection connection = DriverManager.getConnection(url, username, password);

                                String buildingQuery = "select * from building";
                                PreparedStatement buildingPreparedStatement = connection.prepareStatement(buildingQuery);

                                ResultSet buildingResultSet = buildingPreparedStatement.executeQuery();

                                while (buildingResultSet.next()) {
                                    int buildingId = buildingResultSet.getInt("buildingId");
                                    String buildingName = buildingResultSet.getString("buildingName");
                                    String Location = buildingResultSet.getString("Location");
                        %>
                        <tr>
                            <td><%= buildingId %></td>
                            <td><%= buildingName %></td>
                            <td><%= Location %></td>
                        </tr>
                        <%
                            }
                            buildingResultSet.close();
                            buildingPreparedStatement.close();
                        } catch (SQLException | ClassNotFoundException e) {
                            e.printStackTrace();
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
