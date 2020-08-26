<%@page language="java" %>
<%@page import="java.sql.*,java.io.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<HTML>
<HEAD>
<TITLE>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</TITLE>
</HEAD>

<%
	String schoolid="",courseId="",classId="",courseName="",className="";
%>
<form name="DispTopics">
<%

/*
out.println("<frameset rows='20%,80%' border='0'>");

out.println("<frame name='one' src='/grids/coursemgmt/teacher/TopicSelection.jsp?courseid="+courseId+"&coursename="+courseName+"&classid="+classId+"&classname="+className+"' scrolling='no'>");
out.println("<frame name='sec'>");
out.println("</FRAMESET>");
*/
%>
<iframe src="/LBCOM/WebHuddle/teacher/ScheduledMeetings.jsp?schoolid=<%=session.getAttribute("schoolid")%>&emailid=<%=session.getAttribute("emailid")%>" width="100%" height="700px" frameborder="0"></iframe>
<!-- <frameset rows="20%,80%" border="0">
<frame name="one" src="grids/coursemgmt/teacher/TopicSelection.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&classid=<%=classId%>&classname=<%=className%>" scrolling="no">
<frame name="sec">
</frameset> -->

</form>
</HTML>

