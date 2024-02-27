package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RegularVisitorServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        // Retrieve form data
        String visitorName = request.getParameter("visitorName");
        String visitorContact = request.getParameter("visitorContact");


        // String checkOutTime = request.getParameter("checkOutTime");
        //  String visitorType = request.getParameter("visitorType");
        // String role = request.getParameter("role")
        String url = "jdbc:mysql://localhost:3306/dbms";
        String username = "root";
        String password = "vamshibachu";

        PreparedStatement preparedStatement = null;

        try {
            // Create a database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url,username,password);

            // Define the SQL query based on the selected visitor type
            String sqlQuery = "";

            String flatID = request.getParameter("flatId");
            //   System.out.println("flat id = "+flatID);
            // out.println("flat id = +flatID");
           // String checkInTime = request.getParameter("checkInTime");
          //  String status = request.getParameter("status");
            String securityCode = request.getParameter("securityCode");
            String role = request.getParameter("role");
            sqlQuery = "INSERT INTO RegularVisitor (visitorName, visitorContact, securityCode, Role) VALUES ( ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sqlQuery);
            preparedStatement.setString(3, securityCode);
            preparedStatement.setString(4, role);

            // PreparedStatement checkPreparedStatement =connection.prepareStatement(check_query);
            // Set the common parameters
            preparedStatement.setString(1, visitorName);
            preparedStatement.setString(2, visitorContact);

            //  preparedStatement.setString(3, flatID);
            // preparedStatement.setString(3, checkInTime);
            // preparedStatement.setString(4, checkOutTime);

            // Execute the SQL query
            int rowsinserted = preparedStatement.executeUpdate();
            if(rowsinserted>0) {
                response.sendRedirect("Supervisor.jsp");
            }else{
                out.println("unable to insert");
            }


            //response.sendRedirect("Supervisor.jsp");
            connection.close();
            preparedStatement.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            out.println("Error Message :"+ e.getMessage());
        }
    }
    }

