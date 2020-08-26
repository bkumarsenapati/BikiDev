<!--  creats two frames -->

<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String classId="",courseName="",courseId="",examId="",examType="",examName="",enableMode="";
%>
<%
	session=request.getSession(true);

	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	
	examId=request.getParameter("examid");
	examType=request.getParameter("examtype");
	examName=request.getParameter("examname");
		enableMode=request.getParameter("enableMode");
	
	
%>
<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>

	<frameset rows="5%,7%,*" border="0">
		<frame name="ename" target="bottompanel" src="ExamName.jsp?examname=<%=examName%>" scrolling="no" marginwidth="0" marginheight="0">
		<frameset cols="0,*" border="0">
			<frame name="dummy">
			<frame name="contents" target="bottompanel" src="ExamQETopPanel.jsp?enableMode=<%=enableMode%>&type=create&examid=<%=examId%>&examtype=<%=examType%>&examname=<%=examName%>" scrolling="no" marginwidth="0" marginheight="0"> 
		</frameset>
   <!--<frame name="create_fr" src="ViewQuestions.jsp?start=0&totrecords=none&examname=<%=examName%>&examid=<%=examId%>&qtype=none&cat=none&examtype=<%=examType%>&topicid=none&subtopicid=none&samePage=0&visited=0" scrolling="auto">-->
	   <frame name="create_fr"  scrolling="auto">
	</frameset>
<!--</frameset>-->

  <noframes>
  <body topmargin="0" leftmargin="0">
  <p>This page uses frames, but your browser doesn't support them.</p>
  </body>
  </noframes>

</html>


