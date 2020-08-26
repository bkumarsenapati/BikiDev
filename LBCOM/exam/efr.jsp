<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String examId=null;
	String studentId=null;
	String stuTblName="";
	int attempts=0;
	int version=1;
%>
<%
	session=request.getSession(true);
	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	examId=request.getParameter("examid");
	String type;
	if(request.getParameter("type")==null || request.getParameter("type").trim().equals("")){
		type="";
	}else {
		type=request.getParameter("type");
	}
	
	if(type.equals("student")){
		studentId=request.getParameter("studentid");
		version=Integer.parseInt(request.getParameter("version"));
		attempts=Integer.parseInt(request.getParameter("attempts"));
		stuTblName=request.getParameter("stuTblName");
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
<SCRIPT LANGUAGE="JavaScript">
<!--
	var versn='<%=version%>';

//-->
</SCRIPT>
</HEAD>

<frameset cols="80,*" border="0">
  <% if(type.equals("") || type.equals("teacher")){%>
		<frame name="papernos" src="ep.jsp?mode=<%=mode%>&examid=<%=examId%>" scrolling="auto" marginwidth="0" marginheight="0">	
  <%}else if(type.equals("student")){%>
		<frame name="papernos" src="StudentExamPapers.jsp?examid=<%=examId%>&studentid=<%=studentId%>&attempts=<%=attempts%>&version=<%=version%>&stuTblName=<%=stuTblName%>" scrolling="auto" marginwidth="0" marginheight="0">	
  <%}%>

  <frameset rows="25%,75%,0%" border="0">
		  <frame name="top_f" scrolling="no" marginwidth="0" marginheight="0">	
		  <frame name="mid_f"  scrolling="auto" marginwidth="0" marginheight="0"> 
		  <frame name="btm_f"  scrolling="no"> 
  </frameset>

<noframes>
  <body topmargin="0" leftmargin="0">

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>


</html>
