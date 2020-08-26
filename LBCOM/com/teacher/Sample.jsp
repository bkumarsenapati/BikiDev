<%-- 
    Document   : Sample
    Created on : Apr 23, 2011, 5:15:15 PM
    Author     : Sriram
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JQuery Example</title>
    </head>
    <body>
        <center>
            <h3>Getter Example using Servlets</h3>
        </center>
        <script type="text/javascript" src="jquery-1.5.1.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                alert("Thanks for visiting!");
		$(".Submit").click(function(){
                    $name=$("#name").val();
                    alert($name) ;
                    $.get("SampleServlet", {name:$name}, function(data) {
                        alert(data) ;
                        $("#flag").html(data) ;
                    });
		});
            });
        </script>
        <form id="sampleform" method="POST">
            <center>
                Enter your Name:  <input id="name" class="name" type="text">  <br/><br/>
                <input class="Submit" name="Submit" type="button" value="Submit" id="Submit"> 
            </center>
        </form>
        <div id="flag"> </div>
    </body>
</html>
