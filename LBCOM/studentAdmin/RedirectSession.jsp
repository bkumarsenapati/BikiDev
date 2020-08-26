<%@ page import = "java.sql.*,java.io.*,java.util.Hashtable,coursemgmt.ExceptionsFile" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<%
	String handler="",sessState="";

	handler=request.getParameter("handler");
	sessState=(String)session.getAttribute("sessionstatus");

	if(sessState==null)
	{
		session.setAttribute("originalschoolid",(String)session.getAttribute("schoolid"));
		session.setAttribute("originalemailid",(String)session.getAttribute("emailid"));
		session.setAttribute("originalstudentname",(String)session.getAttribute("studentname"));
		session.setAttribute("originalclassid",(String)session.getAttribute("classid"));
	}
	else
	{
		session.setAttribute("schoolid",(String)session.getAttribute("originalschoolid"));
		session.setAttribute("emailid",(String)session.getAttribute("originalemailid"));
		session.setAttribute("studentname",(String)session.getAttribute("originalstudentname"));
		session.setAttribute("classid",(String)session.getAttribute("originalclassid"));
	}

	String schoolId=(String)session.getAttribute("schoolid");
	
	if(handler.equals("profile"))
	{
		response.sendRedirect("/LBCOM/studentAdmin/modifyStudentReg.jsp?mode=modify");
	}
	else if(handler.equals("courseware"))
	{
		response.sendRedirect("/LBCOM/coursemgmt/student/CourseHome.jsp");
	}
	else if(handler.equals("search"))
	{
		response.sendRedirect("/LBCOM/search/SearchFrame.jsp?user=student&schoolid="+schoolId);
	}
	else if(handler.equals("organizer"))
	{
		response.sendRedirect("/LBCOM/studentAdmin.Mediator?mode=organizer");
	}
	else if(handler.equals("personaldocs"))
	{
		response.sendRedirect("/cAuth/index.php?emailid="+session.getAttribute("emailid")+"&schoolid="+schoolId+"&sessid="+session.getId());
	}
	else if(handler.equals("notice"))
	{
		response.sendRedirect("/LBCOM/nboards/StudentNoticeFrame.jsp");//studentAdmin/PublicFrame.jsp");
		//response.sendRedirect("/LBCOM/studentAdmin/PublicFrame.jsp");
	}
	else if(handler.equals("learningcenter"))
	{
		response.sendRedirect("/LBCOM/studentAdmin/lcindex.htm");
	}
	else if(handler.equals("reflibrary"))
	{
		response.sendRedirect("/LBCOM/studentAdmin/RefLibFrames.jsp");
	}
	else if(handler.equals("gradebook"))
	{
		response.sendRedirect("/LBCOM/coursemgmt/reports/GradesByCategory.jsp");
	}
	else if(handler.equals("reports"))
	{
		//response.sendRedirect("/LBCOM/reports"); ///UsageReports.jsp");
		response.sendRedirect("/LBCOM/grades/student");
	}
	else if(handler.equals("grades"))
	{
		response.sendRedirect("/LBCOM/grades/student"); ///UsageReports.jsp");
	}
	else if(handler.equals("mail"))
	{
		response.sendRedirect("/LBCOM/Commonmail/index.jsp?mode=inbox");
	}
	else if(handler.equals("forums"))
	{
		//response.sendRedirect("/LBCOM/studentAdmin/ShowDirTopics.jsp");
	}
	else if(handler.equals("bboards"))
	{
		response.sendRedirect("/LBCOM/studentAdmin/Forums/ShowDirTopics.jsp?mode=findex");
	}
	else if(handler.equals("lboard"))
	{
		response.sendRedirect("/LBCOM/WhiteBoard/student/StudentBoards.jsp?schoolid="+session.getAttribute("schoolid")+"&emailid="+session.getAttribute("emailid"));
	}
	else if(handler.equals("db"))
	{
		response.sendRedirect("/LBCOM/studentAdmin/StudentHome.jsp");
	}
%>

	
