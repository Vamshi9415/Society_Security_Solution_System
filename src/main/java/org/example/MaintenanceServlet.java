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

public class MaintenanceServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        int maintenanceAmount = Integer.parseInt(request.getParameter("maintenanceAmount"));
        String flatID = request.getParameter("flatID");
        String paymentDueDate=request.getParameter("paymentDueDate");
       // String paymentMode = request.getParameter("paymentMode");

        String url = "jdbc:mysql://localhost:3306/dbms";
        String username = "root";
        String password = "vamshibachu";

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection  = DriverManager.getConnection(url,username,password);

            String query = " insert into maintenance(maintenanceAmount,flatID,paymentDueDate) values(?,?,?)";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1,maintenanceAmount);
            preparedStatement.setString(2,flatID);
            preparedStatement.setString(3,paymentDueDate);
          //  preparedStatement.setString(4,paymentMode);


            int rowsInserted = preparedStatement.executeUpdate();
            if(rowsInserted>0){
                response.sendRedirect("Supervisor.jsp");
            }else{
                out.println("issue in inserting values in maintenance table");
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
