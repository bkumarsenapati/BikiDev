<%@ page isErrorPage="true" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
</head>
<body>
<%
out.println("<h3 align=\"center\"><font color=red face=\"Verdana\">"+
		"An error has been occurred::</font></h3>"+
		"<p align=\"center\"><font face=\"Verdana\"><br>");
out.println("<font size=\"2\"><b>");
out.println("<br>Please report this to <a href=\"mailto:support@hotschools.net\">"+
		" us</a></b></font></font>");

 try{
		Thread.sleep(2000);
RequestDispatcher dispatcher =  request.getRequestDispatcher("/LBCOM/asm.RedirectingToHomePage");
	dispatcher.forward(request,response);
	}
	catch(Exception _ex){}

%>

</body>
</html>
