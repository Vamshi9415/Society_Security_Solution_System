<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FlatResident Panel - Maintenance Details</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
    body, h1, th, td, label, select, option, .btn {
                color: #000;
            }
        .table {
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .ApprovalButton form,
        .ApprovalButton form div {
            display: inline;
        }
        .ApprovalButton button {
            display: inline;
            vertical-align: middle;
        }
        .table tbody tr:hover {
            background-color: #f8f9fa;
            transition: background-color 0.3s;
        }
        .hidden{
        display:none;
        }
         .logout{
                        top:25px;
                        right:50px;
                        position:absolute;
                        }
    </style>
</head>
<body>
<div class="logout">
    <form action="LogOutServlet" method="post">
     <input type="submit" value="LogOut">
    </form>
    </div>
    <div class="container mt-5">
        <h1>Welcome, <%= session.getAttribute("username") %></h1>
        <table class="table table-striped table-bordered">
            <thead class="bg-info text-white">
                <tr>
                    <th>Maintenance Amount</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String url = "jdbc:mysql://localhost:3306/dbms";
                    String username = "root";
                    String password = "vamshibachu";
                    Connection connection = null;
                    String residentUser_name = (String) session.getAttribute("username");
                    int residentId = 0; // Declare it here
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        connection = DriverManager.getConnection(url, username, password);

                        // Retrieve residentId based on residentUsername
                        String residentQuery = "select residentID from resident where residentUsername= ?";
                        PreparedStatement residentPreparedStatement = connection.prepareStatement(residentQuery);
                        residentPreparedStatement.setString(1, residentUser_name);
                        ResultSet residentResultSet = residentPreparedStatement.executeQuery();
                        if (residentResultSet.next()) {
                            residentId = residentResultSet.getInt("residentId");
                        }

                        // Query maintenance details for the resident
                        String query = "SELECT maintenance.maintenanceAmount FROM maintenance inner join resident on maintenance.flatID=resident.flatID WHERE residentId = ? and maintenance.maintenanceAmount!=0";
                        PreparedStatement preparedStatement = connection.prepareStatement(query);
                        preparedStatement.setInt(1, residentId); // Use setInt to set residentId
                        ResultSet resultSet = preparedStatement.executeQuery();

                        if (resultSet.next()) {

                %>
                <tr>
                    <td><%= resultSet.getInt("maintenanceAmount") %></td>
                    <td>
                        <form action="payAmountServlet" method="post">
                            <label>Payment Mode</label>
                            <select name="paymentMode" required>
                                <option value="Credit">Credit</option>
                                <option value="Debit">Debit</option>
                                <option value="UPI">UPI</option>
                            </select>
                            <input type="hidden" name="residentId" value="<%= residentId %>">
                            <input type="submit" value="Pay" class="btn btn-primary">
                        </form>
                    </td>
                </tr>
                <%
                        }else{
                        %>
                        <td>
                        No maintenance Details
                        </td>
                        <td></td>
                        <%
                        }
                        resultSet.close();
                        preparedStatement.close();

                %>
            </tbody>
        </table>
        <table class="table table-striped table-bordered">
            <thead class="bg-info text-white">
                <tr>
                    <th>Visitor Details</th>
                    <th>Approval Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String t_query = "select normalvisitor.visitorName from normalvisitor inner join resident on normalvisitor.flatId=resident.flatId where residentId = ? and status='Pending'";
                    PreparedStatement prepared_Statement = connection.prepareStatement(t_query);
                    prepared_Statement.setInt(1, residentId); // Use setInt to set residentId
                    ResultSet result_Set = prepared_Statement.executeQuery();

                    if(result_Set.next()) {
                %>
                <tr>
                    <td><%= result_Set.getString("visitorName") %></td>
                    <td>
                        <div class="ApprovalButton">
                            <form action="approvalApproveServlet" method="post">
                                <input type="hidden" name="residentId" value="<%= residentId %>">
                                <input type="submit" value="Approve" class="btn btn-success">
                            </form>
                            <form action="approvalDenyServlet" method="post">
                                <input type="hidden" name="residentId" value="<%= residentId %>">
                                <input type="submit" value="Deny" class="btn btn-danger">
                            </form>
                        </div>
                    </td>
                </tr>
                <%
                 }else{
                                        %>
                                        <td>
                                        No Visitor Details
                                        </td>
                                        <td></td>
                                        <%
                    }
                    result_Set.close();
                    prepared_Statement.close();
                } catch (ClassNotFoundException | SQLException e) {
                    out.println("An error occurred: " + e.getMessage());
                } finally {
                    if (connection != null) {
                        try {
                            connection.close();
                        } catch (SQLException e) {
                            out.println("An error occurred while closing the database connection: " + e.getMessage());
                        }
                    }
                }
                %>
            </tbody>
        </table>
    </div>
    <button id="togglePasswordForm">Update Password Form</button>
    <div class="updatePassword hidden">
    <form action="updatePasswordServlet" method="post">
        <label for="currentPassword">Current Password:</label>
        <input type="password" name="currentPassword" required>
<br>
        <label for="newPassword">New Password:</label>
        <input type="password" name="newPassword" required>

        <input type="submit" value="Update Password">
    </form>
    <div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        document.getElementById("togglePasswordForm").addEventListener("click", function() {
            var passwordForm = document.querySelector(".updatePassword");
            if (passwordForm.style.display === "none" || passwordForm.style.display === "") {
                passwordForm.style.display = "block";
            } else {
                passwordForm.style.display = "none";
            }
        });
    </script>
</body>
</html>
