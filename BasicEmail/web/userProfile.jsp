<%-- 
    Document   : userProfile
    Created on : Dec 7, 2015, 2:11:01 AM
    Author     : tahany
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css">
        <title>Profile</title>
    </head>
    <body>
        <% 
            String mail=request.getSession().getAttribute("session_mail").toString();
        %>
        
        <a class ="button" href="logout" style="float:right;">Logout</a>
        <div><img class ="image" src ='image_1.jpg'></div>
        <div><h3>Welcome , <%=mail%></h3></div>
        <div id="menu">
            <ul>
       
                <li><a class ="button" href="create.jsp">Send message</a></li>
		<li><a class ="button" href="">Delete</a></li>
                <li><a class ="button" href="">Archive</a></li>
		<li><a class ="button" href="editProfile.jsp">Edit profile</a></li>
            </ul>
        </div>
        <div id="menu">
            <ul>
       
                <li><a class ="button" href="">Inbox</a></li>
		<li><a class ="button" href="">Sent</a></li>
                <li><a class ="button" href="">Archive</a></li>
		</ul>
        </div>
        <div>
            <table border="1">
                <tr>
                    <th></th>
                    <th>From</th>
                    <th>Subject</th>
                    <th>Date</th>
                </tr>
                    <%for(int i =0;i<10;i++){%>
                    <tr>
                    <td><input type="checkbox" name="choose" value="ON" /></td>
                    <td><a href="viewEmail.jsp">tahany@yahoo.com</a></td>
                    <td><a href="">project</a></td>
                    <td><a href="">12-11-2-15</a></td>
                    </tr>
                    <%}%>
               
            </table>
        </div>
    </body>
</html>
