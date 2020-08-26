<%@ page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
	Statement st1=null,st2=null,st3=null,st4=null,st5=null;
	String schoolId="",classId="",className="",courseId="",courseName="",teacherId="",courseEndDate="",studentId="";
	int studentsCount=0,assignCount=0,assessCount=0,assignAttemptedCount=0,assessAttemptedCount=0;
	boolean courseFlag=false;
%>

<%
	schoolId=request.getParameter("schoolid");
	classId=request.getParameter("classid");
	className=request.getParameter("classname");
	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	teacherId=request.getParameter("teacherid");
	courseEndDate=request.getParameter("enddate");

%>

<%
	try
	{
		con=con1.getConnection();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		st4=con.createStatement();
		st5=con.createStatement();
		
		rs1=st1.executeQuery("select student_id from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"' order by student_id");
		
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Class Name</title>
</head>

<body>

<table width="900" cellspacing="1" border="0">
	<tr>
		<td width="104" bgcolor="#ECD8CA"><font face="Verdana" size="2"><b>Class Name:</b></font></td>
		<td width="106" bgcolor="#ECD8CA"><font face="Verdana" size="2"><%=className%></font></td>
		<td width="105" bgcolor="#ECD8CA"><font face="Verdana" size="2"><b>Course Name:</b></font></td>
		<td width="107" bgcolor="#ECD8CA"><font face="Verdana" size="2"><%=courseName%></font></td>
		<td width="126" bgcolor="#ECD8CA"><font face="Verdana" size="2"><b>Teacher Name:</b></font></td>
		<td width="89" bgcolor="#ECD8CA"><font face="Verdana" size="2"><%=teacherId%></font></td>
		<td width="138" bgcolor="#ECD8CA"><font face="Verdana" size="2"><b>Course End Date:</b></font></td>
		<td width="90" bgcolor="#ECD8CA"><font face="Verdana"  size="2" color="#FF0000"><%=courseEndDate%></font></td>
	</tr>
</table>

<br>

<table border="1" cellspacing="1" width="900" bordercolor="#ECD8CA">
  <tr>
    <td width="250" align="center" height="29" bgcolor="#D9B095">
		<font face="Verdana" size="2" color="#FFFFFF"><b>
		Student Name</b></font></td>
    <td width="1" align="center" height="29" bgcolor="#ECD8CA">&nbsp;</td>
    <td width="150" align="center" height="29" bgcolor="#D9B095"><b>
	    <font face="Verdana" size="2" color="#FFFFFF">Assignments</font></b></td>
    <td width="150" align="center" height="29" bgcolor="#D9B095"><b>
		<font face="Verdana" size="2" color="#FFFFFF">Attempted</font></b></td>
    <td width="1" height="29" align="center" bgcolor="#ECD8CA">&nbsp;</td>
    <td width="150" height="29" align="center" bgcolor="#D9B095"><b>
	    <font face="Verdana" size="2" color="#FFFFFF">Assessments</font></b></td>
    <td width="150" align="center" height="29" bgcolor="#D9B095">
	    <font face="Verdana" size="2" color="#FFFFFF"><b>Attempted</b></font></td>
   <!--  <td width="78" align="center" height="29" bgcolor="#D9B095"><b>
	    <font face="Verdana" size="2" color="#FFFFFF">Grade</font></b></td> -->
  </tr>
<%
		while(rs1.next())
		{
			studentId=rs1.getString(1);

			rs2=st2.executeQuery("select count(distinct w.work_id) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join "+schoolId+"_"+classId+"_"+courseId+"_dropbox d on w.work_id=d.work_id where d.student_id='"+studentId+"' and (w.from_date<=curdate())");

			if(rs2.next())
			{
				assignCount=rs2.getInt(1);
			}

			rs3=st3.executeQuery("select count(*) from  "+schoolId+"_"+studentId+" as s inner join exam_tbl as e on s.exam_id=e.exam_id where e.course_id='"+courseId+"' and e.status='1' and e.school_id='"+schoolId+"' order by from_date");
			if(rs3.next())
			{
				assessCount=rs3.getInt(1);
			}
			
			rs4=st4.executeQuery("select count(*) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where student_id='"+studentId+"' and submit_count=1");

			if(rs4.next())
			{
				assignAttemptedCount=rs4.getInt(1);
			}
			
			rs5=st5.executeQuery("select count(*) from  "+schoolId+"_"+studentId+" where exam_status=1");

			if(rs5.next())
			{
				assessAttemptedCount=rs5.getInt(1);
			}


%>

  <tr>
    <td width="250" height="1" align="left">
		<font face="Verdana" size="2"><%=studentId%></font></td>
    <td width="1" height="1" align="center" bgcolor="#ECD8CA">
		&nbsp;</td>
    <td width="150" height="1" align="center">
		<font face="Verdana" size="2"><%=assignCount%></font></td>
    <td width="150" height="1" align="center">
		<font face="Verdana" size="2"><%=assignAttemptedCount%></font></td>
	<td width="1" height="1" align="center" bgcolor="#ECD8CA">&nbsp;</td>
	<td width="150" height="1" align="center">
		<font face="Verdana" size="2"><%=assessCount%></font></td>
	<td width="150" height="1" align="center">
		<font face="Verdana" size="2"><%=assessAttemptedCount%></font></td>
	<!-- <td width="78" height="1" align="center">
		<font color="#800000" face="Verdana" size="2"><b>A</b></font></td> -->
  </tr>
<%
		}	  
%>

</table>

<%
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("StudentList.jsp","Operations on database ","Exception",e.getMessage());
		out.println("<b>There is an error raised in the StudentList. Please try once again.</b>");
	}
	
	finally
	{
		try
		{
			if(con!=null)
				con.close();
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("StudentList.jsp","Closing connection objects","Exception",e.getMessage());
		}
}
%>
</body>

</html>