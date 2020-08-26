<!-- creats two frames -->
<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String classId="";
%>
<%
	session=request.getSession(true);

	String s=(String)session.getAttribute("sessid");
	String schoolId = (String)session.getAttribute("schoolid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	
	classId=request.getParameter("classid");
//	mode=request.getParameter("mode");

	//puts the values of classid,coursename,courseid in the session
%>
<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>


<frameset rows="15%,*" border="0">
	  <frame name="contents" target="main" src="SelectGrade.jsp?schoolid=<%=schoolId%>" scrolling="no" marginwidth="0" marginheight="0"> 

	 <frame name="main"  marginwidth="0" marginheight="0" scrolling="auto">
</frameset>

  <noframes>
  <body topmargin="0" leftmargin="0">

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</html>
