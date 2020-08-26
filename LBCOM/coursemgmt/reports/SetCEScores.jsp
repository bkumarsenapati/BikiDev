<meta http-equiv="Content-Language" content="en-us">
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>CESCORES EDITOR</title>
<body>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p align="center">
<%
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;
	 
	String cat="",schoolId="",teacherId="",courseName="",classId="",sessid="";
	String courseId="",categoryId="";
	String studentId="",secPoints="",maxPoints="",status="",repStatus="",workId="",submitDate="";

	session=request.getSession();
	sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;	
	}
	
	con=con1.getConnection();
	teacherId = (String)session.getAttribute("emailid");
	schoolId = (String)session.getAttribute("schoolid");
	courseName=(String)session.getAttribute("coursename");
	classId=(String)session.getAttribute("classid");
	courseId=(String)session.getAttribute("courseid");		
	//cat=request.getParameter("cat");

	studentId=request.getParameter("studentid");
	workId=request.getParameter("workid");
	submitDate=request.getParameter("submitdate");
	secPoints=request.getParameter("secpoints");
	maxPoints=request.getParameter("maxpoints");
	status=request.getParameter("status");
	repStatus=request.getParameter("repstatus");
	
	st=con.createStatement();
	out.println("<font face='verdana' size='2' color='green'>");
	
	out.println("update "+schoolId+"_cescores set submit_date='"+submitDate+"',marks_secured='"+secPoints+"',total_marks='"+maxPoints+"',status='"+status+"',report_status='"+repStatus+"' where school_id='"+schoolId+"' and course_id= '"+courseId+"' and user_id='"+studentId+"' and work_id='"+workId+"'");
	
	out.println("</font>");


	int i= st.executeUpdate("update "+schoolId+"_cescores set submit_date='"+submitDate+"',marks_secured='"+secPoints+"',total_marks='"+maxPoints+"',status='"+status+"',report_status='"+repStatus+"' where school_id='"+schoolId+"' and course_id= '"+courseId+"' and user_id='"+studentId+"' and work_id='"+workId+"'");

	out.println("<br><br><br><font face='verdana' size='2' color='red'>");
	
	if(i >0)
		out.println("Updated "+i+" record(s) Successfully!");
	else
		out.println("Updation  Failed!");
	out.println("</font>");
%>
<p>&nbsp;</p>
<p align="center">
	<a href="#" onclick="history.go(-1); return false;">
		<font face="verdana" size="2" color="orange"><b>Go Back!</font></a>

</body>
</html>