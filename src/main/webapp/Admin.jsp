<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel - Upload Building Details</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

</div>
    <h1 class="text-center mt-5">Welcome, Administrator!</h1>

    <div class="logout">
    <form action="LogOutServlet" method="post">
     <input type="submit" value="LogOut">
    </form>
    </div>
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h2>Upload Building Details</h2>
                    </div>
                    <div class="card-body">
                        <form action="BuildingServlet" method="post">
                            <div class="form-group">
                                <label for="buildingName">Building Name</label>
                                <input type="text" class="form-control" name="buildingName" required>
                            </div>
                            <div class="form-group">
                                <label for="Location">Location</label>
                                <input type="text" class="form-control" name="Location" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Upload Building Details</button>
                        </form>
                    </div>
                </div>
                <a href="building.jsp" class="btn btn-info mt-2">Show Building Details</a>
            </div>

            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h2>Upload Flat Details</h2>
                    </div>
                    <div class="card-body">
                        <form action="FlatServlet" method="post">
                            <div class="form-group">
                                <label for="buildingId">Building Id</label>
                                <select class="form-control" name="buildingId" required>
                                    <option value="" disabled selected>Select Building Id</option>
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
                            <div class="form-group">
                                <label for="flatNumber">Flat Number</label>
                                <input type="number" class="form-control" name="flatNumber">
                            </div>
                            <button type="submit" class="btn btn-primary">Upload Flat Details</button>
                        </form>
                    </div>
                </div>
                <a href="flat.jsp" class="btn btn-info mt-2">Show Flat Details</a>
            </div>

            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h2>Upload Resident Details</h2>
                    </div>
                    <div class="card-body">
                        <form action="ResidentServlet" method="post">
                            <div class="form-group">
                                <label for="residentFirstName">First Name</label>
                                <input type="text" class="form-control" name="residentFirstName" required>
                            </div>
                            <div class="form-group">
                                <label for="residentLastName">Last Name</label>
                                <input type="text" class="form-control" name="residentLastName" required>
                            </div>
                            <div class="form-group">
                                <label for="residentPhoneNumber">Phone Number</label>
                                <input type="text" class="form-control" name="residentPhoneNumber" required>
                            </div>
                            <div class="form-group">
                                <label for="flatId">Flat Id</label>
                                <select class="form-control" name="flatId" required>
                                    <option value="" disabled selected>Select Flat ID</option>
                                    <!-- Your dynamic flat options here -->
                                     <%


                                                        try {
                                                            Class.forName("com.mysql.cj.jdbc.Driver");
                                                            Connection connection = DriverManager.getConnection(url, username, password);

                                                            String flatQuery = "SELECT f.flatId FROM flat f LEFT JOIN resident r ON f.flatId = r.flatId WHERE r.flatId IS NULL";

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
                            <button type="submit" class="btn btn-primary">Upload Resident Details</button>
                        </form>
                    </div>
                </div>
                <a href="resident.jsp" class="btn btn-info mt-2">Show Resident Details</a>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
