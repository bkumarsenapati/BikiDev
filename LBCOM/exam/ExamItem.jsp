<!-- creates two frames. one for providing the links for create/list options of  a particular Assignment(HW/PW/AS) and another for  displaying the list or for providing a templete for creating/modifing -->
<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>

<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String examtype="",classId="",courseName="";
%>
<%
	session=request.getSession();

	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	classId=(String)session.getAttribute("classid");
	courseName=(String)session.getAttribute("coursename");
	examtype=request.getParameter("examtype");
	System.out.println("examtype..."+examtype);
	if(examtype==null || examtype.equals(""))
	{
		examtype="all";
	}
%>
<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>

<frameset rows="12%,*" noborders framespacing="0" border="0" frameborder="0"  style="margin-top:-5px;">
  <frame name="toppanel" target="main" src="ExamItemTopPanel.jsp" scrolling="no" marginwidth="0" marginheight="0">
  <frame name="bottompanel" target="main" src="ExamsList.jsp?totrecords=&start=0&examtype=<%=examtype%>" marginwidth="0" marginheight="0" scrolling="auto">
  <noframes>
  <body topmargin="0" leftmargin="0">

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</frameset>

</html>
