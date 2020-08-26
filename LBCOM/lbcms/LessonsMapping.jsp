<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile,exam.FindGrade" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>

<%
	String courseId="",courseName="",unitId="",lessonId="";
	String query=null;

	
	ResultSet  rs=null,rs1=null,rs2=null,rs3=null,rs4=null;
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null;
	boolean flag=false;
	
	try
	{
		courseId=request.getParameter("courseid");
		if(courseId == null)
			courseId="selectunit";     
		System.out.println("courseId..."+courseId);
		
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		
		rs=st.executeQuery("select * from lbcms_dev_units_master where course_id='"+courseId+"'order by unit_id");	
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Main Student Score</title>
<SCRIPT LANGUAGE="JavaScript">
<!--

function goUnit()
{
	var courseId=document.lessonmap.courselist.value;
	window.location="Mainlessonmap.jsp?courseid="+courseId + "&classid=C000&dlesson=dlesson";
}
function goLesson()
{
	var courseId=document.lessonmap.courselist.value;
	var studentId=document.lessonmap.studentlist.value;
	if((courseId.value!="")&&(studentId.value!=""))	
	//window.location="MainStudentScores.jsp?courseid="+courseId+"&studentid="+studentId + ";
}
</SCRIPT>
</head>
<body>
<form name="lessonmap" method="POST" action="--WEBBOT-SELF--"><BR>

<div align="center">
  <center>
<table border="0" cellspacing="0" width="95%" bgcolor="#429EDF" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" height="28">
  <tr>
    <td width="50%" height="24"><b>
    &nbsp;<font face="Arial" size="2" color="#FFFFFF">Assessments Mapping</font></b></td>
    <td width="50%" height="24" align="right">
	
		<a href="#" onclick="javascript:history.back();"><IMG SRC="images/back.png" WIDTH="22" HEIGHT="22" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a> &nbsp;
	</td>
  </tr>
</table>
</center>
</div>
<br>
<div align="center">
<center>
<table border="0" cellspacing="0" width="95%" id="AutoNumber1" bgcolor="#429EDF" height="15" style="border-collapse: collapse" bordercolor="#111111" cellpadding="5">
  <tr>
    <td width="30%" height="23" colspan="2" bgcolor="#96C8ED">
	<%
				while(rs.next())
				{
					System.out.println("Entered into while loop");
					if(unitId.equals(rs.getString("unit_id")))
					{
			%>
						<b><font face="Arial" size="2">Course Name : <b><%=rs.getString("unit_name")%></font></b></font></b>

			<%
					}
				}
				rs.close();
%>
		<select id="courselist" style="width:200px" name="courselist" onchange="goUnit(); return false;" style="display:none">
			<option value="selectunit" selected>Select Unit</option>

		</select>
		 <script>
			document.lessonmap.courselist.value="<%=unitId%>";	
		</script> 
	</td>
	<td width="30%" height="23" colspan="2" bgcolor="#96C8ED" align="right">
		<select id="studentlist" style="width:200px" name="studentlist" onchange="goLesson();" style="display:none">
		<option value="selectlesson" selected>Select Lesson</option>
<%
			rs=st.executeQuery("select * from lbcms_dev_lessons_master where course_id='"+courseId+"' and unit_id='"+unitId+"' order by lesson_id");
			
			while(rs.next())
			{
				out.println("<option value='"+rs.getString("lesson_id")+"'>"+rs.getString("lesson_name")+"</option>");
				
			}
		
			rs.close();
%>
		</select>
		 <script>
			document.lessonmap.studentlist.value="<%=lessonId%>";	
		</script> 
		</td>
</tr>
<%
	if(!lessonId.equals("allstudents"))
		{
			if(unitId.equals("selectunit") || lessonId.equals("selectlesson"))
				{
%>
<tr>
    <td width="60%" height="23" colspan="4" bgcolor="#FFFFFF">
  </tr>
  
<%
		if(request.getParameter("dlesson")!=null)
					{
%>
<tr>
				<td width="100%" colspan="5">
					<font face="Arial" size="2"><center><strong>Please select a Lesson</strong></center></font>
				</td>
			</tr>
<%
	}
else{		
%>
<tr>
				<td width="100%" colspan="5">
					<font face="Arial" size="2"><center><strong>Please select a Unit and  a Lesson</strong></center></font>
				</td>
			</tr>
			</table>
</center>
</div>

<%
	}
				}
	else 
	{
		// To do
	}
	}	
	}
		catch(SQLException se)
		{
			System.out.println("Error: SQL -" + se.getMessage());
		}
		catch(Exception e)
		{
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
			ExceptionsFile.postException("Mainlessonmap.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
		
%>


</center>
</div>

</form>
</body>
</html>