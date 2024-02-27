<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<!DOCTYPE html>
<html>
<head>
    <title>Supervisor Panel - Upload Building Details</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* Add hover animation and color change to anchor tags */
        a:hover {
            color: #FF5733; /* Change the color when hovering */
            border: 2px solid #FF5733; /* Add a border when hovering */
            transition: color 0.3s, border 0.3s; /* Smooth color and border transition */
        }


                .button:hover {
                    box-shadow: 0px 37px 20px -20px rgba(0, 0, 0, 0.2);
                    -webkit-transform: translate(0px, -10px) scale(1.2);
                    transform: translate(0px, -10px) scale(1.2);
                }
                .container{
                margin-top:75px;
                border:5px solid black;
                padding:20px;
                }
                .title{
                margin-top:20px;
                }
                .logout{
                top:25px;
                right:50px;
                position:absolute;
                }
    </style>
</head>
<body>
 <div class="logout" >
                               <form action="LogOutServlet" method="post">
                                <input type="submit" value="LogOut">
                               </form>
                               </div>
<div class="title">
                        <center>
                           <h1 class="card-title">Welcome, Supervisor!</h1>
                           </center>
                           </div>

    <div class="container">
        <div class="row">
            <div class="col-12 col-sm-6 col-md-4">
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <a href="uploadStaff.jsp" class="btn btn-primary btn-block">Upload Staff Details</a>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-4">
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <a href="uploadNormalVisitor.jsp" class="btn btn-primary btn-block">Upload Normal Visitor Details</a>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-4">
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <a href="RegisterVisitor.jsp" class="btn btn-primary btn-block">Register Regular Visitor Details</a>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-4">
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <a href="VisitorEntry.jsp" class="btn btn-primary btn-block">Upload Regular Visitor Entry Details</a>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-4">
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <a href="VisitorExit.jsp" class="btn btn-primary btn-block">Upload Regular Visitor Exit Details</a>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-4">
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <a href="UploadMaintenance.jsp" class="btn btn-primary btn-block">Upload Maintenance Details</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Bootstrap JS and Popper.js links if needed -->
</body>
</html>
