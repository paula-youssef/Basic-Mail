/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author tahany
 */
@WebServlet(urlPatterns = {"/forward"})
public class forward extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try{
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            String sender = request.getSession().getAttribute("session_mail").toString();
            String reciever = request.getParameter("receiver");
            String subject = request.getParameter("subject");
            String mail_id = request.getParameter("id");
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            Calendar cal = Calendar.getInstance();
            String date =dateFormat.format(cal.getTime()); //2014/08/06 16:00:22
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/basicemail";
            String user = "root";
            String password = "admin";
            Connection connection =null;
            Statement statement = null;
            ResultSet result = null;
            int  id  =0;
            int affected_rows = 0;
            connection = DriverManager.getConnection(url,user,password);
            statement=connection.createStatement();
            String query ="select * from basicemail.forward";
            result = statement.executeQuery(query);
            
            if(result.wasNull())
                id =0;
            
            
            while(result.next()){
                if(result.last()){
                    id = Integer.parseInt(result.getString("FORWARD_ID"));
                }
            }
            id++;
            connection = DriverManager.getConnection(url,user,password);
            statement=connection.createStatement();
            query ="INSERT INTO basicemail.forward (FORWARD_DATE , FORWARD_ID ,  MAIL_ID_F , MAIL_F , FORWARD_SUBJECT) "
                    + "VALUES ('"+date+"',"+id+",'"+mail_id+"','"+sender+"','"+subject+"')";
            affected_rows = statement.executeUpdate(query);        
            String [] recievers = reciever.split(" ");
            for (String reciever1 : recievers) {
                statement = connection.createStatement();
                query = "select * from users where MAIL = '"+reciever1+"'";
                result = statement.executeQuery(query);
                if(result.next()){
                    System.out.println(reciever1+"       scfklansklvaen "+mail_id);
                    statement = connection.createStatement();
                    query = "insert into basicemail.forward_recieve values ('"+reciever1+"',"+id+")";
                    affected_rows = statement.executeUpdate(query);
                }
            }            
             response.sendRedirect("userProfile.jsp");
        }finally{
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(forward.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(forward.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(forward.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
