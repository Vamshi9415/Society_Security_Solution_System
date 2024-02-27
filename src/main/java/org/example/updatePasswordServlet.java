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
import java.sql.ResultSet;
import java.sql.SQLException;

public class updatePasswordServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        String url = "jdbc:mysql://localhost:3306/dbms";
        String username = "root";
        String password = "vamshibachu";

        HttpSession session = request.getSession();
        String User_Name = (String) session.getAttribute("username");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, username, password);

            // Retrieve the current password for the user
            String selectPasswordQuery = "SELECT residentPassword FROM resident WHERE residentUsername = ?";
            PreparedStatement selectPasswordStatement = connection.prepareStatement(selectPasswordQuery);
            selectPasswordStatement.setString(1, User_Name);
            ResultSet resultSet = selectPasswordStatement.executeQuery();

            String storedPassword = "";
            if (resultSet.next()) {
                storedPassword = resultSet.getString("residentPassword");
            }

            if (currentPassword.equals(storedPassword)) {
                // Update the password in the resident table
                String updatePasswordQuery = "UPDATE resident SET residentPassword = ? WHERE residentUsername = ?";
                PreparedStatement updatePasswordStatement = connection.prepareStatement(updatePasswordQuery);
                updatePasswordStatement.setString(1, newPassword);
                updatePasswordStatement.setString(2, User_Name);
                updatePasswordStatement.executeUpdate();

                if(!newPassword.equals(currentPassword)) {
                    String pdatePasswordQuery = "UPDATE user SET Password = ? WHERE Username = ?";
                    PreparedStatement pdatePasswordStatement = connection.prepareStatement(pdatePasswordQuery);
                    pdatePasswordStatement.setString(1, newPassword);
                    pdatePasswordStatement.setString(2, User_Name);
                    pdatePasswordStatement.executeUpdate();

                    response.sendRedirect("FlatResident.jsp");
                }else {
                    out.println("Failed to update password. Please check your current password.");
                }
            } else {
                out.println("Failed to update password. Please check your current password.");
            }

            selectPasswordStatement.close();
            resultSet.close();
            connection.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    }
}
