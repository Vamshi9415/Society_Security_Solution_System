<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Resident Details</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .table tbody tr:hover {
            background-color: #f8f9fa;
            transition: background-color 0.3s;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <div class="col">
                <h2 class="mb-3">Resident Details</h2>
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover">
                        <thead class="bg-info text-white">
                            <tr>
                                <th>Flat ID</th>
                                <th>Phone Number</th>
                                <th>Name</th>
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

                                    String buildingQuery = "select resident.flatId,resident.residentPhoneNumber,concat(resident.residentFirstName,' ',resident.residentLastName) as Name from flat inner join resident on flat.flatId = resident.flatId order by buildingId";
                                    PreparedStatement buildingPreparedStatement = connection.prepareStatement(buildingQuery);

                                    ResultSet buildingResultSet = buildingPreparedStatement.executeQuery();

                                    while (buildingResultSet.next()) {
                                        String flatId = buildingResultSet.getString("flatId");
                                        String residentPhoneNumber = buildingResultSet.getString("residentPhoneNumber");
                                        String Name = buildingResultSet.getString("Name");
                            %>
                            <tr>
                                <td><%= flatId %></td>
                                <td><%= residentPhoneNumber %></td>
                                <td><%= Name %></td>
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
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
