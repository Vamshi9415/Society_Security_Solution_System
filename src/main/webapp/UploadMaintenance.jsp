<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Upload Maintenance Details</title>
    <!-- Add Bootstrap CSS if not already included -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Upload Maintenance Details</h2>
        <form action="MaintenanceServlet" method="post" class="my-4" onsubmit="return validateMaintenanceForm()">
            <div class="form-group">
                <label for="maintenanceAmount">Maintenance Amount:</label>
                <input type="text" class="form-control" id="maintenanceAmount" name="maintenanceAmount" required>
            </div>
            <div class="form-group">
                <label for="flatID">Flat ID</label>
                <select class="form-control" name="flatID" required>
                    <option value="" disabled selected>Select Flat ID</option>
                    <%
                    String url = "jdbc:mysql://localhost:3306/dbms";
                                                String username = "root";
                                                String password = "vamshibachu";
                    try {
                                                            Class.forName("com.mysql.cj.jdbc.Driver");
                                                            Connection connection = DriverManager.getConnection(url, username, password);

                                                            String flatQuery = "SELECT f.flatId FROM flat f ";

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
                <label for="paymentDueDate">Payment Due Date</label>
                <input type="date" class="form-control" name="paymentDueDate" required>
            </div>
            <button type="submit" class="btn btn-primary">Upload</button>
        </form>
    </div>

    <!-- Add Bootstrap JS and Popper.js links if needed -->
    <script>
        function validateMaintenanceForm() {
            var maintenanceAmount = document.getElementById("maintenanceAmount").value;
            var flatID = document.querySelector("select[name='flatID']").value;
            var paymentDueDate = document.querySelector("input[name='paymentDueDate']").value;

            if (maintenanceAmount.trim() === "") {
                alert("Please enter Maintenance Amount.");
                return false;
            }

            if (flatID.trim() === "") {
                alert("Please select a Flat ID.");
                return false;
            }

            if (paymentDueDate.trim() === "") {
                alert("Please enter Payment Due Date.");
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
