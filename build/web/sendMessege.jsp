<%-- 
    Document   : create
    Created on : Dec 9, 2015, 5:26:32 PM
    Author     : th
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Email</title>
	<link rel="stylesheet" type="text/css" href="style.css" />
        <script>
             function validate(form)
                {
                    if(form.receiver.value === "")
                    {
                        alert("Error: receiver cannot be blank ! ");
                        form.receiver.focus();
                        return false;
                    }
                    var mail = form.receiver.value
                    
                    var mails = mail.split(" ");
                    
                    for (i = 0; i < mails.length; i++) { 
                        if(mails[i].indexOf("@")== -1){
                            alert("Error: reciever "+mails[i]+" invaled .. must contain @ ! ");
                            form.receiver.focus();
                            return false;
                        }
                        if(mails[i].indexOf(".com")== -1){
                            alert("Error: reciever "+mails[i]+" invaled .. must contain .com ! ");
                            form.receiver.focus();
                            return false;
                        }
                        for (j = 0; j < mails.length; j++) {
                            if((i != j)&&(mails[i] == mails[j])){
                                alert("Error: reciever "+mails[i]+" repeated ! ");
                                form.receiver.focus();
                                return false;
                            }
                        } 
                    }
                   
                }
         </script>
</head>
<body>
	<% 
            String mail=request.getSession().getAttribute("session_mail").toString();
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
            <form action = "send"  onsubmit="return validate(this);">
                To      <input type="text" name="receiver" value="" />
                Subject <input type="text" name="subject" value="" /><br>
                <textarea rows="10" cols="102" name="content" placeholder="Email content"></textarea>
                <center><input class ="button" type="submit" value="Send" name="send" /></center>
            </form>
	    </div>
</body>
</html>