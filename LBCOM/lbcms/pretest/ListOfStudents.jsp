<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st1=null,st2=null;
	ResultSet rs1=null,rs2=null;
	String schoolId="",classId="";
	String courseId="",studentId="",studentName="",status="";
	int i=0,studentCount=10;

	try
	{
		con=con1.getConnection();
		st1=con.createStatement();
		st2=con.createStatement();

		schoolId=(String)session.getAttribute("schoolid");
		classId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");

		rs1=st1.executeQuery("select count(*) from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"' and s.grade='"+classId+"' and s.schoolid='"+schoolId+"' and username !='C000_vstudent' and s.status=1 order by s.subsection_id,fname,lname");

		while(rs1.next())
		{
			studentCount=rs1.getInt(1);
		}

		rs1=st1.executeQuery("select * from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"' and s.grade='"+classId+"' and s.schoolid='"+schoolId+"' and username !='C000_vstudent' and s.status=1 order by s.subsection_id,fname,lname");
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Pretest - List of Students</title>
</head>

<body>
<form method="POST" action="--WEBBOT-SELF--">
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%" height="41">
  <tr>
    <td width="25%" height="25" bgcolor="#934900">
    <font color="#FFFFFF" face="Verdana" size="2">&nbsp;<b>Pretest - List of Students</b></font></td>
    <td width="25%" align="center" height="25" bgcolor="#934900">&nbsp;</td>
    <td width="25%" align="right" height="25" bgcolor="#934900">
		<a href="index.jsp">
			<b><font face="Verdana" size="2" color="#FFFFFF">Back to Pretest</font></b>
		</a>&nbsp;
	</td>
  </tr>
  <tr>
    <td width="75%" align="center" colspan="3" height="16"><hr></td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="red" width="100%">
<tr>
	<td width="20%">
		<font color="#934900" face="Verdana" size="1">&lt;&lt; </font>
		<font face="Verdana" size="2">Prev</font>
	</td>
    <td width="60%" align="center">
    	<font face="Verdana" size="2" color="#934900">1 - <%=studentCount%> of <%=studentCount%> Students</font>
    </td>
    <td width="20%" align="right">
    	<font color="#934900"><font face="Verdana" size="2">Next </font><font face="Verdana" size="1">&gt;&gt;</font></font>
    </td>
  </tr>
</table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
    <td width="2%" align="center" bgcolor="#CE6700">&nbsp;</td>
    <td width="2%" align="center" bgcolor="#CE6700">&nbsp;</td>
	<td width="36%" bgcolor="#CE6700"><b><font face="Verdana" size="2" color="#FFFFFF">&nbsp;Name of the Student</font></b></td>
	<td width="30%" bgcolor="#CE6700"><b><font face="Verdana" size="2" color="#FFFFFF">&nbsp;Student ID</font></b></td>
    <td width="30%" align="center" bgcolor="#CE6700">
		<b><font face="Verdana" size="2" color="#FFFFFF">Pretest Status</font></b></td>
  </tr>

<%
		while(rs1.next())
		{
			studentId=rs1.getString("emailid");
			studentName=rs1.getString("fname")+" "+rs1.getString("lname");
			i++;

			rs2=st2.executeQuery("select * from pretest_student_material_distribution where school_id='"+schoolId+"' and course_id='"+courseId+"' and student_id='"+studentId+"'");
			if(rs2.next())
			{
				status=rs2.getString("status");
				if(status.equals("0"))
				{
%>

  <tr>
    <td width="2%" align="center"><font face="Verdana" size="1"><b><input type="checkbox" name="C1" value="ON"></b></font></td>
    <td width="2%" align="center"><font face="Verdana" size="1"><%=i%></font>&nbsp;</td>
    <td width="36%"><font face="Verdana" size="2">&nbsp;<%=studentName%></font></td>
	<td width="30%"><font face="Verdana" size="2">&nbsp;<%=studentId%></font></td>
    <td width="30%" align="center">
		<a href="EvaluateStudentExamPaper.jsp?courseid=<%=courseId%>&studentid=<%=studentId%>&studentname=<%=studentName%>">
			<font face="Verdana" size="2">Pending for Submission</font></a></td>
  </tr>
<%
				}
				else if(status.equals("1"))
				{
%>
   <tr>
    <td width="2%" align="center"><font face="Verdana" size="1"><b><input type="checkbox" name="C1" value="ON"></b></font></td>
    <td width="2%" align="center"><font face="Verdana" size="1"><%=i%></font>&nbsp;</td>
    <td width="36%"><font face="Verdana" size="2">&nbsp;<%=studentName%></font></td>
	<td width="30%"><font face="Verdana" size="2">&nbsp;<%=studentId%></font></td>
    <td width="30%" align="center">
		<a href="EvaluateStudentExamPaper.jsp?courseid=<%=courseId%>&studentid=<%=studentId%>&studentname=<%=studentName%>">
			<font face="Verdana" size="2">Evaluate</font></a></td>
  </tr>
<%
				}
				else if(status.equals("2"))
				{
%>
  <tr>
    <td width="2%" align="center"><font face="Verdana" size="1"><b><input type="checkbox" name="C1" value="ON"></b></font></td>
    <td width="2%" align="center"><font face="Verdana" size="1"><%=i%></font>&nbsp;</td>
    <td width="36%"><font face="Verdana" size="2">&nbsp;<%=studentName%></font></td>
	<td width="30%"><font face="Verdana" size="2">&nbsp;<%=studentId%></font></td>
    <td width="30%" align="center">
		<a href="EvaluateStudentExamPaper.jsp?courseid=<%=courseId%>&studentid=<%=studentId%>&studentname=<%=studentName%>">
			<font face="Verdana" size="2">Already Evaluated</font></a></td>
  </tr>
<%
				}
			}
			else
			{
%>
   <tr>
    <td width="2%" align="center"><font face="Verdana" size="1"><b><input type="checkbox" name="C1" value="ON"></b></font></td>
    <td width="2%" align="center"><font face="Verdana" size="1"><%=i%></font>&nbsp;</td>
    <td width="36%"><font face="Verdana" size="2">&nbsp;<%=studentName%></font></td>
	<td width="30%"><font face="Verdana" size="2">&nbsp;<%=studentId%></font></td>
    <td width="30%" align="center">
		<a href="AssignPretest.jsp?courseid=<%=courseId%>&studentid=<%=studentId%>">
			<font face="Verdana" size="2">Distribute</font></a></td>
  </tr>
<%
			}
		}	  
		if(studentCount == 0)
		{
%>
  <tr>
    <td width="100%" colspan="5">
		<font face="Verdana" size="1">There are no students in this course.</font></td>
  </tr>
<%
		}
	}
  	catch(SQLException se)
	{
		System.out.println("Error in ListOfStudents.jsp : pretest : SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("Error:  in ListOfStudents.jsp : pretest -" + e.getMessage());
	}
	finally
	{
		try
		{
			if(st1!=null)
				st1.close();
			if(st2!=null)
				st2.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			System.out.println("Error:  in finally of ListOfStudents.jsp : pretest -"+se.getMessage());
		}
	}
%>
 
</table>
</form>
</body>
</html>