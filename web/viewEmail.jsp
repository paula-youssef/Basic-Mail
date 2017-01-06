<%-- 
    Document   : create
    Created on : Dec 9, 2015, 5:26:32 PM
    Author     : th
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>View Email</title>
        <link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
	<% 
            String mail_ID = request.getParameter("ID"); //the mail id that was clicked
            String mail=request.getSession().getAttribute("session_mail").toString();
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/basicemail";
            String user = "root";
            String password = "admin";
            Connection connection =null;
            Statement statement = null;
            ResultSet result = null;
            connection = DriverManager.getConnection(url,user,password);
            statement=connection.createStatement();
            String query ="select * from basicemail.mail where MAIL_ID = '"+mail_ID+"'";
            result=statement.executeQuery(query);
            Statement st = null;
            ResultSet res =null;
            st = connection.createStatement();
            String q ="select reply.REPLY_TEXT,reply.REPLY_DATE ,reply.MAIL_ID_F3,reply.replaier "
                    + "from reply where reply.MAIL_ID_F3 = '"+mail_ID+"'";
            res = st.executeQuery(q);
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
        
        <div id="sideMenu">
            <ul>
                <li><a href="userProfile.jsp">Inbox</a></li>
		<li><a href="sentMesseges.jsp">Sent</a></li>
                <li><a href="archiveMessages.jsp">Archive</a></li>
            </ul>
        </div>
      
    <div id="content1">
        <form>
            <div id = "readonly">
                <%
                    String subject ="",date="",content="",name="";
                    String allMessege = "";
                    while(res.next())
                    {
                        allMessege += "DATE : "+res.getString("REPLY_DATE")+"\n"+"From : "
                                +res.getString("replaier")+"\n"+"Message : "+res.getString("REPLY_TEXT")
                                +"\n";
                    }
                    String mail_only ="";
                    while(result.next())
                    {
                        name = result.getString("MAIL_F2");
                        subject =result.getString("SUBJECT");
                        date =result.getString("MAIL_DATE");
                        content ="From : "+name+"\n Subject : "+subject+"\n Date : "+date+"\n Messege : " 
                                +result.getString("MAIL_TEXT")+"\n Replays :- \n"+allMessege;
                        mail_only = result.getString("MAIL_TEXT");
                %>
                
                <textarea rows="10" cols="102" placeholder="<%=content%>" readonly></textarea>
                <%}%>
                </div>
                <div id = "select">
                    <a class ="button" href ="replay.jsp?ID=<%=(mail_ID)%>&subject=<%=subject%>&sender=<%=name%>"> Replay </a>
                    <a class ="button" href ="forward.jsp?ID=<%=mail_ID%>&subject=<%=subject%>&content=<%=mail_only%>"> Forward </a>
                    
            </div>
        </form>
        </div>

</body>
</html>