<!-- creats two frames -->
<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String classId="",courseName="",courseId="";
%>
<%
	session=request.getSession(true);

	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	
	classId=request.getParameter("classid");
	courseId=request.getParameter("courseid");
//	mode=request.getParameter("mode");

	//puts the values of classid,coursename,courseid in the session
%>
<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>


<frameset rows="8%,*" border="0">
  <frameset cols="0,*" border="0">
	  <frame name="dummy">  
	  <frame name="contents" target="main" src="qeTopPanel.jsp?type=qe&classid=<%=classId%>&courseid=<%=courseId%>" scrolling="auto" marginwidth="0" marginheight="0"> 

<!--	  <frame name="contents" target="main" src="tmp/test.html" scrolling="no" marginwidth="0" marginheight="0">  -->
  
  </frameset>

  <frameset rows="90%,0,0" border="0">
	 <frame name="q_ed_fr"  marginwidth="0" marginheight="0" scrolling="auto">
	 <frame name="q_a_fr" src="qeditor/qa_f.html">
	 <frame name="q_debug">
  </frameset>
</frameset>

  <noframes>
  <body topmargin="0" leftmargin="0">

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</html>
