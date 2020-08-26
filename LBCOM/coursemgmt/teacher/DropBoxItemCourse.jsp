<%@ page language="java" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String classId="",courseName="",type="";
%>
<%
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
			
	classId=(String)session.getAttribute("classid");
	type=request.getParameter("type");
%>

<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>

<frameset rows="6%,*" noborders framespacing="0" border="0" frameborder="0" topmargin="0">
	<frame name="toppanel"  src="dbitemcoursetoppanel.jsp?type=<%=type%>" scrolling="no" marginwidth="0" marginheight="0">
<%  
	if (type.equals("CM"))
	{
%>
		<frame name="bottompanel" src="CoursesDocList.jsp?totrecords=&start=0&cat=all&type=<%=type%>&tag=false" marginwidth="0" marginheight="0" scrolling="auto">
<%
	}
	else if (type.equals("CO"))
	{
%>
		<frame name="bottompanel" src="CoursesDocList.jsp?totrecords=&start=0&cat=CL&type=<%=type%>&tag=true" marginwidth="0" marginheight="0" scrolling="auto">	 
<%
	}
%>
<noframes>
<body topmargin="0" leftmargin="0">
	<p>This page uses frames, but your browser doesn't support them.</p>
</body>
</noframes>
</frameset>

</html>
