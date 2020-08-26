<!--  creats two frames -->


<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String examId="",examName="",examType="",noOfGrps="",editMode="",status="0",enableMode="";
%>
<%
	session=request.getSession(true);

	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	
	editMode=request.getParameter("editMode");
	examType=request.getParameter("examType");
	enableMode=request.getParameter("enableMode");
	if(editMode.equals("edit")){
		examId=request.getParameter("examId");
		examName=request.getParameter("examName");		
		noOfGrps=request.getParameter("noOfGrps");
		status=request.getParameter("status");
	}
	
	
%>
<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>

	<frameset rows="10%,*" border="0">
		<frame name="top_fr" src="CETopPanelFB.jsp?enableMode=<%=enableMode%>&status=<%=status%>&editMode=<%=editMode%>&examId=<%=examId%>&examName=<%=examName%>&examType=<%=examType%>&noOfGrps=<%=noOfGrps%>" scrolling="no" marginwidth="0" marginheight="0">
	<%	if(editMode.equals("edit")) { %>
	    <frame name="bot_fr" src="CreateExamFB.jsp?enableMode=<%=enableMode%>&examtype=<%=examType%>&examid=<%=examId%>&mode=edit" scrolling="auto">
	<% } else { %>
	    <frame name="bot_fr" src="CreateExamFB.jsp?enableMode=<%=enableMode%>&examtype=<%=examType%>&mode=create" scrolling="auto">
	<% } %>
	</frameset>


  <noframes>
  <body topmargin="0" leftmargin="0">
  <p>This page uses frames, but your browser doesn't support them.</p>
  </body>
  </noframes>

</html>


