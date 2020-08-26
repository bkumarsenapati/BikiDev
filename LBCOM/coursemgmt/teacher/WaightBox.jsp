<!-- creats two frames -->


<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String classId="",courseName="",courseId="",className="",mode="";
%>
<%
	session=request.getSession();

	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	classId=request.getParameter("classid");
	courseName=request.getParameter("coursename");
	courseId=request.getParameter("courseid");
	className=request.getParameter("classname");
	mode=request.getParameter("mode");
%>
<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>

<frameset rows="48,*" noborders framespacing="0" border="0" frameborder="0" topmargin="0" >
  <frame name="contents" target="main" src="WaightTopPanel.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId%>&classname=<%=className%>&mode=<%=mode%>"; scrolling="no" marginwidth="0" marginheight="0">
  <frame name="main" src="about:blank" marginwidth="0" marginheight="0" scrolling="auto">
  <noframes>
  <body topmargin="0" leftmargin="0">

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</frameset>

</html>
