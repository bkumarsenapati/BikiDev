<%@ page language="java"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String examId=null,examName="",studentId=null,stuTblName="";
	int attempts=0;
	int version=1;
%>
<%
	session=request.getSession(true);
	String s=(String)session.getAttribute("sessid");
	if(s==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}

	//Santhosh from here
	String examType="",marksScheme="",status="",count="",totalMarks="";
	String shortAnsMarks="";
	//Santhosh upto here
	String type;

	examId=request.getParameter("examid");
	
	if(request.getParameter("type")==null || request.getParameter("type").trim().equals(""))
	{
		type="";
	}
	else 
	{
		type=request.getParameter("type");
	}
	
	if(type.equals("student"))
	{
		studentId=request.getParameter("studentid");
		version=Integer.parseInt(request.getParameter("version"));
		attempts=Integer.parseInt(request.getParameter("attempts"));
		stuTblName=request.getParameter("stuTblName");
		examName=request.getParameter("examname");
		//Santhosh from here
		examType=request.getParameter("examtype");
		marksScheme=request.getParameter("scheme");
		status=request.getParameter("status");
		count=request.getParameter("count");
		totalMarks=request.getParameter("totalmarks");
		shortAnsMarks=request.getParameter("shortansmarks");
		//Santhosh upto here
	}

	String mode="";
	if(request.getParameter("mode")==null)
		mode="act";
	else
		mode="tmp";
	//puts the values of classid,coursename,courseid in the session
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<title><%=application.getInitParameter("title")%></title>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<META HTTP-EQUIV='Expires' CONTENT='Mon, 04 Dec 1999 21:29:02 GMT'>
<SCRIPT LANGUAGE="JavaScript">
<!--
	var versn='<%=version%>';
	var messageBody='';
	var toAddress='';
	var subject='';
//-->
</SCRIPT>
</HEAD>

<% 
	if(type.equals("") || type.equals("teacher"))
	{
%>
		<frameset cols="100,*" border="0">
			<frame name="papernos" src="ExamPapers.jsp?mode=<%=mode%>&examid=<%=examId%>" scrolling="auto" marginwidth="0" marginheight="0">	
			<frameset rows="25%,75%,0%" border="1">
				<frame name="top_f" scrolling="no" marginwidth="0" marginheight="0">	
				<frame name="mid_f" scrolling="auto" marginwidth="0" marginheight="0"> 
				<frame name="btm_f" scrolling="no"> 
		</frameset>
<%
	}
	else if(type.equals("student"))
	{
		session.setAttribute("submissionNo",request.getParameter("attempts"));
		session.setAttribute("version",request.getParameter("version"));
		session.setAttribute("stuTblName",stuTblName);
		session.setAttribute("marksScheme",marksScheme);
		session.setAttribute("totalMarks",totalMarks);
%>
		<frameset rows="60,*" border="0">
			<frame name="modeframe" src="ModeSelector.jsp?mode=VIEW&studentid=<%=studentId%>&examid=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&status=<%=status%>&count=<%=count%>&shortansmarks=<%=shortAnsMarks%>" scrolling="no" marginwidth="0" marginheight="0">
			<frameset cols="100,*" border="0">
				<frame name="papernos" src="StudentExamPapers.jsp?examid=<%=examId%>&studentid=<%=studentId%>&examname=<%=examName%>&examtype=<%=examType%>&status=<%=status%>&shortansmarks=<%=shortAnsMarks%>" scrolling="auto" marginwidth="0" marginheight="0">

				<frameset rows="25%,55%,20%,0%" border="1">
					<frame name="top_f" scrolling="no" marginwidth="0" marginheight="0">	
					<frame name="mid_f" scrolling="auto" marginwidth="0" marginheight="0"> 
					<frame name="fb_f" scrolling="auto" marginwidth="0" marginheight="0"> 
					<frame name="btm_f" scrolling="no"> 
		</frameset>
<%
	}
%>

<noframes>
<body topmargin="0" leftmargin="0">
	<p>This page uses frames, but your browser doesn't support them.</p>
</body>
</noframes>
</html>
