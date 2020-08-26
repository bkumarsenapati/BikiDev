<%@page language="java" %>
<%@page import="java.sql.*,java.io.*,java.util.Date,java.util.*,java.text.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<HTML>
<HEAD>
<TITLE>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</TITLE>
</HEAD>

<%
	String schoolid="",courseId="",classId="",courseName="",className="",selDate="";
%>
<form name="DispTopics">
<%
courseId=request.getParameter("courseid");
classId=request.getParameter("classid");
courseName=request.getParameter("coursename");
selDate=request.getParameter("sel_date");
//selDate=new Date();
if(selDate==null || selDate=="")
{
	 DateFormat df = new SimpleDateFormat("MM/dd/yyyy");           
	
	Date today = Calendar.getInstance().getTime();         
    // Using DateFormat format method we can create a string  
    // representation of a date with the defined format. 
        selDate= df.format(today); 
          
        // Print what date is today! 
}
else
{
	//
}

/*
out.println("<frameset rows='20%,80%' border='0'>");

out.println("<frame name='one' src='/grids/coursemgmt/teacher/TopicSelection.jsp?courseid="+courseId+"&coursename="+courseName+"&classid="+classId+"&classname="+className+"' scrolling='no'>");
out.println("<frame name='sec'>");
out.println("</FRAMESET>");
*/
%>
<iframe src="/LBCOM/calendar/index.jsp?type=teacher&sel_date=<%=selDate%>" width="100%" height="600px" frameborder="0"></iframe>
<!-- <frameset rows="20%,80%" border="0">
<frame name="one" src="grids/coursemgmt/teacher/TopicSelection.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&classid=<%=classId%>&classname=<%=className%>" scrolling="no">
<frame name="sec">
</frameset> -->

</form>
</HTML>

