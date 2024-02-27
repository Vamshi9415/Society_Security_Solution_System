package org.example;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import static java.lang.System.out;

public class StaffServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String url = "jdbc:mysql://localhost:3306/dbms";
        String username = "root";
        String password = "vamshibachu";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url,username,password);
            String staffName = request.getParameter("staffName");
            String staffPhoneNumber = request.getParameter("staffPhoneNumber");
            String staffType = request.getParameter("staffType");
            int buildingId = Integer.parseInt(request.getParameter("buildingId"));
            String query = "insert into staff(staffName,staffType,staffPhoneNumber,buildingId) values(?,?,?,?)";
            PreparedStatement preparedStatement = connection.prepareStatement(query);

            preparedStatement.setString(1,staffName);
            preparedStatement.setString(2,staffPhoneNumber);
            preparedStatement.setString(3,staffType);
            preparedStatement.setInt(4,buildingId);

            int rowsInserted = preparedStatement.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("Supervisor.jsp");
            } else {
                out.println("Failed to insert flat details.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
