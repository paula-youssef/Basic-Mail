<%-- 
    Document   : userProfile
    Created on : Dec 7, 2015, 2:11:01 AM
    Author     : tahany
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
        <link rel="stylesheet" href="style.css" type="text/css">
        <title>Profile</title>
        <script type="text/javascript">
            function sendAjax()
            {
                //document.getElementById('checkboxx').checked;
                //check if there any check boxes marked & if--return true unless--> return false
                var checkboxes = document.getElementsByName('choose[]');
                var vals = "";
                for (var i=0, n=checkboxes.length;i<n;i++) {
                     if (checkboxes[i].checked){
                           vals += ","+checkboxes[i].value;
                        }
                  }
                if (vals) vals = vals.substring(1);
                // window.alert(vals);
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("GET","delete?check="+vals, true);
                xmlhttp.send();
                
                xmlhttp.onreadystatechange = function()
                {
                    if(xmlhttp.readyState ==4 && xmlhttp.status ==200)
                    {
                        document.getElementById("forTable").hidden;
                        document.getElementById("forTable2").innerHTML = xmlhttp.responseText;
                    }
                }
            }
            function sendAjaxArchive()
            {
                //check if there any check boxes marked & if--return true unless--> return false
                var checkboxes = document.getElementsByName('choose[]');
                var vals = "";
                for (var i=0,n=checkboxes.length;i<n;i++) {
                     if (checkboxes[i].checked){
                           vals += ","+checkboxes[i].value;
                        }
                  }
                if (vals) vals = vals.substring(1);
                // window.alert(vals);
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("GET","archive?check="+vals, true);
                xmlhttp.send();
                
                xmlhttp.onreadystatechange = function()
                {
                    if(xmlhttp.readyState ==4 && xmlhttp.status ==200)
                    {
                        document.getElementById("forTable").hidden;
                        document.getElementById("forTable2").innerHTML = xmlhttp.responseText;
                    }
                }
            }
            function searchCheck(form) {
                    var r = document.getElementsByName("search");
                    var c = -1;

                    for(var i=0; i < r.length; i++){
                       if(r[i].checked) {
                          c = i; 
                       }
                    }
                    var value = document.getElementById('SearchValue').value;
                    if (value === ""){
                        alert("Error: Search text cannot be blank ! ");
                        form.stext.focus();
                        return false;
                    }else if(c === -1){
                        alert("please select one of Search types");
                        return false;
                    }else {
                        if (document.getElementById('To').checked || document.getElementById('From').checked) {
                            if(value.indexOf("@")=== -1){
                                alert("Error: Searched mail must contain ( @ ) ! ");
                                form.stext.focus();
                                return false;
                            }else if(value.indexOf(".com")=== -1){
                                alert("Error: Searched mail must contain ( .com ) ! ");
                                form.stext.focus();
                                return false;
                            }
                            if(value.indexOf(" ") !== -1){
                                alert("Error: Searched mail must not contain space ! ");
                                form.stext.focus();
                                return false;
                            }
                            return true;
                          }
                          
                        if (document.getElementById('Date').checked) {
                            var values= value.split("/");
                            if(values.length !== 2){
                                alert("Error: The input must be 2 dates sepreted by ( / ):- \n EX: 2015-12-28 19:35:54/2015-12-28 19:35:54 !\n Start with smallest !!! ");
                                form.stext.focus();
                                return false;
                            }else{
                                var dtRegex = /^([\+-]?\d{4}(?!\d{2}\b))((-?)((0[1-9]|1[0-2])(\3([12]\d|0[1-9]|3[01]))?|W([0-4]\d|5[0-2])(-?[1-7])?|(00[1-9]|0[1-9]\d|[12]\d{2}|3([0-5]\d|6[1-6])))([T\s]((([01]\d|2[0-3])((:?)[0-5]\d)?|24\:?00)([\.,]\d+(?!:))?)?(\17[0-5]\d([\.,]\d+)?)?([zZ]|([\+-])([01]\d|2[0-3]):?([0-5]\d)?)?)?)?$/;
                                if( ! dtRegex.test(values[0])){
                                    alert(values[0]+" This is invalied format for date !!!");
                                    return false;
                                }
                                if (! dtRegex.test(values[1])){
                                    alert(values[1]+" This is invalied format for date !!!");
                                    return false;
                                }
                                return  true;
                            }
                        }
                    }
                }
            
        </script>
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
            rs=st.executeQuery(query);
        %>
        <div><img class ="image" src ='image_1.jpg'></div>
        
        <div><h3>Welcome , <%=mail%></h3></div>
        
        <div id="menu">
            <ul>
                <li><a href="sendMessege.jsp">Send message</a></li>
		<li><a href="" onclick="sendAjax()">Delete</a></li>
                <li><a href="" onclick="sendAjaxArchive()">Archive</a></li>
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
            <div id = search>
                <form name="Search" onsubmit= "return searchCheck(this);" action="search.jsp">
                    <input type="text" name="stext" id="SearchValue" value="" />
                    <input type="radio" name="search" id="To" value="To" />To
                    <input type="radio" name="search" id="From" value="From" />From
                    <input type="radio" name="search" id="Date" value="Date" />Date Range
                    <input id = "submit" type="submit" value="Search" />
                </form>
            </div>
        <div id ="forTable">
            <table border="1">
                <tr>
                    <th></th>
                    <th>From</th>
                    <th>Subject</th>
                    <th>Date</th>
                </tr>
                    <% while (rs.next()){ %>
                <tr>
                    <td>
                        <%
                         String ID = rs.getString("MAIL_ID");
                        %>
                        <input class = "checkboxx" id="checkboxx" type="checkbox" name="choose[]" value=<%=ID%> /> 
                    </td>
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
                <div id="forTable2">   
                </div>
        </div>
    </body>
</html>
