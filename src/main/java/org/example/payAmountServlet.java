package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.FileStore;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class payAmountServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String url = "jdbc:mysql://localhost:3306/dbms";
        String username = "root";
        String password = "vamshibachu";

        String residentId = (request.getParameter("residentId"));
       // String paid_amount = (request.getParameter("paid_amount"));
        String paymentMode = request.getParameter("paymentMode");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, username, password);
            String x_query = "UPDATE maintenance INNER JOIN resident ON maintenance.flatId = resident.flatId SET maintenance.paid_amount = maintenance.maintenanceAmount WHERE resident.residentId = ?";
            PreparedStatement xpreparedStatement = connection.prepareStatement(x_query);
            xpreparedStatement.setString(1, residentId);

            String query = "UPDATE maintenance INNER JOIN resident ON maintenance.flatId = resident.flatId SET maintenanceAmount = 0 WHERE resident.residentId = ?";

            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, residentId);

            String t_query = "UPDATE maintenance INNER JOIN resident ON maintenance.flatId = resident.flatId SET paymentMode = ? WHERE resident.residentId = ?";
            PreparedStatement t_queryStatement = connection.prepareStatement(t_query);
            t_queryStatement.setString(1, paymentMode);
            t_queryStatement.setString(2, residentId);

            /*String q_query = "UPDATE maintenance INNER JOIN resident ON maintenance.flatId = resident.flatId SET paid_amount = ? WHERE resident.residentId = ?";
            PreparedStatement q_queryStatement = connection.prepareStatement(q_query);
            q_queryStatement.setString(1, paid_amount);
            q_queryStatement.setString(2, residentId);*/
            int paid_amounteffected = xpreparedStatement.executeUpdate();
            if(paid_amounteffected>0){
                int rowsEffected = preparedStatement.executeUpdate();
                if (rowsEffected > 0) {
                    t_queryStatement.executeUpdate();
                    //q_queryStatement.executeUpdate();
                    response.sendRedirect("FlatResident.jsp");
                } else {
                    out.println("Issue in updating maintenance details");
                }
            }else {
                out.println("Issue in updating paid_amount details");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
