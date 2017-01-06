<%-- 
    Document   : signup
    Created on : Dec 7, 2015, 12:52:49 AM
    Author     : paula
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Edit Profile </title>
         <link rel="stylesheet" href="signupStyle.css" type="text/css">   
           <script>
             function validate(form)
                {
                    if(form.fname.value === "")
                    {
                        alert("Error: First Name cannot be blank!");
                        form.fname.focus();
                        return false;
                    }
                    if(form.lname.value === "")
                    {
                        alert("Error: Last Name cannot be blank!");
                        form.lname.focus();
                        return false;
                    }
                    if(form.phone_number.value === "")
                    {
                        alert("Error: phone_number cannot be blank!");
                        form.phone_number.focus();
                        return false;
                    }
                    if(form.pass.value === "")
                    {
                        alert("Error: Password cannot be blank!");
                        form.pass.focus();
                        return false;
                    }
                    else{
                        return true;
                    }
                }
         </script>
    </head>
    <body>
        <div><img class ="image" src ='image_1.jpg'></div>
        <div class="container">
            <%
                String mail = request.getSession().getAttribute("session_mail").toString();
                System.out.println(mail);
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/basicemail";
                String user = "root";
                String password = "admin";
                Connection connection =null;
                Statement statement = null;
                ResultSet result = null;
                connection = DriverManager.getConnection(url,user,password);
                statement=connection.createStatement();
                String query ="select F_NAME,L_NAME,PASS,PHONE_NUM from users where MAIL = '"+mail+"'";
                result=statement.executeQuery(query);
                String fname = "",lname = "",pass = "",phone = "";
                while (result.next()){
                    fname = result.getString("F_NAME");
                    lname = result.getString("L_NAME");
                    pass = result.getString("PASS");
                    phone = result.getString("PHONE_NUM");
                    }
                %>
        
    <form id="signup" name="form" onsubmit="return validate(this);" action="editprofile">

            <div class="header">

                <h3>Edit Profile</h3>

                <p>Edit information you want to edit</p>

            </div>

            <div class="sep"></div>

            <div class="inputs">
                <h5>Mail</h5>
                <label><%=mail%></label>
                <h5>First name</h5>
                <input type="text" name ="fname"  value="<%=fname%>" autofocus/>
                <h5>Last name</h5>
                <input type="text" name ="lname" value="<%=lname%>" />
                <h5>Phone number</h5>
                <input type="text" name ="phone_number" value="<%=phone%>" />
                <h5>Password</h5>
                <input type="text" name="pass" value="<%=pass%>"/>

                <input type="submit" id="submit" value="Save Changes To MY ACCOUNT NOW" />

            </div>

        </form>
</div>

    </body>
</html>
