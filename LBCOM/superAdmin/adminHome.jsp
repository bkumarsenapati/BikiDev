<html>
<head>
<title><%=application.getInitParameter("title")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<%@ page language="java" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ page import = "java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
	session=request.getSession(true);
	String s=(String)session.getAttribute("sessid");
	if(s==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	String superId="";
	
	superId=request.getParameter("superid");
%>

</head>

<frameset rows="125,*" framespacing="0" border="0" frameborder="0">
	<frame name="banner" noresize target="contents" scrolling="no" src="/LBCOM/superAdmin/top.jsp" noresize border="0">
	<frame name="main" src="about:blank">
</frameset>
<body>
</body>
</html>

