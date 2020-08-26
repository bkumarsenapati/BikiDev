<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile,exam.FindGrade" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	String courseId="",courseName="",unitId="",lessonId="",assmtIds="",userId="";
	String query=null;

	ResultSet  rs=null,rs1=null;
	Connection con=null;
	Statement st=null,st1=null;
	
	try
	{
		courseId=request.getParameter("courseid");
		if(courseId==null)
			courseId="DC008";
		assmtIds=request.getParameter("assmtids");
		unitId=request.getParameter("unitid");
		userId=request.getParameter("userid");
		if(unitId==null)
			unitId="";
				
		%>
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Assessments Mapping</title>
<SCRIPT LANGUAGE="JavaScript">
<!--

function goUnit(cId)
{
	var unitId=document.frm.unitid.value;
	
	window.location.href="MapLessons.jsp?courseid="+cId+"&unitid="+unitId+"&assmtids=<%=assmtIds%>&userid=<%=userId%>";
}


function validate(cId)
{	
	var obj=document.setmarking;
	var unitId=document.frm.unitid.value;
	var lessonId=document.frm.lessonid.value;
	
	
	if(unitId=="uall")
	{
		alert("Please select Unit");
		window.document.frm.unitid.focus();
		return false;
		
	}
	else if(lessonId=="lall")
	{
		alert("Please select Lesson");
		window.document.frm.lessonid.focus();
		return false;
		
	}
	else
	{
		
		window.location.href="LessonMapUpdate.jsp?assmtids=<%=assmtIds%>&courseid="+cId+"&unitid="+unitId+"&lessonid="+lessonId+"&userid=<%=userId%>";
		return true;
	}
	
}
</SCRIPT>
</head>
<body>

<form name="frm" method="post">
<table border="0" cellpadding="0" cellspacing="0" width="100%" background="images/CourseHome_01.gif">
<tr>
	<td width="15" height="70">&nbsp;</td>
	<td width="475" height="70">
		<img src="images/hscoursebuilder.gif" width="194" height="70" border="0">
	</td>
    <td width="493" height="70" align="right">
		<img src="images/mahoning-Logo.gif" width="296" height="70" border="0">
    </td>
</tr>
<tr>
	
	<td width="100%" height="495" colspan="3" background="images/bg2.gif" align="left" valign="top">
		
		

<table>
<tr>
<td>
<b>Unit:</b>&nbsp;
<select name="unitid" style="width: 246px" onChange ="goUnit('<%=courseId%>'); return false;">
<option value="uall">Select</option>
<%
	con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		
	rs=st.executeQuery("select * from lbcms_dev_units_master where course_id='"+courseId+"'order by unit_id");
	while(rs.next())
	{
		String uName = rs.getString("unit_name");
		String uId   = rs.getString("unit_id");
		if(unitId.equals(uId))
		{
%>
			<option value="<%= uId %>" selected><% out.println(uName); %></option>
<%
		}
		else
		{
%>
			<option value="<%= uId %>"><% out.println(uName); %></option>
<%
		}
	}
	rs.close();
	
	%>
	</select>
<%
	if(!unitId.equals(""))
	{

%>
	<b>Lesson Name:</b>&nbsp;
	<select name="lessonid" style="width: 246px" selected><option value="lall">Select</option>
	<%

		rs1=st1.executeQuery("select * from lbcms_dev_lessons_master where course_id='"+courseId+"'and unit_id='"+unitId+"' order by lesson_id");
	while(rs1.next())
	{
		String lName = rs1.getString("lesson_name");
		String lId   = rs1.getString("lesson_id");
	%>
	<option value="<%= lId %>"><% out.println(lName); %></option>
	<%
	}
	rs1.close();

	
	%>
	</select>
	</td>
	</tr>
	

	
<input type="hidden" name="courseid" value="<%=courseId%>">

	<%
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
			if(con!=null && !con.isClosed())
				con.close();
			
		}
		catch(SQLException se){
			ExceptionsFile.postException("Mainlessonmap.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
		}
		%>
		<tr>
	<td colspan=8 align="left"><input type="button" value="Submit" onClick="return validate('<%=courseId%>');"></td>
</tr>
		</table>
		</tr></table>

		 </form></body></html>