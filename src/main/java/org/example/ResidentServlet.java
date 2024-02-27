package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ResidentServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String url = "jdbc:mysql://localhost:3306/dbms";
        String username = "root";
        String password = "vamshibachu";

        String residentFirstName = request.getParameter("residentFirstName");
        String residentLastName = request.getParameter("residentLastName");
        String residentPhoneNumber = request.getParameter("residentPhoneNumber");
        String flatId = request.getParameter("flatId");


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, username, password);

            // Insert data into the resident table
            String insertQuery = "INSERT INTO resident (residentFirstName, residentLastName, residentPhoneNumber, flatId) VALUES (?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);
            preparedStatement.setString(1, residentFirstName);
            preparedStatement.setString(2, residentLastName);
            preparedStatement.setString(3, residentPhoneNumber);
            preparedStatement.setString(4, flatId);
            int rowsInserted = preparedStatement.executeUpdate();

            if (rowsInserted > 0) {


                // Insert data into the user table
                String userQuery = "INSERT INTO user (username, password, role) SELECT residentUsername, residentPassword, role FROM resident where resident.residentUsername not in (select username from user)";
                PreparedStatement userPreparedStatement = connection.prepareStatement(userQuery);

                int userRowsInserted = userPreparedStatement.executeUpdate();

                if (userRowsInserted > 0) {
                   // out.println("User data inserted successfully.");
                    response.sendRedirect("Admin.jsp");

                    // Update resident records
                    String updateResidentQuery = "UPDATE resident INNER JOIN user ON resident.residentUsername = user.username SET resident.userId = user.userId where resident.residentUserId is null";
                    PreparedStatement updateResidentPreparedStatement = connection.prepareStatement(updateResidentQuery);


                        response.sendRedirect("Admin.jsp");


                    updateResidentPreparedStatement.close();
                } else {
                    out.println("Failed to insert User data.");
                }

                userPreparedStatement.close();
            } else {
                out.println("Failed to insert Resident data.");
            }

            preparedStatement.close();
            connection.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    }
}
