package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

public class LoginServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) {
        System.setProperty("javax.net.debug", "ssl");
        String url = "jdbc:mysql://localhost:3306/dbms";
        String username = "root";
        String password = "vamshibachu";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, username, password);

            String user_name = request.getParameter("username");
            String user_password = request.getParameter("password");
            String checkingQuery = "SELECT password, role FROM user WHERE username = ?";

            HttpSession session = request.getSession();
            session.setAttribute("username", user_name);


            PreparedStatement preparedStatement = connection.prepareStatement(checkingQuery);
            preparedStatement.setString(1, user_name);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String storedPassword = resultSet.getString("password");
                String userRole = resultSet.getString("role");

                session.setAttribute("role", userRole);
                if (user_password.equals(storedPassword)) {
                    if ("Administrator".equals(userRole)) {
                        response.sendRedirect("Admin.jsp");
                    } else if ("Supervisor".equals(userRole)) {
                        response.sendRedirect("Supervisor.jsp");
                    } else if ("FlatResident".equals(userRole)) {
                        response.sendRedirect("FlatResident.jsp");
                    }
                } else {
                    // Invalid password
                    request.setAttribute("errorMessage", "Invalid password");
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                }
            } else {
                // User not found
                request.setAttribute("errorMessage", "User not found");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }

            // Close resources
            resultSet.close();
            preparedStatement.close();
            connection.close();

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }


    }
}
