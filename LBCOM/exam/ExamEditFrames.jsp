<%@ page language="Java"%>

<%
	String examId,examType,examName;
	int noOfGrps;
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
	if(request.getParameter("noofgrps")!=null)
		noOfGrps=Integer.parseInt(request.getParameter("noofgrps"));
	else
	    noOfGrps=0;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>
<FRAMESET ROWS="8%,*" border=0>
	<FRAME SRC="ExamSteps.jsp?examid=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&noofgrps=<%=noOfGrps%>" NAME="steps">
	<FRAME NAME="desc">
</FRAMESET>
<BODY>
</BODY>
</HTML>
