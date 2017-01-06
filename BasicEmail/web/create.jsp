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
	<link rel="stylesheet" type="text/css" href="Email.css" />
        <script>
             function validate(form)
                {
                    if(form.receiver.value === "")
                    {
                        alert("Error: receiver cannot be blank!");
                        form.receiver.focus();
                        return false;
                    }
                }
         </script>
</head>
<body>
	<div id="headerwrap">
		<div id="header">
			<img class ="image" src ='image_1.jpg'>
		</div>
	</div>
    <div id="contentwrap">
        <div id="content1">
		    <form class="send" action = "send"  onsubmit="return validate(this);">
                        To      <input type="text" name="receiver" value="" />
		        Subject <input type="text" name="subject" value="" /><br>
		        <textarea rows="10" cols="102" name="content" placeholder="Email content"></textarea>
		        <center><input class ="button" type="submit" value="Send" name="send" /></center>
		    </form>
	    </div>
    </div>
</body>
</html>