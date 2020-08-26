<%@page language="java" %>
<%@page import="java.sql.*,java.io.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<HTML>
<HEAD>
<TITLE>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</TITLE>
</HEAD>

<%
	String schoolId="",studentId="";
%>
<form name="DispTopics">
<%
schoolId = (String)session.getAttribute("schoolid");
studentId = (String)session.getAttribute("emailid");
System.out.println("Forums......."+schoolId);

System.out.println("Forums......."+studentId);

/*
out.println("<frameset rows='20%,80%' border='0'>");

out.println("<frame name='one' src='/grids/coursemgmt/teacher/TopicSelection.jsp?courseid="+courseId+"&coursename="+courseName+"&classid="+classId+"&classname="+className+"' scrolling='no'>");
out.println("<frame name='sec'>");
out.println("</FRAMESET>");
*/
%>
<iframe src="/LBCOM/studentAdmin/Forums/ShowDirTopics.jsp?mode=findex" width="100%" height="500px" frameborder="0"></iframe>

</form>
</HTML>

