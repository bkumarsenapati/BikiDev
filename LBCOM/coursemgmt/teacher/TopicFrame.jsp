<%@page language="java" %>
<%@page import="java.sql.*,java.io.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<HTML>
<HEAD>
<TITLE>.:: Welcome to www.learnbeyond.com ::. [ for quality eLearning experience ]</TITLE>
</HEAD>

<%
	String schoolid="",courseId="",classId="",courseName="",className="";
%>
<form name="DispTopics">
<%
courseId=request.getParameter("courseid");
classId=request.getParameter("classid");
courseName=request.getParameter("coursename");
className=request.getParameter("classname");

out.println("<frameset rows='20%,80%' border='0'>");

out.println("<frame name='one' src='/LBCOM/com/teacher/grids/coursemgmt/teacher/TopicSelection.jsp?courseid="+courseId+"&coursename="+courseName+"&classid="+classId+"&classname="+className+"' scrolling='no'>");
out.println("<frame name='sec'>");
out.println("</FRAMESET>");
%>
<!-- <iframe src="grids/coursemgmt/teacher/TopicSelection.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&classid=<%=classId%>&classname=<%=className%>" width="100%" height="500px"></iframe>
 --><!-- <frameset rows="20%,80%" border="0">
<frame name="one" src="grids/coursemgmt/teacher/TopicSelection.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&classid=<%=classId%>&classname=<%=className%>" scrolling="no">
<frame name="sec">
</frameset> -->

</form>
</HTML>

