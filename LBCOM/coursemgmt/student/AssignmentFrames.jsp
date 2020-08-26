<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>


<%
	session=request.getSession(true);
	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	String courseName=request.getParameter("coursename");
	String courseId="";
	if(request.getParameter("courseid")==null)
		 courseId=(String)session.getAttribute("courseid");
	else
		courseId=request.getParameter("courseid");
	
	String type=request.getParameter("type");

%>
<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>


<frameset rows="50,*" border="0">
  <frame name="category" target="main" src="TopFrame.jsp?coursename=<%=courseName%>&type=<%=type%>&courseid=<%=courseId%>" scrolling="no" marginwidth="0" marginheight="0">	
<%if(type.equals("AS")){%>
	  <frame name="contents" target="main" src="StudentInbox.jsp?totrecords=&start=0&cat=all&coursename=<%=courseName%>&courseid=<%=courseId%>" scrolling="auto" marginwidth="0" marginheight="0"> 
  <%} else if(type.equals("CM")){%>
		<frame name="contents" target="main" src="CourseInbox.jsp?totrecords=&start=0&cat=all&coursename=<%=courseName%>&type=<%=type%>&courseid=<%=courseId%>" scrolling="auto" marginwidth="0" marginheight="0"> 
  <%}else if(type.equals("CO")){%>

	    <frame name="contents" target="main" src="CourseInbox.jsp?totrecords=&start=0&cat=all&coursename=<%=courseName%>&type=<%=type%>&courseid=<%=courseId%>&lsttag=false" scrolling="auto" marginwidth="0" marginheight="0"> 
<!--	    <frame name="contents" target="main"  scrolling="auto" marginwidth="0" marginheight="0"> -->
  <%}else if(type.equals("EX")){%>
		<frame name="contents" target="main" src="../../exam/StudentExamsList.jsp?totrecords=&start=0&examtype=all&coursename=<%=courseName%>&courseid=<%=courseId%>" scrolling="auto" marginwidth="0" marginheight="0"> 
  <%}%>
</frameset>
  <noframes>
  <body topmargin="0" leftmargin="0">

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</html>
