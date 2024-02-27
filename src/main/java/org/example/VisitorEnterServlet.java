package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class VisitorEnterServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String SecurityCodeEntered = request.getParameter("SecurityCode");
        String checkInTime = request.getParameter("checkInTime");
       // String checkOutTime = request.getParameter("checkOutTime");
        String url = "jdbc:mysql://localhost:3306/dbms";
        String username = "root";
        String password = "vamshibachu";

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, username, password);

            String query ="Select securityCode from RegularVisitor where securityCode = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1,SecurityCodeEntered);
            ResultSet resultSet = preparedStatement.executeQuery();

            String enterQuery = "insert into VisitorEntry(SecurityCode,checkInTime) values (?,?) ";
            PreparedStatement enterPreparedStatement = connection.prepareStatement(enterQuery);
            enterPreparedStatement.setString(1,SecurityCodeEntered);
            enterPreparedStatement.setString(2,checkInTime);
            if(resultSet.next()){
                int rowsentered = enterPreparedStatement.executeUpdate();
                if(rowsentered>0){
                    response.sendRedirect("Supervisor.jsp");
                }
                else{
                    out.println("Values not entered in visitor entry");
                }
            }else{
                out.println("No security Code matched");
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
