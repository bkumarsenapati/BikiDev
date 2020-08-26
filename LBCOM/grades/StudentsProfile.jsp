<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String schoolId="",teacherId="",courseId="",classId="",courseName="",fname="",lname="";
	String studentId="",studentid="",emailid="";
	ResultSet rs=null,rs1=null,rs2=null;
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	int studentCount=0;

	try
	{
		classId=request.getParameter("classid");
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}   
		
		schoolId = (String)session.getAttribute("schoolid");
		teacherId = (String)session.getAttribute("emailid");

		studentId=request.getParameter("studentid");
		if(studentId == null)
			studentId="selectstudent";
		

		
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();

%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Student Profile</title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goStudent()
{
	var studentId=document.studentprofile.studentlist.value;
	if(studentId.value!="")	
		window.location="StudentsProfile.jsp?studentid="+studentId +"";
}
//-->
</SCRIPT>
</head>

<body>
<form name="studentprofile" method="POST" action="--WEBBOT-SELF--"><BR>

<div align="center">
<center>
<table border="0" cellpadding="0" cellspacing="0" width="90%" bgcolor="#429EDF" height="24">
  <tr>
    <td width="50%" height="24">&nbsp; <b>
    <font face="Arial" size="2" color="#FFFFFF">Student Profile</font></b></td>
    <td width="50%" height="24" align="right">
	<%
	if(!studentId.equals("selectstudent")){
	%><a href="javascript:window.print()"><img border="0" src="images/printer22.png" width="22" height="22" BORDER="0" ALT="Print"></a><%}%>&nbsp;&nbsp;
		
		<a href="index.jsp?userid=<%=teacherId%>"><IMG src="images/back.png" width="22" height="22" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
  </tr>
</table>
  </center>
</div>
<br>
<div align="center">
  <center>
<table border="0" cellspacing="0" width="90%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
  <tr>
   <td width="30%" height="23" colspan="2" bgcolor="#96C8ED" align="right">
		<select id="studentlist" name="studentlist" onchange="goStudent(); return false;">
		<option value="selectstudent" selected>Select Student</option>
<%
			rs=st.executeQuery("select distinct(d.student_id) from coursewareinfo_det d,coursewareinfo c where d.school_id='"+schoolId+"' and d.course_id=c.course_id and c.teacher_id='"+teacherId+"' order by student_id");

		while(rs.next())
			{
			studentid=rs.getString("student_id");
			rs1=st1.executeQuery("select * from studentprofile where username='" +studentid +"'" );
				while(rs1.next())
					{
					fname=rs1.getString("fname");
					lname=rs1.getString("lname");
					}
				if(!rs.getString(1).equals("C000_vstudent")){
%>
			<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
<%
	}
				}
			rs.close();
%>
		</select>

		 <script>
			document.studentprofile.studentlist.value="<%=studentId%>";	
		</script> 
		</td>
	
</tr>
  <tr>
    <td width="60%" height="23" bgcolor="#FFFFFF">
    <hr color="#F16C0A"></td>
</tr>
</table>
<%
	if(studentId.equals("selectstudent")){
	%>
	<tr>
				<td width="100%" colspan="5" align="left">
					<font face="Arial" size="2">Please select a student.</font>
				</td>
              
			</tr>
			
			<%
}
	else{
				rs1=st1.executeQuery("select * from studentprofile where username='" +studentId +"'" );
				while(rs1.next())
					{
					fname=rs1.getString("fname");
					lname=rs1.getString("lname");
					emailid=rs1.getString("con_emailid");
					}
%>

<table border="1" cellspacing="0" width="90%" bordercolorlight="#E6F2FF" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
<tr>
	<td width="25%" align="left" bgcolor="#96C8ED" height="25">
		<b><font face="Arial" size="2">&nbsp;School ID</font></b>
	</td>
	<td width="25%" align="left">
		<b><font face="Arial" size="2">
		&nbsp;<INPUT type="text" maxLength="50" size=30 name="schoolid" value="<%=schoolId%>" readonly>
		</font></b>
	</td>

    <td width="25%" align="left" bgcolor="#96C8ED" height="25">
		<b><font face="Arial" size="2">&nbsp;Student ID</font></b>
	</td>
	<td width="25%" align="left">
		<b><font face="Arial" size="2">
		&nbsp;<INPUT type="text" maxLength="50" size=30 name="studentid" value="<%=studentId%>" readonly>
		</font></b>
	</td>
</tr>
<tr>
    <td width="25%" align="left" bgcolor="#96C8ED" height="25">
		<b><font face="Arial" size="2">&nbsp;First Name</font></b>
	</td>
	<td width="25%" align="left">
		<b><font face="Arial" size="2">
		&nbsp;<INPUT type="text" maxLength="50" size=30 name="fname" value="<%=fname%>" readonly>
		</font></b>
	</td>

	<td width="25%" align="left" bgcolor="#96C8ED" height="25">
		<b><font face="Arial" size="2">&nbsp;Last Name</font></b>
	</td>
	<td width="25%" align="left">
		<b><font face="Arial" size="2">
		&nbsp;<INPUT type="text" maxLength="50" size=30 name="lname" value="<%=lname%>" readonly>
		</font></b>
	</td>
</tr>
<tr>
	<td width="25%" align="left" bgcolor="#96C8ED" height="25">
		<b><font face="Arial" size="2">&nbsp;Email Id</font></b>
	</td>
	<td width="25%" align="left">
		<b><font face="Arial" size="2">
		&nbsp;<INPUT type="text" maxLength="50" size=30 name="emailid" value="<%=emailid%>" readonly>
		</font></b>
	</td>
	<td width="25%" align="left" height="25">
		<a href="InstantMessage.jsp?emailid=<%=emailid%>&lname=<%=lname%>&fname=<%=fname%>&studentid=<%=studentId%>"><font face="Arial" size="1" color="#800000"><b>&nbsp;Send an Instant Message</b></font></a>
	</td>
	
</tr>

<%
	}
	}	
	catch(Exception e)
	{
		out.println("Error: General-" + e);
		System.out.println("Error:  -" + e.getMessage());
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(st2!=null)
				st2.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}
		catch(SQLException se){
			ExceptionsFile.postException("SBCScores.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

%>

</table>
<hr color="#F16C0A" width="90%" size="1">
</center>
</div>
</form>
</body>
</html>