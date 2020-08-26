
<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
	String classId="",courseName="",courseId="",examId="",examType="",examName="",enableMode="";
	int noOfGrps=0;
%>
<%
	session=request.getSession(false);

	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	
	examId=request.getParameter("examid");
	examName=request.getParameter("examname");
	examType=request.getParameter("examtype");
	enableMode=request.getParameter("enableMode");
	noOfGrps=Integer.parseInt(request.getParameter("noofgrps"));
	
	//puts the values of classid,coursename,courseid in the session
%>
<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>


<frameset rows="7%,10%,*" border="0" >
  <frame name="examname" target="bottompanel" src="ExamName.jsp?examname=<%=examName%>" scrolling="no" marginwidth="0" marginheight="0">	
  <frame name="grpsconfirm" target="bottompanel" src="GrpsConfirm.jsp?enableMode=<%=enableMode%>&examid=<%=examId%>&examtype=<%=examType%>&noofgrps=<%=noOfGrps%>&examname=<%=examName%>" scrolling="no" marginwidth="0" marginheight="0"> 
  <% //if (noOfGrps>=1) {%>
  <frame name="grpcontents" target="bottompanel" src="GroupDetails.jsp?enableMode=<%=enableMode%>&examid=<%=examId%>&noofgrps=<%=noOfGrps%>&examtype=<%=examType%>&examname=<%=examName%>" scrolling="auto" marginwidth="0" marginheight="0">
  <%//}else {%>
  <!--<frame name="grpcontents" target="bottompanel" src="CreateExamFrames.jsp?examid=<%=examId%>&examtype=<%=examType%>&noofgrps=<%=noOfGrps%>" scrolling="auto" marginwidth="0" marginheight="0">-->
  <%//}%>
  
</frameset>
  <noframes>
  <body topmargin="0" leftmargin="0">

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</html>
