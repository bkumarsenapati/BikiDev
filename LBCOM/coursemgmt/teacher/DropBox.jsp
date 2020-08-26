<!-- creats two frames -->


<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String classId="",courseName="",courseId="",className="";
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

	//puts the values of classid,coursename,courseid in the session
	session.putValue("classid",classId);				
	session.putValue("coursename",courseName);
	session.putValue("courseid",courseId);
	session.putValue("classname",className);
%>
<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>

<frameset rows="48,*" noborders framespacing="0" border="0" frameborder="0" topmargin="0" >
  <frame name="contents" target="main" src="DBTopPanel.jsp" scrolling="no" marginwidth="0" marginheight="0">
  <frame name="main" src="about:blank" marginwidth="0" marginheight="0" scrolling="auto">
  <noframes>
  <body topmargin="0" leftmargin="0">

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</frameset>

</html>
