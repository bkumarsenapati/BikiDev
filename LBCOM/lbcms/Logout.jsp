<%@ page language="java" import="coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>You have successfully logged out from your account</title>
</head>

<body>
<%
	String sessionId=(String)session.getAttribute("sessid");
	if(sessionId==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/'; \n </script></html>");
		//response.sendRedirect("/LBCOM/lbcms/");
	 	return;
	}
     
	try
	{	
		session.invalidate();
		//response.sendRedirect("/LBCOM/lbcms/");

	}
	catch(Exception e)
  	{
		ExceptionsFile.postException("Logout.jsp","invalidating the session","Exception",e.getMessage());
		
   	}
	finally
	{
		try
		{
		
			if(request.getParameter("redirect")==null)
			{
				response.sendRedirect("Logout.jsp");
			}
			else
			{
				
				response.sendRedirect("../");
			}
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("Developer Logout.jsp","Closing the connection objects ","Exception",e.getMessage());
			out.println(e.getMessage());
		}
	}
%>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p align="center"><font face="Verdana" size="2" color="#FF0000"><b>You have 
successfully logged out from your account!</b></font></p>

</body>

</html>
