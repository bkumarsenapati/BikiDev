<!-- creats two frames -->

<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String classId="",courseName="",courseId="",mode="",examId="",examType="";
	
%>
<%
	session=request.getSession(true);

	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	mode=request.getParameter("mode");
	
%>
<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>


<frameset rows="0%,6%,*" border="0">
 <frame name="blank">
 <frameset cols="0,*" border="0">
	  <frame name="dummy">  
	  <frame name="courses_fr" target="bottompanel" src="SelectGrade.jsp?type=create&mode=<%=mode%>&examid=<%=examId%>&examtype=<%=examType%>" scrolling="no" marginwidth="0" marginheight="0"> 
<!--	  <frame name="contents" target="main" src="tmp/test.html" scrolling="no" marginwidth="0" marginheight="0">  -->
  </frameset>

	 <!--<frame name="topics_fr" src="qeTopPanel.jsp?type=qe" scrolling="no" marginwidth="0" marginheight="0"> -->

 <frame name="topics_fr" scrolling="yes" marginwidth="0" marginheight="0">
</frameset>
</frameset>

  <noframes>
  <body topmargin="0" leftmargin="0">

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</html>
