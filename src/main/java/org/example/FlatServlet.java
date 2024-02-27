package org.example;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class FlatServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        int flatNumber = Integer.parseInt(request.getParameter("flatNumber"));
        int buildingId = Integer.parseInt(request.getParameter("buildingId"));

        String url = "jdbc:mysql://localhost:3306/dbms";
        String username = "root";
        String password = "vamshibachu";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, username, password);

            String insertQuery = "INSERT INTO flat (flatNumber, buildingId) VALUES (?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);

            preparedStatement.setInt(1, flatNumber);
            preparedStatement.setInt(2, buildingId);

            int rowsInserted = preparedStatement.executeUpdate();

            if (rowsInserted > 0) {
                //out.println("Flat details inserted successfully!");
                response.sendRedirect("Admin.jsp");
            } else {
                out.println("Failed to insert flat details.");
            }

            preparedStatement.close();
            connection.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    }
}

