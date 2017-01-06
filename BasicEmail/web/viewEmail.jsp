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
	<title>View Email</title>
	<link rel="stylesheet" type="text/css" href="Email.css" />
</head>
<body>
	<div id="headerwrap">
		<div id="header">
			<img class ="image" src ='image_1.jpg'>
		</div>
	</div>
    <div id="leftcolumnwrap">
        <div id="leftcolumn">
        	<ul class="list" style="square">
        		<li>
        			<a class ="button" href="create.jsp">send message</a>
        		</li>
                        <br>
                        <br>
                        <br>
        		<li>
        			<a class ="button" href="#">Delete</a>
        		</li>
                        <br>
                        <br>
                        <br>
        		<li>
        			<a class ="button" id="sendButton" href="editProfile.jsp">Edit Profile</a>
        		</li>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
        	</ul>
        </div>
    </div>
    <div id="contentwrap">
        <div id="content1">
		    <form class="send">
		        To      <input type="text" name="receiver" value="" />
		        From    <input type="text" name="sender" value="" />
		        Subject <input type="text" name="subject" value="" /><br>
		        <textarea rows="10" cols="102" placeholder="Email content"></textarea>
		        <input class ="button" type="submit" value="Reply" name="send" />
                        <input class ="button" type="submit" value="Foreword" name="send" />
		    </form>
	    </div>
    </div>
</body>
</html>