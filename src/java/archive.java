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
@WebServlet(urlPatterns = {"/archive"})
public class archive extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try{
            String mail=request.getSession().getAttribute("session_mail").toString();
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/basicemail";
            String user = "root";
            String password = "admin";
            Connection connection =null;
            Statement statement = null;
            int affected_rows = 0;
            ResultSet rs = null;
            connection = DriverManager.getConnection(url,user,password);      
            String [] value = request.getParameter("check").split(",");
            for (String value1 : value) 
            {
                statement = connection.createStatement();
                String query ="UPDATE basicemail.recieve SET recieve.ARCHIVE = '1' where (recieve.MAIL_F3 = '"+mail+"'and recieve.MAIL_ID_F2 = '"+Integer.parseInt(value1)+"')";
                affected_rows = statement.executeUpdate(query);
                System.out.println(value1);
            }
            
            statement = connection.createStatement();
            String query ="(select mail.MAIL_ID ,mail.MAIL_F2,mail.MAIL_DATE,mail.SUBJECT from "
                    + "mail where mail.MAIL_ID in(select recieve.MAIL_ID_F2 from recieve"
                    + " where recieve.MAIL_F3 = '"+mail+"' and recieve.ARCHIVE ='0'))"
                    + "union(select reply.MAIL_ID_F3 ,reply.replaier,reply.REPLY_DATE,"
                    + "reply.REPLY_SUBJECT from reply where reply.replaier <> '"+mail+"'"
                    + "and reply.MAIL_ID_F3 in(select mail.MAIL_ID from mail where "
                    + "mail.MAIL_F2 = '"+mail+"' and mail.MAIL_ID in"
                    + "(select recieve.MAIL_ID_F2 from recieve where recieve.ARCHIVE ='0')))"
                    + "union(select forward.FORWARD_ID , forward.MAIL_F, forward.FORWARD_DATE,forward.FORWARD_SUBJECT "
                    + "from forward where FORWARD_ID in(select forward_recieve.FORWARD_ID_F "
                    + "from forward_recieve where forward_recieve.MAIL_F='"+mail+"'))"
                    + "order by MAIL_DATE desc";
            rs=statement.executeQuery(query);
            
            out.println(" <table border=\"1\">");
            out.println(" <tr>");
            out.println(" <th></th>");
            out.println(" <th>From</th>");
            out.println("<th>Subject</th>");
            out.println(" <th>Date</th>");
            out.println(" </tr>");
            while (rs.next()){
            out.println(" <tr>");
            out.println("  <td>");
            String ID = rs.getString("MAIL_ID");
            out.println(" <input class = \"checkboxx\" id=\"checkboxx\" type=\"checkbox\" name=\"choose[]\" value=\""+ID+" /> ");
            out.println(" </td>");
            out.println(" <td>");
            String name = rs.getString("MAIL_F2");
            out.println(" <a href =\"viewEmail.jsp?ID=<%=(ID)%>\">"+name+" </a>");
            out.println(" </td>");
            out.println(" <td>");
             String subj =rs.getString("SUBJECT");
            out.print(subj);
            out.println(" </td>");
            out.println(" <td>");
            String date =rs.getString("MAIL_DATE");
            out.print(date);
            out.println(" </td>");
            out.println(" </tr>");
            }
            out.println(" </table>");
            
        }finally{}
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
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(archive.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(archive.class.getName()).log(Level.SEVERE, null, ex);
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
