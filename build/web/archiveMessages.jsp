<%-- 
    Document   : archiveMessages
    Created on : Dec 29, 2015, 1:14:37 AM
    Author     : tahany
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css">
        <title>Archive</title>
    </head>
    <body>
        <%
            String mail=request.getSession().getAttribute("session_mail").toString();
            String url = "jdbc:mysql://localhost:3306/basicemail";
            String user = "root";
            String password = "admin";
            Connection con=null;
            Statement st = null;
            ResultSet rs = null;
            con = DriverManager.getConnection(url,user,password);
            st = con.createStatement();
            String query ="select * from mail where mail.Mail_ID in ("
                    + "select recieve.MAIL_ID_F2 from recieve where recieve.ARCHIVE = '1' "
                    + "and recieve.MAIL_F3 ='"+mail+"')order by MAIL_DATE desc";
            rs=st.executeQuery(query);
        %>
        <div><img class ="image" src ='image_1.jpg'></div>
        
        <div><h3>Welcome , <%=mail%></h3></div>
        
        <div id="menu">
            <ul>
                <li><a href="sendMessege.jsp">Send message</a></li>
		<li><a href="editProfile.jsp">Edit profile</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </div>
        <div id = "wrapper">
        <div id="sideMenu">
            <ul>
                <li><a href="userProfile.jsp">Inbox</a></li>
                <li><a href="sentMesseges.jsp">Sent</a></li>
                <li><a href="archiveMessages.jsp">Archive</a></li>
            </ul>
        </div>
        
        <div id ="forTable">
            <table border="1">
                <tr>
                    
                    <th>From</th>
                    <th>Subject</th>
                    <th>Date</th>
                </tr>
                    <% while (rs.next()){ %>
                <tr>
                    
                        <%
                         String ID = rs.getString("MAIL_ID");
                        %>
                    <td>
                        <% 
                            String name = rs.getString("MAIL_F2");
                        %>
                        <a href ="viewEmail.jsp?ID=<%=(ID)%>"> <%=name%> </a>
                    </td>
                    <td>
                        <%
                            String subj =rs.getString("SUBJECT");
                            
                        %>
                        <%=subj%>
                    </td>
                    <td>
                        <%
                            String date =rs.getString("MAIL_DATE");
                        %>
                        <%=date%>
                    </td>
                </tr>
                <%}%>
  
            </table>
        </div>
        </div>
    </body>
</html>
