<%@page language="java" %>
<%@page import="java.sql.*,java.io.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<HTML>
<HEAD>
<TITLE>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</TITLE>
</HEAD>

<%
	String schoolId="",teacherId="";
%>
<form name="DispTopics">
<%
schoolId = (String)session.getAttribute("schoolid");
teacherId = (String)session.getAttribute("emailid");
System.out.println("Forums......."+schoolId);

System.out.println("Forums......."+teacherId);

/*
out.println("<frameset rows='20%,80%' border='0'>");

out.println("<frame name='one' src='/grids/coursemgmt/teacher/TopicSelection.jsp?courseid="+courseId+"&coursename="+courseName+"&classid="+classId+"&classname="+className+"' scrolling='no'>");
out.println("<frame name='sec'>");
out.println("</FRAMESET>");
*/
%>
<iframe src="/LBCOM/teacherAdmin/Forums/ForumManagement.jsp?mode=findex&emailid=<%=teacherId%>&schoolid=<%=schoolId%>" width="100%" height="500px" frameborder="0"></iframe>

</form>
</HTML>

