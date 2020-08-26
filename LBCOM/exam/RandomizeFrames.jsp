<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String examId="",examType="",examName="",mode="",enableMode="";
	int noOfGrps=0;
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
	
	//puts the values of classid,coursename,courseid in the session
%>
<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>


<frameset rows="7%,*" border="0">
  <frame name="exname" target="bottompanel" src="ExamName.jsp?examname=<%=examName%>" scrolling="no" marginwidth="0" marginheight="0">	
  <frame name="Randomcontents" target="bottompanel" src="RandomizeDetails.jsp?enableMode=<%=enableMode%>&examid=<%=examId%>&examtype=<%=examType%>" scrolling="no" marginwidth="0" marginheight="0"> 
</frameset>
  <noframes>
  <body topmargin="0" leftmargin="0">

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</html>
