<%-- 
    Document   : signup
    Created on : Dec 7, 2015, 12:52:49 AM
    Author     : paula
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Sign UP </title>
         <link rel="stylesheet" href="signupStyle.css" type="text/css">
         <script>
             function validate(form)
                {
                    if(form.mail.value === "")
                    {
                        alert("Error: Mail cannot be blank!");
                        form.mail.focus();
                        return false;
                    }
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
        
            <form id="signup" name="form" onsubmit="return validate(this);" action="signup">

            <div class="header">

                <h3>Sign Up</h3>

                <p>You should fill out this form</p>

            </div>

            <div class="sep"></div>

            <div class="inputs">

                <input type="email" name ="mail" placeholder="e-mail" autofocus />

                <input type="text" name ="fname" placeholder="First Name" />

                <input type="text" name ="lname" placeholder="Last Name" />

                 <input type="text" name ="phone_number" placeholder="Phone Number" />

                <input type="password" name="pass" placeholder="Password" />

                <input type="submit" id="submit" value="SIGN UP TO MY ACCOUNT NOW" />

            </div>

        </form>

    </div>

    </body>
</html>
