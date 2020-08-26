<%@page language="java" %>
<%@page import="java.sql.*,java.io.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<HTML>
<HEAD>
<TITLE>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</TITLE>
</HEAD>

<%
	String schoolId="",courseId="",classId="",courseName="",className="",studentName="",studentId="",mode="",pageType="";
%>
<form name="DispTopics">
<%
schoolId=(String)session.getAttribute("schoolid");
studentId=(String)session.getAttribute("emailid");
studentName=(String)session.getAttribute("studentname");
classId=(String)session.getAttribute("classid");
courseId=request.getParameter("courseid");
courseName=request.getParameter("coursename");
//classId=request.getParameter("classid");
mode=request.getParameter("mode");
pageType=request.getParameter("page_type");
/*
out.println("<frameset rows='20%,80%' border='0'>");

out.println("<frame name='one' src='/grids/coursemgmt/teacher/TopicSelection.jsp?courseid="+courseId+"&coursename="+courseName+"&classid="+classId+"&classname="+className+"' scrolling='no'>");
out.println("<frame name='sec'>");
out.println("</FRAMESET>");
*/
%>
<!-- <iframe src="/LBCOM/coursemgmt/student/CourseHome.jsp" width="100%" height="700px" frameborder="0"></iframe>  -->
<iframe src="/LBCOM/coursemgmt/student/ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&studentid=<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=newtoold&page_type=<%=pageType%>" width="100%" height="700px" frameborder="0" scrolling="auto"></iframe> 


</form>
</HTML>

