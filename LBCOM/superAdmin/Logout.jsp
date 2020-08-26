<%@ page language="java" import="coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<html>
<head>
<title></title>
</head> 
<body bgcolor='ffffff'>
<%
	String sessionId=(String)session.getAttribute("sessid");
	if(sessionId==null)
	{
		response.sendRedirect("/LBCOM/superAdmin/");
	 	return;
	}
     
	try
	{	
		session.invalidate();
		response.sendRedirect("/LBCOM/superAdmin/");

	}
	catch(Exception e)
  	{
		ExceptionsFile.postException("Logout.jsp","invalidating the session","Exception",e.getMessage());
		response.sendRedirect("../");
   	} 
%>
</body></html>
