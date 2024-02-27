package org.example;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

import static java.lang.Class.forName;

public class BuildingServlet extends HttpServlet {
    public void doPost( HttpServletRequest request,HttpServletResponse response){
        String url = "jdbc:mysql://localhost:3306/dbms";
        String username = "root";
        String password = "vamshibachu";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url,username,password);

            String buildingName = request.getParameter("buildingName");
            String Location = request.getParameter("Location");
            String insertQuery="insert into building(buildingName,Location) values (?,?)";
            PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);

            preparedStatement.setString(1,buildingName);
            preparedStatement.setString(2,Location);
            preparedStatement.executeUpdate();

            preparedStatement.close();
            connection.close();

            response.sendRedirect("Admin.jsp");

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
